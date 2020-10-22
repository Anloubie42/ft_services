<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'wproot' );

/** MySQL database password */
define( 'DB_PASSWORD', 'wppassword' );

/** MySQL hostname */
define( 'DB_HOST', 'mysql' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         'he4(vi{(3.2<LadkGZpG#tU-Eu-C+@g@MMrUC`kFVpEfH(3Fgb0*7YZ<=D6[GeyO' );
define( 'SECURE_AUTH_KEY',  'w(>ANJGg*+-i7yYPCBbqT+bB,IIM)lk=XQ6n67ffZCCMA/1J83(N{%o<IkJoiJoB' );
define( 'LOGGED_IN_KEY',    'p_Fj8+ez1e!1&SN< >5~^[zO$HVO};fQ]- Sx5EOQz{CCaNcm6TYKr1 a(n$RZz]' );
define( 'NONCE_KEY',        'DR%4v[`@sZk+VvL]c(%|.Jv+W~j92)@Q4aq/a>=!db/q?%&8eT]py&Vq>,R@9w>J' );
define( 'AUTH_SALT',        'akz%4g%N(B1~B`Cl,S[/08yKRLSnN?94jU[X7gM 7|;Is$73]JU*F>Zy=`I}zJ{Z' );
define( 'SECURE_AUTH_SALT', 'yc{*jn8C@;@#M#=}v)v>Q|.n,>?1G+}d2Dtpa-|zvB^uI&jk}ACI<&%.C@pA#Dit' );
define( 'LOGGED_IN_SALT',   '(>uaZah5AX]?(^>?d1E@`8H}*Qsc6i&6{VG[wIV{(N)kSbT;3c /tivpo%C*jSn&' );
define( 'NONCE_SALT',       '9y:t1m=p,/S+{5azGkk3y7Gl1DhC&:(FXMZ=x$ZQaw Yx&/q>|Y-jm~e;y[z-e-e' );

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
        define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */