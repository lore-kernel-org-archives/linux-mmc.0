From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH 2/6] mmc: sdhci-s3c: Cache bus clock rates
Date: Sat, 11 Jan 2014 22:39:02 +0100
Message-ID: <1389476346-20396-3-git-send-email-tomasz.figa@gmail.com>
References: <1389476346-20396-1-git-send-email-tomasz.figa@gmail.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1389476346-20396-1-git-send-email-tomasz.figa@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>, Chris Ball <chris@printf.net>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>
List-Id: linux-mmc@vger.kernel.org

To fix scheduling while atomic happening in sdhci_s3c_set_clock() caused
by calling clk_get_rate() that might sleep, this patch modifies the
driver to cache rates of all bus clocks at probe time and then only use
those cache values.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/mmc/host/sdhci-s3c.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 52770d5..9b78391 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -57,6 +57,7 @@ struct sdhci_s3c {
 
 	struct clk		*clk_io;
 	struct clk		*clk_bus[MAX_BUS_CLK];
+	unsigned long		clk_rates[MAX_BUS_CLK];
 };
 
 /**
@@ -158,7 +159,7 @@ static unsigned int sdhci_s3c_consider_clock(struct sdhci_s3c *ourhost,
 		return wanted - rate;
 	}
 
-	rate = clk_get_rate(clksrc);
+	rate = ourhost->clk_rates[src];
 
 	for (shift = 0; shift < 8; ++shift) {
 		if ((rate >> shift) <= wanted)
@@ -215,7 +216,7 @@ static void sdhci_s3c_set_clock(struct sdhci_host *host, unsigned int clock)
 		writew(0, host->ioaddr + SDHCI_CLOCK_CONTROL);
 
 		ourhost->cur_clk = best_src;
-		host->max_clk = clk_get_rate(clk);
+		host->max_clk = ourhost->clk_rates[best_src];
 
 		ctrl = readl(host->ioaddr + S3C_SDHCI_CONTROL2);
 		ctrl &= ~S3C_SDHCI_CTRL2_SELBASECLK_MASK;
@@ -583,8 +584,10 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 		 */
 		sc->cur_clk = ptr;
 
+		sc->clk_rates[ptr] = clk_get_rate(sc->clk_bus[ptr]);
+
 		dev_info(dev, "clock source %d: %s (%ld Hz)\n",
-			 ptr, name, clk_get_rate(clk));
+				ptr, name, sc->clk_rates[ptr]);
 	}
 
 	if (clks == 0) {
-- 
1.8.5.2
