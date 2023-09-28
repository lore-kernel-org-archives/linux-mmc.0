Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAB5CE7B09
	for <linux-mmc@archiver.kernel.org>; Thu, 28 Sep 2023 08:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjI1IHB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 28 Sep 2023 04:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjI1IGw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Sep 2023 04:06:52 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041621B4
        for <linux-mmc@vger.kernel.org>; Thu, 28 Sep 2023 01:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695888373; x=1727424373;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H+PLl+AnH13D3Mj+h1afaj1AEDzCexoHxzzUREB4uTE=;
  b=VuDfFEhk+cFgC9LeF2x+vprJztNPtWFaeUbEr0feVOJoCBFaEuV11Hqn
   ZuibN4RfA5BMhOlEO6+b8axNVNDGoqCYDBVwW7yjpW8s11QfOkigt65/L
   Y0JuTU+2EMXLj8PiMhusx2UjZeSHU57Zmu9HE6Dcnyz68ryJIv8oe53BP
   MyjiniF2FIEM1WE3rrNwl3+SoDJnfrIQbfhwa9GSrPie8J6sPwEw5d+jE
   f+wzVeZn8jzzUuaeXMOIZREdbDTDMVpVkAU4Kb5JV7qIaRMPkFKlNsj0T
   bcWgyeLx5auwKBZNiYz/aj6iNDsmC2FgL7mtkNE0hGyc0T1b9peodclcD
   w==;
X-CSE-ConnectionGUID: 3M1lCIVFQkiLDUb3g1efQQ==
X-CSE-MsgGUID: 3u71RKV1TbSgh+CXBvS3xQ==
X-IronPort-AV: E=Sophos;i="6.03,183,1694707200"; 
   d="scan'208";a="357259057"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2023 16:06:13 +0800
IronPort-SDR: yqt+4GJFdj98554WNO+e1FhiFWiPQpJjhsjEyQlLJrStNwIo+wMEavXXmOM0CgBqQz9PyixRnd
 2sRXPwoVAT/pIkqG/0olzZnOMC7QooME4wasbXakqYbpQ4cQ47hCdzCJCPH44eVTApLg/JQTcy
 /i8c2Dktfqx2G+DrBXsCtSoq+6VbueGHGar32oQIqWNghJ0+CEVQFK2uBtsThLAT4OpIYvzY/+
 dWJIVol2wNVfLgXc2GgL+UPEjWfCFZ8/w++o0QBxByTMzlF9sHreAqg3euy/dD5jlHie6dar9K
 y/E=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Sep 2023 00:12:58 -0700
IronPort-SDR: 09CGyWdr6dexemSc1JOz0rR8TDaQ0Gs7BaGeOCPaiyI1dK/V37VcfKhlNeumVGdOPLq3ErBH0l
 tcxQzx9INfSiGjf/WvnQlSjoeRnAtCINnsZwFykP++d9TOVN4EZ7HCHQiiX2z+x1vNbxre/hSR
 /QmLM7RsYRXKtk76UYlaHfOuxOxC2A0kE7ftKeWRVmhBnVyL2jkaR0hOKtDJCVSszQkUisgLbc
 Exh9WsK0HpXKtZQprYn+YEImqHHjgwLeqsIz1syb5WGSXYmwSIW4415tqYBZhPukJ0sGdLkxeL
 4cU=
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Sep 2023 01:06:12 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2 2/4] mmc-utils: lsmmc: Simplify interface processing functions
Date:   Thu, 28 Sep 2023 11:04:39 +0300
Message-Id: <20230928080441.1793898-3-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230928080441.1793898-1-avri.altman@wdc.com>
References: <20230928080441.1793898-1-avri.altman@wdc.com>
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
index 3b52b9f..e9b0762 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -77,7 +77,6 @@ enum REG_TYPE {
 	CID = 0,
 	CSD,
 	SCR,
-	EXT_CSD,
 };
 
 struct ids_database {
@@ -2217,29 +2216,10 @@ void print_sd_scr(struct config *config, char *scr)
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
@@ -2267,29 +2247,41 @@ int process_dir(struct config *config, enum REG_TYPE reg)
 
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
@@ -2297,30 +2289,16 @@ int process_dir(struct config *config, enum REG_TYPE reg)
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

