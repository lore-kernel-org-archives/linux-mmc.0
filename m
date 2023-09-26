Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED3AE7D273
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Sep 2023 10:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbjIZKC0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Sep 2023 06:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbjIZKCU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Sep 2023 06:02:20 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE16126
        for <linux-mmc@vger.kernel.org>; Tue, 26 Sep 2023 03:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695722533; x=1727258533;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xMSsDN0pdJvWEB/9ETHhWBHk694ynlb0lpBF4/28UYY=;
  b=FmB+DCFPSUKzHGz13Y8U65UDa8rjyG9zfCcl9evl/n2DUFS/7p7EaXh+
   aQRcQK8sQhFOVEzLONo+tYU3DRYARKZX81WTLrOJH+gecSNzdx182J9oM
   FxiBatJziTTErZc5qTKP/kFqB6iD3tsXGpdT+u8+TMIoQZ79mjjDhfAC8
   Wa4s2ab6iET9/dqeap0lJiqpWAXOLnCsH3h+CdWYlQ8CLjOcUFPje+ens
   NjyXq87qc4n7tod1T4XaOhYj01gWM3girjg0vGTSQu0Om5YXYe6pcrS2T
   zkms4zuppnu1WyivQ7wb53WRnGB5NZK/VDb6U/X/JCo8Az258la7lGi4/
   A==;
X-CSE-ConnectionGUID: iV+6TmpJRKOyeruQCX6BFA==
X-CSE-MsgGUID: HfT1YmTERn274I1IIkXnbw==
X-IronPort-AV: E=Sophos;i="6.03,177,1694707200"; 
   d="scan'208";a="245305991"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Sep 2023 18:02:13 +0800
IronPort-SDR: R+oDH55MM9/NOHFoMpDha3QOPFfYVP0gvbiALVu36UHDxHgVsT5LeAhLfosIRviZCBMnHISGV8
 H9f/s+T08vRzddccUlW4IJhP1Apr+qBycOTqc4S/6Zng223RFjB5nzX2y7m3Uz0Bnd/v2MKKFU
 bLuuAyF7p9T0uY1Z5QM0GMy3xpDCRnNlhqjCYGE6U2uVfU2L3jC6Unh6hiwObLysNw+hvUNIk2
 a5TdLgjK3MDDDJ9cCxoTASep/BNYdNcRcMdmra8bh3LtBzOSNnwyiLKo9lzAX9kbXRfDF/ZTkZ
 9pw=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Sep 2023 02:09:00 -0700
IronPort-SDR: ibOAdgs/elRzxw8K1nQJrsqdJrO+ESibgrQeVjchV9qM/uYAqX3j5vJ6CG0ShCJJwKEOTMDQzm
 Dlm7LCSFQnI3cNhwctqwvJsqPdBLQBbESv8atP7blZ2PVC3txF9WoMVdxe97nay9Eu5kfw3vC7
 39e8FZKOvSlEdMYit/KxTQpXuxLoQqWitTdhekqXRZFMF6rdaGMY0Dj1a+OSyHHQFTBvJtL5iI
 3k36MS/YkpL+eqzT5JMNLqwkc+UQJGLZkofVsy/3d+zoWPnYP8EXZvrXOtBPb3B5oAHSdJyhRe
 Z4s=
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Sep 2023 03:02:13 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 1/5] mmc-utils: lsmmc: Reuse do_read_reg
Date:   Tue, 26 Sep 2023 13:00:02 +0300
Message-Id: <20230926100006.1789276-2-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230926100006.1789276-1-avri.altman@wdc.com>
References: <20230926100006.1789276-1-avri.altman@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

All 3 register parsing: CID, CSD, and CSR follow the same structure -
reuse it instead of duplicating the code 3 times. No functional change.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 lsmmc.c | 59 +++++++++++++++++++--------------------------------------
 1 file changed, 19 insertions(+), 40 deletions(-)

diff --git a/lsmmc.c b/lsmmc.c
index 54c3167..85779bb 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -2373,7 +2373,6 @@ int lsmmc_main(struct config *config, int argc, char **argv)
 {
 	int ret;
 
-	memset(config, 0, sizeof(*config));
 	config->mmc_ids = calloc(IDS_MAX, sizeof(char *));
 	config->sd_ids = calloc(IDS_MAX, sizeof(char *));
 	if (!config->mmc_ids || !config->sd_ids) {
@@ -2395,71 +2394,51 @@ void lsmmc_free(struct config *config)
 	free(config->dir);
 }
 
-int do_read_csd(int argc, char **argv)
+static int do_read_reg(int argc, char **argv, enum REG_TYPE reg)
 {
-	struct config config;
+	struct config cfg = {};
 	int ret;
 
-	if (argc != 2 && argc != 3) {
-		fprintf(stderr, "Usage: Print CSD data from <device path>.\n");
-		exit(1);
-	}
-
-	ret = lsmmc_main(&config, argc, argv);
+	ret = lsmmc_main(&cfg, argc, argv);
 	if (ret)
 		goto out;
 
-	if (config.dir)
-		ret = process_dir(&config, CSD);
+	if (cfg.dir)
+		ret = process_dir(&cfg, reg);
 
 out:
-	lsmmc_free(&config);
+	lsmmc_free(&cfg);
 
 	return ret;
+
 }
 
-int do_read_cid(int argc, char **argv)
+int do_read_csd(int argc, char **argv)
 {
-	struct config config;
-	int ret;
-
 	if (argc != 2 && argc != 3) {
-		fprintf(stderr, "Usage: Print CID data from <device path>.\n");
+		fprintf(stderr, "Usage: Print CSD data from <device path>.\n");
 		exit(1);
 	}
 
-	ret = lsmmc_main(&config, argc, argv);
-	if (ret)
-		goto out;
-
-	if (config.dir)
-		ret = process_dir(&config, CID);
+	return do_read_reg(argc, argv, CSD);
+}
 
-out:
-	lsmmc_free(&config);
+int do_read_cid(int argc, char **argv)
+{
+	if (argc != 2 && argc != 3) {
+		fprintf(stderr, "Usage: Print CID data from <device path>.\n");
+		exit(1);
+	}
 
-	return ret;
+	return do_read_reg(argc, argv, CID);
 }
 
 int do_read_scr(int argc, char **argv)
 {
-	struct config config;
-	int ret;
-
 	if (argc != 2 && argc != 3) {
 		fprintf(stderr, "Usage: Print SCR data from <device path>.\n");
 		exit(1);
 	}
 
-	ret = lsmmc_main(&config, argc, argv);
-	if (ret)
-		goto out;
-
-	if (config.dir)
-		ret = process_dir(&config, SCR);
-
-out:
-	lsmmc_free(&config);
-
-	return ret;
+	return do_read_reg(argc, argv, SCR);
 }
-- 
2.42.0

