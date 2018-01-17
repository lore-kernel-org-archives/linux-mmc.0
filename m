From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v3 07/16] mmc: renesas_sdhi: use MMC_CAP2_NO_WRITE_PROTECT instead of TMIO own flag
Date: Thu, 18 Jan 2018 01:28:07 +0900
Message-ID: <1516206496-16612-8-git-send-email-yamada.masahiro@socionext.com>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conuserg-08.nifty.com ([210.131.2.75]:36694 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753853AbeAQQ3d (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Jan 2018 11:29:33 -0500
In-Reply-To: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Ulf Magnusson <ulfalizer@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

TMIO_MMC_WRPROTECT_DISABLE is equivalent to MMC_CAP2_NO_WRITE_PROTECT.

The flag is propagated as follows:
       renesas_sdhi_of_data::capabilities2
    -> tmio_mmc_data::capabilities2
    -> mmc_host::caps2

Only the difference is the TMIO_... makes tmio_mmc_get_ro() return 0
(i.e. it does not affect mmc_gpio_get_ro() at all), while MMC_CAP2_...
returns 0 before calling ->get_ro() hook (i.e. it affects both IP own
logic and GPIO detection).

The TMIO MMC drivers do not set-up gpio_ro by themselves.  Only the
possibility, if any, would be DT specifies "wp-gpios" property, and
gpio_ro is set by mmc_gpiod_request_ro() called from mmc_of_parse().
However, it does not make sense to specify "wp-gpios" property and
TMIO_MMC_WRPROTECT_DISABLE at the same time.

I checked under arch/arm/boot/dts/ and arch/arm64/boot/dts/renesas/,
and I did not see any Renesas boards with "wp-gpios".  So, this
conversion should be safe.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3:
  - newly added

Changes in v2: None

 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  6 +++---
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      | 16 ++++++++--------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 02c2724..0d1f95e 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -71,11 +71,11 @@ static struct renesas_sdhi_scc rcar_gen3_scc_taps[] = {
 };
 
 static const struct renesas_sdhi_of_data of_rcar_gen3_compatible = {
-	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE |
-			  TMIO_MMC_CLK_ACTUAL | TMIO_MMC_HAVE_CBSY |
-			  TMIO_MMC_MIN_RCAR2,
+	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_CLK_ACTUAL |
+			  TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2,
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
 			  MMC_CAP_CMD23,
+	.capabilities2	= MMC_CAP2_NO_WRITE_PROTECT,
 	.bus_shift	= 2,
 	.scc_offset	= 0x1000,
 	.taps		= rcar_gen3_scc_taps,
diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index c8a74b2..afdb66b 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -40,9 +40,9 @@ static const struct renesas_sdhi_of_data of_rz_compatible = {
 };
 
 static const struct renesas_sdhi_of_data of_rcar_gen1_compatible = {
-	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE |
-			  TMIO_MMC_CLK_ACTUAL,
+	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_CLK_ACTUAL,
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
+	.capabilities2	= MMC_CAP2_NO_WRITE_PROTECT,
 };
 
 /* Definitions for sampling clocks */
@@ -58,11 +58,11 @@ static struct renesas_sdhi_scc rcar_gen2_scc_taps[] = {
 };
 
 static const struct renesas_sdhi_of_data of_rcar_gen2_compatible = {
-	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE |
-			  TMIO_MMC_CLK_ACTUAL | TMIO_MMC_HAVE_CBSY |
-			  TMIO_MMC_MIN_RCAR2,
+	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_CLK_ACTUAL |
+			  TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2,
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
 			  MMC_CAP_CMD23,
+	.capabilities2	= MMC_CAP2_NO_WRITE_PROTECT,
 	.dma_buswidth	= DMA_SLAVE_BUSWIDTH_4_BYTES,
 	.dma_rx_offset	= 0x2000,
 	.scc_offset	= 0x0300,
@@ -79,11 +79,11 @@ static struct renesas_sdhi_scc rcar_gen3_scc_taps[] = {
 };
 
 static const struct renesas_sdhi_of_data of_rcar_gen3_compatible = {
-	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE |
-			  TMIO_MMC_CLK_ACTUAL | TMIO_MMC_HAVE_CBSY |
-			  TMIO_MMC_MIN_RCAR2,
+	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_CLK_ACTUAL |
+			  TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2,
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
 			  MMC_CAP_CMD23,
+	.capabilities2	= MMC_CAP2_NO_WRITE_PROTECT,
 	.bus_shift	= 2,
 	.scc_offset	= 0x1000,
 	.taps		= rcar_gen3_scc_taps,
-- 
2.7.4

