From: Arnd Hannemann <arnd@arndnet.de>
Subject: [PATCH 4/4] ARM: mach-shmobile: ap4evb: Fix hotplug for SDHI1
Date: Tue, 24 Aug 2010 17:27:02 +0200
Message-ID: <1282663622-20564-5-git-send-email-arnd@arndnet.de>
References: <1282663622-20564-1-git-send-email-arnd@arndnet.de>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mta-1.ms.rz.RWTH-Aachen.DE ([134.130.7.72]:49635 "EHLO
	mta-1.ms.rz.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755420Ab0HXP1L (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Aug 2010 11:27:11 -0400
In-reply-to: <1282663622-20564-1-git-send-email-arnd@arndnet.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ian@mnementh.co.uk
Cc: sameo@linux.intel.com, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, yusuke.goda.sx@renesas.com, Arnd Hannemann <arnd@arndnet.de>

On AP4EVB the card detect pin of the top SD/MMC slot is not directly connected
to the tmio/mmcif controller but to a GPIO pin, so polling needs to be done for
SDHI1 and MMCIF in order to support hotplug for that slot. SHDI1 and MMCIF
share that slot, and the used controller is selected by a DIP switch.
This patch adds a helper function to check if a card is present in that
particular slot, registers this function with SDHI1 and MMCIF and enables
polling for SDHI1.

Signed-off-by: Arnd Hannemann <arnd@arndnet.de>
---
 arch/arm/mach-shmobile/board-ap4evb.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 95935c8..2e90ce4 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -235,6 +235,18 @@ static struct platform_device smc911x_device = {
 	},
 };
 
+/*
+ * The card detect pin of the top SD/MMC slot (CN7) is active low and is
+ * connected to GPIO A22 of SH7372 (GPIO_PORT41).
+ */
+static int slot_cn7_get_cd(struct platform_device *pdev)
+{
+	if (gpio_is_valid(GPIO_PORT41))
+		return !gpio_get_value(GPIO_PORT41);
+	else
+		return -ENXIO;
+}
+
 /* SH_MMCIF */
 static struct resource sh_mmcif_resources[] = {
 	[0] = {
@@ -261,6 +273,7 @@ static struct sh_mmcif_plat_data sh_mmcif_plat = {
 	.caps		= MMC_CAP_4_BIT_DATA |
 			  MMC_CAP_8_BIT_DATA |
 			  MMC_CAP_NEEDS_POLL,
+	.get_cd		= slot_cn7_get_cd,
 };
 
 static struct platform_device sh_mmcif_device = {
@@ -310,6 +323,8 @@ static struct sh_mobile_sdhi_info sdhi1_info = {
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI1_RX,
 	.tmio_ocr_mask	= MMC_VDD_165_195,
 	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE,
+	.tmio_caps	= MMC_CAP_NEEDS_POLL,
+	.get_cd		= slot_cn7_get_cd,
 };
 
 static struct resource sdhi1_resources[] = {
@@ -948,6 +963,10 @@ static void __init ap4evb_init(void)
 	gpio_no_direction(GPIO_PORT9CR);  /* FSIAOBT needs no direction */
 	gpio_no_direction(GPIO_PORT10CR); /* FSIAOLR needs no direction */
 
+	/* card detect pin for MMC slot (CN7) */
+	gpio_request(GPIO_PORT41, NULL);
+	gpio_direction_input(GPIO_PORT41);
+
 	/* set SPU2 clock to 119.6 MHz */
 	clk = clk_get(NULL, "spu_clk");
 	if (!IS_ERR(clk)) {
-- 
1.7.0.4

