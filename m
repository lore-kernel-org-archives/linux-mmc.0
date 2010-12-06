From: Arnd Hannemann <arnd@arndnet.de>
Subject: [PATCH 2/4] ARM: mach-shmobile: sh7372 Enable SDIO IRQs
Date: Mon,  6 Dec 2010 12:35:40 -0500
Message-ID: <1291656942-18100-2-git-send-email-arnd@arndnet.de>
References: <1291656942-18100-1-git-send-email-arnd@arndnet.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1291656942-18100-1-git-send-email-arnd@arndnet.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, g.liakhovetski@gmx.de, Arnd Hannemann <arnd@arndnet.de>
List-Id: linux-mmc@vger.kernel.org

This patch enables the interrupt generation for SDIO IRQs
of the sdhi controllers of the soc. To make sure interrupts
are handled announce the MMC_CAP_SDIO_IRQ capability
on AP4EVB. Tested with a b43-based SDIO wireless card.

Signed-off-by: Arnd Hannemann <arnd@arndnet.de>
---
 arch/arm/mach-shmobile/board-ap4evb.c |    3 ++-
 arch/arm/mach-shmobile/intc-sh7372.c  |    4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 16eba07..5763b0d 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -310,6 +310,7 @@ static u64 sdhi0_dma_mask = DMA_BIT_MASK(32);
 static struct sh_mobile_sdhi_info sdhi0_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
+	.tmio_caps	= MMC_CAP_SDIO_IRQ,
 };
 
 static struct resource sdhi0_resources[] = {
@@ -344,7 +345,7 @@ static struct sh_mobile_sdhi_info sdhi1_info = {
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI1_RX,
 	.tmio_ocr_mask	= MMC_VDD_165_195,
 	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE,
-	.tmio_caps	= MMC_CAP_NEEDS_POLL,
+	.tmio_caps	= MMC_CAP_NEEDS_POLL | MMC_CAP_SDIO_IRQ,
 	.get_cd		= slot_cn7_get_cd,
 };
 
diff --git a/arch/arm/mach-shmobile/intc-sh7372.c b/arch/arm/mach-shmobile/intc-sh7372.c
index 30b2f40..f78a1ea 100644
--- a/arch/arm/mach-shmobile/intc-sh7372.c
+++ b/arch/arm/mach-shmobile/intc-sh7372.c
@@ -230,10 +230,10 @@ static struct intc_mask_reg intca_mask_registers[] __initdata = {
 	  { SCIFB, SCIFA5, SCIFA4, MSIOF1,
 	    0, 0, MSIOF2, 0 } },
 	{ 0xe694009c, 0xe69400dc, 8, /* IMR7A / IMCR7A */
-	  { DISABLED, DISABLED, ENABLED, ENABLED,
+	  { DISABLED, ENABLED, ENABLED, ENABLED,
 	    FLCTL_FLTREQ1I, FLCTL_FLTREQ0I, FLCTL_FLTENDI, FLCTL_FLSTEI } },
 	{ 0xe69400a0, 0xe69400e0, 8, /* IMR8A / IMCR8A */
-	  { 0, DISABLED, ENABLED, ENABLED,
+	  { 0, ENABLED, ENABLED, ENABLED,
 	    TTI20, USBHSDMAC0_USHDMI, 0, 0 } },
 	{ 0xe69400a4, 0xe69400e4, 8, /* IMR9A / IMCR9A */
 	  { CMT1_CMT13, CMT1_CMT12, CMT1_CMT11, CMT1_CMT10,
-- 
1.7.0.4

