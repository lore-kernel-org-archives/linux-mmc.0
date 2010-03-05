From: Thomas Abraham <thomas.ab@samsung.com>
Subject: [PATCH] S3C: SDHCI: Modify timeout clock calculation.
Date: Fri, 05 Mar 2010 12:32:43 +0530
Message-ID: <1267772563-14846-1-git-send-email-thomas.ab@samsung.com>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ben-linux@fluff.org, linux-samsung-soc@vger.kernel.org, Thomas Abraham <thomas.ab@samsung.com>
List-Id: linux-mmc@vger.kernel.org

In sdhci_s3c_set_clock function of S3C SDHCI controller driver, when a new
clock source is selected, the timeout clock is recalculated. This patch 
modifies the calculation of the timeout clock based on the 
SDHCI_TIMEOUT_CLK_UNIT capability which is determined from the 
SDHCI_CAPABILITIES register.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 50997d2..ab4641c 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -181,6 +181,7 @@ static void sdhci_s3c_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	if (ourhost->cur_clk != best_src) {
 		struct clk *clk = ourhost->clk_bus[best_src];
+		unsigned int caps;
 
 		/* turn clock off to card before changing clock source */
 		writew(0, host->ioaddr + SDHCI_CLOCK_CONTROL);
@@ -188,7 +189,10 @@ static void sdhci_s3c_set_clock(struct sdhci_host *host, unsigned int clock)
 		ourhost->cur_clk = best_src;
 		host->max_clk = clk_get_rate(clk);
 		host->timeout_clk = sdhci_s3c_get_timeout_clk(host);
-
+		caps = readl(host->ioaddr + SDHCI_CAPABILITIES);
+		if (caps & SDHCI_TIMEOUT_CLK_UNIT)
+			host->timeout_clk *= 1000;
+
 		ctrl = readl(host->ioaddr + S3C_SDHCI_CONTROL2);
 		ctrl &= ~S3C_SDHCI_CTRL2_SELBASECLK_MASK;
 		ctrl |= best_src << S3C_SDHCI_CTRL2_SELBASECLK_SHIFT;
-- 
1.6.6.rc2
