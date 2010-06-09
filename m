From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 4/5] sdhci-s3c: add support for the non standard minimal clock
	value
Date: Wed, 09 Jun 2010 11:39:42 +0200
Message-ID: <1276076383-24825-5-git-send-email-m.szyprowski@samsung.com>
References: <1276076383-24825-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1276076383-24825-1-git-send-email-m.szyprowski@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: kyungmin.park@samsung.com, kgene.kim@samsung.com, ben-linux@fluff.org, m.szyprowski@samsung.com
List-Id: linux-mmc@vger.kernel.org

S3C SDHCI host controller can change the source for generating mmc clock.
By default host bus clock is used, what causes some problems on machines
with 133MHz bus, because the SDHCI divider cannot be as high get proper
clock value for identification mode. This is not a problem for the
controller, because it can generate lower frequencies from other clock
sources. This patch adds a new quirk to SDHCI driver to calculate the
minimal supported clock frequency.

This fixes the flood of the following warnings on Samsung S5PV210 SoCs:
mmc0: Minimum clock frequency too high for identification mode

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c |    1 +
 drivers/mmc/host/sdhci-s3c.c      |   29 +++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c          |    2 +-
 drivers/mmc/host/sdhci.h          |    2 ++
 4 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index c8623de..64b3f79 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -124,6 +124,7 @@ struct sdhci_of_data sdhci_esdhc = {
 		  SDHCI_QUIRK_BROKEN_CARD_DETECTION |
 		  SDHCI_QUIRK_NO_BUSY_IRQ |
 		  SDHCI_QUIRK_NONSTANDARD_CLOCK |
+		  SDHCI_QUIRK_NONSTANDARD_MINCLOCK |
 		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
 		  SDHCI_QUIRK_PIO_NEEDS_DELAY |
 		  SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET |
diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 2b6cb44..615008d 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -209,10 +209,37 @@ static void sdhci_s3c_set_clock(struct sdhci_host *host, unsigned int clock)
 	}
 }
 
+/**
+ * sdhci_s3c_get_min_clock - callback to get minimal supported clock value
+ * @host: The SDHCI host being queried
+ *
+ * To init mmc host properly a minimal clock value is needed. For high system
+ * bus clock's values the standard formula gives values out of allowed range.
+ * The clock still can be set to lower values, if clock source other then
+ * system bus is selected.
+*/
+static unsigned int sdhci_s3c_get_min_clock(struct sdhci_host *host)
+{
+	struct sdhci_s3c *ourhost = to_s3c(host);
+	unsigned int delta, min = UINT_MAX;
+	int src;
+
+	for (src = 0; src < MAX_BUS_CLK; src++) {
+		delta = sdhci_s3c_consider_clock(ourhost, src, 0);
+		if (delta == UINT_MAX)
+			continue;
+		/* delta is a negative value in this case */
+		if (-delta < min)
+			min = -delta;
+	}
+	return min;
+}
+
 static struct sdhci_ops sdhci_s3c_ops = {
 	.get_max_clock		= sdhci_s3c_get_max_clk,
 	.get_timeout_clock	= sdhci_s3c_get_timeout_clk,
 	.set_clock		= sdhci_s3c_set_clock,
+	.get_min_clock		= sdhci_s3c_get_min_clock,
 };
 
 static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
@@ -316,6 +343,8 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 	host->quirks = 0;
 	host->irq = irq;
 
+	host->quirks |= SDHCI_QUIRK_NONSTANDARD_MINCLOCK;
+
 	/* Setup quirks for the controller */
 	host->quirks |= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC;
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c6d1bd8..8b3ee53 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1785,7 +1785,7 @@ int sdhci_add_host(struct sdhci_host *host)
 	 * Set host parameters.
 	 */
 	mmc->ops = &sdhci_ops;
-	if (host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK &&
+	if (host->quirks & SDHCI_QUIRK_NONSTANDARD_MINCLOCK &&
 			host->ops->set_clock && host->ops->get_min_clock)
 		mmc->f_min = host->ops->get_min_clock(host);
 	else
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index c846813..3fd87c2 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -240,6 +240,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN		(1<<25)
 /* Controller cannot support End Attribute in NOP ADMA descriptor */
 #define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC		(1<<26)
+/* Controller has nonstandard clock management */
+#define SDHCI_QUIRK_NONSTANDARD_MINCLOCK		(1<<27)
 
 	int			irq;		/* Device IRQ */
 	void __iomem *		ioaddr;		/* Mapped address */
-- 
1.7.1.240.g225c
