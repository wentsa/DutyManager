const fs = require('fs');
const copydir = require('copy-dir');
const path = require('path');
const rimraf = require("rimraf");
const archiver = require('archiver');

const versionTag = "## Version:";

const srcDir = path.join(__dirname, '../src');
const libDir = path.join(__dirname, '../Libs');
const targetDir = path.join(__dirname, '../target');
const WoW_dir = 'D:\\Games\\BattleNet\\World of Warcraft\\_classic_';
const AddonDir = `${WoW_dir}\\Interface\\Addons\\DutyManager`;

const copySources = (dest) => {
    copydir.sync(srcDir, dest);
    copydir.sync(libDir, `${dest}\\Libs`);
};

const getVersion = () => {
    const contents = fs.readFileSync(path.join(srcDir, 'DutyManager.toc'), 'utf8');
    const lines = contents.split(/(?:\r\n|\r|\n)/g);

    for (let i = 0; i < lines.length; i++) {
        if (lines[i].startsWith(versionTag)) {
            return lines[i].substring(versionTag.length).trim();
        }
    }
};

const createZip = (dir, target) => {
    const output = fs.createWriteStream(target);
    const archive = archiver('zip', {
        zlib: { level: 9 } // Sets the compression level.
    });

    output.on('close', function() {
        console.log(archive.pointer() + ' total bytes');
        console.log('archiver has been finalized and the output file descriptor has closed.');
    });

    output.on('end', function() {
        console.log('Data has been drained');
    });

    archive.on('warning', function(err) {
        if (err.code === 'ENOENT') {
            console.warn(err);
        } else {
            throw err;
        }
    });

    archive.on('error', function(err) {
        throw err;
    });

    archive.pipe(output);
    archive.directory(dir, 'DutyManager');
    archive.finalize();
};


rimraf.sync(targetDir);
if (!fs.existsSync(targetDir)){
    fs.mkdirSync(targetDir);
}
copySources(path.join(targetDir, 'sources'));

createZip(path.join(targetDir, 'sources'), path.join(targetDir, `DutyManager-v${getVersion()}.zip`));

rimraf.sync(AddonDir);
copySources(AddonDir);

