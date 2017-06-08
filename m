From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH/RFC 5/5] mmc: renesas-sdhi: remove gen3 support from sysc dmac driver
Date: Thu,  8 Jun 2017 15:09:28 +0200
Message-ID: <1496927368-18897-8-git-send-email-horms+renesas@verge.net.au>
References: <1496927368-18897-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1496927368-18897-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Gen3 SoCs are now supported by the internal dmac variant of the SDHI driver.
Remove them from the sys dmac variant where only PIO mode is supported.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/mmc/host/renesas_sdhi_sys_dmac.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index cc3e0f94b276..1f8863e725aa 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -63,25 +63,6 @@ static const struct renesas_sdhi_of_data of_rcar_gen2_compatible = {
 	.taps_num	= ARRAY_SIZE(rcar_gen2_scc_taps),
 };
 
-/* Definitions for sampling clocks */
-static struct renesas_sdhi_scc rcar_gen3_scc_taps[] = {
-	{
-		.clk_rate = 0,
-		.tap = 0x00000300,
-	},
-};
-
-static const struct renesas_sdhi_of_data of_rcar_gen3_compatible = {
-	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE |
-			  TMIO_MMC_CLK_ACTUAL | TMIO_MMC_MIN_RCAR2,
-	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
-			  MMC_CAP_CMD23,
-	.bus_shift	= 2,
-	.scc_offset	= 0x1000,
-	.taps		= rcar_gen3_scc_taps,
-	.taps_num	= ARRAY_SIZE(rcar_gen3_scc_taps),
-};
-
 static const struct of_device_id renesas_sdhi_sys_dmac_of_match[] = {
 	{ .compatible = "renesas,sdhi-shmobile" },
 	{ .compatible = "renesas,sdhi-sh73a0", .data = &of_default_cfg, },
@@ -95,8 +76,6 @@ static const struct of_device_id renesas_sdhi_sys_dmac_of_match[] = {
 	{ .compatible = "renesas,sdhi-r8a7792", .data = &of_rcar_gen2_compatible, },
 	{ .compatible = "renesas,sdhi-r8a7793", .data = &of_rcar_gen2_compatible, },
 	{ .compatible = "renesas,sdhi-r8a7794", .data = &of_rcar_gen2_compatible, },
-	{ .compatible = "renesas,sdhi-r8a7795", .data = &of_rcar_gen3_compatible, },
-	{ .compatible = "renesas,sdhi-r8a7796", .data = &of_rcar_gen3_compatible, },
 	{},
 };
 MODULE_DEVICE_TABLE(of, renesas_sdhi_sys_dmac_of_match);
-- 
2.1.4
