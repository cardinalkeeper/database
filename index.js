
const _ = require("lodash");
const fs = require("fs");
const path = require("path");
const program = require("commander");
const programPackage = require("load-pkg").sync(__dirname);
const pgp = require("pg-promise")({});

console.log(programPackage.description);
console.log("Версия:", programPackage.version);

program.version(programPackage.version);

/**
 * Глобальные данные.
 */

const config = require("./config/config.json");

const reg = {
	config: config,
	pgp: pgp,
	db: pgp(config.db),
	dirUpMigration: path.join(__dirname, "migrations")
};

	
/**
 * Обработчики команд.
 */

["install", "update", "info"].forEach(cmd => {
	const commandConf = require(`./commands/${cmd}`)(reg);
	program
		.command(commandConf.command)
		.description(commandConf.description)
		.action(commandConf.action);
});



/**
 * Обработка командной строки.
 */


program.parse(process.argv);
if (!program.args.length) program.help();