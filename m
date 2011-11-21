From: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
Subject: [PATCH v2 4/4] ARM: pxa168/gplugd: Add support for SD port 1
Date: Mon, 21 Nov 2011 09:57:35 +0530
Message-ID: <1321849655-3056-1-git-send-email-tanmay.upadhyay@einfochips.com>
References: <87r51fwxgt.fsf@laptop.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ahm.einfochips.com ([203.76.128.206]:59413 "EHLO
	ahm.einfochips.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903Ab1KUE1p (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 20 Nov 2011 23:27:45 -0500
In-Reply-To: <87r51fwxgt.fsf@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: eric.y.miao@gmail.com, jason.chagas@marvell.com
Cc: prakity@marvell.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>

v2 - after sdhci-pxav1 driver is merged with sdhci-pxav2, pass
     pxav1_controller = 1
   - as sdhci device numbering now starts from 1, call
     pxa168_add_sdh accordingly

Signed-off-by: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
Reviewed-by: Philip Rakity <prakity@marvell.com>
---
 arch/arm/mach-mmp/gplugd.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/gplugd.c b/arch/arm/mach-mmp/gplugd.c
index 6915656..d7947e7 100644
--- a/arch/arm/mach-mmp/gplugd.c
+++ b/arch/arm/mach-mmp/gplugd.c
@@ -154,6 +154,11 @@ struct pxa168_eth_platform_data gplugd_eth_platform_data = {
 	.init        = gplugd_eth_init,
 };
 
+struct sdhci_pxa_platdata gplugd_sdh_platdata = {
+	.delay_in_ms = 5,
+	.pxav1_controller = 1,
+};
+
 static void __init select_disp_freq(void)
 {
 	/* set GPIO 35 & clear GPIO 85 to set LCD External Clock to 74.25 MHz */
@@ -186,6 +191,7 @@ static void __init gplugd_init(void)
 	pxa168_add_twsi(0, NULL, ARRAY_AND_SIZE(gplugd_i2c_board_info));
 
 	pxa168_add_eth(&gplugd_eth_platform_data);
+	pxa168_add_sdh(1, &gplugd_sdh_platdata);
 }
 
 MACHINE_START(GPLUGD, "PXA168-based GuruPlug Display (gplugD) Platform")
-- 
1.7.0.4

