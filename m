From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCHv3 1/4] sdhci-s3c: add support for the non standard minimal
 clock value
Date: Thu, 29 Jul 2010 14:34:32 +0200
Message-ID: <1280406875-31830-2-git-send-email-m.szyprowski@samsung.com>
References: <1280406875-31830-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1280406875-31830-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: m.szyprowski@samsung.com, kyungmin.park@samsung.com, kgene.kim@samsung.com, ben-linux@fluff.org, akpm@linux-foundation.org, broonie@opensource.wolfsonmicro.com
List-Id: linux-mmc@vger.kernel.org

S3C SDHCI host controller can change the source for generating mmc
clock. By default host bus clock is used, what causes some problems on
machines with 133MHz bus, because the SDHCI divider cannot be as high
get proper clock value for identification mode. This is not a problem
for the controller, because it can generate lower frequencies from other
clock sources. This patch changes sdhci driver to use get_min_clock()
call if it has been provided.

This fixes the flood of the following warnings on Samsung S5PV210 SoCs:
mmc0: Minimum clock frequency too high for identification mode

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---

Changes since V2: 
- removed the need for additional quirk, just use get_min_clock() method
if provided

Changes since V1:
- rebased onto latest -mm kernel tree
---
 drivers/mmc/host/sdhci-s3c.c |   27 +++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c     |    3 +--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index d7058ee..47138af 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -203,9 +203,36 @@ static void sdhci_s3c_set_clock(struct sdhci_host *host, unsigned int clock)
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
 	.set_clock		= sdhci_s3c_set_clock,
+	.get_min_clock		= sdhci_s3c_get_min_clock,
 };
 
 static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 07b2695..1c67f91 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1776,8 +1776,7 @@ int sdhci_add_host(struct sdhci_host *host)
 	 * Set host parameters.
 	 */
 	mmc->ops = &sdhci_ops;
-	if (host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK &&
-			host->ops->get_min_clock)
+	if (host->ops->get_min_clock)
 		mmc->f_min = host->ops->get_min_clock(host);
 	else
 		mmc->f_min = host->max_clk / 256;
-- 
1.7.1.569.g6f426
