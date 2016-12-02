From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 1/1] mmc: mmc: Relax checking for switch errors after HS200 switch
Date: Fri,  2 Dec 2016 13:16:35 +0200
Message-ID: <1480677395-14169-2-git-send-email-adrian.hunter@intel.com>
References: <1480677395-14169-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:7518 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758734AbcLBLVk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 2 Dec 2016 06:21:40 -0500
In-Reply-To: <1480677395-14169-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Stephen Boyd <sboyd@codeaurora.org>, Michael Walle <michael@walle.cc>, Yong Mao <yong.mao@mediatek.com>, Shawn Lin <shawn.lin@rock-chips.com>

The JEDEC specification indicates CMD13 can be used after a HS200 switch
to check for errors. However in practice some boards experience CRC errors
in the CMD13 response. Consequently, for HS200, CRC errors are not a
reliable way to know the switch failed. If there really is a problem, we
would expect tuning will fail and the result ends up the same. So change
the error condition to ignore CRC errors in that case.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/mmc.c     | 15 +++++++++++++--
 drivers/mmc/core/mmc_ops.c |  9 ++++++++-
 drivers/mmc/core/mmc_ops.h |  1 +
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 033e00abe93f..b61b52f9da3d 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1240,7 +1240,12 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 
 	mmc_set_timing(host, MMC_TIMING_MMC_HS200);
 
-	err = mmc_switch_status(card);
+	/*
+	 * For HS200, CRC errors are not a reliable way to know the switch
+	 * failed. If there really is a problem, we would expect tuning will
+	 * fail and the result ends up the same.
+	 */
+	err = __mmc_switch_status(card, false);
 	if (err)
 		goto out_err;
 
@@ -1403,7 +1408,13 @@ static int mmc_select_hs200(struct mmc_card *card)
 		old_timing = host->ios.timing;
 		mmc_set_timing(host, MMC_TIMING_MMC_HS200);
 
-		err = mmc_switch_status(card);
+		/*
+		 * For HS200, CRC errors are not a reliable way to know the
+		 * switch failed. If there really is a problem, we would expect
+		 * tuning will fail and the result ends up the same.
+		 */
+		err = __mmc_switch_status(card, false);
+
 		/*
 		 * mmc_select_timing() assumes timing has not changed if
 		 * it is a switch error.
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index cb7006feb5c4..81ce63bb0773 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -431,18 +431,25 @@ static int mmc_switch_status_error(struct mmc_host *host, u32 status)
 }
 
 /* Caller must hold re-tuning */
-int mmc_switch_status(struct mmc_card *card)
+int __mmc_switch_status(struct mmc_card *card, bool crc_err_fatal)
 {
 	u32 status;
 	int err;
 
 	err = mmc_send_status(card, &status);
+	if (!crc_err_fatal && err == -EILSEQ)
+		return 0;
 	if (err)
 		return err;
 
 	return mmc_switch_status_error(card->host, status);
 }
 
+int mmc_switch_status(struct mmc_card *card)
+{
+	return __mmc_switch_status(card, true);
+}
+
 static int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
 			bool send_status, bool retry_crc_err)
 {
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 761cb69c46af..abd525ed74be 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -28,6 +28,7 @@
 int mmc_send_hpi_cmd(struct mmc_card *card, u32 *status);
 int mmc_can_ext_csd(struct mmc_card *card);
 int mmc_switch_status(struct mmc_card *card);
+int __mmc_switch_status(struct mmc_card *card, bool crc_err_fatal);
 int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		unsigned int timeout_ms, unsigned char timing,
 		bool use_busy_signal, bool send_status,	bool retry_crc_err);
-- 
1.9.1

