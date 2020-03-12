Return-Path: <SRS0=Im6a=45=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC06C10DCE
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Mar 2020 14:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F8220724
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Mar 2020 14:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbgCLOZx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:25:53 -0400
Received: from mga01.intel.com ([192.55.52.88]:41667 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727340AbgCLOZw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 12 Mar 2020 10:25:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 07:25:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,545,1574150400"; 
   d="scan'208";a="266348415"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.167])
  by fmsmga004.fm.intel.com with ESMTP; 12 Mar 2020 07:25:51 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Kyungmin Seo <kyungmin.seo@intel.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Subject: [PATCH RFC 2/3] mmc: core: Do not check CRC response for switch from HS400 to HS200
Date:   Thu, 12 Mar 2020 16:25:00 +0200
Message-Id: <20200312142501.9868-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200312142501.9868-1-adrian.hunter@intel.com>
References: <20200312142501.9868-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Switching from HS400 to HS200 may experience CRC errors. Do not check
CRC response in that case.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/mmc.c     | 22 +++++++++++-----------
 drivers/mmc/core/mmc_ops.c |  7 +++++--
 drivers/mmc/core/mmc_ops.h |  2 +-
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index c2abd417a84a..3e2ad728b55e 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1055,7 +1055,7 @@ static int mmc_select_hs(struct mmc_card *card)
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			   EXT_CSD_HS_TIMING, EXT_CSD_TIMING_HS,
 			   card->ext_csd.generic_cmd6_time, MMC_TIMING_MMC_HS,
-			   true, true);
+			   true, true, false);
 	if (err)
 		pr_warn("%s: switch to high-speed failed, err:%d\n",
 			mmc_hostname(card->host), err);
@@ -1087,7 +1087,7 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
 			   ext_csd_bits,
 			   card->ext_csd.generic_cmd6_time,
 			   MMC_TIMING_MMC_DDR52,
-			   true, true);
+			   true, true, false);
 	if (err) {
 		pr_err("%s: switch to bus width %d ddr failed\n",
 			mmc_hostname(host), 1 << bus_width);
@@ -1155,7 +1155,7 @@ static int mmc_select_hs400(struct mmc_card *card)
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			   EXT_CSD_HS_TIMING, val,
 			   card->ext_csd.generic_cmd6_time, 0,
-			   false, true);
+			   false, true, false);
 	if (err) {
 		pr_err("%s: switch to high-speed from hs200 failed, err:%d\n",
 			mmc_hostname(host), err);
@@ -1197,7 +1197,7 @@ static int mmc_select_hs400(struct mmc_card *card)
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			   EXT_CSD_HS_TIMING, val,
 			   card->ext_csd.generic_cmd6_time, 0,
-			   false, true);
+			   false, true, false);
 	if (err) {
 		pr_err("%s: switch to hs400 failed, err:%d\n",
 			 mmc_hostname(host), err);
@@ -1243,7 +1243,7 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 	val = EXT_CSD_TIMING_HS;
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
 			   val, card->ext_csd.generic_cmd6_time, 0,
-			   false, true);
+			   false, true, true);
 	if (err)
 		goto out_err;
 
@@ -1256,7 +1256,7 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 	/* Switch HS DDR to HS */
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_BUS_WIDTH,
 			   EXT_CSD_BUS_WIDTH_8, card->ext_csd.generic_cmd6_time,
-			   0, false, true);
+			   0, false, true, false);
 	if (err)
 		goto out_err;
 
@@ -1274,7 +1274,7 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 	      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
 			   val, card->ext_csd.generic_cmd6_time, 0,
-			   false, true);
+			   false, true, false);
 	if (err)
 		goto out_err;
 
@@ -1358,7 +1358,7 @@ static int mmc_select_hs400es(struct mmc_card *card)
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			   EXT_CSD_HS_TIMING, EXT_CSD_TIMING_HS,
 			   card->ext_csd.generic_cmd6_time, 0,
-			   false, true);
+			   false, true, false);
 	if (err) {
 		pr_err("%s: switch to hs for hs400es failed, err:%d\n",
 			mmc_hostname(host), err);
@@ -1392,7 +1392,7 @@ static int mmc_select_hs400es(struct mmc_card *card)
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			   EXT_CSD_HS_TIMING, val,
 			   card->ext_csd.generic_cmd6_time, 0,
-			   false, true);
+			   false, true, false);
 	if (err) {
 		pr_err("%s: switch to hs400es failed, err:%d\n",
 			mmc_hostname(host), err);
@@ -1457,7 +1457,7 @@ static int mmc_select_hs200(struct mmc_card *card)
 		err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				   EXT_CSD_HS_TIMING, val,
 				   card->ext_csd.generic_cmd6_time, 0,
-				   false, true);
+				   false, true, false);
 		if (err)
 			goto err;
 		old_timing = host->ios.timing;
@@ -1959,7 +1959,7 @@ static int mmc_poweroff_notify(struct mmc_card *card, unsigned int notify_type)
 
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			EXT_CSD_POWER_OFF_NOTIFICATION,
-			notify_type, timeout, 0, false, false);
+			notify_type, timeout, 0, false, false, false);
 	if (err)
 		pr_err("%s: Power Off Notification timed out, %u\n",
 		       mmc_hostname(card->host), timeout);
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 619088a94688..2baaa66e491d 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -552,12 +552,13 @@ int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
  *	@timing: new timing to change to
  *	@send_status: send status cmd to poll for busy
  *	@retry_crc_err: retry when CRC errors when polling with CMD13 for busy
+ *	@no_crc_resp: do not require to check CRC response
  *
  *	Modifies the EXT_CSD register for selected card.
  */
 int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		unsigned int timeout_ms, unsigned char timing,
-		bool send_status, bool retry_crc_err)
+		bool send_status, bool retry_crc_err, bool no_crc_resp)
 {
 	struct mmc_host *host = card->host;
 	int err;
@@ -594,6 +595,8 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 	} else {
 		cmd.flags |= MMC_RSP_SPI_R1 | MMC_RSP_R1;
 	}
+	if (no_crc_resp)
+		cmd.flags &= ~MMC_RSP_CRC;
 
 	if (index == EXT_CSD_SANITIZE_START)
 		cmd.sanitize_busy = true;
@@ -639,7 +642,7 @@ int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		unsigned int timeout_ms)
 {
 	return __mmc_switch(card, set, index, value, timeout_ms, 0,
-			    true, false);
+			    true, false, false);
 }
 EXPORT_SYMBOL_GPL(mmc_switch);
 
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 38dcfeeaf6d5..1a75c347b8a7 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -40,7 +40,7 @@ int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
 		      enum mmc_busy_cmd busy_cmd);
 int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		unsigned int timeout_ms, unsigned char timing,
-		bool send_status, bool retry_crc_err);
+		bool send_status, bool retry_crc_err, bool no_crc_resp);
 int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		unsigned int timeout_ms);
 void mmc_run_bkops(struct mmc_card *card);
-- 
2.17.1

