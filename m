Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB63B280037
	for <linux-mmc@vger.kernel.org>; Wed, 24 Jun 2026 18:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782326922; cv=none; b=axyqtsH4+2DvGJr7z1i5MZQa1nvlyD9iPYG7+2oO0Spy+QX0hFj2U3OBiswp19pk5WZU8EoMelKqUhDklnyW1vdEjTeg90ztqJNhtj/HiaPBtfpD5Dt9Hq0egIDiPobqxIh2z63FGIrlwI2ZRpMs4ISFeAFPNnLnHHH/oh2FswY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782326922; c=relaxed/simple;
	bh=xYQ6PmD5pRjv0E2X8BmzZTzYDAybMOF4jMpmjYkAgoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pY1HQjYnT1bSxV9MQ1OLw573a/QBcWWS8mNJpjPW8wTLTvGyJJ0iRdWgqBMtfhrnpjZ4eSazN4BCnRDnfl35Lnj9KtXDG9GWZayLEajjyeLnpI3CMmPCtS25ma1uZ18/cTIKAV4a81Mxlmw7d3OT3IPBrKSdWgnPBmSKfmZGLvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMIw1G+V; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMIw1G+V"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-697564cb69eso1188989a12.0
        for <linux-mmc@vger.kernel.org>; Wed, 24 Jun 2026 11:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782326918; x=1782931718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+Um6fTXnB/svvAGStdr1esnIG/FgBlGf+o6jrlN6yU=;
        b=DMIw1G+VInD5czW8UkjKOPSAAxunUqvTWCpQerz6Ww9+RueJmIue1I0Hz+W0EjmIqm
         VVOTbfrBcbAZ02noPAQ8+Kygdn78hUTUhNTI/W/JK1lCvyn0XrtvaAcHE/avB61UTRfx
         2lrF78N69x1n32V8tlW34z48IEoshBWf3S93l2O7ubMyIYsCtNcJoEbcP2OBVF5R2NE5
         EmyiUviN9QKPUiEwfyYkGSFzBA45zELRzVjcjE4EgBErdJEpHufdgQP/VfJ/zu79FYWZ
         TRVapQOKS34FD8l+BCYNpCtN87/2IsehW1c/Y2FhH1VEKaPxm28GW2Lia5rgf3rqmiAH
         zURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782326918; x=1782931718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c+Um6fTXnB/svvAGStdr1esnIG/FgBlGf+o6jrlN6yU=;
        b=ryNU+3baBb4/vno0AgzNRvl7vmlnBXysHWimBiU4h7jY5mXKIgrjS7lM/Jm3b1Ulm9
         wEgEwtFa/USKPMfPXXVp8Ao2aWRRuSzzWfXWK21jiJNboRLqkAqbOTkEuT7PN7LAN1ue
         fs/B8zavMd1Q07vImJwKgFus06Dp2rPl2xqK0dJ5399bxjeQqngQplWKlS9tpK+OeA2L
         xn8Ke37ku/xNgF4+oUyXehE128k6bgA4DMS//o5DEhIywlwN4GB6QYTtmf3UDCGhx99b
         dx/3ps6UbMdbZrCP94FAcwrs9gIZzSAms+Z0Gn8mcuIbOWxJkLVAHUqCnNH2W4vxTZ7W
         zHLg==
X-Gm-Message-State: AOJu0YyJuiYfGJlXEa8Wt/CCh5OdoYHZYAbI5R5DoeaEhkP771FaxUhx
	QjifbeSZU0GxDcFBU0mQn/4lGmq6N3dkPc2nC8XkyVYwmGsftssbsnwBl5ggUg==
X-Gm-Gg: AfdE7cn47E02KhXuKpumyamQMupiYJhuM+eYCUfgAbVi0jJCBJ2xHC6OQcv7jeH1Xj/
	GobnlF8XKfmYUzgFlT4S/JlAfjjDnPyGeOBcgX/R9b0CRBCT+q5EDUuDlL+Yz4q4s+rav0HAUvw
	pkPtInPoiBpvThcxa1mWmflkegZQktYzSQDHCTy5nxV9//BL68R3WB7Tlwvw2K7Xv/F/4YRPEU6
	CmLf7nBq7KJ0FE2rVVq8Ospv9nQPwRFKdGN6GLwRH/1eDIKseztYI4ydck2jtH+A/f7gjkzuMc3
	t0B6rZf/JlzuOuWiRzinaBS3RT8rwffkci8i2EW6Ob+s7fnTEIAvpCVqIqCUpmrNeAUcTuiFhf3
	3MF2oLRHmsWVnI0aVbfM0yY7d4QgVclnNvU48Xx322rTB/mD50Ytn+YfCMsWChWpRyYyl47oFyT
	42weHng+sjQrCCLpbUfInpPB0clJPrf37I5mqtzA==
X-Received: by 2002:a05:6402:4591:b0:697:4f51:1c0d with SMTP id 4fb4d7f45d1cf-697f3a9d94emr2453512a12.18.1782326918149;
        Wed, 24 Jun 2026 11:48:38 -0700 (PDT)
Received: from torstein-laptop ([2a01:799:3a1:9700:91be:16ef:9f06:8b10])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-697f3ac4774sm1659189a12.3.2026.06.24.11.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 11:48:37 -0700 (PDT)
Sender: Torstein Eide <torsteine@gmail.com>
From: Torstein Eide <torsteine+linux@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>
Subject: [PATCH v4 1/3] mmc-utils: lsmmc: Use external .ids files and accept /dev, /sys/block paths
Date: Wed, 24 Jun 2026 20:48:22 +0200
Message-ID: <20260624184824.2215718-2-torsteine+linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624184824.2215718-1-torsteine+linux@gmail.com>
References: <20260624184824.2215718-1-torsteine+linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to pci.ids and usb.ids, move the statically defined manufacturer
ID arrays out of the source and into external sdcard.ids and
multimediacard.ids files. This allows other programs to use the same
database without an API, ABI, or cmd interface.

Make the program able to read from the base directory to test without
installing.

Make it possible from the Makefile to change the install directory of
the database.

Also accept /dev and /sys/block paths for register reads. Commands like
'cid read' previously required a raw sysfs device path such as
/sys/bus/mmc/devices/mmc0:0001/. Most users know their block device as
/dev/mmcblk0 or /sys/block/mmcblk0.

Add resolve_dev_path() which follows /sys/class/block/<dev>/device via
realpath() to reach the canonical sysfs device directory. Paths that
start with /dev/ or /sys/block/ are resolved automatically in
do_read_reg() before processing, and the resolved sysfs path is printed
so the caller can see which device was matched.

Signed-off-by: Torstein Eide <torsteine+linux@gmail.com>
Reviewed-by: Avri Altman <avri.altman@sandisk.com>
---
 Makefile           |   8 +-
 docs/HOWTO.rst     |  59 +++++-
 lsmmc.c            | 476 ++++++++++++++++++++-------------------------
 multimediacard.ids |  16 ++
 sdcard.ids         |  23 +++
 5 files changed, 308 insertions(+), 274 deletions(-)
 create mode 100644 multimediacard.ids
 create mode 100644 sdcard.ids

diff --git a/Makefile b/Makefile
index 7631524..bf8c006 100644
--- a/Makefile
+++ b/Makefile
@@ -3,7 +3,9 @@ CC ?= gcc
 # e.g., v1.0-5-2023-10-01
 GIT_VERSION := "$(shell git describe --abbrev=0 --tags)-$$(git rev-list --count $$(git describe --abbrev=0 --tags)..HEAD)-$$(git log -1 --format=%cd --date=short)"
 AM_CFLAGS = -D_FILE_OFFSET_BITS=64 -D_FORTIFY_SOURCE=2 \
-	    -DVERSION=\"$(GIT_VERSION)\"
+	    -DVERSION=\"$(GIT_VERSION)\" \
+	    -DSD_IDS_PATH=\"$(idsdir)/sdcard.ids\" \
+	    -DMMC_IDS_PATH=\"$(idsdir)/multimediacard.ids\"
 CFLAGS ?= -g -O2
 objects = \
 	mmc.o \
@@ -21,6 +23,7 @@ override CFLAGS := $(CHECKFLAGS) $(AM_CFLAGS) $(CFLAGS)
 INSTALL = install
 prefix ?= /usr/local
 bindir = $(prefix)/bin
+idsdir ?= /usr/share/misc
 LIBS=
 RESTORE_LIBS=
 mandir = /usr/share/man
@@ -57,6 +60,9 @@ install: $(progs)
 	$(INSTALL) $(progs) $(DESTDIR)$(bindir)
 	$(INSTALL) -m755 -d $(DESTDIR)$(mandir)/man1
 	$(INSTALL) -m 644 mmc.1 $(DESTDIR)$(mandir)/man1
+	$(INSTALL) -m755 -d $(DESTDIR)$(idsdir)
+	$(INSTALL) -m 644 sdcard.ids $(DESTDIR)$(idsdir)
+	$(INSTALL) -m 644 multimediacard.ids $(DESTDIR)$(idsdir)
 
 -include $(foreach obj,$(objects), $(dir $(obj))/.$(notdir $(obj)).d)
 
diff --git a/docs/HOWTO.rst b/docs/HOWTO.rst
index d454d8c..3739a0a 100644
--- a/docs/HOWTO.rst
+++ b/docs/HOWTO.rst
@@ -35,19 +35,60 @@ Running mmc-utils
         Set user area write protection.
 
     ``csd read  [-h] [-v] [-b bus_type] [-r register]  <device path>``
-        Print CSD data from <device path>. The device path should specify the csd sysfs file directory.
-        if [bus_type] is passed (mmc or sd) the [register] content must be passed as well, and no need for device path.
-        it is useful for cases we are getting the register value without having the actual platform.
+        Print CSD data from <device path>. The device path may be one of the following:
+          - sysfs device directory  (/sys/devices/platform/fe310000.mmc/mmc_host/mmc0/mmc0:0001)
+          - device node (/dev/mmcblkN)
+          - sysfs block device entry (/sys/block/mmcblkN)
+        /dev/ and /sys/block/ paths are resolved to the sysfs device
+        directory automatically and the resolved path is printed.
+        If [-b bus_type] is passed (mmc or sd) the [-r register] content must
+        be passed as well, and no device path is required. Useful when the
+        register value is known without access to the actual hardware.
+
+        Example::
+
+            $ mmc csd read /dev/mmcblk0
+            sysfs: /sys/devices/platform/fe310000.mmc/mmc_host/mmc0/mmc0:0001
+            CSD Register: 00000000...
 
     ``cid read <device path>``
-        Print CID data from <device path>. The device path should specify the cid sysfs file directory.
-        if [bus_type] is passed (mmc or sd) the [register] content must be passed as well, and no need for device path.
-        it is useful for cases we are getting the register value without having the actual platform.
+        Print CID data from <device path>. The device path may be one of the following:
+          - sysfs device directory  (/sys/devices/platform/fe310000.mmc/mmc_host/mmc0/mmc0:0001)
+          - device node (/dev/mmcblkN)
+          - sysfs block device entry (/sys/block/mmcblkN)
+        /dev/ and /sys/block/ paths are resolved to the sysfs device
+        directory automatically and the resolved path is printed.
+        If [-b bus_type] is passed (mmc or sd) the [-r register] content must
+        be passed as well, and no device path is required. Useful when the
+        register value is known without access to the actual hardware.
+
+        Example::
+
+            $ mmc cid read /dev/mmcblk0
+            sysfs: /sys/devices/platform/fe310000.mmc/mmc_host/mmc0/mmc0:0001
+            Manufacturer ID: 0x15
+            OEM ID: 0x0100
+            Product name: MAG4FA
+            Product revision: 1.0
+            Serial number: 0x1a2b3c4d
+            Manufacturing date: 01/2021
 
     ``scr read <device path>``
-        Print SCR data from <device path>. The device path should specify the scr sysfs file directory.
-        if [bus_type] is passed (mmc or sd) the [register] content must be passed as well, and no need for device path.
-        it is useful for cases we are getting the register value without having the actual platform.
+        Print SCR data from <device path>. The device path may be one of the following:
+          - sysfs device directory  (/sys/devices/platform/fe320000.mmc/mmc_host/mmc1/mmc1:aaaa)
+          - device node (/dev/mmcblkN)
+          - sysfs block device entry (/sys/block/mmcblkN)
+        /dev/ and /sys/block/ paths are resolved to the sysfs device
+        directory automatically and the resolved path is printed.
+        If [-b bus_type] is passed (mmc or sd) the [-r register] content must
+        be passed as well, and no device path is required. Useful when the
+        register value is known without access to the actual hardware.
+
+        Example::
+
+            $ mmc scr read /dev/mmcblk1
+            sysfs: /sys/devices/platform/fe320000.mmc/mmc_host/mmc1/mmc1:aaaa
+            SCR Register: 0235800000000000
 
     ``ffu <image name> <device> [chunk-bytes]``
       Default mode.  Run Field Firmware Update with `<image name>` on `<device>`. `[chunk-bytes]` is optional and defaults to its max - 512k. Should be in decimal bytes and sector aligned.
diff --git a/lsmmc.c b/lsmmc.c
index e9df5e1..d5a26b6 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -57,6 +57,13 @@
 #define IDS_MAX			256
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
 
+#ifndef SD_IDS_PATH
+#define SD_IDS_PATH "/usr/share/misc/sdcard.ids"
+#endif
+#ifndef MMC_IDS_PATH
+#define MMC_IDS_PATH "/usr/share/misc/multimediacard.ids"
+#endif
+
 enum bus_type {
 	MMC = 1,
 	SD,
@@ -77,157 +84,6 @@ enum REG_TYPE {
 	SCR,
 };
 
-struct ids_database {
-	int id;
-	char *manufacturer;
-};
-
-static struct ids_database sd_database[] = {
-	{
-		.id = 0x01,
-		.manufacturer = "Panasonic",
-	},
-	{
-		.id = 0x02,
-		.manufacturer = "Toshiba/Kingston/Viking",
-	},
-	{
-		.id = 0x03,
-		.manufacturer = "SanDisk",
-	},
-	{
-		.id = 0x08,
-		.manufacturer = "Silicon Power",
-	},
-	{
-		.id = 0x18,
-		.manufacturer = "Infineon",
-	},
-	{
-		.id = 0x1b,
-		.manufacturer = "Transcend/Samsung",
-	},
-	{
-		.id = 0x1c,
-		.manufacturer = "Transcend",
-	},
-	{
-		.id = 0x1d,
-		.manufacturer = "Corsair/AData",
-	},
-	{
-		.id = 0x1e,
-		.manufacturer = "Transcend",
-	},
-	{
-		.id = 0x1f,
-		.manufacturer = "Kingston",
-	},
-	{
-		.id = 0x27,
-		.manufacturer = "Delkin/Phison",
-	},
-	{
-		.id = 0x28,
-		.manufacturer = "Lexar",
-	},
-	{
-		.id = 0x30,
-		.manufacturer = "SanDisk",
-	},
-	{
-		.id = 0x31,
-		.manufacturer = "Silicon Power",
-	},
-	{
-		.id = 0x33,
-		.manufacturer = "STMicroelectronics",
-	},
-	{
-		.id = 0x41,
-		.manufacturer = "Kingston",
-	},
-	{
-		.id = 0x6f,
-		.manufacturer = "STMicroelectronics",
-	},
-	{
-		.id = 0x74,
-		.manufacturer = "Transcend",
-	},
-	{
-		.id = 0x76,
-		.manufacturer = "Patriot",
-	},
-	{
-		.id = 0x82,
-		.manufacturer = "Gobe/Sony",
-	},
-	{
-		.id = 0x89,
-		.manufacturer = "Unknown",
-	},
-};
-
-static struct ids_database mmc_database[] = {
-	{
-		.id = 0x00,
-		.manufacturer = "SanDisk",
-	},
-	{
-		.id = 0x02,
-		.manufacturer = "Kingston/SanDisk",
-	},
-	{
-		.id = 0x03,
-		.manufacturer = "Toshiba",
-	},
-	{
-		.id = 0x05,
-		.manufacturer = "Unknown",
-	},
-	{
-		.id = 0x06,
-		.manufacturer = "Unknown",
-	},
-	{
-		.id = 0x11,
-		.manufacturer = "Toshiba",
-	},
-	{
-		.id = 0x13,
-		.manufacturer = "Micron",
-	},
-	{
-		.id = 0x15,
-		.manufacturer = "Samsung/SanDisk/LG",
-	},
-	{
-		.id = 0x37,
-		.manufacturer = "KingMax",
-	},
-	{
-		.id = 0x44,
-		.manufacturer = "ATP",
-	},
-	{
-		.id = 0x45,
-		.manufacturer = "SanDisk Corporation",
-	},
-	{
-		.id = 0x2c,
-		.manufacturer = "Kingston",
-	},
-	{
-		.id = 0x70,
-		.manufacturer = "Kingston",
-	},
-	{
-		.id = 0xfe,
-		.manufacturer = "Micron",
-	},
-};
-
 /* Command line parsing functions */
 static void usage(char *progname)
 {
@@ -323,37 +179,73 @@ static int parse_opts(int argc, char **argv, struct config *config)
 
 static char *get_manufacturer(struct config *config, unsigned int manid)
 {
-	struct ids_database *db;
-	unsigned int ids_cnt;
-	int i;
+	char local_path[PATH_MAX];
+	const char *system_path;
+	FILE *f;
+	char name[256];
+	char line[256];
+	const char *local_name;
 
-	if (config->bus == MMC) {
-		db = mmc_database;
-		ids_cnt = ARRAY_SIZE(mmc_database);
-	} else {
-		db = sd_database;
-		ids_cnt = ARRAY_SIZE(sd_database);
+	local_name = (config->bus == MMC) ? "multimediacard.ids" : "sdcard.ids";
+	system_path = (config->bus == MMC) ? MMC_IDS_PATH : SD_IDS_PATH;
+	snprintf(local_path, sizeof(local_path), "%s", local_name);
+
+	f = fopen(local_path, "r");
+	if (!f)
+		f = fopen(system_path, "r");
+	if (!f) {
+		static bool warned;
+
+		if (!warned) {
+			fprintf(stderr, "Warning: ids file not found (%s or %s)\n",
+				local_path, system_path);
+			warned = true;
+		}
+		goto fallback;
 	}
 
-	for (i = 0; i < ids_cnt; i++) {
-		if (db[i].id == manid)
-			return db[i].manufacturer;
+	while (fgets(line, sizeof(line), f)) {
+		unsigned int id;
+		char *nl;
+
+		nl = strchr(line, '\n');
+		if (nl)
+			*nl = '\0';
+
+		if (line[0] == '#' || line[0] == '\0')
+			continue;
+
+		if (sscanf(line, "0x%x %255[^\n]", &id, name) == 2) {
+			if (id == manid) {
+				fclose(f);
+				return strdup(name);
+			}
+		}
 	}
 
-	return NULL;
+	fclose(f);
+fallback:
+	snprintf(name, sizeof(name), "0x%02x", manid);
+	return strdup(name);
 }
 
 /* MMC/SD file parsing functions */
-static char *read_file(char *name)
+static char *read_file_at(const char *dir, const char *name)
 {
+	char path[PATH_MAX];
 	char line[4096];
 	char *preparsed, *start = line;
 	int len;
 	FILE *f;
 
-	f = fopen(name, "r");
+	if (snprintf(path, sizeof(path), "%s/%s", dir, name) >= PATH_MAX) {
+		fprintf(stderr, "Path too long: %s/%s\n", dir, name);
+		return NULL;
+	}
+
+	f = fopen(path, "r");
 	if (!f) {
-		fprintf(stderr, "Could not open MMC/SD file '%s'.\n", name);
+		fprintf(stderr, "Could not open MMC/SD file '%s'.\n", path);
 		return NULL;
 	}
 
@@ -361,20 +253,20 @@ static char *read_file(char *name)
 	if (!preparsed) {
 		if (ferror(f))
 			fprintf(stderr, "Could not read MMC/SD file '%s'.\n",
-				name);
+				path);
 		else
 			fprintf(stderr,
 				"Could not read data from MMC/SD file '%s'.\n",
-				name);
+				path);
 
 		if (fclose(f))
 			fprintf(stderr, "Could not close MMC/SD file '%s'.\n",
-				name);
+				path);
 		return NULL;
 	}
 
 	if (fclose(f)) {
-		fprintf(stderr, "Could not close MMC/SD file '%s'.\n", name);
+		fprintf(stderr, "Could not close MMC/SD file '%s'.\n", path);
 		return NULL;
 	}
 
@@ -393,6 +285,50 @@ static char *read_file(char *name)
 	return strdup(start);
 }
 
+static char *resolve_dev_path(const char *path)
+{
+	const char *devname = strrchr(path, '/');
+	char basedev[NAME_MAX + 1];
+	char syspath[PATH_MAX];
+	char resolved[PATH_MAX];
+	char *p, *type;
+
+	devname = devname ? devname + 1 : path;
+	if (*devname == '\0')
+		return NULL;
+
+	/* strip partition suffix: mmcblk0p1 -> mmcblk0 */
+	snprintf(basedev, sizeof(basedev), "%s", devname);
+	p = basedev + strlen(basedev);
+	while (p > basedev && isdigit((unsigned char)p[-1]))
+		p--;
+	if (p > basedev && p[-1] == 'p')
+		p[-1] = '\0';
+
+	if (snprintf(syspath, sizeof(syspath), "/sys/class/block/%s/device",
+		     basedev) >= PATH_MAX)
+		return NULL;
+
+	if (realpath(syspath, resolved) == NULL) {
+		fprintf(stderr, "Cannot resolve '%s': %s\n", path, strerror(errno));
+		return NULL;
+	}
+
+	type = read_file_at(resolved, "type");
+	if (!type) {
+		fprintf(stderr, "'%s' does not appear to be an MMC/SD device\n", path);
+		return NULL;
+	}
+	if (strcmp(type, "MMC") && strcmp(type, "SD")) {
+		fprintf(stderr, "'%s': unknown device type '%s'\n", path, type);
+		free(type);
+		return NULL;
+	}
+	free(type);
+
+	return strdup(resolved);
+}
+
 /* Hexadecimal string parsing functions */
 static char *to_binstr(char *hexstr)
 {
@@ -511,63 +447,85 @@ static void parse_bin(char *hexstr, char *fmt, ...)
 	free(origstr);
 }
 
-/* MMC/SD information parsing functions */
-static void print_sd_cid(struct config *config, char *cid)
-{
-	static const char *months[] = { "invalid0",
-		"jan", "feb", "mar", "apr", "may", "jun",
-		"jul", "aug", "sep", "oct", "nov", "dec",
-		"invalid1", "invalid2", "invalid3",
-	};
+struct sd_cid {
 	unsigned int mid;
 	char oid[3];
 	char pnm[6];
 	unsigned int prv_major;
 	unsigned int prv_minor;
 	unsigned int psn;
+	unsigned int mdt_year;
 	unsigned int mdt_month;
+	unsigned int crc;
+};
+
+struct mmc_cid {
+	unsigned int mid;
+	unsigned int cbx;
+	unsigned int oid;
+	char pnm[7];
+	unsigned int prv_major;
+	unsigned int prv_minor;
+	unsigned int psn;
 	unsigned int mdt_year;
+	unsigned int mdt_month;
 	unsigned int crc;
-	char *manufacturer = NULL;
+};
+
+static void parse_sd_cid(char *raw, struct sd_cid *c)
+{
+	parse_bin(raw, "8u16a40a4u4u32u4r8u4u7u1r",
+		  &c->mid, &c->oid[0], &c->pnm[0], &c->prv_major, &c->prv_minor,
+		  &c->psn, &c->mdt_year, &c->mdt_month, &c->crc);
+	c->oid[2] = '\0';
+	c->pnm[5] = '\0';
+}
 
-	parse_bin(cid, "8u16a40a4u4u32u4r8u4u7u1r",
-		&mid, &oid[0], &pnm[0], &prv_major, &prv_minor, &psn,
-		&mdt_year, &mdt_month, &crc);
+static void parse_mmc_cid(char *raw, struct mmc_cid *c)
+{
+	parse_bin(raw, "8u6r2u8u48a4u4u32u4u4u7u1r",
+		  &c->mid, &c->cbx, &c->oid, &c->pnm[0], &c->prv_major,
+		  &c->prv_minor, &c->psn, &c->mdt_year, &c->mdt_month, &c->crc);
+	c->pnm[6] = '\0';
+}
 
-	oid[2] = '\0';
-	pnm[5] = '\0';
+/* MMC/SD information parsing functions */
+static void print_sd_cid(struct config *config, char *cid)
+{
+	static const char *months[] = { "invalid0",
+		"jan", "feb", "mar", "apr", "may", "jun",
+		"jul", "aug", "sep", "oct", "nov", "dec",
+		"invalid1", "invalid2", "invalid3",
+	};
+	struct sd_cid c;
+	char *manufacturer;
 
-	manufacturer = get_manufacturer(config, mid);
+	parse_sd_cid(cid, &c);
+	manufacturer = get_manufacturer(config, c.mid);
 
 	if (config->verbose) {
 		printf("======SD/CID======\n");
 
-		printf("\tMID: 0x%02x (", mid);
-		if (manufacturer)
-			printf("%s)\n", manufacturer);
-		else
-			printf("Unlisted)\n");
-
-		printf("\tOID: %s\n", oid);
-		printf("\tPNM: %s\n", pnm);
-		printf("\tPRV: 0x%01x%01x ", prv_major, prv_minor);
-		printf("(%u.%u)\n", prv_major, prv_minor);
-		printf("\tPSN: 0x%08x\n", psn);
-		printf("\tMDT: 0x%02x%01x %u %s\n", mdt_year, mdt_month,
-		       2000 + mdt_year, months[mdt_month]);
-		printf("\tCRC: 0x%02x\n", crc);
+		printf("\tMID: 0x%02x (%s)\n", c.mid, manufacturer);
+
+		printf("\tOID: %s\n", c.oid);
+		printf("\tPNM: %s\n", c.pnm);
+		printf("\tPRV: 0x%01x%01x ", c.prv_major, c.prv_minor);
+		printf("(%u.%u)\n", c.prv_major, c.prv_minor);
+		printf("\tPSN: 0x%08x\n", c.psn);
+		printf("\tMDT: 0x%02x%01x %u %s\n", c.mdt_year, c.mdt_month,
+		       2000 + c.mdt_year, months[c.mdt_month]);
+		printf("\tCRC: 0x%02x\n", c.crc);
 	} else {
-		if (manufacturer)
-			printf("manufacturer: '%s' '%s'\n",
-			       manufacturer, oid);
-		else
-			printf("manufacturer: 'Unlisted' '%s'\n", oid);
+		printf("manufacturer: '%s' '%s'\n", manufacturer, c.oid);
 
-		printf("product: '%s' %u.%u\n", pnm, prv_major, prv_minor);
-		printf("serial: 0x%08x\n", psn);
-		printf("manufacturing date: %u %s\n", 2000 + mdt_year,
-		       months[mdt_month]);
+		printf("product: '%s' %u.%u\n", c.pnm, c.prv_major, c.prv_minor);
+		printf("serial: 0x%08x\n", c.psn);
+		printf("manufacturing date: %u %s\n", 2000 + c.mdt_year,
+		       months[c.mdt_month]);
 	}
+
+	free(manufacturer);
 }
 
 static void print_mmc_cid(struct config *config, char *cid)
@@ -577,32 +535,18 @@ static void print_mmc_cid(struct config *config, char *cid)
 		"jul", "aug", "sep", "oct", "nov", "dec",
 		"invalid1", "invalid2", "invalid3",
 	};
-	unsigned int mid;
-	unsigned int cbx;
-	unsigned int oid;
-	char pnm[7];
-	unsigned int prv_major;
-	unsigned int prv_minor;
-	unsigned int psn;
-	unsigned int mdt_month;
-	unsigned int mdt_year;
-	unsigned int crc;
-	char *manufacturer = NULL;
+	struct mmc_cid c;
+	char *manufacturer;
 	int base_year = 1997;
 
-	parse_bin(cid, "8u6r2u8u48a4u4u32u4u4u7u1r",
-		&mid, &cbx, &oid, &pnm[0], &prv_major, &prv_minor, &psn,
-		&mdt_month, &mdt_year, &crc);
-
-	pnm[6] = '\0';
-
-	manufacturer = get_manufacturer(config, mid);
+	parse_mmc_cid(cid, &c);
+	manufacturer = get_manufacturer(config, c.mid);
 
 	if (config->ext_csd_rev) {
 		/* Adjust base year according to ext_csd_rev */
 		if (config->ext_csd_rev > 8) {
 			base_year = 2029;
-			if (mdt_year >= 13)
+			if (c.mdt_year >= 13)
 				base_year = 2013;
 		} else if (config->ext_csd_rev > 4) {
 			base_year = 2013;
@@ -613,14 +557,10 @@ static void print_mmc_cid(struct config *config, char *cid)
 	if (config->verbose) {
 		printf("======MMC/CID======\n");
 
-		printf("\tMID: 0x%02x (", mid);
-		if (manufacturer)
-			printf("%s)\n", manufacturer);
-		else
-			printf("Unlisted)\n");
+		printf("\tMID: 0x%02x (%s)\n", c.mid, manufacturer);
 
-		printf("\tCBX: 0x%01x (", cbx);
-		switch (cbx) {
+		printf("\tCBX: 0x%01x (", c.cbx);
+		switch (c.cbx) {
 		case 0:
 			printf("card)\n");
 			break;
@@ -635,32 +575,31 @@ static void print_mmc_cid(struct config *config, char *cid)
 			break;
 		}
 
-		printf("\tOID: 0x%01x\n", oid);
-		printf("\tPNM: %s\n", pnm);
-		printf("\tPRV: 0x%01x%01x ", prv_major, prv_minor);
-		printf("(%u.%u)\n", prv_major, prv_minor);
-		printf("\tPSN: 0x%08x\n", psn);
-		printf("\tMDT: 0x%01x%01x %u %s\n", mdt_month, mdt_year,
-		       base_year + mdt_year, months[mdt_month]);
+		printf("\tOID: 0x%01x\n", c.oid);
+		printf("\tPNM: %s\n", c.pnm);
+		printf("\tPRV: 0x%01x%01x ", c.prv_major, c.prv_minor);
+		printf("(%u.%u)\n", c.prv_major, c.prv_minor);
+		printf("\tPSN: 0x%08x\n", c.psn);
+		printf("\tMDT: 0x%01x%01x %u %s\n", c.mdt_month, c.mdt_year,
+		       base_year + c.mdt_year, months[c.mdt_month]);
 		if (!config->ext_csd_rev)
 			printf("\tWarn: ext_csd_rev not provided, "
 			       "manufacturing date year may be wrong.\n");
-		printf("\tCRC: 0x%02x\n", crc);
+		printf("\tCRC: 0x%02x\n", c.crc);
 	} else {
-		if (manufacturer)
-			printf("manufacturer: 0x%02x (%s) oid: 0x%01x\n",
-			       mid, manufacturer, oid);
-		else
-			printf("manufacturer: 0x%02x (Unlisted) oid: 0x%01x\n", mid, oid);
+		printf("manufacturer: 0x%02x (%s) oid: 0x%01x\n",
+		       c.mid, manufacturer, c.oid);
 
-		printf("product: '%s' %u.%u\n", pnm, prv_major, prv_minor);
-		printf("serial: 0x%08x\n", psn);
-		printf("manufacturing date: %u %s\n", base_year + mdt_year,
-		       months[mdt_month]);
+		printf("product: '%s' %u.%u\n", c.pnm, c.prv_major, c.prv_minor);
+		printf("serial: 0x%08x\n", c.psn);
+		printf("manufacturing date: %u %s\n", base_year + c.mdt_year,
+		       months[c.mdt_month]);
 		if (!config->ext_csd_rev)
 			printf("Warn: ext_csd_rev not provided, "
 			       "manufacturing date year may be wrong.\n");
 	}
+
+	free(manufacturer);
 }
 
 static void print_sd_csd(struct config *config, char *csd)
@@ -2244,12 +2183,12 @@ static int process_reg_from_file(struct config *config, enum REG_TYPE reg)
 
 	switch (reg) {
 	case CID:
-		reg_content = read_file("cid");
+		reg_content = read_file_at(config->dir, "cid");
 		ret = process_reg(config, reg_content, CID);
 
 		break;
 	case CSD:
-		reg_content = read_file("csd");
+		reg_content = read_file_at(config->dir, "csd");
 		ret = process_reg(config, reg_content, CSD);
 
 		break;
@@ -2257,7 +2196,7 @@ static int process_reg_from_file(struct config *config, enum REG_TYPE reg)
 		if (config->bus != SD)
 			break;
 
-		reg_content = read_file("scr");
+		reg_content = read_file_at(config->dir, "scr");
 		ret = process_reg(config, reg_content, SCR);
 
 		break;
@@ -2276,19 +2215,13 @@ static int process_dir(struct config *config, enum REG_TYPE reg)
 	char *type = NULL;
 	int ret = 0;
 
-	if (chdir(config->dir) < 0) {
-		fprintf(stderr,
-			"MMC/SD information directory '%s' does not exist.\n",
-			config->dir);
-		return -1;
-	}
-
-	type = read_file("type");
+	type = read_file_at(config->dir, "type");
 	if (!type) {
 		fprintf(stderr,
 			"Could not read card interface type in directory '%s'.\n",
 			config->dir);
-		return -1;
+		ret = -1;
+		goto err;
 	}
 
 	if (strcmp(type, "MMC") && strcmp(type, "SD")) {
@@ -2316,6 +2249,21 @@ static int do_read_reg(int argc, char **argv, enum REG_TYPE reg)
 	if (ret)
 		return ret;
 
+	if (cfg.dir &&
+	    (strncmp(cfg.dir, "/dev/", 5) == 0 ||
+	     strncmp(cfg.dir, "/sys/block/", 11) == 0)) {
+		char *sysfs = resolve_dev_path(cfg.dir);
+
+		if (!sysfs) {
+			free(cfg.dir);
+			return -1;
+		}
+
+		free(cfg.dir);
+		cfg.dir = sysfs;
+		printf("sysfs: %s\n", cfg.dir);
+	}
+
 	if (cfg.dir) {
 		ret = process_dir(&cfg, reg);
 		free(cfg.dir);
diff --git a/multimediacard.ids b/multimediacard.ids
new file mode 100644
index 0000000..0c91118
--- /dev/null
+++ b/multimediacard.ids
@@ -0,0 +1,16 @@
+# MMC manufacturer IDs
+# This file is maintained at: https://git.kernel.org/pub/scm/utils/mmc/mmc-utils.git
+0x00 SanDisk
+0x02 Kingston/SanDisk
+0x03 Toshiba
+0x05 Unknown
+0x06 Unknown
+0x11 Toshiba
+0x13 Micron
+0x15 Samsung/SanDisk/LG
+0x37 KingMax
+0x44 ATP
+0x45 SanDisk Corporation
+0x2c Kingston
+0x70 Kingston
+0xfe Micron
diff --git a/sdcard.ids b/sdcard.ids
new file mode 100644
index 0000000..cbddcae
--- /dev/null
+++ b/sdcard.ids
@@ -0,0 +1,23 @@
+# SD card (secure digital) manufacturer IDs
+# This file is maintained at: https://git.kernel.org/pub/scm/utils/mmc/mmc-utils.git
+0x01 Panasonic
+0x02 Toshiba/Kingston/Viking
+0x03 SanDisk
+0x08 Silicon Power
+0x18 Infineon
+0x1b Transcend/Samsung
+0x1c Transcend
+0x1d Corsair/AData
+0x1e Transcend
+0x1f Kingston
+0x27 Delkin/Phison
+0x28 Lexar
+0x30 SanDisk
+0x31 Silicon Power
+0x33 STMicroelectronics
+0x41 Kingston
+0x6f STMicroelectronics
+0x74 Transcend
+0x76 Patriot
+0x82 Gobe/Sony
+0x89 Unknown
-- 
2.53.0

