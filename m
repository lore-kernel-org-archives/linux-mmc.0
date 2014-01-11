From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH 3/6] mmc: sdhci-s3c: Use correct condition to check for clock presence
Date: Sat, 11 Jan 2014 22:39:03 +0100
Message-ID: <1389476346-20396-4-git-send-email-tomasz.figa@gmail.com>
References: <1389476346-20396-1-git-send-email-tomasz.figa@gmail.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1389476346-20396-1-git-send-email-tomasz.figa@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>, Chris Ball <chris@printf.net>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>
List-Id: linux-mmc@vger.kernel.org

IS_ERR() must be used to make sure that not a valid clock was returned
by clk_get() and company.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/mmc/host/sdhci-s3c.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 9b78391..7fde938 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -147,7 +147,7 @@ static unsigned int sdhci_s3c_consider_clock(struct sdhci_s3c *ourhost,
 	struct clk *clksrc = ourhost->clk_bus[src];
 	int shift;
 
-	if (!clksrc)
+	if (IS_ERR(clksrc))
 		return UINT_MAX;
 
 	/*
@@ -567,16 +567,14 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 	clk_prepare_enable(sc->clk_io);
 
 	for (clks = 0, ptr = 0; ptr < MAX_BUS_CLK; ptr++) {
-		struct clk *clk;
 		char name[14];
 
 		snprintf(name, 14, "mmc_busclk.%d", ptr);
-		clk = devm_clk_get(dev, name);
-		if (IS_ERR(clk))
+		sc->clk_bus[ptr] = devm_clk_get(dev, name);
+		if (IS_ERR(sc->clk_bus[ptr]))
 			continue;
 
 		clks++;
-		sc->clk_bus[ptr] = clk;
 
 		/*
 		 * save current clock index to know which clock bus
-- 
1.8.5.2
