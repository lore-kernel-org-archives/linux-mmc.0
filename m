From: Chuanxiao Dong <chuanxiao.dong@intel.com>
Subject: [PATCH v3] mmc: core: try 1.8v signling in ddr mode if host and
 device
Date: Fri, 15 Aug 2014 11:28:07 +0800
Message-ID: <20140815032806.GA19745@intel.com>
Reply-To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:5458 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932122AbaHOD3I (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 14 Aug 2014 23:29:08 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, chris@printf.org

Even (e)MMC card can support 3.3v to 1.2v vccq in DDR, but not all
host controller can support this, like some of the SDHCI host
which connect to an eMMC device. Some of these host controller
still needs to use 1.8v vccq for supporting DDR mode.

So the sequence will be:
if (host and device can both support 1.2v IO)
	use 1.2v IO;
else if (host and device can both support 1.8v IO)
	use 1.8v IO;
so if host and device can only support 3.3v IO, this is the last choice.

Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
Signed-off-by: Yunpeng Gao <yunpeng.gao@intel.com>
---
Changelog V2:
     - For (e)MMC device switching to DDR mode, try 1.2v singaling first. Then
     try 1.8v. If 1.2v and 1.8v are both not supported, use the default 

Changelog V3:
     - continue to try 1.8v/3.3v vccq if there is IO voltage switching failure

 drivers/mmc/core/mmc.c |   34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 793c6f7..8d69671 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -988,19 +988,35 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
 	 * 1.8V vccq at 3.3V core voltage (vcc) is not required
 	 * in the JEDEC spec for DDR.
 	 *
-	 * Do not force change in vccq since we are obviously
-	 * working and no change to vccq is needed.
+	 * Even (e)MMC card can support 3.3v to 1.2v vccq, but not all
+	 * host controller can support this, like some of the SDHCI
+	 * controller which connect to an eMMC device. Some of these
+	 * host controller still needs to use 1.8v vccq for supporting
+	 * DDR mode.
+	 *
+	 * So the sequence will be:
+	 * if (host and device can both support 1.2v IO)
+	 *	use 1.2v IO;
+	 * else if (host and device can both support 1.8v IO)
+	 * 	use 1.8v IO;
+	 * so if host and device can only support 3.3v IO, this is the
+	 * last choice.
 	 *
 	 * WARNING: eMMC rules are NOT the same as SD DDR
 	 */
-	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_DDR_1_2V) {
-		err = __mmc_set_signal_voltage(host,
-				MMC_SIGNAL_VOLTAGE_120);
-		if (err)
-			return err;
-	}
+	err = -EINVAL;
+	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_DDR_1_2V)
+		err = __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120);
 
-	mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
+	if (err && (card->mmc_avail_type & EXT_CSD_CARD_TYPE_DDR_1_8V))
+		err = __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180);
+
+	/* make sure vccq is 3.3v after switching disaster */
+	if (err)
+		err = __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330);
+
+	if (!err)
+		mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
 
 	return err;
 }
-- 
1.7.10.4

