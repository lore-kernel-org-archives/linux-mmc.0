From: oscardagrach <ryan@edited.us>
Subject: [PATCH] mmc: dw_mmc-k3: Fix DDR52 mode by setting required clock divisor
Date: Thu, 29 Mar 2018 13:24:22 -0500
Message-ID: <20180329182423.21201-1-ryan@edited.us>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: oscardagrach <ryan@edited.us>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: oscardagrach <ryan@edited.us>
---
 drivers/mmc/host/dw_mmc-k3.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
index 89cdb3d533bb..efc546cb4db8 100644
--- a/drivers/mmc/host/dw_mmc-k3.c
+++ b/drivers/mmc/host/dw_mmc-k3.c
@@ -194,8 +194,14 @@ static void dw_mci_hi6220_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 	int ret;
 	unsigned int clock;
 
-	clock = (ios->clock <= 25000000) ? 25000000 : ios->clock;
-
+	/* CLKDIV must be 1 for DDR52/8-bit mode */
+	if (ios->bus_width == MMC_BUS_WIDTH_8 &&
+		ios->timing == MMC_TIMING_MMC_DDR52) {
+		mci_writel(host, CLKDIV, 0x1);
+		clock = ios->clock;
+	} else {
+		clock = (ios->clock <= 25000000) ? 25000000 : ios->clock;
+	}
 	ret = clk_set_rate(host->biu_clk, clock);
 	if (ret)
 		dev_warn(host->dev, "failed to set rate %uHz\n", clock);
-- 
2.11.0
