From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH 6/6] mmc: sdhci-s3c: Do not allow frequencies higher than requested
Date: Sat, 11 Jan 2014 22:39:06 +0100
Message-ID: <1389476346-20396-7-git-send-email-tomasz.figa@gmail.com>
References: <1389476346-20396-1-git-send-email-tomasz.figa@gmail.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1389476346-20396-1-git-send-email-tomasz.figa@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>, Chris Ball <chris@printf.net>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>
List-Id: linux-mmc@vger.kernel.org

This patch modifies sdhci_s3c_consider_clock() to fail if bus clock
being considered can not provide frequency lower or equal requested,
instead of returning the lowest supported.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/mmc/host/sdhci-s3c.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index bad0e00..d61eb5a 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -126,11 +126,18 @@ static unsigned int sdhci_s3c_consider_clock(struct sdhci_s3c *ourhost,
 
 	rate = ourhost->clk_rates[src];
 
-	for (shift = 0; shift < 8; ++shift) {
+	for (shift = 0; shift <= 8; ++shift) {
 		if ((rate >> shift) <= wanted)
 			break;
 	}
 
+	if (shift > 8) {
+		dev_dbg(&ourhost->pdev->dev,
+			"clk %d: rate %ld, min rate %lu > wanted %u\n",
+			src, rate, rate / 256, wanted);
+		return UINT_MAX;
+	}
+
 	dev_dbg(&ourhost->pdev->dev, "clk %d: rate %ld, want %d, got %ld\n",
 		src, rate, wanted, rate >> shift);
 
-- 
1.8.5.2
