# Created by: Guangyuan Yang <ygy@FreeBSD.org>
# $FreeBSD$

PORTNAME=	electron
DISTVERSION=	1.8.2
CATEGORIES=	devel
MASTER_SITES=	https://github.com/yzgyyang/freebsd-libcc-release/releases/download/v59.0.3071.115/
DISTFILES=	libchromiumcontent.zip libchromiumcontent-static.zip

MAINTAINER=	ygy@FreeBSD.org

LICENSE=	MIT

BUILD_DEPENDS=	python:lang/python \
		node:www/node \
		npm:www/npm \
		libnotify>0:devel/libnotify

LIB_DEPENDS=	libdbus-1.so:devel/dbus \
		libFLAC.so:audio/flac \
		libplds4.so:devel/nspr \
		libplc4.so:devel/nspr \
		libnspr4.so:devel/nspr \
		libfontconfig.so:x11-fonts/fontconfig \
		libfreetype.so:print/freetype2 \
		libexpat.so:textproc/expat2 \
		libharfbuzz.so:print/harfbuzz \
		libpng16.so:graphics/png \
		libwebp.so:graphics/webp \
		libcups.so:print/cups \
		libspeechd.so:accessibility/speech-dispatcher \
		libasound.so:audio/alsa-lib \
		libsnappy.so:archivers/snappy \
		libnss3.so:security/nss \
		libsmime3.so:security/nss \
		libssl3.so:security/nss \
		libnssutil3.so:security/nss

USES=		gettext-runtime jpeg
USE_GNOME=	atk cairo gdkpixbuf2 gconf2 glib20 gtk30 libxslt pango
USE_XORG=	xcb xcomposite xcursor xdamage xext xfixes xi xrandr xrender xtst xscrnsaver x11

USE_GITHUB=	yes
GH_ACCOUNT=	electron
GH_PROJECT=	electron
GH_TAGNAME=	v1.8.2
GH_TUPLE=	boto:boto:f7574aa:boto/vendor/boto \
		electron:chromium-breakpad:82f0452:breakpad/vendor/breakpad \
		electron:crashpad:f7c3207:crashpad/vendor/crashpad \
		yzgyyang:depot-tools:4fa73b8:depot_tools/vendor/depot_tools \
		electron:gyp:549e55a:gyp/vendor/gyp \
		electron:libchromiumcontent:dbd83b6:libchromiumcontent/vendor/libchromiumcontent \
		electron:native-mate:bf92fa8:native_mate/vendor/native_mate \
		electron:node:2586ef1:node/vendor/node \
		electron:pdf-viewer:beb3687:pdf_viewer/vendor/pdf_viewer \
		requests:requests:e4d59be:requests/vendor/requests \
		yzgyyang:grit:9536fb6:grit/vendor/pdf_viewer/vendor/grit

post-extract:
	${MKDIR} ${WRKSRC}/vendor/download/libchromiumcontent
	${UNZIP_NATIVE_CMD} -d ${WRKSRC}/vendor/download/libchromiumcontent/ \
		${DISTDIR}/${DIST_SUBDIR}/libchromiumcontent.zip
	${UNZIP_NATIVE_CMD} -d ${WRKSRC}/vendor/download/libchromiumcontent/ \
		${DISTDIR}/${DIST_SUBDIR}/libchromiumcontent-static.zip

post-patch:
	${PATCH} -p1 --ignore-whitespace -d ${WRKSRC} < ${FILESDIR}/electron_111.diff
	${PATCH} -d ${WRKSRC} < ${FILESDIR}/script_bootstrap.py.diff
	(cd ${WRKSRC} && script/bootstrap.py -v --clang_dir=/usr || true)
	${PATCH} -p1 --ignore-whitespace -d ${WRKSRC}/vendor/native_mate/ < ${FILESDIR}/electron_vendor_native_matev1.diff
	${PATCH} -p1 --ignore-whitespace -d ${WRKSRC}/brightray/ < ${FILESDIR}/electron_brightrayv3.diff
	${PATCH} -p1 --ignore-whitespace -d ${WRKSRC}/vendor/libchromiumcontent/ < ${FILESDIR}/electron_vendor_libchromiumcontentv1.diff
	${PATCH} -p1 --ignore-whitespace -d ${WRKSRC} < ${FILESDIR}/electron_libchromiumcontent_git.diff

do-build:
	(cd ${WRKSRC} && script/bootstrap.py -v --clang_dir=/usr)
	(cd ${WRKSRC} && script/build.py -c R)
	(cd ${WRKSRC} && script/create-dist.py)

do-install:
	${MKDIR} ${STAGEDIR}${DATADIR}
	(cd ${WRKSRC}/dist && ${COPYTREE_SHARE} . ${STAGEDIR}${DATADIR})
	${CHMOD} +x ${STAGEDIR}${DATADIR}/electron
	${RLN} ${STAGEDIR}${DATADIR}/electron ${STAGEDIR}${PREFIX}/bin/electron

.include <bsd.port.mk>
