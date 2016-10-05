From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 2/4] mmc: sdhci: Rename sdhci_set_power() to sdhci_set_power_noreg()
Date: Wed,  5 Oct 2016 12:11:22 +0300
Message-ID: <1475658684-32312-3-git-send-email-adrian.hunter@intel.com>
References: <1475658684-32312-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:13461 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752488AbcJEJRE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 5 Oct 2016 05:17:04 -0400
In-Reply-To: <1475658684-32312-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Jisheng Zhang <jszhang@marvell.com>

Unlike other cases, sdhci_set_power() does not reflect the default
implementation of the ->set_power() callback. Rename it and create
sdhci_set_power() that is the default implementation.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/mmc/host/sdhci-pxav3.c |  2 +-
 drivers/mmc/host/sdhci.c       | 26 +++++++++++++-------------
 drivers/mmc/host/sdhci.h       |  2 ++
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index dd1938d341f7..d0f5c05fbc19 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -315,7 +315,7 @@ static void pxav3_set_power(struct sdhci_host *host, unsigned char mode,
 	struct mmc_host *mmc = host->mmc;
 	u8 pwr = host->pwr;
 
-	sdhci_set_power(host, mode, vdd);
+	sdhci_set_power_noreg(host, mode, vdd);
 
 	if (host->pwr == pwr)
 		return;
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3711813f5654..223a91e039dc 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1394,8 +1394,8 @@ static void sdhci_set_power_reg(struct sdhci_host *host, unsigned char mode,
 		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
 }
 
-void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
-		     unsigned short vdd)
+void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
+			   unsigned short vdd)
 {
 	u8 pwr = 0;
 
@@ -1459,20 +1459,17 @@ void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
 			mdelay(10);
 	}
 }
-EXPORT_SYMBOL_GPL(sdhci_set_power);
+EXPORT_SYMBOL_GPL(sdhci_set_power_noreg);
 
-static void __sdhci_set_power(struct sdhci_host *host, unsigned char mode,
-			      unsigned short vdd)
+void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
+		     unsigned short vdd)
 {
-	struct mmc_host *mmc = host->mmc;
-
-	if (host->ops->set_power)
-		host->ops->set_power(host, mode, vdd);
-	else if (!IS_ERR(mmc->supply.vmmc))
-		sdhci_set_power_reg(host, mode, vdd);
+	if (IS_ERR(host->mmc->supply.vmmc))
+		sdhci_set_power_noreg(host, mode, vdd);
 	else
-		sdhci_set_power(host, mode, vdd);
+		sdhci_set_power_reg(host, mode, vdd);
 }
+EXPORT_SYMBOL_GPL(sdhci_set_power);
 
 /*****************************************************************************\
  *                                                                           *
@@ -1613,7 +1610,10 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		}
 	}
 
-	__sdhci_set_power(host, ios->power_mode, ios->vdd);
+	if (host->ops->set_power)
+		host->ops->set_power(host, ios->power_mode, ios->vdd);
+	else
+		sdhci_set_power(host, ios->power_mode, ios->vdd);
 
 	if (host->ops->platform_send_init_74_clocks)
 		host->ops->platform_send_init_74_clocks(host, ios->power_mode);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index c722cd23205c..766df17fb7eb 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -683,6 +683,8 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
 void sdhci_set_clock(struct sdhci_host *host, unsigned int clock);
 void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
 		     unsigned short vdd);
+void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
+			   unsigned short vdd);
 void sdhci_set_bus_width(struct sdhci_host *host, int width);
 void sdhci_reset(struct sdhci_host *host, u8 mask);
 void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
-- 
1.9.1

