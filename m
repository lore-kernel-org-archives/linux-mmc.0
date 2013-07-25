From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 04/12] sh: ecovec24: Remove mmcif .down_pwr() callback
Date: Fri, 26 Jul 2013 01:26:40 +0200
Message-ID: <1374794808-21890-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1374794808-21890-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1374794808-21890-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org, Hartley Sweeten <hsweeten@visionengravers.com>, Ryan Mallon <rmallon@gmail.com>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>
List-Id: linux-mmc@vger.kernel.org

The callback isn't used by the mmcif driver, don't initialize it in
board code.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/sh/boards/mach-ecovec24/setup.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 4d46700..e1b6aa3 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -983,11 +983,6 @@ static struct platform_device vou_device = {
 
 #if defined(CONFIG_MMC_SH_MMCIF) || defined(CONFIG_MMC_SH_MMCIF_MODULE)
 /* SH_MMCIF */
-static void mmcif_down_pwr(struct platform_device *pdev)
-{
-	cn12_set_pwr(pdev, 0);
-}
-
 static struct resource sh_mmcif_resources[] = {
 	[0] = {
 		.name	= "SH_MMCIF",
@@ -1009,7 +1004,6 @@ static struct resource sh_mmcif_resources[] = {
 
 static struct sh_mmcif_plat_data sh_mmcif_plat = {
 	.set_pwr	= cn12_set_pwr,
-	.down_pwr	= mmcif_down_pwr,
 	.sup_pclk	= 0, /* SH7724: Max Pclk/2 */
 	.caps		= MMC_CAP_4_BIT_DATA |
 			  MMC_CAP_8_BIT_DATA |
-- 
1.8.1.5

