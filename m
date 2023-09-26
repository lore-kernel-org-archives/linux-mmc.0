Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B341BE7D273
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Sep 2023 10:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbjIZKCi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Sep 2023 06:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234337AbjIZKCf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Sep 2023 06:02:35 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CDD97
        for <linux-mmc@vger.kernel.org>; Tue, 26 Sep 2023 03:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695722550; x=1727258550;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ua9aPNbtj0WT4TJ50xkgwq26uMkRGmH1em8NHPFYUSY=;
  b=BDSXxPfRPxrba0W6P3nIm+eJNh85XdCeTfNeYWPg9hVgD6UeEnAjY8ol
   iZL33euDNwqxnOZZORWwHksgo0Suq40dduBgAmyTMosLKglwNklrfXfTR
   eGZKExBgdhQ48EdOYqskzTFvhmit+3r+gNEGH0fEgnKwvoA7COF9cxa/A
   Rf7bkgK34mNrvimd8PW9R360V6AWNFCO9VSESLO0kQBVZOnYAbqKpdyVo
   XHQV6gTHW9kBu/T9NvuIit5pYx6mM3j5e/fdjTgMsllgETMGlzNtw0K9E
   Tn26iOOQ5wkrTAT/pBn0AyAHd9FSNDt9g4grF2XWeRiagJ1YixRfizvqv
   w==;
X-CSE-ConnectionGUID: u9l6HuBdQO6dC+3VDScW8A==
X-CSE-MsgGUID: dynjXNziQOynxhYh7c8pjg==
X-IronPort-AV: E=Sophos;i="6.03,177,1694707200"; 
   d="scan'208";a="244969605"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Sep 2023 18:02:29 +0800
IronPort-SDR: klNrGiCiOsHYY5dvpQnBg8he5ruFHI6Fu1CxE+21FoZlbwEeL0Ewx6GqlrXDXrv1A7uwzIjkaw
 D24pBuBdY4gSyE+xLsnUcDAoWF5s9o4ctdKnEBgegIvR4ndu6ccbx/tPPuv2kVYP8SBraIqIaf
 HpPDaBVUAhHgz7P4mBurmlGSoJcJ1CuA3IyWaxN8P3CeT1CCIDUBOR6e9H6QlDJV12JVFw8yEY
 xBR5JpznNkFsZtE0kma3AsOZx3HgAa+b7WtnrBA4eo8rzddbS9bBWqWyzV14ky/5grbptwoRMJ
 sUA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Sep 2023 02:14:57 -0700
IronPort-SDR: hQghx4aD5YEloXBhYCbbmUuEVku/DRzIMU68aKH+gvoTvMwLwIrIgEUgUK5S9C+14NCO1Vyf1d
 vQQdztKAB2s+fE1foeFoKBV4calHkn/djuFFZIUFBEJRMfgbNOIUKAbbqUP5Qw6seqcqgCX3g/
 IYC1ePZrVOjPBse1a2hlLszVI/oTk8Yh33tgdhA4CooD91rXcdUssn+3PY8B4U/u+dp5ZGLIOJ
 RH7fmH3iXJ3xL4ofeTGYdeaAa7EopC81LnhSmWZcFYCHJpm1OC/enTT6r7IbQBHzOhFCJebZD8
 QVg=
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Sep 2023 03:02:29 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 3/5] mmc-utils: lsmmc: Simplify interface processing functions
Date:   Tue, 26 Sep 2023 13:00:04 +0300
Message-Id: <20230926100006.1789276-4-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230926100006.1789276-1-avri.altman@wdc.com>
References: <20230926100006.1789276-1-avri.altman@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Call those directly form process_dir() and remove the no longer needed
print_info().

While at it remove the deprecated EXT_CSD handling.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 lsmmc.c | 70 ++++++++++++++++++++-------------------------------------
 1 file changed, 24 insertions(+), 46 deletions(-)

diff --git a/lsmmc.c b/lsmmc.c
index 7e3165a..dae75b6 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -77,7 +77,6 @@ enum REG_TYPE {
 	CID = 0,
 	CSD,
 	SCR,
-	EXT_CSD,
 };
 
 struct ids_database {
@@ -2210,29 +2209,10 @@ void print_sd_scr(struct config *config, char *scr)
 	}
 }
 
-/* MMC/SD interface processing functions */
-void print_info(struct config *config, char *type,
-	char *cid, char *csd, char *scr, char *ext_csd)
-{
-	printf("type: '%s'\n", type);
-
-	if (!strcmp(type, "SD") && cid)
-		print_sd_cid(config, cid);
-	else if (!strcmp(type, "MMC") && cid)
-		print_mmc_cid(config, cid);
-
-	if (!strcmp(type, "SD") && scr)
-		print_sd_scr(config, scr);
-
-	if (!strcmp(type, "MMC") && csd)
-		print_mmc_csd(config, csd);
-	else if (!strcmp(type, "SD") && csd)
-		print_sd_csd(config, csd);
-}
-
 int process_dir(struct config *config, enum REG_TYPE reg)
 {
-	char *type = NULL, *cid = NULL, *csd = NULL, *scr = NULL, *ext_csd = NULL;
+	char *type = NULL;
+	char *reg_content = NULL;
 	int ret = 0;
 
 	if (chdir(config->dir) < 0) {
@@ -2260,29 +2240,41 @@ int process_dir(struct config *config, enum REG_TYPE reg)
 
 	switch (reg) {
 	case CID:
-		cid = read_file("cid");
-		if (!cid) {
+		reg_content = read_file("cid");
+		if (!reg_content) {
 			fprintf(stderr,
 				"Could not read card identity in directory '%s'.\n",
 				config->dir);
 			ret = -1;
 			goto err;
 		}
+
+		if (config->bus == SD)
+			print_sd_cid(config, reg_content);
+		else
+			print_mmc_cid(config, reg_content);
+
 		break;
 	case CSD:
-		csd = read_file("csd");
-		if (!csd) {
+		reg_content = read_file("csd");
+		if (!reg_content) {
 			fprintf(stderr,
 				"Could not read card specific data in "
 				"directory '%s'.\n", config->dir);
 			ret = -1;
 			goto err;
 		}
+
+		if (config->bus == SD)
+			print_sd_csd(config, reg_content);
+		else
+			print_mmc_csd(config, reg_content);
+
 		break;
 	case SCR:
 		if (!strcmp(type, "SD")) {
-			scr = read_file("scr");
-			if (!scr) {
+			reg_content = read_file("scr");
+			if (!reg_content) {
 				fprintf(stderr, "Could not read SD card "
 					"configuration in directory '%s'.\n",
 					config->dir);
@@ -2290,30 +2282,16 @@ int process_dir(struct config *config, enum REG_TYPE reg)
 				goto err;
 			}
 		}
-		break;
-	case EXT_CSD:
-		if (!strcmp(type, "MMC")) {
-			ext_csd = read_file("ext_csd");
-			if (!ext_csd) {
-				fprintf(stderr, "Could not read extra specific "
-					"data in directory '%s'.\n",
-					config->dir);
-				ret = -1;
-				goto err;
-			}
-		}
+
+		print_sd_scr(config, reg_content);
+
 		break;
 	default:
 		goto err;
 	}
 
-	print_info(config, type, cid, csd, scr, ext_csd);
-
 err:
-	free(ext_csd);
-	free(scr);
-	free(csd);
-	free(cid);
+	free(reg_content);
 	free(type);
 
 	return ret;
-- 
2.42.0

