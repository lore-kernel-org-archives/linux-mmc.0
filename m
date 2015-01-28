From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH] mmc: sdhci-pxav3: fix setting of pdata->clk_delay_cycles
Date: Wed, 28 Jan 2015 14:57:59 +0800
Message-ID: <1422428279-525-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: chris@printf.net, ulf.hansson@linaro.org, sebastian.hesselbarth@gmail.com
Cc: thomas.petazzoni@free-electrons.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Jisheng Zhang <jszhang@marvell.com>, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Current code checks "clk_delay_cycles > 0" to know whether the optional
"mrvl,clk_delay_cycles" is set or not. But of_property_read_u32() doesn't
touch clk_delay_cycles if the property is not set. And type of
clk_delay_cycles is u32, so we may always set pdata->clk_delay_cycles as a
random value.

This patch fix this problem by check the return value of of_property_read_u32()
to know whether the optional clk-delay-cycles is set or not.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Cc: <stable@vger.kernel.org> # v3.6+
---
 drivers/mmc/host/sdhci-pxav3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index c5db5d2..f1c6362 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -268,8 +268,8 @@ static struct sdhci_pxa_platdata *pxav3_get_mmc_pdata(struct device *dev)
 	if (!pdata)
 		return NULL;
 
-	of_property_read_u32(np, "mrvl,clk-delay-cycles", &clk_delay_cycles);
-	if (clk_delay_cycles > 0)
+	if (!of_property_read_u32(np, "mrvl,clk-delay-cycles",
+				  &clk_delay_cycles))
 		pdata->clk_delay_cycles = clk_delay_cycles;
 
 	return pdata;
-- 
2.1.4
