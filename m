Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3C9E7D273
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Sep 2023 10:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbjIZKCb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Sep 2023 06:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbjIZKCa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Sep 2023 06:02:30 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4D9101
        for <linux-mmc@vger.kernel.org>; Tue, 26 Sep 2023 03:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695722543; x=1727258543;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7dYijs1ozuN5Cpqy9z6FqV0jUZ7L65azGz7G9f1Ld1c=;
  b=F/ya5l/Uq7dmFVrk3MYTv6lIU+HJF7Jnf9JUcW3ZMQR/Ccf629idCW2S
   EAdQJIqqQGwKoJqgjshmoOLBacFiJgStTrFvLg4u0C6M5GIqUbFh6yDO6
   hw3pI9trl2gDgWJCGGw4Z4bdbaglCtG8E79aOs8KFmmj6w34hNV4xVoNv
   jslsFSI8RvzkzfsZgYqjE+r6WddnyoKtVO/Y4JpZl8pfn71DpAicCgiSx
   yq8Uub8Y9tm+pZA5J1BEXUatMa3xZPo3VreMT5jT5Gjss0m3KARUqkHNk
   KeNoBoYNqpqAABXzSB7TwW+9sbasuSIDbI2IYmHTdkcIG8WAnEKSBuD3Q
   Q==;
X-CSE-ConnectionGUID: LKNPJGysSNi/dqr9S3DOVA==
X-CSE-MsgGUID: St0U1tEbSfyPJMXe9Eb+Xg==
X-IronPort-AV: E=Sophos;i="6.03,177,1694707200"; 
   d="scan'208";a="357062215"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Sep 2023 18:02:23 +0800
IronPort-SDR: a8zySrVj+toqDVrwE7nQskHW+d4L32PiqSw36T2bimyJ/k47SkjNBWtsK2A/ctgAY6vrPs62zR
 byiNPCHE5B0fh2W9Fx50S0+NsgkNURvMRyCVzkjkTM64f47NVbQ5WhKChsB8oe4mIN4W6BLxEk
 /RGCBlTMqko7MRsnstEuVUs1R0cK4VOLJk0UBx52pWd4QgqE0VGtHVsJp7btN3tqonVPlsFqBr
 zKQX2aJbOnJyX1pRRdqB+zVh8ypY8O9HNmi4zpMTqd9GMDhAm1/ug8bvxI61DXXhK6+nWxZc+K
 zko=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Sep 2023 02:09:08 -0700
IronPort-SDR: cKRiE4N92Bl/2oOCKmIPLdVXjYuR/n35HmoQ5sFRMKVOD5lhDQm+kuprSA0IDEYkSKI5KLR/ZF
 Lq5mHG6MQPg/5V1iN871on6MX4P3TlaErttLaf/ClTEeGMe8Vdf7Sw1fxJR2UIkYpBw8fFiPzk
 pLx0eiyfU79JLh7FFJC+imsEAWmdl9Kozz69SZebQa0nqsIdQxyuvvv7MDQlmQ0VR4+qq1l8eI
 Ae8AiPsNoT3nrrtgzeIei/qKk2zskEpYMQGRJJdLHMsw/9hYP0RGouexGdVu3yci0YrrIDLRIe
 5BM=
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Sep 2023 03:02:21 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 2/5] mmc-utils: lsmmc: Simplify prinitng manufacturer name
Date:   Tue, 26 Sep 2023 13:00:03 +0300
Message-Id: <20230926100006.1789276-3-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230926100006.1789276-1-avri.altman@wdc.com>
References: <20230926100006.1789276-1-avri.altman@wdc.com>
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
 lsmmc.c | 150 ++++++++++++++------------------------------------------
 1 file changed, 37 insertions(+), 113 deletions(-)

diff --git a/lsmmc.c b/lsmmc.c
index 85779bb..7e3165a 100644
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
@@ -78,189 +81,157 @@ enum REG_TYPE {
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
 };
 
+
 /* Command line parsing functions */
 void usage(void)
 {
@@ -310,47 +281,18 @@ int parse_opts(int argc, char **argv, struct config *config)
 	return 0;
 }
 
-int parse_ids(struct config *config)
+static char *get_manufacturer(struct config *config, unsigned int manid)
 {
-	unsigned int ids_cnt = sizeof(database) / sizeof(struct ids_database);
-	unsigned int value;
-	char **ids;
-	char *type;
+	struct ids_database *db = config->bus == MMC ? mmc_database : sd_database;
+	unsigned int ids_cnt = ARRAY_SIZE(db);
 	int i;
 
 	for (i = 0; i < ids_cnt; i++) {
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
-
-		ids[value] = database[i].manufacturer;
+		if (db[i].id == manid)
+			return db[i].manufacturer;
 	}
 
-	return 0;
+	return NULL;
 }
 
 /* MMC/SD file parsing functions */
@@ -538,6 +480,7 @@ void print_sd_cid(struct config *config, char *cid)
 	unsigned int mdt_month;
 	unsigned int mdt_year;
 	unsigned int crc;
+	char *manufacturer = NULL;
 
 	parse_bin(cid, "8u16a40a4u4u32u4r8u4u7u1r",
 		&mid, &oid[0], &pnm[0], &prv_major, &prv_minor, &psn,
@@ -546,12 +489,14 @@ void print_sd_cid(struct config *config, char *cid)
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
 
@@ -564,9 +509,9 @@ void print_sd_cid(struct config *config, char *cid)
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
 
@@ -594,6 +539,7 @@ void print_mmc_cid(struct config *config, char *cid)
 	unsigned int mdt_month;
 	unsigned int mdt_year;
 	unsigned int crc;
+	char *manufacturer = NULL;
 
 	parse_bin(cid, "8u6r2u8u48a4u4u32u4u4u7u1r",
 		&mid, &cbx, &oid, &pnm[0], &prv_major, &prv_minor, &psn,
@@ -601,12 +547,14 @@ void print_mmc_cid(struct config *config, char *cid)
 
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
 
@@ -635,9 +583,9 @@ void print_mmc_cid(struct config *config, char *cid)
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
 
@@ -2308,6 +2256,8 @@ int process_dir(struct config *config, enum REG_TYPE reg)
 		goto err;
 	}
 
+	config->bus = strcmp(type, "MMC") ? SD : MMC;
+
 	switch (reg) {
 	case CID:
 		cid = read_file("cid");
@@ -2369,45 +2319,19 @@ err:
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

