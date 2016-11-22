
const _ = require("lodash");
const path = require("path");
const func = require("./func");

module.exports = function(reg) {
	
	const dirUpMigration = reg.dirUpMigration;
	const pgp = reg.pgp;
	const db = reg.db;
	
	return {
		command: "info",
		description: "Получить номер версии последней миграции",
		action: function() {
		
			console.log("");
			
			func.checkInstalledDatabase(db).then(installed => {
				if (!installed) {
					console.log("База данных не установлена.");
					return;
				} else {
					return db.one("select * from migration_history order by version desc", null, m => m.version).then(lastMigrationVersion => {
						console.log("Версия последней миграции:", lastMigrationVersion);
					});
				}
			}).then(none => {
				process.exit(0);
			}).catch(func.onError);
			
		}
	};
	
};