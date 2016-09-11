From: Chris Brandt <chris.brandt@renesas.com>
Subject: [PATCH v2 3/3] mmc: sh_mobile_sdhi: Add r7s72100 support
Date: Sun, 11 Sep 2016 17:03:28 -0400
Message-ID: <20160911210328.30641-4-chris.brandt@renesas.com>
References: <20160911210328.30641-1-chris.brandt@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160911210328.30641-1-chris.brandt@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Simon Horman <horms+renesas@verge.net.au>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Chris Brandt <chris.brandt@renesas.com>
List-Id: linux-mmc@vger.kernel.org

Add support for r7s72100 SoC.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
 Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 1 +
 drivers/mmc/host/sh_mobile_sdhi.c                  | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
index 13df9c2..08b3a30 100644
--- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
@@ -13,6 +13,7 @@ Required properties:
 - compatible:	"renesas,sdhi-shmobile" - a generic sh-mobile SDHI unit
 		"renesas,sdhi-sh7372" - SDHI IP on SH7372 SoC
 		"renesas,sdhi-sh73a0" - SDHI IP on SH73A0 SoC
+		"renesas,sdhi-r7s72100" - SDHI IP on R7S72100 SoC
 		"renesas,sdhi-r8a73a4" - SDHI IP on R8A73A4 SoC
 		"renesas,sdhi-r8a7740" - SDHI IP on R8A7740 SoC
 		"renesas,sdhi-r8a7778" - SDHI IP on R8A7778 SoC
diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index b033500..fe9cc41 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -77,6 +77,12 @@ static const struct sh_mobile_sdhi_of_data of_default_cfg = {
 	.tmio_flags = TMIO_MMC_HAS_IDLE_WAIT,
 };
 
+static const struct sh_mobile_sdhi_of_data of_rz_compatible = {
+	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_32BIT_DATA_PORT,
+	.tmio_ocr_mask	= MMC_VDD_32_33,
+	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
+};
+
 static const struct sh_mobile_sdhi_of_data of_rcar_gen1_compatible = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE |
 			  TMIO_MMC_CLK_ACTUAL,
@@ -133,6 +139,7 @@ static const struct of_device_id sh_mobile_sdhi_of_match[] = {
 	{ .compatible = "renesas,sdhi-sh73a0", .data = &of_default_cfg, },
 	{ .compatible = "renesas,sdhi-r8a73a4", .data = &of_default_cfg, },
 	{ .compatible = "renesas,sdhi-r8a7740", .data = &of_default_cfg, },
+	{ .compatible = "renesas,sdhi-r7s72100", .data = &of_rz_compatible, },
 	{ .compatible = "renesas,sdhi-r8a7778", .data = &of_rcar_gen1_compatible, },
 	{ .compatible = "renesas,sdhi-r8a7779", .data = &of_rcar_gen1_compatible, },
 	{ .compatible = "renesas,sdhi-r8a7790", .data = &of_rcar_gen2_compatible, },
-- 
2.9.2
