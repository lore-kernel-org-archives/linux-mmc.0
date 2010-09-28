From: Philip Rakity <prakity@marvell.com>
Subject: [RFC] remove quirk for broken clock - redundant since
 ops->max_clock defined
Date: Tue, 28 Sep 2010 00:39:47 -0700
Message-ID: <23CB1625-7451-41BD-AD43-73C588A1593F@marvell.com>
References: <8C0FC31B-681F-4541-AD64-43578FC926F6@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:48966 "HELO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754173Ab0I1HlS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 28 Sep 2010 03:41:18 -0400
In-Reply-To: <8C0FC31B-681F-4541-AD64-43578FC926F6@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Anton Vorontsov <cbouatmailru@gmail.com>


>From 2b436be109ad004e94a2b63f71f6bb8e00f9d3da Mon Sep 17 00:00:00 2001
From: Philip Rakity <prakity@marvell.com>
Date: Tue, 28 Sep 2010 00:34:17 -0700
Subject: [RFC] remove quirk for broken clock - redundant since ops->max_clock defined

Are we okay moving in this direction?  Patch is NOT tested since RFC -- does compile.

If we are moving away from using both quirks and host->ops to define
platform specific actions -- just use the host->ops operation to
get max_clock.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci-cns3xxx.c |    1 -
 drivers/mmc/host/sdhci.c         |   24 +++++++++++++-----------
 drivers/mmc/host/sdhci.h         |    2 --
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci-cns3xxx.c b/drivers/mmc/host/sdhci-cns3xxx.c
index b7050b3..27c896d 100644
--- a/drivers/mmc/host/sdhci-cns3xxx.c
+++ b/drivers/mmc/host/sdhci-cns3xxx.c
@@ -91,7 +91,6 @@ struct sdhci_pltfm_data sdhci_cns3xxx_pdata = {
 	.quirks = SDHCI_QUIRK_BROKEN_DMA |
 		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
 		  SDHCI_QUIRK_INVERTED_WRITE_PROTECT |
-		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
 		  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
 		  SDHCI_QUIRK_NONSTANDARD_CLOCK,
 };
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 451fad3..64af676 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1799,18 +1799,20 @@ int sdhci_add_host(struct sdhci_host *host)
 		mmc_dev(host->mmc)->dma_mask = &host->dma_mask;
 	}
 
-	host->max_clk =
-		(caps & SDHCI_CLOCK_BASE_MASK) >> SDHCI_CLOCK_BASE_SHIFT;
-	host->max_clk *= 1000000;
-	if (host->max_clk == 0 || host->quirks &
-			SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN) {
-		if (!host->ops->get_max_clock) {
-			printk(KERN_ERR
-			       "%s: Hardware doesn't specify base clock "
-			       "frequency.\n", mmc_hostname(mmc));
-			return -ENODEV;
-		}
+	if (host->ops->get_max_clock) {
 		host->max_clk = host->ops->get_max_clock(host);
+	} else {
+		host->max_clk =
+			(caps & SDHCI_CLOCK_BASE_MASK)
+				>> SDHCI_CLOCK_BASE_SHIFT;
+		host->max_clk *= 1000000;
+	}
+
+	if (host->max_clk == 0 ) {
+		printk(KERN_ERR
+		       "%s: Hardware doesn't specify base clock "
+		       "frequency.\n", mmc_hostname(mmc));
+		return -ENODEV;
 	}
 
 	host->timeout_clk =
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index f8c18cd..7c15bc5 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -237,8 +237,6 @@ struct sdhci_host {
 #define SDHCI_QUIRK_DELAY_AFTER_POWER			(1<<23)
 /* Controller uses SDCLK instead of TMCLK for data timeouts */
 #define SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK		(1<<24)
-/* Controller reports wrong base clock capability */
-#define SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN		(1<<25)
 /* Controller cannot support End Attribute in NOP ADMA descriptor */
 #define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC		(1<<26)
 /* Controller is missing device caps. Use caps provided by host */
-- 
1.6.0.4

