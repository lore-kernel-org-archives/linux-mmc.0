From: Chuanxiao Dong <chuanxiao.dong@intel.com>
Subject: [PATCH] mmc: sdhci: check 1.2v IO capability for SDHC host
Date: Thu, 14 Aug 2014 18:05:59 +0800
Message-ID: <20140814100559.GB3933@intel.com>
Reply-To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:46820 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752327AbaHNKGd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 14 Aug 2014 06:06:33 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, chris@printf.org

Right now enable 1.2v IO voltage for SDHC is by using vqmmc.
Thus for the host which doesn't have vqmmc, or its vqmmc does
not support 1.2v, directly use MMC_CAP2_HS200 may cause HS200
failure.

So needs to check if vqmmc is able to support 1.2v. If it does
not support, disable 1.2v IO for HS200.

Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
---
 drivers/mmc/host/sdhci.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c026ec8..6b701e1 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2999,8 +2999,12 @@ int sdhci_add_host(struct sdhci_host *host)
 		/* SD3.0: SDR104 is supported so (for eMMC) the caps2
 		 * field can be promoted to support HS200.
 		 */
-		if (!(host->quirks2 & SDHCI_QUIRK2_BROKEN_HS200))
+		if (!(host->quirks2 & SDHCI_QUIRK2_BROKEN_HS200)) {
 			mmc->caps2 |= MMC_CAP2_HS200;
+			if (!host->vqmmc || !regulator_is_supported_voltage
+					(host->vqmmc, 1100000, 1300000))
+				mmc->caps2 &= ~MMC_CAP2_HS200_1_2V_SDR;
+		}
 	} else if (caps[1] & SDHCI_SUPPORT_SDR50)
 		mmc->caps |= MMC_CAP_UHS_SDR50;
 
-- 
1.7.10.4

