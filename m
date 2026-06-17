Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256851ACED5
	for <linux-mmc@vger.kernel.org>; Wed, 17 Jun 2026 17:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781717072; cv=none; b=dvGVbv75CSkY5uXsC3f016yscc2WpLRcQsowG+GBMgMip9vFoVm7An2qcCyoqfzYElCs7WNFEiFpG/VRaXlk+GLxN5L0p/tJbSNC4tR2apq3vt4rgtnyDk1N2qlWPcN55byiUrv4HFqm9zYRAPSWyzWk6XtoUjmFG3yG8M859gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781717072; c=relaxed/simple;
	bh=xgmSY8aLhqKY+mZQK7Uc4E7R+eiHRnomj+ihZVSFycw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GxPZ6q0VyLTvn29jIIE47OmFXneC9lycDh/A1RwlUFkUY+O6d6NW2RLxoc0gwHlfEIdPB8oqiP8MeqgOPbt89UgcG4VyMyvxVZ8/FCvakGG96mfA9Kn2iEQG8DjWmrtaZzKkLgU2Px94Dtm835VU9yhZ8gJ+B84bgX7M5ZU1SIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pwjcCb6L; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pwjcCb6L"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bef47b1ac01so911359066b.2
        for <linux-mmc@vger.kernel.org>; Wed, 17 Jun 2026 10:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781717068; x=1782321868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDOvG7U+SRwFxpB+G3/uZVif0G3ji7rwtJX95LphIqM=;
        b=pwjcCb6LMTrK1fpzmDcaopYhSA2Zmd4aJ73IRODa1sM/JKDS2x0aAFLWk/8AHo21HJ
         gkgGwf0GaNZQMO1LWtfplFbeawOjX54xumu/jPGKIFjb5DqrXurJjrqQNTY6bfbTg+At
         cxF9OudOvWumY1ch/Tn8tPhMWzxjxYGcCZVz22hdXFzJHonk6cywQReVmkSI7FAestv0
         K1bRI7EDspzqJXLzPgxAPrwTq6KrJ+U6ReNj1Ng2C8vvSlYZMqy+TxGChhXhcPTm2vZ1
         rrjIZbe5HaV0IJ7UiWTr4dQAuWFLqM8R0LbfGCni+mHy9thduZXwiv1M/0Vo/Ln+LZDa
         QdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781717068; x=1782321868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MDOvG7U+SRwFxpB+G3/uZVif0G3ji7rwtJX95LphIqM=;
        b=KGVx+dfxiRzQDMnDJZZEtFChIsvqVS/Zb/otRjD4FAjCpFqLUBYNYLh5z9GkRrVLqd
         VWA6gu5QvkouUEzcPQYXpsw4AaNc3fXKEvSDYGsfANd4A3v+j24SXfUtFcc7kvv0/9Sl
         2nno0RKDd6eqjo2EjqPo5Pr/HoxlKU9KylGrEoYO4pihnjm8uWIWlTVdvUsqUQhkoU7J
         GhsK8Zg81Xh4qf0g3p1m+KXhmqaBqtfOzYb6d9joBfk5HqoCc1EEmsQCY2AonbMG0avT
         exB4CQeTwXIO7MDGK3CGzhQqsCF0K5jhFtWIrLe1/2rZnZBYUSi0/HE+Sh4IJxK/EWpE
         ck5A==
X-Gm-Message-State: AOJu0YxgEzyEXVSIKwikkQgCi5bArOPbpLVaWK33TupxMByhXZIf9I+5
	yv7yueOso7JTwifKGDDuEHrbwI9MXKv1UhVkjrbzAwoipsZ6OuNb6iS27b407UJO
X-Gm-Gg: Acq92OGYE0I3yspWhlTSXa4XDkjk+gt1jhADfx6Ms4PZIijO0qOkE9voS7UFoSXgb4H
	qcDlZgZo4iu8P2NXBvrxQ5h6d21D7zqp1uWnRrQhSAovd5R9gV+tKDYz3NTRbmyyLC7QhvmgISi
	4Hzo81jdA9Lex+Km4GBLNHWwASHUwG3SGQBGt9ASym/R/obmWXl2u+YoDnoWDfcX7VnLPk7AutC
	SD+oRKLOJpLek3dTChdeCPgEtHL2P1XSsgxL+jteQqj7mRlZCwvBchkwrnSEqWcQ2d6Piy/9ief
	ESVJPkgPFfVHZ3Q8NvS2XdNBdGawBiqXIuVZWGpU8Ht+mJATL1/mxtPm9doTLdztx00+25ys5n1
	SgY+rTJBOjYNGAn9rEXdTOo8PY1aHduSfFubZu4Vv6EB/f+1fqkQCzHJsnpiXJw2WChh21Urg6X
	I9RazC7SyMPSlQdS/cPI9is1QgXPQ=
X-Received: by 2002:a17:907:75e4:b0:bec:5264:e52d with SMTP id a640c23a62f3a-c05a610350cmr243958266b.11.1781717068165;
        Wed, 17 Jun 2026 10:24:28 -0700 (PDT)
Received: from torstein-laptop ([2a01:799:3a1:9700:ec6d:6f56:be28:aea2])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c0463a2d1f4sm323873766b.51.2026.06.17.10.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 10:24:27 -0700 (PDT)
Sender: Torstein Eide <torsteine@gmail.com>
From: Torstein Eide <torsteine+linux@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Torstein Eide <torsteine+linux@gmail.com>,
	Avri Altman <avri.altman@sandisk.com>
Subject: [PATCH v3 1/4] mmc-utils: lsmmc: Use external .ids files for manufacturer lookup
Date: Wed, 17 Jun 2026 19:24:08 +0200
Message-ID: <20260617172411.42805-2-torsteine+linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617172411.42805-1-torsteine+linux@gmail.com>
References: <20260617172411.42805-1-torsteine+linux@gmail.com>
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
Reviewed-by: Avri Altman <avri.altman@sandisk.com>
---
 Makefile           |   8 +-
 lsmmc.c            | 490 +++++++++++++++++++++------------------------
 multimediacard.ids |  16 ++
 sdcard.ids         |  23 +++
 4 files changed, 272 insertions(+), 265 deletions(-)
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
 
diff --git a/lsmmc.c b/lsmmc.c
index e9df5e1..afcf446 100644
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
 
@@ -511,63 +403,85 @@ static void parse_bin(char *hexstr, char *fmt, ...)
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
 
-	parse_bin(cid, "8u16a40a4u4u32u4r8u4u7u1r",
-		&mid, &oid[0], &pnm[0], &prv_major, &prv_minor, &psn,
-		&mdt_year, &mdt_month, &crc);
+static void parse_sd_cid(char *raw, struct sd_cid *c)
+{
+	parse_bin(raw, "8u16a40a4u4u32u4r8u4u7u1r",
+		  &c->mid, &c->oid[0], &c->pnm[0], &c->prv_major, &c->prv_minor,
+		  &c->psn, &c->mdt_year, &c->mdt_month, &c->crc);
+	c->oid[2] = '\0';
+	c->pnm[5] = '\0';
+}
+
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
@@ -577,32 +491,18 @@ static void print_mmc_cid(struct config *config, char *cid)
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
@@ -613,14 +513,10 @@ static void print_mmc_cid(struct config *config, char *cid)
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
@@ -635,32 +531,31 @@ static void print_mmc_cid(struct config *config, char *cid)
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
@@ -2244,12 +2139,12 @@ static int process_reg_from_file(struct config *config, enum REG_TYPE reg)
 
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
@@ -2257,7 +2152,7 @@ static int process_reg_from_file(struct config *config, enum REG_TYPE reg)
 		if (config->bus != SD)
 			break;
 
-		reg_content = read_file("scr");
+		reg_content = read_file_at(config->dir, "scr");
 		ret = process_reg(config, reg_content, SCR);
 
 		break;
@@ -2276,19 +2171,13 @@ static int process_dir(struct config *config, enum REG_TYPE reg)
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
@@ -2326,6 +2215,79 @@ static int do_read_reg(int argc, char **argv, enum REG_TYPE reg)
 	return ret;
 }
 
+static const char *month_name(unsigned int month)
+{
+	static const char *months[] = {
+		"jan", "feb", "mar", "apr", "may", "jun",
+		"jul", "aug", "sep", "oct", "nov", "dec",
+		"invalid0", "invalid1", "invalid2", "invalid3",
+	};
+
+	if (month >= ARRAY_SIZE(months))
+		return "invalid";
+
+	return months[month];
+}
+
+int do_list(int nargs, char **argv)
+{
+	const char *bus_path = "/sys/bus/mmc/devices";
+	DIR *d;
+	struct dirent *ent;
+	bool header_printed = false;
+
+	d = opendir(bus_path);
+	if (!d) {
+		fprintf(stderr, "Cannot open %s\n", bus_path);
+		return -1;
+	}
+
+	struct config cfg = {};
+
+	while ((ent = readdir(d)) != NULL) {
+		char devpath[PATH_MAX];
+		char resolved[PATH_MAX];
+		char *type, *cid, *blkdev;
+
+		if (!strchr(ent->d_name, ':'))
+			continue;
+
+		snprintf(devpath, sizeof(devpath), "%s/%s", bus_path, ent->d_name);
+		if (realpath(devpath, resolved) == NULL)
+			continue;
+
+		type = read_file_at(resolved, "type");
+		if (!type)
+			continue;
+
+		cid = read_file_at(resolved, "cid");
+		if (!cid) {
+			free(type);
+			continue;
+		}
+
+		blkdev = find_block_devname(resolved);
+		cfg.bus = strcmp(type, "MMC") ? SD : MMC;
+
+		if (!header_printed) {
+			printf("%-14s %-14s %-5s%-20s %-10s %-5s %-12s %s\n",
+			       "DEVICE", "DEV", "TYPE", "MANUFACTURER", "PRODUCT",
+			       "REV", "SERIAL", "DATE");
+			header_printed = true;
+		}
+
+		print_list_entry(&cfg, ent->d_name, blkdev, cid);
+
+		free(blkdev);
+		free(cid);
+		free(type);
+	}
+
+	closedir(d);
+	return 0;
+}
+
+
 int do_read_csd(int argc, char **argv)
 {
 	return do_read_reg(argc, argv, CSD);
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

