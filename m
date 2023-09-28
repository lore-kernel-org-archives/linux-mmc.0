Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C12E732FD
	for <linux-mmc@archiver.kernel.org>; Thu, 28 Sep 2023 18:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjI1SIn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 28 Sep 2023 14:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjI1SIn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Sep 2023 14:08:43 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B8C1A8
        for <linux-mmc@vger.kernel.org>; Thu, 28 Sep 2023 11:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695924521; x=1727460521;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H+PLl+AnH13D3Mj+h1afaj1AEDzCexoHxzzUREB4uTE=;
  b=qAu7rShzt5kJyFKrjm0zC5QTnMv2fC/JkRtQtO/K3VTIJuSAIumns6/v
   +xw7UmQYiR31U1i0I9880OnMNBzEF+BMMKIEfcukooyfhjuzAi/Mx43uR
   /OAdp6nYKz9j0lLogprGmylnj03yhj6yGKMFpp0CgRfqJFGoyyvt1x+rt
   VunfmczHWShbaeLRxNj67UQ3g4s4GD2cuCYSl3wjBaRqRGveS3eOHn35j
   A9Jz6POD5SzH75HBlFdu+b1MTTmLj98zjp4VIC695Q+N6P3C815mTzLm/
   iczSptVZTdoKATsBUos3gwWbzpPBJqQAV98BUY7Y2dJRD5+kvWOuj0Ild
   g==;
X-CSE-ConnectionGUID: r2QALQoVQvSCgemkeJE5pA==
X-CSE-MsgGUID: krZJKkaETGqHJbTMoALygg==
X-IronPort-AV: E=Sophos;i="6.03,184,1694707200"; 
   d="scan'208";a="350593333"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Sep 2023 02:08:41 +0800
IronPort-SDR: +J2+/VQ9nab+vJFpQGleNyxXqbdLUECQQy0U0jbUGFhxOHCWq/fzxm/BMbCc9efXV76S5Dl3lN
 NEZEWJo583qDgpnP/+KSKlsGpam70likbptWG0I4eOM6qZE2p/qlW37/8456cgo6FbKYmRG53i
 d3iV/lmEORmnC3TNNyikwFFIwxdwUBUmapp+BFuTcp1dZKjf0QUNOdPRk5nD+OmCdBaDXrFJa0
 wU3aeVmuSLELZfWAs/w+QbG1VZpopYMPa3bVfWpDveyRpwF39G8WsgjuJTPt9Oqm+K4v2oH3oH
 8xo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Sep 2023 10:21:06 -0700
IronPort-SDR: 5FF2EBkCnHH+FwfpGlwoUhvV8hj9A4TUk8eMlwDIN9SElhYkgVd4dlvBto0JJcBc4Ma1EpwIGx
 Jgp9rQMhd6QEgH++1GV/cemyOVN7iOzzdUh+Jkd3T/0QbyglxULsu3P8AJXoSHxFnDEHJlPNmz
 EBFqrHWB/mCwBd9aToFkGVXY18ilFgJEmOP5ekZapHPWw9dPZCtIZ+Ke63QZV2OKD0qlAFo8fy
 OwJpXSwIEl/wE+XBrBaHkbt6dxEcSt72hGJ1nwD/nvjr2p/yQrd93EyF5w2mO9Y01OEizJIX2G
 GIM=
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Sep 2023 11:08:40 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v3 2/4] mmc-utils: lsmmc: Simplify interface processing functions
Date:   Thu, 28 Sep 2023 21:06:56 +0300
Message-Id: <20230928180658.1795491-3-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230928180658.1795491-1-avri.altman@wdc.com>
References: <20230928180658.1795491-1-avri.altman@wdc.com>
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

