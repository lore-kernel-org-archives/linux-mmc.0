From: Arnd Hannemann <arnd@arndnet.de>
Subject: [PATCH 3/4] sh: sh7724 Enable SDIO IRQs
Date: Mon,  6 Dec 2010 12:35:41 -0500
Message-ID: <1291656942-18100-3-git-send-email-arnd@arndnet.de>
References: <1291656942-18100-1-git-send-email-arnd@arndnet.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from slowhand.arndnet.de ([88.198.19.76]:56225 "EHLO mail.unitix.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753211Ab0LFRgV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 6 Dec 2010 12:36:21 -0500
In-Reply-To: <1291656942-18100-1-git-send-email-arnd@arndnet.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, g.liakhovetski@gmx.de, Arnd Hannemann <arnd@arndnet.de>

This patch enables the interrupt generation for SDIO IRQs
of the sdhi controllers of the soc. To make sure interrupts
are handled announce the MMC_CAP_SDIO_IRQ capability
on ecovec, kfr2r09 and se7724.

Tested with a b43-based SDIO wireless card on ecovec.

Signed-off-by: Arnd Hannemann <arnd@arndnet.de>
---
 arch/sh/boards/mach-ecovec24/setup.c   |    2 ++
 arch/sh/boards/mach-kfr2r09/setup.c    |    1 +
 arch/sh/boards/mach-se/7724/setup.c    |    2 ++
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |    4 ++--
 4 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 4e0e65a..36d7ca7 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -476,6 +476,7 @@ static struct sh_mobile_sdhi_info sdhi0_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
 	.set_pwr	= sdhi0_set_pwr,
+	.tmio_caps      = MMC_CAP_SDIO_IRQ,
 };
 
 static struct resource sdhi0_resources[] = {
@@ -517,6 +518,7 @@ static void sdhi1_set_pwr(struct platform_device *pdev, int state)
 static struct sh_mobile_sdhi_info sdhi1_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI1_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI1_RX,
+	.tmio_caps      = MMC_CAP_SDIO_IRQ,
 	.set_pwr	= sdhi1_set_pwr,
 };
 
diff --git a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-kfr2r09/setup.c
index 1423aa3..4e2eefe 100644
--- a/arch/sh/boards/mach-kfr2r09/setup.c
+++ b/arch/sh/boards/mach-kfr2r09/setup.c
@@ -369,6 +369,7 @@ static struct sh_mobile_sdhi_info sh7724_sdhi0_data = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
 	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE,
+	.tmio_caps      = MMC_CAP_SDIO_IRQ,
 };
 
 static struct platform_device kfr2r09_sh_sdhi0_device = {
diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index ab187c9..4eeb7c7 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -470,6 +470,7 @@ static struct resource sdhi0_cn7_resources[] = {
 static struct sh_mobile_sdhi_info sh7724_sdhi0_data = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
+	.tmio_caps      = MMC_CAP_SDIO_IRQ,
 };
 
 static struct platform_device sdhi0_cn7_device = {
@@ -504,6 +505,7 @@ static struct resource sdhi1_cn8_resources[] = {
 static struct sh_mobile_sdhi_info sh7724_sdhi1_data = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI1_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI1_RX,
+	.tmio_caps      = MMC_CAP_SDIO_IRQ,
 };
 
 static struct platform_device sdhi1_cn8_device = {
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
index 828c965..c598a7f 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
@@ -1144,7 +1144,7 @@ static struct intc_group groups[] __initdata = {
 static struct intc_mask_reg mask_registers[] __initdata = {
 	{ 0xa4080080, 0xa40800c0, 8, /* IMR0 / IMCR0 */
 	  { 0, TMU1_TUNI2, TMU1_TUNI1, TMU1_TUNI0,
-	    0, DISABLED, ENABLED, ENABLED } },
+	    0, ENABLED, ENABLED, ENABLED } },
 	{ 0xa4080084, 0xa40800c4, 8, /* IMR1 / IMCR1 */
 	  { VIO_VOU, VIO_VEU1, VIO_BEU0, VIO_CEU0,
 	    DMAC0A_DEI3, DMAC0A_DEI2, DMAC0A_DEI1, DMAC0A_DEI0 } },
@@ -1166,7 +1166,7 @@ static struct intc_mask_reg mask_registers[] __initdata = {
 	  { I2C0_DTEI, I2C0_WAITI, I2C0_TACKI, I2C0_ALI,
 	    I2C1_DTEI, I2C1_WAITI, I2C1_TACKI, I2C1_ALI } },
 	{ 0xa40800a0, 0xa40800e0, 8, /* IMR8 / IMCR8 */
-	  { DISABLED, DISABLED, ENABLED, ENABLED,
+	  { DISABLED, ENABLED, ENABLED, ENABLED,
 	    0, 0, SCIFA5, FSI } },
 	{ 0xa40800a4, 0xa40800e4, 8, /* IMR9 / IMCR9 */
 	  { 0, 0, 0, CMT, 0, USB1, USB0, 0 } },
-- 
1.7.0.4

