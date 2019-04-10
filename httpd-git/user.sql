CREATE TABLE IF NOT EXISTS user_info (
  user_name CHAR(30) NOT NULL,
  user_passwd CHAR(20) NOT NULL,
  user_group CHAR(10),
    [ any other fields if needed ]
  PRIMARY KEY (user)
)

AuthMySQLEnable On
AuthMySQLHost localhost
AuthMySQLPort 3306
AuthMySQLSocket <default socket in MySQL>
AuthMySQLUser root
AuthMySQLPassword root
AuthMySQLDB git
AuthMySQLUserTable user
AuthMySQLUserCondition <no default>
AuthMySQLNameField user_name
AuthMySQLPasswordField user_passwd
AuthMySQLNoPasswd Off
AuthMySQLPwEncryption crypt
AuthMySQLSaltField <>
AuthMySQLGroupTable <defaults to value of AuthMySQLUserTable>
AuthMySQLGroupCondition <no default>
AuthMySQLGroupField <no default>
AuthMySQLKeepAlive Off
AuthMySQLAuthoritative On
AuthMySQLCharacterSet <no default>