From: Chuanxiao Dong <chuanxiao.dong@intel.com>
Subject: [PATCH] mmc: core: use 1.8v signling in ddr mode for some special
 host
Date: Fri, 1 Aug 2014 14:08:16 +0800
Message-ID: <20140801060816.GA3172@intel.com>
Reply-To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:33866 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750745AbaHAGKI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 1 Aug 2014 02:10:08 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, chris@printf.org, ulf.hansson@linaro.org
Cc: yunpeng.gao@intel.com

Even eMMC card can support 3.3v to 1.2v vccq in DDR, but not all
host controller can support this, like some of the SDHCI host
which connect to an eMMC device. Some of these host controller
still needs to use 1.8v vccq for supporting DDR mode.

If a host controller cannot support 3.3v for DDR, try 1.8v.

Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
Signed-off-by: Yunpeng Gao <yunpeng.gao@intel.com>
---
 drivers/mmc/core/mmc.c   |   19 +++++++++++++++++++
 include/linux/mmc/host.h |    1 +
 2 files changed, 20 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 793c6f7..13a5b24 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1000,6 +1000,25 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
 			return err;
 	}
 
+	/*
+	 * Even eMMC card can support 3.3v to 1.2v vccq, but not all
+	 * host controller can support this, like some of the SDHCI
+	 * controller which connect to an eMMC device. Some of these
+	 * host controller still needs to use 1.8v vccq for supporting
+	 * DDR mode.
+	 *
+	 * If a host controller cannot support 3.3v for DDR, try 1.8v
+	 */
+	if (unlikely(host->caps2 & MMC_CAP2_NO_3_3V_DDR)) {
+		if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200_1_8V) {
+			err = __mmc_set_signal_voltage(host,
+					MMC_SIGNAL_VOLTAGE_180);
+			if (err)
+				return err;
+		} else
+			return -EOPNOTSUPP;
+	}
+
 	mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
 
 	return err;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 7960424..e5d3ada 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -283,6 +283,7 @@ struct mmc_host {
 #define MMC_CAP2_HS400		(MMC_CAP2_HS400_1_8V | \
 				 MMC_CAP2_HS400_1_2V)
 #define MMC_CAP2_SDIO_IRQ_NOTHREAD (1 << 17)
+#define MMC_CAP2_NO_3_3V_DDR	(1 << 18) /* doesn't support 3.3v vccq in ddr */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
-- 
1.7.10.4

