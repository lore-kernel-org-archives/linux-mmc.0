From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [PATCH 1/3] sdhci: Implement CAP_CLOCK_BASE_BROKEN quirk
Date: Fri, 19 Feb 2010 22:48:27 +0300
Message-ID: <20100219194827.GA16636@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Richard =?utf-8?Q?R=C3=B6jfors?= <richard.rojfors.ext@mocean-labs.com>, Pierre Ossman <pierre@ossman.eu>, Ben Dooks <ben@simtec.co.uk>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Some hosts (e.g. as found in CNS3xxx SOCs) report wrong value in
CLOCK_BASE capability field, and currently there is no way to
force the SDHCI core to use the platform-provided base clock value.

This patch implements CAP_CLOCK_BASE_BROKEN quirk. When enabled,
the SDHCI core will always use base clock frequency provided by
the platform.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/mmc/host/sdhci.c |    3 ++-
 drivers/mmc/host/sdhci.h |    2 ++
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c279fbc..aedf4a1 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1745,7 +1745,8 @@ int sdhci_add_host(struct sdhci_host *host)
 	host->max_clk =
 		(caps & SDHCI_CLOCK_BASE_MASK) >> SDHCI_CLOCK_BASE_SHIFT;
 	host->max_clk *= 1000000;
-	if (host->max_clk == 0) {
+	if (host->max_clk == 0 || host->quirks &
+			SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN) {
 		if (!host->ops->get_max_clock) {
 			printk(KERN_ERR
 			       "%s: Hardware doesn't specify base clock "
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 842f46f..831bf7f 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -236,6 +236,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_DELAY_AFTER_POWER			(1<<23)
 /* Controller uses SDCLK instead of TMCLK for data timeouts */
 #define SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK		(1<<24)
+/* Controller reports wrong base clock capability */
+#define SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN		(1<<25)
 
 	int			irq;		/* Device IRQ */
 	void __iomem *		ioaddr;		/* Mapped address */
-- 
1.7.0
