Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8EE3ED5A8
	for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 21:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778881091; cv=none; b=ROS9sA28uE42lCCTYug9Wu0kIw+8183KLaBy0PattfI+owqlweIZPDw+mciimJON+uxZaLC+BCcIv8YZrAUoIzJI+tgoZWlTJOgoO85dTvbdzO0tTU6MBE4Bs67P7cOaw7XCYXFMLgl69jYbf083pb7QeLrQqKmz+8Jza+/fvi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778881091; c=relaxed/simple;
	bh=XvV3gFV0PQaDMmk6l2mq7mekOaBuv/bVyFW1s4LULBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OF4p4mUSzHb6MinrE5qkGLeChNnLwDXXeqDuGXrbGRoM96amOzg37AJu6ARBfw3LP3ohJmRokkj9g4EvP3akhjYIwGbN6G6NR9vTwICrxm9d2n9SRITpVBAJOsu0kL/fgGGvPrMgmQ3b9Bqu4/48J4f3Cd92s1PkXAk9JvH2dfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MaW57IYM; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaW57IYM"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-67bc6098640so621967a12.0
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 14:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778881088; x=1779485888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMFDZHn6M2vdUl4IIJ1t/sEJlCsmJ8slpG/AtcvMci8=;
        b=MaW57IYMiYSJdlVBvKsPyIA1aysNRzIELVBEYrCK5RfcAUiXfiYZ5e4iYmtKrvzEgE
         L2N/M7KSguQNKWvbUjRAgKU03xrYjAHlzcZFJYLceXIWyDuyC4mOX+HeLI023Um8Au9d
         giWn3RYaiXHm5u3UDfWwCdoo11Y0l25bw0bHuAf7UoQSFdmrAzWIIvfvyoAJXuIXZy8a
         vw1T9Bkmlg571BM98894ThQDR9wJyhIe2J+sOpF/LBZX4rwnhIDP5+asIk9Y2ET7gCz3
         2+uYJxARD9TA51hKesdF6HY9a28eZ+8dCZUlbKPC2Cqa2ZENcBuu5xGLSoFfE361TvnS
         AnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778881088; x=1779485888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tMFDZHn6M2vdUl4IIJ1t/sEJlCsmJ8slpG/AtcvMci8=;
        b=T+ax5eEPlqqB7hhwHXTSrpjivHLtWHEX6z5O5BJT7T38HvwscCFMHI12IjXMtnmLmP
         xPwHa68CmhLDOaQkJVEs9XWwa96Ylubj7zB94W92IiNouutNh5ac2iCbSxi7NzznZfFS
         zQcqKgnUPCzd/nHiFaKgcxey457GixxK+wPwi3VW0UivF7eU1RW0bWWu6Wi4R+4/KPaI
         EDPzVSmqtPYCnZ5fOYBhZ3ekfQEEQmBkP5E+aOwD0LPUENZyKEqs4YtO/FHvIYYSUk/C
         XZcPMmnhWaRS3i4bX1Kb/czvn6zGGqTR+kt70ojxdkgx42UAkvOAAwfUK1wimvlcHxhT
         3E7g==
X-Gm-Message-State: AOJu0YyoeZFpSH71yGdTLVaWSrz7edxRguv/RWymOa0B2Bw8UBlKCTev
	RcRVjwTCdqh9wsWlC0wwZQPnCtKNpHleS2ImVrFZmeK9xEjY/AayHsZ6nP387rNy
X-Gm-Gg: Acq92OHpuk1B8DGYKAMIx7DIaaS9ysdNDyPLxHMs8gSN1DEkCdRv5DCe7OM+pnnMCLv
	0l75Av89Pepj6mRbz2ZV5Uf3K2765acUcQA43dVYGqvYCKdlu3f6r0emGLIPqHXBERy8A1GvCgg
	4tuv0hb0SSmI0GFEMNfN814lDOD9VaDf9dbcvHCRgnApwGdlX7CD3kYBB3pMimG3yB6j0Avcwg1
	uZU8Dq/pU4ezdE+EDAWof43lLBYH+kOhr7UfAW/Tq0lrhLqZmNTrkr0PseZIdrYVTHm4fF49/By
	Y0jNfyO+wPRWg/J+x+mqPm6O+u2g/+ST0xL7faG+VwwiWPpns7bR5CnIM4XOhfoXHzhJXqCgiRh
	z++G02uaupRHFkwdzUJX8FqBDSIcag/2bxqSF+reFClfk2rPf1BOWxBz8stTClEByr1ywJ+dpwl
	1jtSSvyzlq/FJmhYt0z8eBlfrSqPH7kGpl3UPW
X-Received: by 2002:aa7:d689:0:b0:672:f3e:1475 with SMTP id 4fb4d7f45d1cf-683bd38e5dcmr2040466a12.12.1778881087715;
        Fri, 15 May 2026 14:38:07 -0700 (PDT)
Received: from torstein-laptop ([2a01:799:3a1:9700:690:4aa1:581c:2e09])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-68310d510fasm2484038a12.11.2026.05.15.14.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:38:07 -0700 (PDT)
From: Torstein Eide <torsteine@gmail.com>
X-Google-Original-From: Torstein Eide <torsteine+linux@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Torstein Eide <torsteine+linux@gmail.com>
Subject: [PATCH v2 1/5] mmc-utils: lsmmc: Refactor CID parsing into shared structs
Date: Fri, 15 May 2026 23:37:43 +0200
Message-ID: <20260515213747.1452692-2-torsteine+linux@gmail.com>
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

Add struct sd_cid and struct mmc_cid with parse_sd_cid() and
parse_mmc_cid() helpers. Use them in print_sd_cid(), print_mmc_cid()
and print_list_entry() to eliminate duplicated parse_bin() format
strings and local variable lists.

Also fix print_list_entry() using const char * for the strdup'd
manufacturer string without a matching free().

Signed-off-by: Torstein Eide <torsteine+linux@gmail.com>
---
 lsmmc.c | 250 +++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 184 insertions(+), 66 deletions(-)

diff --git a/lsmmc.c b/lsmmc.c
index 799e1ea..8155a5c 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -509,62 +509,89 @@ static void parse_bin(char *hexstr, char *fmt, ...)
 	free(origstr);
 }
 
-/* MMC/SD information parsing functions */
-static void print_sd_cid(struct config *config, char *cid)
-{
-	static const char *months[] = {
-		"jan", "feb", "mar", "apr", "may", "jun",
-		"jul", "aug", "sep", "oct", "nov", "dec",
-		"invalid0", "invalid1", "invalid2", "invalid3",
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
 
-	oid[2] = '\0';
-	pnm[5] = '\0';
+static void parse_mmc_cid(char *raw, struct mmc_cid *c)
+{
+	parse_bin(raw, "8u6r2u8u48a4u4u32u4u4u7u1r",
+		  &c->mid, &c->cbx, &c->oid, &c->pnm[0], &c->prv_major,
+		  &c->prv_minor, &c->psn, &c->mdt_year, &c->mdt_month, &c->crc);
+	c->pnm[6] = '\0';
+}
+
+/* MMC/SD information parsing functions */
+static void print_sd_cid(struct config *config, char *cid)
+{
+	static const char *months[] = {
+		"jan", "feb", "mar", "apr", "may", "jun",
+		"jul", "aug", "sep", "oct", "nov", "dec",
+		"invalid0", "invalid1", "invalid2", "invalid3",
+	};
+	struct sd_cid c;
+	char *manufacturer;
 
-	manufacturer = get_manufacturer(config, mid);
+	parse_sd_cid(cid, &c);
+	manufacturer = get_manufacturer(config, c.mid);
 
 	if (config->verbose) {
 		printf("======SD/CID======\n");
 
-		printf("\tMID: 0x%02x (", mid);
+		printf("\tMID: 0x%02x (", c.mid);
 		if (manufacturer)
 			printf("%s)\n", manufacturer);
 		else
 			printf("Unlisted)\n");
 
-		printf("\tOID: %s\n", oid);
-		printf("\tPNM: %s\n", pnm);
-		printf("\tPRV: 0x%01x%01x ", prv_major, prv_minor);
-		printf("(%u.%u)\n", prv_major, prv_minor);
-		printf("\tPSN: 0x%08x\n", psn);
-		printf("\tMDT: 0x%02x%01x %u %s\n", mdt_year, mdt_month,
-		       2000 + mdt_year, months[mdt_month]);
-		printf("\tCRC: 0x%02x\n", crc);
+		printf("\tOID: %s\n", c.oid);
+		printf("\tPNM: %s\n", c.pnm);
+		printf("\tPRV: 0x%01x%01x ", c.prv_major, c.prv_minor);
+		printf("(%u.%u)\n", c.prv_major, c.prv_minor);
+		printf("\tPSN: 0x%08x\n", c.psn);
+		printf("\tMDT: 0x%02x%01x %u %s\n", c.mdt_year, c.mdt_month,
+		       2000 + c.mdt_year, months[c.mdt_month]);
+		printf("\tCRC: 0x%02x\n", c.crc);
 	} else {
 		if (manufacturer)
-			printf("manufacturer: '%s' '%s'\n",
-			       manufacturer, oid);
+			printf("manufacturer: '%s' '%s'\n", manufacturer, c.oid);
 		else
-			printf("manufacturer: 'Unlisted' '%s'\n", oid);
+			printf("manufacturer: 'Unlisted' '%s'\n", c.oid);
 
-		printf("product: '%s' %u.%u\n", pnm, prv_major, prv_minor);
-		printf("serial: 0x%08x\n", psn);
-		printf("manufacturing date: %u %s\n", 2000 + mdt_year,
-		       months[mdt_month]);
+		printf("product: '%s' %u.%u\n", c.pnm, c.prv_major, c.prv_minor);
+		printf("serial: 0x%08x\n", c.psn);
+		printf("manufacturing date: %u %s\n", 2000 + c.mdt_year,
+		       months[c.mdt_month]);
 	}
 }
 
@@ -575,37 +602,23 @@ static void print_mmc_cid(struct config *config, char *cid)
 		"jul", "aug", "sep", "oct", "nov", "dec",
 		"invalid0", "invalid1", "invalid2", "invalid3",
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
-
-	parse_bin(cid, "8u6r2u8u48a4u4u32u4u4u7u1r",
-		&mid, &cbx, &oid, &pnm[0], &prv_major, &prv_minor, &psn,
-		&mdt_year, &mdt_month, &crc);
-
-	pnm[6] = '\0';
+	struct mmc_cid c;
+	char *manufacturer;
 
-	manufacturer = get_manufacturer(config, mid);
+	parse_mmc_cid(cid, &c);
+	manufacturer = get_manufacturer(config, c.mid);
 
 	if (config->verbose) {
 		printf("======MMC/CID======\n");
 
-		printf("\tMID: 0x%02x (", mid);
+		printf("\tMID: 0x%02x (", c.mid);
 		if (manufacturer)
 			printf("%s)\n", manufacturer);
 		else
 			printf("Unlisted)\n");
 
-		printf("\tCBX: 0x%01x (", cbx);
-		switch (cbx) {
+		printf("\tCBX: 0x%01x (", c.cbx);
+		switch (c.cbx) {
 		case 0:
 			printf("card)\n");
 			break;
@@ -620,25 +633,26 @@ static void print_mmc_cid(struct config *config, char *cid)
 			break;
 		}
 
-		printf("\tOID: 0x%01x\n", oid);
-		printf("\tPNM: %s\n", pnm);
-		printf("\tPRV: 0x%01x%01x ", prv_major, prv_minor);
-		printf("(%u.%u)\n", prv_major, prv_minor);
-		printf("\tPSN: 0x%08x\n", psn);
-		printf("\tMDT: 0x%01x%01x %u %s\n", mdt_month, mdt_year,
-		       1997 + mdt_year, months[mdt_month]);
-		printf("\tCRC: 0x%02x\n", crc);
+		printf("\tOID: 0x%01x\n", c.oid);
+		printf("\tPNM: %s\n", c.pnm);
+		printf("\tPRV: 0x%01x%01x ", c.prv_major, c.prv_minor);
+		printf("(%u.%u)\n", c.prv_major, c.prv_minor);
+		printf("\tPSN: 0x%08x\n", c.psn);
+		printf("\tMDT: 0x%01x%01x %u %s\n", c.mdt_month, c.mdt_year,
+		       1997 + c.mdt_year, months[c.mdt_month]);
+		printf("\tCRC: 0x%02x\n", c.crc);
 	} else {
 		if (manufacturer)
 			printf("manufacturer: 0x%02x (%s) oid: 0x%01x\n",
-			       mid, manufacturer, oid);
+			       c.mid, manufacturer, c.oid);
 		else
-			printf("manufacturer: 0x%02x (Unlisted) oid: 0x%01x\n", mid, oid);
+			printf("manufacturer: 0x%02x (Unlisted) oid: 0x%01x\n",
+			       c.mid, c.oid);
 
-		printf("product: '%s' %u.%u\n", pnm, prv_major, prv_minor);
-		printf("serial: 0x%08x\n", psn);
-		printf("manufacturing date: %u %s\n", 1997 + mdt_year,
-		       months[mdt_month]);
+		printf("product: '%s' %u.%u\n", c.pnm, c.prv_major, c.prv_minor);
+		printf("serial: 0x%08x\n", c.psn);
+		printf("manufacturing date: %u %s\n", 1997 + c.mdt_year,
+		       months[c.mdt_month]);
 	}
 }
 
@@ -2270,6 +2284,110 @@ static int do_read_reg(int argc, char **argv, enum REG_TYPE reg)
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
+static void print_list_entry(struct config *cfg, const char *devname,
+			     const char *blkdev, char *cid)
+{
+	char *mfr;
+	char devnode[32];
+
+	snprintf(devnode, sizeof(devnode), "/dev/%s", blkdev ? blkdev : "?");
+
+	if (cfg->bus == SD) {
+		struct sd_cid c;
+
+		parse_sd_cid(cid, &c);
+		mfr = get_manufacturer(cfg, c.mid);
+		printf("%-14s %-14s SD   %-20s %-10s %u.%u  0x%08x  %u-%s\n",
+		       devname, devnode, mfr ? mfr : "Unlisted", c.pnm,
+		       c.prv_major, c.prv_minor, c.psn, 2000 + c.mdt_year,
+		       month_name(c.mdt_month));
+	} else {
+		struct mmc_cid c;
+
+		parse_mmc_cid(cid, &c);
+		mfr = get_manufacturer(cfg, c.mid);
+		printf("%-14s %-14s MMC  %-20s %-10s %u.%u  0x%08x  %u-%s\n",
+		       devname, devnode, mfr ? mfr : "Unlisted", c.pnm,
+		       c.prv_major, c.prv_minor, c.psn, 1997 + c.mdt_year,
+		       month_name(c.mdt_month));
+	}
+
+	free(mfr);
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
-- 
2.53.0

