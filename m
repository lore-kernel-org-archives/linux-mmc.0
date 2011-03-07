From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 4/5] sh: use the new TMIO_MMC_HI_REGS_MISSING flag for SDHI
Date: Mon, 7 Mar 2011 19:47:59 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1103071945320.29543@axis700.grange>
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
 arch/sh/boards/mach-ap325rxa/setup.c |    3 +++
 arch/sh/boards/mach-ecovec24/setup.c |    3 +++
 arch/sh/boards/mach-kfr2r09/setup.c  |    2 +-
 arch/sh/boards/mach-migor/setup.c    |    2 ++
 arch/sh/boards/mach-se/7724/setup.c  |    3 +++
 5 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/sh/boards/mach-ap325rxa/setup.c b/arch/sh/boards/mach-ap325rxa/setup.c
index 33bfebc..ea1f1a3 100644
--- a/arch/sh/boards/mach-ap325rxa/setup.c
+++ b/arch/sh/boards/mach-ap325rxa/setup.c
@@ -15,6 +15,7 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/mfd/sh_mobile_sdhi.h>
+#include <linux/mfd/tmio.h>
 #include <linux/mmc/host.h>
 #include <linux/mtd/physmap.h>
 #include <linux/mtd/sh_flctl.h>
@@ -427,6 +428,7 @@ static struct resource sdhi0_cn3_resources[] = {
 };
 
 static struct sh_mobile_sdhi_info sdhi0_cn3_data = {
+	.tmio_flags	= TMIO_MMC_HI_REGS_MISSING,
 	.tmio_caps      = MMC_CAP_SDIO_IRQ,
 };
 
@@ -457,6 +459,7 @@ static struct resource sdhi1_cn7_resources[] = {
 };
 
 static struct sh_mobile_sdhi_info sdhi1_cn7_data = {
+	.tmio_flags	= TMIO_MMC_HI_REGS_MISSING,
 	.tmio_caps      = MMC_CAP_SDIO_IRQ,
 };
 
diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index aa620fd..0cc86a4 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -12,6 +12,7 @@
 #include <linux/device.h>
 #include <linux/platform_device.h>
 #include <linux/mfd/sh_mobile_sdhi.h>
+#include <linux/mfd/tmio.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/sh_mmcif.h>
 #include <linux/mtd/physmap.h>
@@ -473,6 +474,7 @@ static struct sh_mobile_sdhi_info sdhi0_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
 	.set_pwr	= sdhi0_set_pwr,
+	.tmio_flags	= TMIO_MMC_HI_REGS_MISSING,
 	.tmio_caps      = MMC_CAP_SDIO_IRQ | MMC_CAP_POWER_OFF_CARD,
 };
 
@@ -512,6 +514,7 @@ static void sdhi1_set_pwr(struct platform_device *pdev, int state)
 static struct sh_mobile_sdhi_info sdhi1_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI1_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI1_RX,
+	.tmio_flags	= TMIO_MMC_HI_REGS_MISSING,
 	.tmio_caps      = MMC_CAP_SDIO_IRQ | MMC_CAP_POWER_OFF_CARD,
 	.set_pwr	= sdhi1_set_pwr,
 };
diff --git a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-kfr2r09/setup.c
index 7504daa..fa473d4 100644
--- a/arch/sh/boards/mach-kfr2r09/setup.c
+++ b/arch/sh/boards/mach-kfr2r09/setup.c
@@ -366,7 +366,7 @@ static struct resource kfr2r09_sh_sdhi0_resources[] = {
 static struct sh_mobile_sdhi_info sh7724_sdhi0_data = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
-	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE,
+	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE | TMIO_MMC_HI_REGS_MISSING,
 	.tmio_caps      = MMC_CAP_SDIO_IRQ,
 };
 
diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
index 03a7ffe..20e641e 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -13,6 +13,7 @@
 #include <linux/input.h>
 #include <linux/input/sh_keysc.h>
 #include <linux/mfd/sh_mobile_sdhi.h>
+#include <linux/mfd/tmio.h>
 #include <linux/mmc/host.h>
 #include <linux/mtd/physmap.h>
 #include <linux/mtd/nand.h>
@@ -411,6 +412,7 @@ static struct resource sdhi_cn9_resources[] = {
 static struct sh_mobile_sdhi_info sh7724_sdhi_data = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
+	.tmio_flags	= TMIO_MMC_HI_REGS_MISSING,
 	.tmio_caps      = MMC_CAP_SDIO_IRQ,
 };
 
diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index 5276793..2ca3253 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -15,6 +15,7 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/mfd/sh_mobile_sdhi.h>
+#include <linux/mfd/tmio.h>
 #include <linux/mmc/host.h>
 #include <linux/mtd/physmap.h>
 #include <linux/delay.h>
@@ -472,6 +473,7 @@ static struct resource sdhi0_cn7_resources[] = {
 static struct sh_mobile_sdhi_info sh7724_sdhi0_data = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
+	.tmio_flags	= TMIO_MMC_HI_REGS_MISSING,
 	.tmio_caps      = MMC_CAP_SDIO_IRQ,
 };
 
@@ -504,6 +506,7 @@ static struct resource sdhi1_cn8_resources[] = {
 static struct sh_mobile_sdhi_info sh7724_sdhi1_data = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI1_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI1_RX,
+	.tmio_flags	= TMIO_MMC_HI_REGS_MISSING,
 	.tmio_caps      = MMC_CAP_SDIO_IRQ,
 };
 
-- 
1.7.2.3

