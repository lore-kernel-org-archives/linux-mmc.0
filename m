Return-Path: <SRS0=Im6a=45=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E873C2BB1D
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Mar 2020 14:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755C220716
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Mar 2020 14:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbgCLOZy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:25:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:41667 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727340AbgCLOZy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 12 Mar 2020 10:25:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 07:25:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,545,1574150400"; 
   d="scan'208";a="266348428"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.167])
  by fmsmga004.fm.intel.com with ESMTP; 12 Mar 2020 07:25:52 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Kyungmin Seo <kyungmin.seo@intel.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Subject: [PATCH RFC 3/3] mmc: core: Do not change frequency before switch from HS400
Date:   Thu, 12 Mar 2020 16:25:01 +0200
Message-Id: <20200312142501.9868-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200312142501.9868-1-adrian.hunter@intel.com>
References: <20200312142501.9868-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Do not change frequency before switch from HS400 but in case of error
try again after frequency change.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/mmc.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 3e2ad728b55e..e2b3d7505d6c 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1235,20 +1235,27 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 	int err;
 	u8 val;
 
-	/* Reduce frequency to HS */
-	max_dtr = card->ext_csd.hs_max_dtr;
-	mmc_set_clock(host, max_dtr);
-
 	/* Switch HS400 to HS DDR */
 	val = EXT_CSD_TIMING_HS;
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
 			   val, card->ext_csd.generic_cmd6_time, 0,
 			   false, true, true);
-	if (err)
-		goto out_err;
 
 	mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
 
+	/* Reduce frequency to HS */
+	max_dtr = card->ext_csd.hs_max_dtr;
+	mmc_set_clock(host, max_dtr);
+
+	if (err) {
+		err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+				   EXT_CSD_HS_TIMING, val,
+				   card->ext_csd.generic_cmd6_time, 0, false,
+				   true, true);
+	}
+	if (err)
+		goto out_err;
+
 	err = mmc_switch_status(card, true);
 	if (err)
 		goto out_err;
-- 
2.17.1

