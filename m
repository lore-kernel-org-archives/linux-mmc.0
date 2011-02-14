From: panduranga_mallireddy@ti.com
Subject: [PATCH 1/5] omap: panda: wlan board muxing
Date: Mon, 14 Feb 2011 02:19:14 -0500
Message-ID: <1297667958-22377-2-git-send-email-panduranga_mallireddy@ti.com>
References: <1297667958-22377-1-git-send-email-panduranga_mallireddy@ti.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46362 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408Ab1BNGxv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Feb 2011 01:53:51 -0500
In-Reply-To: <1297667958-22377-1-git-send-email-panduranga_mallireddy@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: coelho@ti.com, netdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ohad@wizery.com, benzyg@ti.com, pradeepgurumath@ti.com, vishalm@ti.com, x-boudet@ti.com, naveen_jain@ti.com, pavan_savoy@ti.com, manjunatha_halli@ti.com, tony@atomide.com, cjb@laptop.org, Panduranga Mallireddy <panduranga_mallireddy@ti.com>

From: Panduranga Mallireddy <panduranga_mallireddy@ti.com>

Add board muxing to support the wlan wl1271 chip that is
hardwired to mmc5 (fifth mmc controller) on the PANDA.

Based on the wlan board muxing for zoom3 by Ohad Ben-Cohen
<ohadb@ti.com>
Signed-off-by: Panduranga Mallireddy <panduranga_mallireddy@ti.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 9218862..cc9df6c 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -401,6 +401,19 @@ static int __init omap4_panda_i2c_init(void)
 
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
+	/* WLAN IRQ - GPIO 53 */
+	OMAP4_MUX(GPMC_NCS3, OMAP_MUX_MODE3 | OMAP_PIN_INPUT_PULLUP),
+	/* WLAN POWER ENABLE - GPIO 43 */
+	OMAP4_MUX(GPMC_A19, OMAP_MUX_MODE3 | OMAP_PIN_OUTPUT),
+	/* WLAN SDIO: MMC5 CMD */
+	OMAP4_MUX(SDMMC5_CMD, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
+	/* WLAN SDIO: MMC5 CLK */
+	OMAP4_MUX(SDMMC5_CLK, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
+	/* WLAN SDIO: MMC5 DAT[0-3] */
+	OMAP4_MUX(SDMMC5_DAT0, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
+	OMAP4_MUX(SDMMC5_DAT1, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
+	OMAP4_MUX(SDMMC5_DAT2, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
+	OMAP4_MUX(SDMMC5_DAT3, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
 #else
-- 
1.5.6.3

