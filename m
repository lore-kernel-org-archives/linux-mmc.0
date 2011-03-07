From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 3/5] ARM: mach-shmobile: use the new TMIO_MMC_HI_REGS_MISSING
 flag for SDHI
Date: Mon, 7 Mar 2011 19:47:55 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1103071944480.29543@axis700.grange>
References: <Pine.LNX.4.64.1103071937010.29543@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1103071937010.29543@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>
List-Id: linux-mmc@vger.kernel.org

Prevent access to addresses above 0xff on SDHI instances on sh-mobile SoCs.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-ap4evb.c   |    3 ++-
 arch/arm/mach-shmobile/board-mackerel.c |    5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 3cf0951..7a7b472 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -305,6 +305,7 @@ static struct platform_device sh_mmcif_device = {
 static struct sh_mobile_sdhi_info sdhi0_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
+	.tmio_flags	= TMIO_MMC_HI_REGS_MISSING,
 	.tmio_caps	= MMC_CAP_SDIO_IRQ,
 };
 
@@ -336,7 +337,7 @@ static struct sh_mobile_sdhi_info sdhi1_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI1_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI1_RX,
 	.tmio_ocr_mask	= MMC_VDD_165_195,
-	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE,
+	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE | TMIO_MMC_HI_REGS_MISSING,
 	.tmio_caps	= MMC_CAP_NEEDS_POLL | MMC_CAP_SDIO_IRQ,
 	.get_cd		= slot_cn7_get_cd,
 };
diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 6c9d8b8..2e81352 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -663,6 +663,7 @@ static int slot_cn7_get_cd(struct platform_device *pdev)
 static struct sh_mobile_sdhi_info sdhi0_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
+	.tmio_flags	= TMIO_MMC_HI_REGS_MISSING,
 	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
 };
 
@@ -695,7 +696,7 @@ static struct sh_mobile_sdhi_info sdhi1_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI1_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI1_RX,
 	.tmio_ocr_mask	= MMC_VDD_165_195,
-	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE,
+	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE | TMIO_MMC_HI_REGS_MISSING,
 	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
 			  MMC_CAP_NEEDS_POLL,
 	.get_cd		= slot_cn7_get_cd,
@@ -738,7 +739,7 @@ static int slot_cn23_get_cd(struct platform_device *pdev)
 static struct sh_mobile_sdhi_info sdhi2_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI2_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI2_RX,
-	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE,
+	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE | TMIO_MMC_HI_REGS_MISSING,
 	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
 			  MMC_CAP_NEEDS_POLL,
 	.get_cd		= slot_cn23_get_cd,
-- 
1.7.2.3

