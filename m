From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH 1/6] mmc: sdhci-s3c: Use shifts to divide by powers of two
Date: Sat, 11 Jan 2014 22:39:01 +0100
Message-ID: <1389476346-20396-2-git-send-email-tomasz.figa@gmail.com>
References: <1389476346-20396-1-git-send-email-tomasz.figa@gmail.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1389476346-20396-1-git-send-email-tomasz.figa@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>, Chris Ball <chris@printf.net>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Current implementation of sdhci_s3c_consider_clock() is highly
inefficient due to multiple integer divisions by variable performed in a
loop. Since only divisors that are powers of two are considered, this
patch replaces them with respective shifts, removing all the integer
divisions.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/mmc/host/sdhci-s3c.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 6debda9..52770d5 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -144,7 +144,7 @@ static unsigned int sdhci_s3c_consider_clock(struct sdhci_s3c *ourhost,
 {
 	unsigned long rate;
 	struct clk *clksrc = ourhost->clk_bus[src];
-	int div;
+	int shift;
 
 	if (!clksrc)
 		return UINT_MAX;
@@ -160,15 +160,15 @@ static unsigned int sdhci_s3c_consider_clock(struct sdhci_s3c *ourhost,
 
 	rate = clk_get_rate(clksrc);
 
-	for (div = 1; div < 256; div *= 2) {
-		if ((rate / div) <= wanted)
+	for (shift = 0; shift < 8; ++shift) {
+		if ((rate >> shift) <= wanted)
 			break;
 	}
 
 	dev_dbg(&ourhost->pdev->dev, "clk %d: rate %ld, want %d, got %ld\n",
-		src, rate, wanted, rate / div);
+		src, rate, wanted, rate >> shift);
 
-	return wanted - (rate / div);
+	return wanted - (rate >> shift);
 }
 
 /**
-- 
1.8.5.2
