From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 2/5 v3] sh: ecovec: remove unused .down_pwr() MMCIF callback
Date: Fri, 25 May 2012 17:45:22 +0200
Message-ID: <1337960752-4944-8-git-send-email-g.liakhovetski@gmx.de>
References: <Pine.LNX.4.64.1205251727260.13353@axis700.grange>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1205251727260.13353@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-mmc@vger.kernel.org

.down_pwr() on ecovec was equivalent to .set_pwr(0). Now that .down_pwr()
is no longer used by the driver, it can be removed.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Paul, would be good to get your ack to this one to push all this patches 
via one tree and make preserving the merge order easier. Thanks.

 arch/sh/boards/mach-ecovec24/setup.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 4158d70..dbedfda 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -904,11 +904,6 @@ static void mmcif_set_pwr(struct platform_device *pdev, int state)
 	gpio_set_value(GPIO_PTB7, state);
 }
 
-static void mmcif_down_pwr(struct platform_device *pdev)
-{
-	gpio_set_value(GPIO_PTB7, 0);
-}
-
 static struct resource sh_mmcif_resources[] = {
 	[0] = {
 		.name	= "SH_MMCIF",
@@ -930,7 +925,6 @@ static struct resource sh_mmcif_resources[] = {
 
 static struct sh_mmcif_plat_data sh_mmcif_plat = {
 	.set_pwr	= mmcif_set_pwr,
-	.down_pwr	= mmcif_down_pwr,
 	.sup_pclk	= 0, /* SH7724: Max Pclk/2 */
 	.caps		= MMC_CAP_4_BIT_DATA |
 			  MMC_CAP_8_BIT_DATA |
-- 
1.7.2.5

--
To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
