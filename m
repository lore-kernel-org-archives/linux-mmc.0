Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F15118FDAB
	for <linux-mmc@vger.kernel.org>; Mon, 10 Mar 2025 05:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741586254; cv=none; b=riUu6y+9QfQVF39Z5R+GuYZSoCp511sKyiig8UJBf2btxgce9XZK0tX0pYN41QNY4mHWVYSIidnceTdJ4/oRMvyKsOgneSwXEkmllNDR3t070iLpDa07LsaiwjvpwmCREPGJ6pHF3iaa8ltW399YWorY4ADBI0qHYbT3HFrxNoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741586254; c=relaxed/simple;
	bh=EMA0v5C+BGpsXxlJN0PfWk57Kp4HQdorP0dTll7d++Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D+fMj5Zg5wT2HdoTAXWo8T/e0E/TC5aKwOdyQU3Ix3sPjraXg14qdeQG9ve4c5MPonBxfJeaMsScfU1bApvKHCZ8zDu/N6z/Yg0uI5oxM/Loj7CqU4BsqNKetF5l3CanSXJ/8ViLVAKnldVTRm/imnCX8CSo5MydZNqaWTHJMNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=eUet3gg5; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="eUet3gg5"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1741586253; x=1773122253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EMA0v5C+BGpsXxlJN0PfWk57Kp4HQdorP0dTll7d++Y=;
  b=eUet3gg5ShQaqhz8kxfF0dYo85ASUrQwZulMkkNt3h646A15DlPaMQUD
   OmhHQL+ap8/afeP7Y4YlB/TaBNtII53Wqqr3XsPf7ZJ3m0Z+Sc59Bo8wr
   adKtEwmPZ9qhClhjp+3oee8OxV1DBt0AxdBgDGuZccauUSxcQaoqpVq7E
   PzTBXG421c2PEPdcwWT26gp8vsqQcky50YUg32NxoF1SndVw297eBA75t
   nQvj1a0zVCzxgTaCO12LCodW14e7p1qKosK65nDyur5J3Zicqrbou2yeU
   zcV/Vm9v0AZYeASthA4oFYIjabsLrkxXQlWGEvIkuEES9Eb3XuhsuPDwk
   Q==;
X-CSE-ConnectionGUID: 7AWAe5ojQ3S6FDPdWy1uGA==
X-CSE-MsgGUID: 25udmJL2SIij4eSVa2oasw==
X-IronPort-AV: E=Sophos;i="6.14,235,1736784000"; 
   d="scan'208";a="46599990"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2025 13:56:25 +0800
IronPort-SDR: 67ce7135_CF+EH3pijOEeDMRLcEn56f9Fhj8LnoW9TLhaAc6Lw4SkIDt
 2RKGVpaiclCNO+yyOkr21S3t1UpAWlskJKN41Eg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Mar 2025 21:57:25 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Mar 2025 22:56:24 -0700
From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>
Subject: [PATCH 6/7] mmc-utils: lsmmc: Allow getting registers value as an argument
Date: Mon, 10 Mar 2025 07:52:30 +0200
Message-Id: <20250310055231.304728-7-avri.altman@sandisk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250310055231.304728-1-avri.altman@sandisk.com>
References: <20250310055231.304728-1-avri.altman@sandisk.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

<reg> read was invented to read the register value from its sysfs entry.
However, often we are getting the register value from customers or field
application engineers for analysis, without having the actual platform.
Allow to parse the content of those registers for those cases as well.

While at it, remove some unused fields from struct config.

Signed-off-by: Avri Altman <avri.altman@sandisk.com>
---
 lsmmc.c | 69 ++++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 54 insertions(+), 15 deletions(-)

diff --git a/lsmmc.c b/lsmmc.c
index 726adf8..799e1ea 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -62,16 +62,11 @@ enum bus_type {
 };
 
 struct config {
-	char *idsfile;
 	char *dir;
 	bool verbose;
 
 	enum bus_type bus;
-	char *type;
-	char *cid;
-	char *csd;
-	char *scr;
-	char *ext_csd;
+	char *reg;
 };
 
 enum REG_TYPE {
@@ -234,24 +229,53 @@ static struct ids_database mmc_database[] = {
 /* Command line parsing functions */
 static void usage(char *progname)
 {
-	printf("Usage: %s [-h] [-v] <device path ...>\n", progname);
+	printf("Usage: %s [-h] [-v] [-b bus_type] [-r register] <device path ...>\n", progname);
 	printf("\n");
 	printf("Options:\n");
+	printf("\t-b\t bus type. Either sd or mmc. if specified, register value must be given.\n");
+	printf("\t-r\t The register content. if specified no need for device path\n");
 	printf("\t-h\tShow this help.\n");
 	printf("\t-v\tEnable verbose mode.\n");
 }
 
+static void to_lowercase(char *str)
+{
+	for (; *str; ++str)
+		*str = tolower((unsigned char)*str);
+}
+
 static int parse_opts(int argc, char **argv, struct config *config)
 {
 	int c;
+	bool bus_given = false;
+	bool reg_given = false;
 
-	while ((c = getopt(argc, argv, "hv")) != -1) {
+	while ((c = getopt(argc, argv, "hvb:r:")) != -1) {
 		switch (c) {
 		case 'h':
 			usage(argv[0]);
 			return -1;
 		case 'v':
 			config->verbose = true;
+			break;
+		case 'b':
+			to_lowercase(optarg);
+			if (strcmp(optarg, "mmc") == 0) {
+				config->bus = MMC;
+			} else if (strcmp(optarg, "sd") == 0) {
+				config->bus = SD;
+			} else {
+				fprintf(stderr, "Unknown bus type '%s'.\n\n", optarg);
+				usage(argv[0]);
+				return -1;
+			}
+			bus_given = true;
+
+			break;
+		case 'r':
+			config->reg = strdup(optarg);
+			reg_given = true;
+
 			break;
 		case '?':
 			fprintf(stderr,
@@ -270,13 +294,27 @@ static int parse_opts(int argc, char **argv, struct config *config)
 		}
 	}
 
-	if (optind >= argc) {
-		fprintf(stderr, "Expected mmc directory arguments.\n\n");
+	if (bus_given != reg_given) {
+		fprintf(stderr, "Both bus type and register must be provided together.\n\n");
 		usage(argv[0]);
 		return -1;
 	}
 
-	config->dir = strdup(argv[optind]);
+	if (reg_given) {
+		if (optind < argc) {
+			fprintf(stderr, "Either register or directory, not both.\n\n");
+			usage(argv[0]);
+			return -1;
+		}
+	} else {
+		if (optind >= argc) {
+			fprintf(stderr, "Expected mmc directory arguments.\n\n");
+			usage(argv[0]);
+			return -1;
+		}
+
+		config->dir = strdup(argv[optind]);
+	}
 
 	return 0;
 }
@@ -2222,13 +2260,14 @@ static int do_read_reg(int argc, char **argv, enum REG_TYPE reg)
 	if (ret)
 		return ret;
 
-	if (cfg.dir)
+	if (cfg.dir) {
 		ret = process_dir(&cfg, reg);
-
-	free(cfg.dir);
+		free(cfg.dir);
+	} else if (cfg.reg) {
+		ret = process_reg(&cfg, cfg.reg, reg);
+	}
 
 	return ret;
-
 }
 
 int do_read_csd(int argc, char **argv)
-- 
2.25.1

