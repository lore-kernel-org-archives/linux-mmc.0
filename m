Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C102B385D64
	for <linux-mmc@vger.kernel.org>; Tue, 12 May 2026 17:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778605706; cv=none; b=SeDxzqMYoA/A0jlpirHhj87/Ge3F+eNlRwxUlQY3Cns1oAkmLO3KXg2v/o/4dZEZQVDJTUbx0dqzpD8ScH79ivI/mO6CNJEU5057yTLGnRJV/CQo148CAaytAaPo3Okdlukl/TrvRmTxzKD2T9ANg8Ykx0uS/8PhKeMBKljWAZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778605706; c=relaxed/simple;
	bh=SyrUESmwZsrR4jGC6LG+A/F1NHgl2w8650H8i6QSFsI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z3d6Tk91xsHZJ02zPpzeIMg5TOMkCdw+FLl+M8jqWrfzcgUCYEo7mSFgHGAabjzrrWx17HWgSTs9q4Pb2bHBzpp+WkjHoklADgICOulwlcYA/tvCfxiVXteYT3r2Rv+MjDlmeoeGQ0AtXCnIMiN6NR2w9NfDIClRixeZOTEdoCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbWjS4f/; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbWjS4f/"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-bd36614d329so58690866b.3
        for <linux-mmc@vger.kernel.org>; Tue, 12 May 2026 10:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778605703; x=1779210503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9r839mf11hRZMeKh84WlyPan24QeXae8cSvOtpTkprM=;
        b=fbWjS4f/8on0AtPbb11MD5p0T8Y7+uD8BguDqLpSP0s/PY/LJrVSArO4SRi8yEVAxB
         f3YzoIWoo+sqrEOTXuXasRTztmaHHZ9vaojNVKieW5mPPtighFLGth7sPPL1JckyTX/h
         ohdC3fVUvZKeRCcP8xuw1+Cqsq38w1L2G4ycsCvclfTuNAhKikxjMSLyBnUmk3xT7TI0
         /xTryVIfK0sfC6F/rcHVwNruPhbkDh4wOZZqC9hDAYu3PaOou2JO14NkFyRLxkdMW4mA
         0pgbuU5sRqZAAl1IUXZAsFMB3Z1th34M3yC/knOk+xry1STgAgwztuBlEGB6vhYF/BZO
         34Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778605703; x=1779210503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9r839mf11hRZMeKh84WlyPan24QeXae8cSvOtpTkprM=;
        b=QlEVPjN13Vh6aa004TbFEWlczdrs8L4TCo73fBzrB0SQl/cs0BTmt33uSw7Q2KX2eJ
         /cxjY/TfqSCZDXLzU57BzyQTKl+1W4/gqzRhON1SfS6IC4S1WdPPO/8R/yf5PCvdc20N
         ZsQudIAC3KmvQSrZG3chYLSl+8naeL06RW9f0igrbRk86O1U7ZjR9CMQ58GQSGlaRUKr
         414odTaWUty7ZhMTm0aNubP0smSve5gukSRtxNCohSqHgItVyDMFmzdP7hyFI5MlaH79
         hK9KsMRypflwtLBoh91V8x0uDbb+fDlzjRptv4IeEBQRWNgWCvk2uoBcaIFJ9T9XX9lc
         tFFw==
X-Gm-Message-State: AOJu0YywzPo9qXlxBRhHaz8w3KuF76Gt+WeXHPdE6m+ZWMpt4y7Q1N0l
	9sKA6cY0+pkLcV8ZPJRpmCLqflxzzk4xDPCAhrYfOLomADVkmDwRFOZsg5pzDq/p+oI=
X-Gm-Gg: Acq92OF7ag+15kAR5dgc3k7xKRbU78JQ+Gj1fJXse4LoTgNObA5TGeoXQrxb4DuPJce
	DOSg0iA1/+OOwMxChFjwa2edtq/3ne8PHlOI/Tm8PK37QQMfwZcFBzNaF/6weQtmY7ySR7UEgIK
	ljwcmFdXXh1IpdVbNwcAWrFx3IoD7TrvzDPlLBygfZY77jnIqLCpAGew1E18Zqn+sApO9Pi/9cY
	0RZ7PaZGvdi4/nrKj6J55wpfDZXaeSWzvXcGg08HSR+33F5GXiL4V6CbwfD8Rj9Kj4r693hzrp7
	iar6a/hYC2KgU9TDXjgh1Re2A99QxGusGcUmzz963HNw/JFu7yNTPj/7ngtwdV/XVdWnYw/McBX
	ASw6AxTo5CxB1ANX0hzAkxcp0n0Hq33/1ALYZ9KQR/OugM0ExPDqBlDlxLg/lBfcaq2jNqdNa8N
	j0Dt4o62b9i9ZufFNeylG9Yw+2tmuoDMjSbP84TIURWPsKW5N1
X-Received: by 2002:a17:907:78a:b0:baa:f6c9:51b2 with SMTP id a640c23a62f3a-bd28f09086amr260951866b.23.1778605703031;
        Tue, 12 May 2026 10:08:23 -0700 (PDT)
Received: from torstein-laptop ([2a01:799:3a1:9700:132c:48b3:4466:1640])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-bcd9decf173sm482460266b.43.2026.05.12.10.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 10:08:22 -0700 (PDT)
From: Torstein Eide <torsteine@gmail.com>
X-Google-Original-From: Torstein Eide <torsteine+linux@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Torstein EIde <torsteine+linux@gmail.com>
Subject: [PATCH 1/1] mmc-utils: lsmmc: Use external .ids files for manufacturer lookup
Date: Tue, 12 May 2026 19:08:04 +0200
Message-ID: <20260512170805.36123-1-torsteine+linux@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Torstein EIde <torsteine+linux@gmail.com>

Similar to pci.ids and usb.ids, move the statically defined manufacturer
ID arrays out of the source and into external sdcard.ids and
multimediacard.ids files. This allows other programs to use the same
database without an API, ABI, or cmd interface.

Make the program able to read from the base directory to test without
installing.

Make it possible from the Makefile to change the install directory of
the database.
---
 Makefile           |   8 +-
 lsmmc.c            | 219 +++++++++++----------------------------------
 multimediacard.ids |  16 ++++
 sdcard.ids         |  23 +++++
 4 files changed, 100 insertions(+), 166 deletions(-)
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
index 799e1ea..225c753 100644
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
+
+	while (fgets(line, sizeof(line), f)) {
+		unsigned int id;
+		char *nl;
+
+		nl = strchr(line, '\n');
+		if (nl)
+			*nl = '\0';
 
-	for (i = 0; i < ids_cnt; i++) {
-		if (db[i].id == manid)
-			return db[i].manufacturer;
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
@@ -2220,6 +2105,8 @@ static int process_dir(struct config *config, enum REG_TYPE reg)
 	char *type = NULL;
 	int ret = 0;
 
+	config->ids_dir = getcwd(NULL, 0);
+
 	if (chdir(config->dir) < 0) {
 		fprintf(stderr,
 			"MMC/SD information directory '%s' does not exist.\n",
@@ -2247,6 +2134,8 @@ static int process_dir(struct config *config, enum REG_TYPE reg)
 
 err:
 	free(type);
+	free(config->ids_dir);
+	config->ids_dir = NULL;
 
 	return ret;
 }
diff --git a/multimediacard.ids b/multimediacard.ids
new file mode 100644
index 0000000..233cd53
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
index 0000000..a2022ba
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

