<?php
/**
 * WordPress の基本設定
 *
 * このファイルは、インストール時に wp-config.php 作成ウィザードが利用します。
 * ウィザードを介さずにこのファイルを "wp-config.php" という名前でコピーして
 * 直接編集して値を入力してもかまいません。
 *
 * このファイルは、以下の設定を含みます。
 *
 * * MySQL 設定
 * * 秘密鍵
 * * データベーステーブル接頭辞
 * * ABSPATH
 *
 * @link https://ja.wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// 注意:
// Windows の "メモ帳" でこのファイルを編集しないでください !
// 問題なく使えるテキストエディタ
// (http://wpdocs.osdn.jp/%E7%94%A8%E8%AA%9E%E9%9B%86#.E3.83.86.E3.82.AD.E3.82.B9.E3.83.88.E3.82.A8.E3.83.87.E3.82.A3.E3.82.BF 参照)
// を使用し、必ず UTF-8 の BOM なし (UTF-8N) で保存してください。

// ** MySQL 設定 - この情報はホスティング先から入手してください。 ** //
/** WordPress のためのデータベース名 */
define( 'DB_NAME', 'wordpress' );

/** MySQL データベースのユーザー名 */
define( 'DB_USER', 'wordpress' );

/** MySQL データベースのパスワード */
define( 'DB_PASSWORD', 'wordpress' );

/** MySQL のホスト名 */
define( 'DB_HOST', 'localhost' );

/** データベースのテーブルを作成する際のデータベースの文字セット */
define( 'DB_CHARSET', 'utf8' );

/** データベースの照合順序 (ほとんどの場合変更する必要はありません) */
define( 'DB_COLLATE', '' );

/**#@+
 * 認証用ユニークキー
 *
 * それぞれを異なるユニーク (一意) な文字列に変更してください。
 * {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org の秘密鍵サービス} で自動生成することもできます。
 * 後でいつでも変更して、既存のすべての cookie を無効にできます。これにより、すべてのユーザーを強制的に再ログインさせることになります。
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'r|#W_ w (309t=Wjuq6Jedb9?XQ.,K,Rdxq~VQ!es~z=8xeVE85wY.95hUiXC#?a');
define('SECURE_AUTH_KEY',  'CX+<xd,aCv;XOh;jRo|./QYkkh^#=9fj%o:7nKXH*m-+bnba~anZw*Jj#-N-1+^8');
define('LOGGED_IN_KEY',    ' ljWcswT5@xyL!AS,%2O|{-_X#q5Y2M?6_8@!jFCFL46;;HHMV@.57}UXAp@P|ip');
define('NONCE_KEY',        '|hOR+LV6|WI5.8Ztb-(!&Hupg%uls?0dz&&}+rC#W8?^N5h$%|Z|R|7QzQ>;Bt|a');
define('AUTH_SALT',        'r,!in&+roQV5gM-,#ZPIH1Eg2pD2y*)/wd)#DIv}Qj5g2pKr*+e<,nkc8&yg<$Gj');
define('SECURE_AUTH_SALT', '8Zc/k0=x4kL>*mZT@0>GFhY}|ekXWbo}6<CDOV#1[^&#U)*8SSN(:J/0 ]kZsa=i');
define('LOGGED_IN_SALT',   'e(Dk=YcY;szU-$$-f(NfD9Ww*`[H:7>nk7<146L+&sX`D<v4NCp[dR<iP+{y|u2T');
define('NONCE_SALT',       '3W(~Ewh0>VFZx:XgI.2Zotg&w<+V@(E|Y@[tw*WhIu]_i;02o.kA.@|8iV;!/)<]');

/**#@-*/

/**
 * WordPress データベーステーブルの接頭辞
 *
 * それぞれにユニーク (一意) な接頭辞を与えることで一つのデータベースに複数の WordPress を
 * インストールすることができます。半角英数字と下線のみを使用してください。
 */
$table_prefix = 'wp_';

/**
 * 開発者へ: WordPress デバッグモード
 *
 * この値を true にすると、開発中に注意 (notice) を表示します。
 * テーマおよびプラグインの開発者には、その開発環境においてこの WP_DEBUG を使用することを強く推奨します。
 *
 * その他のデバッグに利用できる定数についてはドキュメンテーションをご覧ください。
 *
 * @link https://ja.wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* 編集が必要なのはここまでです ! WordPress でのパブリッシングをお楽しみください。 */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
