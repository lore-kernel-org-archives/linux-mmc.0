From: Chuanxiao Dong <chuanxiao.dong@intel.com>
Subject: [PATCH V2] mmc: core: try 1.8v signaling in ddr mode if host and
 device
Date: Thu, 14 Aug 2014 17:54:49 +0800
Message-ID: <20140814095449.GA3933@intel.com>
Reply-To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:48261 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754322AbaHNJzP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 14 Aug 2014 05:55:15 -0400
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
    try 1.8v. If 1.2v and 1.8v are both not supported, use the default 3.3v

 drivers/mmc/core/mmc.c |   20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 793c6f7..aa5180b 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -988,8 +988,19 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
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
@@ -998,6 +1009,11 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
 				MMC_SIGNAL_VOLTAGE_120);
 		if (err)
 			return err;
+	} else if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_DDR_1_8V) {
+		err = __mmc_set_signal_voltage(host,
+				MMC_SIGNAL_VOLTAGE_180);
+		if (err)
+			return err;
 	}
 
 	mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
-- 
1.7.10.4

