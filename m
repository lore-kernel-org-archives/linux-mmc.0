From: Arnd Hannemann <arnd@arndnet.de>
Subject: [PATCH 4/4] [RFC] sh: sh7722 Enable SDIO IRQs
Date: Mon,  6 Dec 2010 12:35:42 -0500
Message-ID: <1291656942-18100-4-git-send-email-arnd@arndnet.de>
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
on migor. Untested, therefore RFC.

Signed-off-by: Arnd Hannemann <arnd@arndnet.de>
---
 arch/sh/boards/mach-migor/setup.c      |    1 +
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
index 5dc72b4..b9cba53 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -413,6 +413,7 @@ static struct resource sdhi_cn9_resources[] = {
 static struct sh_mobile_sdhi_info sh7724_sdhi_data = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
+	.tmio_caps      = MMC_CAP_SDIO_IRQ,
 };
 
 static struct platform_device sdhi_cn9_device = {
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
index d551ed8..a164f89 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
@@ -699,7 +699,7 @@ static struct intc_mask_reg mask_registers[] __initdata = {
 	  { I2C_DTEI, I2C_WAITI, I2C_TACKI, I2C_ALI,
 	    FLCTL_FLTREQ1I, FLCTL_FLTREQ0I, FLCTL_FLENDI, FLCTL_FLSTEI } },
 	{ 0xa40800a0, 0xa40800e0, 8, /* IMR8 / IMCR8 */
-	  { DISABLED, DISABLED, ENABLED, ENABLED, 0, 0, TWODG, SIU } },
+	  { DISABLED, ENABLED, ENABLED, ENABLED, 0, 0, TWODG, SIU } },
 	{ 0xa40800a4, 0xa40800e4, 8, /* IMR9 / IMCR9 */
 	  { 0, 0, 0, CMT, 0, USB_USBI1, USB_USBI0, } },
 	{ 0xa40800a8, 0xa40800e8, 8, /* IMR10 / IMCR10 */
-- 
1.7.0.4

