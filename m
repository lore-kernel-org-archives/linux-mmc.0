From: akpm@linux-foundation.org
Subject: [patch 050/177] sdhci-s3c: add support for the non standard minimal clock value
Date: Tue, 10 Aug 2010 18:01:56 -0700
Message-ID: <201008110101.o7B11uem027096@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35151 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932299Ab0HKBWJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Aug 2010 21:22:09 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, m.szyprowski@samsung.com, kyungmin.park@samsung.com, linux-mmc@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

S3C SDHCI host controller can change the source for generating mmc clock. 
By default host bus clock is used, what causes some problems on machines
with 133MHz bus, because the SDHCI divider cannot be as high get proper
clock value for identification mode.  This is not a problem for the
controller, because it can generate lower frequencies from other clock
sources.  This patch changes sdhci driver to use get_min_clock() call if
it has been provided.

This fixes the flood of the following warnings on Samsung S5PV210 SoCs:
mmc0: Minimum clock frequency too high for identification mode

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/sdhci-s3c.c |   27 +++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c     |    3 +--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff -puN drivers/mmc/host/sdhci-s3c.c~sdhci-s3c-add-support-for-the-non-standard-minimal-clock-value drivers/mmc/host/sdhci-s3c.c
--- a/drivers/mmc/host/sdhci-s3c.c~sdhci-s3c-add-support-for-the-non-standard-minimal-clock-value
+++ a/drivers/mmc/host/sdhci-s3c.c
@@ -203,9 +203,36 @@ static void sdhci_s3c_set_clock(struct s
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
diff -puN drivers/mmc/host/sdhci.c~sdhci-s3c-add-support-for-the-non-standard-minimal-clock-value drivers/mmc/host/sdhci.c
--- a/drivers/mmc/host/sdhci.c~sdhci-s3c-add-support-for-the-non-standard-minimal-clock-value
+++ a/drivers/mmc/host/sdhci.c
@@ -1791,8 +1791,7 @@ int sdhci_add_host(struct sdhci_host *ho
 	 * Set host parameters.
 	 */
 	mmc->ops = &sdhci_ops;
-	if (host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK &&
-			host->ops->get_min_clock)
+	if (host->ops->get_min_clock)
 		mmc->f_min = host->ops->get_min_clock(host);
 	else
 		mmc->f_min = host->max_clk / 256;
_
