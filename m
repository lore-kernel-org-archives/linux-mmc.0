Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F4431A56C
	for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 08:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834130; cv=none; b=Dop71mYkTyETpgxgHZZt7sXzoQvRaGHqMsW7Q4OOOgwqt4yFTIGOVsgJy5YHvdwbTHtiPuwNgtmciZb3KaZsLWmdEEMPhEGG3Nc64oQnIZ3fTobuk1aPE1dixS1/mPumfi58nFiUJ0UWHTSz/LyLkKZIvhvJKQPconmSZXzzj0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834130; c=relaxed/simple;
	bh=JRA3CwODzyRcK7pqPuQHOPBxC8Dwi/FeD01Xd+9KoDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RwjhmuRQAdrIPJGT+SYBzxfeYvYkamzXdBjJtETG3Db14/5BuUOPzMdc7ewZ4BPmFEXg2bRnqD4D5gdOtzS3nyEXpGGbJjSyjydWQAYcW5B+jIUbCexQPgZWb8WP/rTzeeBwMX2/mN/tmleicuFEkFNbH+0nHRJH9aEcHz9+NcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o7ckgkzV; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o7ckgkzV"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bd01481e592so725485166b.2
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 01:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778834127; x=1779438927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmrimgkUCCYnZGRY6cNPLMElksw9kJSWZkHq9HWtDCo=;
        b=o7ckgkzVtsORZTcYwSdieeiJdUDhIoUlrrSV4Mw6CV0tAD67tqIxB5HBQRXl1oQpDS
         CEIoe/fTJRto8oS+YEDZtRSAuHxe0sM5HPjldxEikA73sdUJgHtfn2VJkU5XbqxlI/YF
         E8ViDzrHrh1Qx0PFi72XIdw97wS5nzGboXD3mDaeDV5+pYyZOwrSmszeTsKrfSFmTXJz
         wZib90vv26P7zXxwXrFYTrS7IFDbe1qggdDUrBHBLgaQ9lvhMdK5loYAyTdYvbvB7HbA
         wHTp5thtCDnBMiPtKXWyJVBX3rMhhLcbZyiv6CWG3jHJ4Rt196pieNwyz9Blqi/WT+A6
         19ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778834127; x=1779438927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nmrimgkUCCYnZGRY6cNPLMElksw9kJSWZkHq9HWtDCo=;
        b=jZiroQFWra/b/8CuyYrMPnwIorcNIbg/AEVqsXtLSjWVeUwMtkSxAbP6v4GxX6rNUR
         WuWq6DwNa7ZqiNOdWkJyJWTxGhHNXske6jkPcPkyP0iWp2WXa4je3CMgWQT7M5WckHQA
         BJjh9UL2eq1+x5hOwUjo0EH+PFIKkNL5jbnYIJmDhDMzGVmg7mPBOgVQa5V8a4APJXM3
         1MYSXKdaRr5OthhlirThdLGTAyqNPUMf0CfUmz8hjkPPQEhLFUUCBkqV8zhKW5zjDtXk
         e+AeamgXZmjUAEXjwKDencOYpDJBNJyOwqGDGyL9ic5veI+XMg2TrZVxke8vdTcixDOB
         YArg==
X-Gm-Message-State: AOJu0YwGa1cEPkS1DHSAk8WjZpuTEdQgP8DTT6DIV42oPeOpbJxCHjVY
	uQz3AmuDP8Z6UgnJcWEpL6l9IxUvKtxdX/BQcEyGjXkG5BRIVI7hZzYL3Srj6JJO
X-Gm-Gg: Acq92OFos7sQOJcm3MfK9wMEwynimexCqGf578eMGX4Z3KKeILv3WXuOStSRHhP5BD/
	JOsEcBdg6nuhd2c2OoI07/IL/xCfwsjuJYiDSKmeca9W2/MYSoVc4o8jL6DmWQT69EnG4InFduv
	BE4I3wmfx9AG8+VfssbZ9ur6l3bmxZZ9Ic+LYujE/+sTIhVCTBkCTsUaH2L4eGgZmf9J0yqzJlJ
	jd9oRxpfoulIwnsmHuBH1L3N37KnojTGa1eaFPU0coDtWh2FjRQ6c3e3xEOm07GCynLVw+5YQ2+
	CES2omalQWLUWXT0db3hC4vMoERoK7E3to5tbWAK0/1TjJktLCq4l43LUSAopUZxdj7LqUchJZu
	a9zrJRTda+V3wCJqCRPF3VTXR89ZlsoDKsxIMRY7CsVzAeY04GNGV24WLNzGlPZMP4kEWYPZ2D5
	FoH2xhMH4N0I9lQipRHR3MeGkN6siUqHi1vIVW
X-Received: by 2002:a17:907:3cc1:b0:bd5:7c3:69d with SMTP id a640c23a62f3a-bd517abc6d7mr143457166b.48.1778834126734;
        Fri, 15 May 2026 01:35:26 -0700 (PDT)
Received: from torstein-laptop ([2a01:799:3a1:9700:a66:143b:cd2f:c4ae])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-bd4f4dec7d1sm189493566b.32.2026.05.15.01.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 01:35:26 -0700 (PDT)
From: Torstein Eide <torsteine@gmail.com>
X-Google-Original-From: Torstein Eide <torsteine+linux@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Torstein Eide <torsteine+linux@gmail.com>
Subject: [PATCH 1/4] mmc-utils: lsmmc: Use external .ids files for manufacturer lookup
Date: Fri, 15 May 2026 10:34:54 +0200
Message-ID: <20260515083457.3690804-2-torsteine+linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515083457.3690804-1-torsteine+linux@gmail.com>
References: <20260515083457.3690804-1-torsteine+linux@gmail.com>
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

Signed-off-by: Torstein Eide <torsteine+linux@gmail.com>
---
 Makefile           |   8 +-
 lsmmc.c            | 225 ++++++++++++---------------------------------
 multimediacard.ids |  16 ++++
 sdcard.ids         |  23 +++++
 4 files changed, 104 insertions(+), 168 deletions(-)
 create mode 100644 multimediacard.ids
 create mode 100644 sdcard.ids

diff --git a/Makefile b/Makefile
index c0284bb..11685b9 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,9 @@
 CC ?= gcc
 GIT_VERSION := "$(shell git describe --abbrev=6 --always --tags)"
 AM_CFLAGS = -D_FILE_OFFSET_BITS=64 -D_FORTIFY_SOURCE=2 \
-	    -DVERSION=\"$(GIT_VERSION)\"
+	    -DVERSION=\"$(GIT_VERSION)\" \
+	    -DSD_IDS_PATH=\"$(idsdir)/sdcard.ids\" \
+	    -DMMC_IDS_PATH=\"$(idsdir)/multimediacard.ids\"
 CFLAGS ?= -g -O2
 objects = \
 	mmc.o \
@@ -19,6 +21,7 @@ override CFLAGS := $(CHECKFLAGS) $(AM_CFLAGS) $(CFLAGS)
 INSTALL = install
 prefix ?= /usr/local
 bindir = $(prefix)/bin
+idsdir ?= /usr/share/misc
 LIBS=
 RESTORE_LIBS=
 mandir = /usr/share/man
@@ -55,6 +58,9 @@ install: $(progs)
 	$(INSTALL) $(progs) $(DESTDIR)$(bindir)
 	$(INSTALL) -m755 -d $(DESTDIR)$(mandir)/man1
 	$(INSTALL) -m 644 mmc.1 $(DESTDIR)$(mandir)/man1
+	$(INSTALL) -m755 -d $(DESTDIR)$(idsdir)
+	$(INSTALL) -m 644 sdcard.ids $(DESTDIR)$(idsdir)
+	$(INSTALL) -m 644 multimediacard.ids $(DESTDIR)$(idsdir)
 
 -include $(foreach obj,$(objects), $(dir $(obj))/.$(notdir $(obj)).d)
 
diff --git a/lsmmc.c b/lsmmc.c
index 799e1ea..113f371 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -56,6 +56,13 @@
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
@@ -63,6 +70,7 @@ enum bus_type {
 
 struct config {
 	char *dir;
+	char *ids_dir;
 	bool verbose;
 
 	enum bus_type bus;
@@ -75,157 +83,6 @@ enum REG_TYPE {
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
@@ -319,25 +176,53 @@ static int parse_opts(int argc, char **argv, struct config *config)
 	return 0;
 }
 
-static char *get_manufacturer(struct config *config, unsigned int manid)
+static const char *get_manufacturer(struct config *config, unsigned int manid)
 {
-	struct ids_database *db;
-	unsigned int ids_cnt;
+	const char *paths[] = {NULL, NULL};
+	char local_path[PATH_MAX];
 	int i;
+	FILE *f;
+	static char name[256];
+	char line[256];
+	const char *local_name;
+
+	local_name = (config->bus == MMC) ? "multimediacard.ids" : "sdcard.ids";
+	/* check local directory first, then fall back to system path */
+	if (config->ids_dir)
+		snprintf(local_path, sizeof(local_path), "%s/%s", config->ids_dir, local_name);
+	else
+		snprintf(local_path, sizeof(local_path), "%s", local_name);
+	paths[0] = local_path;
+	paths[1] = (config->bus == MMC) ? MMC_IDS_PATH : SD_IDS_PATH;
 
-	if (config->bus == MMC) {
-		db = mmc_database;
-		ids_cnt = ARRAY_SIZE(mmc_database);
-	} else {
-		db = sd_database;
-		ids_cnt = ARRAY_SIZE(sd_database);
+	for (i = 0; i < 2; i++) {
+		f = fopen(paths[i], "r");
+		if (f)
+			break;
 	}
+	if (!f)
+		return NULL;
 
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
+				return name;
+			}
+		}
 	}
 
+	fclose(f);
 	return NULL;
 }
 
@@ -526,7 +411,7 @@ static void print_sd_cid(struct config *config, char *cid)
 	unsigned int mdt_month;
 	unsigned int mdt_year;
 	unsigned int crc;
-	char *manufacturer = NULL;
+	const char *manufacturer = NULL;
 
 	parse_bin(cid, "8u16a40a4u4u32u4r8u4u7u1r",
 		&mid, &oid[0], &pnm[0], &prv_major, &prv_minor, &psn,
@@ -585,7 +470,7 @@ static void print_mmc_cid(struct config *config, char *cid)
 	unsigned int mdt_month;
 	unsigned int mdt_year;
 	unsigned int crc;
-	char *manufacturer = NULL;
+	const char *manufacturer = NULL;
 
 	parse_bin(cid, "8u6r2u8u48a4u4u32u4u4u7u1r",
 		&mid, &cbx, &oid, &pnm[0], &prv_major, &prv_minor, &psn,
@@ -2220,11 +2105,14 @@ static int process_dir(struct config *config, enum REG_TYPE reg)
 	char *type = NULL;
 	int ret = 0;
 
+	config->ids_dir = getcwd(NULL, 0);
+
 	if (chdir(config->dir) < 0) {
 		fprintf(stderr,
 			"MMC/SD information directory '%s' does not exist.\n",
 			config->dir);
-		return -1;
+		ret = -1;
+		goto err;
 	}
 
 	type = read_file("type");
@@ -2232,7 +2120,8 @@ static int process_dir(struct config *config, enum REG_TYPE reg)
 		fprintf(stderr,
 			"Could not read card interface type in directory '%s'.\n",
 			config->dir);
-		return -1;
+		ret = -1;
+		goto err;
 	}
 
 	if (strcmp(type, "MMC") && strcmp(type, "SD")) {
@@ -2247,6 +2136,8 @@ static int process_dir(struct config *config, enum REG_TYPE reg)
 
 err:
 	free(type);
+	free(config->ids_dir);
+	config->ids_dir = NULL;
 
 	return ret;
 }
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

