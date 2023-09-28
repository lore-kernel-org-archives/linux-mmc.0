Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F18CE7B05
	for <linux-mmc@archiver.kernel.org>; Thu, 28 Sep 2023 08:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjI1IG7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 28 Sep 2023 04:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjI1IGt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Sep 2023 04:06:49 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3716E1A2
        for <linux-mmc@vger.kernel.org>; Thu, 28 Sep 2023 01:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695888368; x=1727424368;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=evOhYSKxmNP00bLigpXgocoi+ooubwv4ZNVgQXifWVc=;
  b=MB7T6nwoZZesregoHmMOmnZLwPnfWxqpf3ZXe4XdXenaFc/bZQp0D2tY
   TOhalGA5onuigl1pfAmzCIgrg+pfp+BslEwu4LLcuIYH/Q6Jm/tSnSRmE
   dZY2YttqGDqnA5R8ckRFY/9ySVbTp1UFsFP330MqvdbO5Y8MWjtJCofF/
   7d14hRMK5fhjnE7ybHQsfgFikKxOZTKrunBiGMIEjFtX59PBRBTATXhuf
   Y7+OaSixZMQePrT2wYbhZbrvPsx7iw77Weces6XgMbo6SqeTMAyRqQQ6N
   M+7xAVUHgoOfo5LTrF4BK49f9yfuEjG5142uUND+iixgdU8x2z4k67QJO
   g==;
X-CSE-ConnectionGUID: eNvhi0iARveSDimHO+w5qQ==
X-CSE-MsgGUID: R+0CCx0jSweqW7RPDk6CXQ==
X-IronPort-AV: E=Sophos;i="6.03,183,1694707200"; 
   d="scan'208";a="243360222"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2023 16:06:07 +0800
IronPort-SDR: Ijf+t0VK4HalNwJCBwg9Nz4WC9aEHrt7a4N3NnQ0ml3lOMZUNhTxYVP05p1sg7y5lKM/Cc3zX6
 bsWPF0WHNT9/hA3lF2xq0yuastQQ8+YmKwgeBShqIZBlqj//LDn/ajnsvYXYr+P2KFEuBVR5hM
 VC3G+ADCzbNGh3av+LTPFPdbxJoC3F9yg6nxO7yJ4wUQV8zXDoeIdKefyAI3pAU8x44TrV0Gai
 9ckORXkv3MHYVCmN3cCkxh/Q79/tni97lNWSEvl9ymxJ09UKXve/rKlOpxV1yZcYMXmpDBWUKG
 RyI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Sep 2023 00:18:33 -0700
IronPort-SDR: YwMjrMfibv1mU+z7AMI6DZdp0rDB9r8ChVjN4EaZri9bcl0HHqC6Q/m3EAB8xjcqsjY3NAS+PN
 lOdhoZc2C9cLlB297ehVLPFadfbGdNWSERyCNnph3Su47H8M2F/+bX4U6r6h2YySlMHY+zD5E3
 FZZAc4jWirWfvyIAjtf+LUdy8AaA+fz9J9vbkbmK2EVgF48eSmknaP2zPiRz2epQOE/hUquUiB
 uxZmBWYNo0may7gMnl/ZNaPT2vl5zIvgjcz39BDZcWG/7C7ml48JBgxGaRDUl7xZpxrBl9O2Xc
 9C8=
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Sep 2023 01:06:06 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2 1/4] mmc-utils: lsmmc: Simplify prinitng manufacturer name
Date:   Thu, 28 Sep 2023 11:04:38 +0300
Message-Id: <20230928080441.1793898-2-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230928080441.1793898-1-avri.altman@wdc.com>
References: <20230928080441.1793898-1-avri.altman@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

We used to have this odd way of printing the manufacturer name. To that
end we cached the entire database beforehand which is completely
useless.

While at it, get rid of some more redundant code.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 lsmmc.c | 157 ++++++++++++++++----------------------------------------
 1 file changed, 44 insertions(+), 113 deletions(-)

diff --git a/lsmmc.c b/lsmmc.c
index 85779bb..3b52b9f 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -53,16 +53,19 @@
 #define MASK(high, low)		(MASKTOBIT0(high) & ~MASKTOBIT0(low - 1))
 #define BITS(value, high, low)	(((value) & MASK((high), (low))) >> (low))
 #define IDS_MAX			256
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
+enum bus_type {
+	MMC = 1,
+	SD,
+};
 
 struct config {
 	char *idsfile;
 	char *dir;
 	bool verbose;
-	int interfaces;
-	char **interface;
-	char **mmc_ids;
-	char **sd_ids;
 
+	enum bus_type bus;
 	char *type;
 	char *cid;
 	char *csd;
@@ -78,184 +81,151 @@ enum REG_TYPE {
 };
 
 struct ids_database {
-	char *type;
 	int id;
 	char *manufacturer;
 };
 
-struct ids_database database[] = {
+static struct ids_database sd_database[] = {
 	{
-		.type = "sd",
 		.id = 0x01,
 		.manufacturer = "Panasonic",
 	},
 	{
-		.type = "sd",
 		.id = 0x02,
 		.manufacturer = "Toshiba/Kingston/Viking",
 	},
 	{
-		.type = "sd",
 		.id = 0x03,
 		.manufacturer = "SanDisk",
 	},
 	{
-		.type = "sd",
 		.id = 0x08,
 		.manufacturer = "Silicon Power",
 	},
 	{
-		.type = "sd",
 		.id = 0x18,
 		.manufacturer = "Infineon",
 	},
 	{
-		.type = "sd",
 		.id = 0x1b,
 		.manufacturer = "Transcend/Samsung",
 	},
 	{
-		.type = "sd",
 		.id = 0x1c,
 		.manufacturer = "Transcend",
 	},
 	{
-		.type = "sd",
 		.id = 0x1d,
 		.manufacturer = "Corsair/AData",
 	},
 	{
-		.type = "sd",
 		.id = 0x1e,
 		.manufacturer = "Transcend",
 	},
 	{
-		.type = "sd",
 		.id = 0x1f,
 		.manufacturer = "Kingston",
 	},
 	{
-		.type = "sd",
 		.id = 0x27,
 		.manufacturer = "Delkin/Phison",
 	},
 	{
-		.type = "sd",
 		.id = 0x28,
 		.manufacturer = "Lexar",
 	},
 	{
-		.type = "sd",
 		.id = 0x30,
 		.manufacturer = "SanDisk",
 	},
 	{
-		.type = "sd",
 		.id = 0x31,
 		.manufacturer = "Silicon Power",
 	},
 	{
-		.type = "sd",
 		.id = 0x33,
 		.manufacturer = "STMicroelectronics",
 	},
 	{
-		.type = "sd",
 		.id = 0x41,
 		.manufacturer = "Kingston",
 	},
 	{
-		.type = "sd",
 		.id = 0x6f,
 		.manufacturer = "STMicroelectronics",
 	},
 	{
-		.type = "sd",
 		.id = 0x74,
 		.manufacturer = "Transcend",
 	},
 	{
-		.type = "sd",
 		.id = 0x76,
 		.manufacturer = "Patriot",
 	},
 	{
-		.type = "sd",
 		.id = 0x82,
 		.manufacturer = "Gobe/Sony",
 	},
 	{
-		.type = "sd",
 		.id = 0x89,
 		.manufacturer = "Unknown",
 	},
+};
+
+static struct ids_database mmc_database[] = {
 	{
-		.type = "mmc",
 		.id = 0x00,
 		.manufacturer = "SanDisk",
 	},
 	{
-		.type = "mmc",
 		.id = 0x02,
 		.manufacturer = "Kingston/SanDisk",
 	},
 	{
-		.type = "mmc",
 		.id = 0x03,
 		.manufacturer = "Toshiba",
 	},
 	{
-		.type = "mmc",
 		.id = 0x05,
 		.manufacturer = "Unknown",
 	},
 	{
-		.type = "mmc",
 		.id = 0x06,
 		.manufacturer = "Unknown",
 	},
 	{
-		.type = "mmc",
 		.id = 0x11,
 		.manufacturer = "Toshiba",
 	},
 	{
-		.type = "mmc",
 		.id = 0x13,
 		.manufacturer = "Micron",
 	},
 	{
-		.type = "mmc",
 		.id = 0x15,
 		.manufacturer = "Samsung/SanDisk/LG",
 	},
 	{
-		.type = "mmc",
 		.id = 0x37,
 		.manufacturer = "KingMax",
 	},
 	{
-		.type = "mmc",
 		.id = 0x44,
 		.manufacturer = "ATP",
 	},
 	{
-		.type = "mmc",
 		.id = 0x45,
 		.manufacturer = "SanDisk Corporation",
 	},
 	{
-		.type = "mmc",
 		.id = 0x2c,
 		.manufacturer = "Kingston",
 	},
 	{
-		.type = "mmc",
 		.id = 0x70,
 		.manufacturer = "Kingston",
 	},
 	{
-		.type = "mmc",
 		.id = 0xfe,
 		.manufacturer = "Micron",
 	},
@@ -310,47 +280,26 @@ int parse_opts(int argc, char **argv, struct config *config)
 	return 0;
 }
 
-int parse_ids(struct config *config)
+static char *get_manufacturer(struct config *config, unsigned int manid)
 {
-	unsigned int ids_cnt = sizeof(database) / sizeof(struct ids_database);
-	unsigned int value;
-	char **ids;
-	char *type;
+	struct ids_database *db;
+	unsigned int ids_cnt;
 	int i;
 
-	for (i = 0; i < ids_cnt; i++) {
-		type = database[i].type;
-
-		if (!strcmp(type, "mmc")) {
-			ids = config->mmc_ids;
-		} else if (!strcmp(type, "sd")) {
-			ids = config->sd_ids;
-		} else {
-			fprintf(stderr,
-				"MMC/SD id parse error, unknown type: '%s'.\n",
-				type);
-			return -1;
-		}
-
-		value = database[i].id;
-
-		if (value >= IDS_MAX) {
-			fprintf(stderr,
-				"MMC/SD id parse error, id out of range.\n");
-			return -1;
-		}
-
-		if (ids[value]) {
-			fprintf(stderr,
-				"Duplicate entries: type='%s', id='0x%1x'.\n",
-				type, value);
-			return -1;
-		}
+	if (config->bus == MMC) {
+		db = mmc_database;
+		ids_cnt = ARRAY_SIZE(mmc_database);
+	} else {
+		db = sd_database;
+		ids_cnt = ARRAY_SIZE(sd_database);
+	}
 
-		ids[value] = database[i].manufacturer;
+	for (i = 0; i < ids_cnt; i++) {
+		if (db[i].id == manid)
+			return db[i].manufacturer;
 	}
 
-	return 0;
+	return NULL;
 }
 
 /* MMC/SD file parsing functions */
@@ -538,6 +487,7 @@ void print_sd_cid(struct config *config, char *cid)
 	unsigned int mdt_month;
 	unsigned int mdt_year;
 	unsigned int crc;
+	char *manufacturer = NULL;
 
 	parse_bin(cid, "8u16a40a4u4u32u4r8u4u7u1r",
 		&mid, &oid[0], &pnm[0], &prv_major, &prv_minor, &psn,
@@ -546,12 +496,14 @@ void print_sd_cid(struct config *config, char *cid)
 	oid[2] = '\0';
 	pnm[5] = '\0';
 
+	manufacturer = get_manufacturer(config, mid);
+
 	if (config->verbose) {
 		printf("======SD/CID======\n");
 
 		printf("\tMID: 0x%02x (", mid);
-		if (config->sd_ids[mid])
-			printf("%s)\n", config->sd_ids[mid]);
+		if (manufacturer)
+			printf("%s)\n", manufacturer);
 		else
 			printf("Unlisted)\n");
 
@@ -564,9 +516,9 @@ void print_sd_cid(struct config *config, char *cid)
 		       2000 + mdt_year, months[mdt_month]);
 		printf("\tCRC: 0x%02x\n", crc);
 	} else {
-		if (config->sd_ids[mid])
+		if (manufacturer)
 			printf("manufacturer: '%s' '%s'\n",
-			       config->sd_ids[mid], oid);
+			       manufacturer, oid);
 		else
 			printf("manufacturer: 'Unlisted' '%s'\n", oid);
 
@@ -594,6 +546,7 @@ void print_mmc_cid(struct config *config, char *cid)
 	unsigned int mdt_month;
 	unsigned int mdt_year;
 	unsigned int crc;
+	char *manufacturer = NULL;
 
 	parse_bin(cid, "8u6r2u8u48a4u4u32u4u4u7u1r",
 		&mid, &cbx, &oid, &pnm[0], &prv_major, &prv_minor, &psn,
@@ -601,12 +554,14 @@ void print_mmc_cid(struct config *config, char *cid)
 
 	pnm[6] = '\0';
 
+	manufacturer = get_manufacturer(config, mid);
+
 	if (config->verbose) {
 		printf("======MMC/CID======\n");
 
 		printf("\tMID: 0x%02x (", mid);
-		if (config->mmc_ids[mid])
-			printf("%s)\n", config->mmc_ids[mid]);
+		if (manufacturer)
+			printf("%s)\n", manufacturer);
 		else
 			printf("Unlisted)\n");
 
@@ -635,9 +590,9 @@ void print_mmc_cid(struct config *config, char *cid)
 		       1997 + mdt_year, months[mdt_month]);
 		printf("\tCRC: 0x%02x\n", crc);
 	} else {
-		if (config->mmc_ids[mid])
+		if (manufacturer)
 			printf("manufacturer: 0x%02x (%s) oid: 0x%01x\n",
-			       mid, config->mmc_ids[mid], oid);
+			       mid, manufacturer, oid);
 		else
 			printf("manufacturer: 0x%02x (Unlisted) oid: 0x%01x\n", mid, oid);
 
@@ -2308,6 +2263,8 @@ int process_dir(struct config *config, enum REG_TYPE reg)
 		goto err;
 	}
 
+	config->bus = strcmp(type, "MMC") ? SD : MMC;
+
 	switch (reg) {
 	case CID:
 		cid = read_file("cid");
@@ -2369,45 +2326,19 @@ err:
 	return ret;
 }
 
-int lsmmc_main(struct config *config, int argc, char **argv)
-{
-	int ret;
-
-	config->mmc_ids = calloc(IDS_MAX, sizeof(char *));
-	config->sd_ids = calloc(IDS_MAX, sizeof(char *));
-	if (!config->mmc_ids || !config->sd_ids) {
-		fprintf(stderr, "Could not allocate memory for lsmmc.\n");
-		return -1;
-	}
-
-	ret = parse_opts(argc, argv, config);
-	if (ret)
-		return ret;
-
-	return parse_ids(config);
-}
-
-void lsmmc_free(struct config *config)
-{
-	free(config->mmc_ids);
-	free(config->sd_ids);
-	free(config->dir);
-}
-
 static int do_read_reg(int argc, char **argv, enum REG_TYPE reg)
 {
 	struct config cfg = {};
 	int ret;
 
-	ret = lsmmc_main(&cfg, argc, argv);
+	ret = parse_opts(argc, argv, &cfg);
 	if (ret)
-		goto out;
+		return ret;
 
 	if (cfg.dir)
 		ret = process_dir(&cfg, reg);
 
-out:
-	lsmmc_free(&cfg);
+	free(cfg.dir);
 
 	return ret;
 
-- 
2.42.0

