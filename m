From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH] sdhci: enable DUAL DATA RATE -- check capability 1 register
Date: Fri, 8 Oct 2010 17:47:19 -0700
Message-ID: <6D8204DA-1DF9-4B5C-8A78-0F51F5E1294C@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:36077 "HELO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1759979Ab0JIArW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 8 Oct 2010 20:47:22 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


Dual Data Rate is support is defined in CAPABILITY ONE Register. 
a) add bit field definitions
b) check if DDR50 -- 1.8v support is available --  then enable slot is DDR capable

---
 drivers/mmc/host/sdhci.c |    8 +++++++-
 drivers/mmc/host/sdhci.h |   13 +++++++++++++
 2 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 21b4ff9..16c6cee 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1726,6 +1726,7 @@ int sdhci_add_host(struct sdhci_host *host)
 {
 	struct mmc_host *mmc;
 	unsigned int caps;
+	unsigned int caps1;
 	int ret;
 
 	WARN_ON(host == NULL);
@@ -1813,9 +1814,14 @@ int sdhci_add_host(struct sdhci_host *host)
 		mmc_dev(host->mmc)->dma_mask = &host->dma_mask;
 	}
 
-	if (host->version >= SDHCI_SPEC_300)
+	if (host->version >= SDHCI_SPEC_300) {
 		host->max_clk = (caps & SDHCI_CLOCK_V3_BASE_MASK)
 			>> SDHCI_CLOCK_BASE_SHIFT;
+		caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
+		if ((caps1 & SDHCI_CAN_DO_DDR50) &&
+			(caps & SDHCI_CAN_VDD_180))
+			host->mmc->caps |= MMC_CAP_1_8V_DDR;
+	}
 	else
 		host->max_clk = (caps & SDHCI_CLOCK_BASE_MASK)
 			>> SDHCI_CLOCK_BASE_SHIFT;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index ae30f7d..3c1860d 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -163,6 +163,19 @@
 #define  SDHCI_CAN_64BIT	0x10000000
 
 #define SDHCI_CAPABILITIES_1	0x44
+#define  SDHCI_CAN_DO_SRD50	0x00000001
+#define  SDHCI_CAN_DO_SR104	0x00000002
+#define  SDHCI_CAN_DO_DDR50	0x00000004
+#define  SDHCI_CAN_DO_DRIVER_A	0x00000010
+#define  SDHCI_CAN_DO_DRIVER_C	0x00000020
+#define  SDHCI_CAN_DO_DRIVER_D	0x00000040
+#define  SDHCI_TIMER_COUNT_MASK		0xF
+#define  SDHCI_TIMER_COUNT_SHIFT	8
+#define  SDHCI_USE_TIMING_SDR50	0x00002000
+#define  SDHCI_RETUNING_MODE_MASK	0x3
+#define  SDHCI_RETUNING_MODE_SHIFT	14
+#define  SDHCI_CLOCK_MULT_MASK		0xFF
+#define  SDHCI_CLOCK_MULT_SHIFT		16
 
 #define SDHCI_MAX_CURRENT	0x48
 
-- 
1.6.0.4

