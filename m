From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH 4/6] mmc: sdhci-s3c: Simplify min/max clock calculation
Date: Sat, 11 Jan 2014 22:39:04 +0100
Message-ID: <1389476346-20396-5-git-send-email-tomasz.figa@gmail.com>
References: <1389476346-20396-1-git-send-email-tomasz.figa@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f49.google.com ([74.125.83.49]:63488 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025AbaAKVjY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 11 Jan 2014 16:39:24 -0500
In-Reply-To: <1389476346-20396-1-git-send-email-tomasz.figa@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>, Chris Ball <chris@printf.net>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>

This patch reimplements functions calculating minimum and maximum clock
rates to leverage clock rate cache introduced by previous patches.

In addition, the calculation is simplified to just comparing input
clock rates (max case) or input clock rates divided by maximum divisor
(min case), which is basically what the original code did, but with much
more unnecessary work.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/mmc/host/sdhci-s3c.c | 60 +++++++++++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 7fde938..7e14db0 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -112,20 +112,16 @@ static void sdhci_s3c_check_sclk(struct sdhci_host *host)
 static unsigned int sdhci_s3c_get_max_clk(struct sdhci_host *host)
 {
 	struct sdhci_s3c *ourhost = to_s3c(host);
-	struct clk *busclk;
-	unsigned int rate, max;
-	int clk;
+	unsigned long rate, max = 0;
+	int src;
 
 	/* note, a reset will reset the clock source */
 
 	sdhci_s3c_check_sclk(host);
 
-	for (max = 0, clk = 0; clk < MAX_BUS_CLK; clk++) {
-		busclk = ourhost->clk_bus[clk];
-		if (!busclk)
-			continue;
 
-		rate = clk_get_rate(busclk);
+	for (src = 0; src < MAX_BUS_CLK; src++) {
+		rate = ourhost->clk_rates[src];
 		if (rate > max)
 			max = rate;
 	}
@@ -255,17 +251,17 @@ static void sdhci_s3c_set_clock(struct sdhci_host *host, unsigned int clock)
 static unsigned int sdhci_s3c_get_min_clock(struct sdhci_host *host)
 {
 	struct sdhci_s3c *ourhost = to_s3c(host);
-	unsigned int delta, min = UINT_MAX;
+	unsigned long rate, min = ULONG_MAX;
 	int src;
 
 	for (src = 0; src < MAX_BUS_CLK; src++) {
-		delta = sdhci_s3c_consider_clock(ourhost, src, 0);
-		if (delta == UINT_MAX)
+		rate = ourhost->clk_rates[src] / 256;
+		if (!rate)
 			continue;
-		/* delta is a negative value in this case */
-		if (-delta < min)
-			min = -delta;
+		if (rate < min)
+			min = rate;
 	}
+
 	return min;
 }
 
@@ -273,20 +269,44 @@ static unsigned int sdhci_s3c_get_min_clock(struct sdhci_host *host)
 static unsigned int sdhci_cmu_get_max_clock(struct sdhci_host *host)
 {
 	struct sdhci_s3c *ourhost = to_s3c(host);
+	unsigned long rate, max = 0;
+	int src;
+
+	for (src = 0; src < MAX_BUS_CLK; src++) {
+		struct clk *clk;
+
+		clk = ourhost->clk_bus[src];
+		if (IS_ERR(clk))
+			continue;
+
+		rate = clk_round_rate(clk, ULONG_MAX);
+		if (rate > max)
+			max = rate;
+	}
 
-	return clk_round_rate(ourhost->clk_bus[ourhost->cur_clk], UINT_MAX);
+	return max;
 }
 
 /* sdhci_cmu_get_min_clock - callback to get minimal supported clock value. */
 static unsigned int sdhci_cmu_get_min_clock(struct sdhci_host *host)
 {
 	struct sdhci_s3c *ourhost = to_s3c(host);
+	unsigned long rate, min = ULONG_MAX;
+	int src;
 
-	/*
-	 * initial clock can be in the frequency range of
-	 * 100KHz-400KHz, so we set it as max value.
-	 */
-	return clk_round_rate(ourhost->clk_bus[ourhost->cur_clk], 400000);
+	for (src = 0; src < MAX_BUS_CLK; src++) {
+		struct clk *clk;
+
+		clk = ourhost->clk_bus[src];
+		if (IS_ERR(clk))
+			continue;
+
+		rate = clk_round_rate(clk, 0);
+		if (rate < min)
+			min = rate;
+	}
+
+	return min;
 }
 
 /* sdhci_cmu_set_clock - callback on clock change.*/
-- 
1.8.5.2

