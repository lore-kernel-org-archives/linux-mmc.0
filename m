Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B293ED5BE
	for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 21:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778881094; cv=none; b=MubEI8PjyEnVtSJCmnOYrT+FSBG/uaFM2VV6j1iRMTlOo6tCkf4pmIUEHnk4vNVK60TvvCx1qX0/scXaSk6Zq5R5jTuX+Ea3S9pHU2lZH/4UtXo33n9TN+Jd7SLi2SXZZROS2PHRIvcaZ9Ol5XotdwnusYrvF8lRHobDFN0kmMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778881094; c=relaxed/simple;
	bh=6jmT6uMAICyH8mXRBkLMxtdsSQRl8oBnxNAZ7hyugFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/F2O/gB7Zmt7fYihB9lycPq11aQtJXmwD/ox7P9PPu1wC8MCXCSewsYZTsVx9WMHV8CXSFRShSsZABdnlJj7EKBlAbE5CAjsT8NEE4wnmik5+E+WEwY/79gUs/yIKD/Zl4ZqloIwDo2LHET1/MzzplchGJmOy1AUwi8k2waXhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/Q2mQx/; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/Q2mQx/"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-67c9616b4feso642948a12.1
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 14:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778881091; x=1779485891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghWOgvnmSjVmFnBsPh3ZuMwTtDH/qodJxmi0ZmYCSXc=;
        b=I/Q2mQx/6bOh8NAeYdMYUb/sKDbhRxliImx4ybi3W71b9L+RmBZXBShhVw+JVYQF6D
         78JImrsgtrpeF5cxXWou8svZGBnhQIHyB7/olMT86oc1Zva3sw3bmPDCWYBhUqIUP5Yn
         JdCSU+d72YTM8RdJM5yPR8IasCYfLEjE+01DNiPMbvTNCx6Qqr3VeOhjpRa4YjNAqLAh
         ++H7r9XRsa3GVW1VC+t1iU1cbFw9D3iC8hFRyDssubg5mipt4RKvCkA0Y9ihK1bkmgWQ
         faXIKs/rW2A2IxxLMrMQhm9wTuPky+h6eYmat+EKH5so9KCHOuagcc5aNB1YssIQU1lh
         S77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778881091; x=1779485891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ghWOgvnmSjVmFnBsPh3ZuMwTtDH/qodJxmi0ZmYCSXc=;
        b=W9O5nS92vC/yLt+9ectrPF+ia2G8lmZ1nvhh5xBej2YTBF56wTWkesGEqAqR66WOD1
         fMclyjTT+d/WFXSj499243aq6IOJkI6Sn4sjmEN/DAywC8iEyHW6NhdYXk+0qgcIk/jZ
         Ryyn3sbQTaKNlJflyG76fA/KmJz5WACVQnJNnv5js7NQOU4b7LptLdT3sGAC0B7IXFOe
         M79OSaZbG18Aj9Hk96nDn0U0I3QtvoXZUZ/qWZqgesPpVzMhLQHbTdqOLy+lQYtRKcPw
         JtQgjEBv3p5TSW2sEeP6k1sM+ZZMNUbrLsjK63nmqDCn4Ze5Vw3m8IAcrpsa4XG3MH2B
         pJ/A==
X-Gm-Message-State: AOJu0Yzy+Y4JdX1Ae5jHFSYHzThCIfsCDJuBvfPhTFDZ2au2TXBWD2rn
	u+s/89fKYqVwAgjR6t6dyU7MsMUw8zuIy50b4TBwHyYZtfeLf7KxgGQMID0YHrcW
X-Gm-Gg: Acq92OFuuZpWf5cETCgyhY8M1eCTz8+7Aqkxing25GYVwaw9cFo3D8RS6nO8xOP0pw8
	LMkYe/0J/di3LWozaixPa2whNZt/3Y/oSHH80FukW0h32bJlqxu51V3svmzt1Jz8LAMl9odWbhT
	zcwujYyv6nB94gx7naeg+31BI/lC8HoxrRApKCUb4Q1BGujrN6CSZP3utNR1CFmhYVs7/dHx4JC
	/gEEX3oStdThjrezjHGuonnVR5onCBAY4tjdydq/GfJKvQpRxoF5UmZvUlwszNeXiOjGK3itf1c
	FfdJg2zuYLVNUeSKKeNz2x1q9vf+1vzJu4KAxW/6fGEFcx18lqzXmLPXXKpxMpfMLd1R+XI/nEy
	oLdH8FFLpa6NEvF9HEVEgP/sgVXG9OwnHlGS8NFqbXvaLVcsmFKSbw4uz7OoIQvQua7TcCqXmEN
	i2/4jZGcZjrY2YcQONX1mYIW/jqdekl8vZO6ec
X-Received: by 2002:a05:6402:a204:20b0:674:74bf:8813 with SMTP id 4fb4d7f45d1cf-683bd28e6a2mr2246158a12.21.1778881090637;
        Fri, 15 May 2026 14:38:10 -0700 (PDT)
Received: from torstein-laptop ([2a01:799:3a1:9700:690:4aa1:581c:2e09])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-68310d510fasm2484038a12.11.2026.05.15.14.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:38:09 -0700 (PDT)
From: Torstein Eide <torsteine@gmail.com>
X-Google-Original-From: Torstein Eide <torsteine+linux@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Torstein Eide <torsteine+linux@gmail.com>
Subject: [PATCH v2 2/5] mmc-utils: lsmmc: Use external .ids files for manufacturer lookup
Date: Fri, 15 May 2026 23:37:44 +0200
Message-ID: <20260515213747.1452692-3-torsteine+linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515213747.1452692-1-torsteine+linux@gmail.com>
References: <20260515213747.1452692-1-torsteine+linux@gmail.com>
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
 lsmmc.c            | 252 +++++++++++++--------------------------------
 multimediacard.ids |  16 +++
 sdcard.ids         |  23 +++++
 4 files changed, 116 insertions(+), 183 deletions(-)
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
index 8155a5c..1c55b86 100644
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
@@ -75,157 +82,6 @@ enum REG_TYPE {
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
@@ -321,37 +177,71 @@ static int parse_opts(int argc, char **argv, struct config *config)
 
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
+		return NULL;
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
 
+	fclose(f);
 	return NULL;
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
 
@@ -359,20 +249,20 @@ static char *read_file(char *name)
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
 
@@ -593,6 +483,8 @@ static void print_sd_cid(struct config *config, char *cid)
 		printf("manufacturing date: %u %s\n", 2000 + c.mdt_year,
 		       months[c.mdt_month]);
 	}
+
+	free(manufacturer);
 }
 
 static void print_mmc_cid(struct config *config, char *cid)
@@ -654,6 +546,8 @@ static void print_mmc_cid(struct config *config, char *cid)
 		printf("manufacturing date: %u %s\n", 1997 + c.mdt_year,
 		       months[c.mdt_month]);
 	}
+
+	free(manufacturer);
 }
 
 static void print_sd_csd(struct config *config, char *csd)
@@ -2202,12 +2096,12 @@ static int process_reg_from_file(struct config *config, enum REG_TYPE reg)
 
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
@@ -2215,7 +2109,7 @@ static int process_reg_from_file(struct config *config, enum REG_TYPE reg)
 		if (config->bus != SD)
 			break;
 
-		reg_content = read_file("scr");
+		reg_content = read_file_at(config->dir, "scr");
 		ret = process_reg(config, reg_content, SCR);
 
 		break;
@@ -2234,19 +2128,13 @@ static int process_dir(struct config *config, enum REG_TYPE reg)
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

