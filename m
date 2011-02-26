From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH V2] arm: mach-mmp: brownstone.c support multiple sd slots
Date: Fri, 25 Feb 2011 17:50:44 -0800
Message-ID: <12B59539-897B-4EB6-AAC5-F33177CC8B49@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:45307 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750797Ab1BZBu4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 25 Feb 2011 20:50:56 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>

Support multiple sd/eMMC interfaces. enable mmc1, 2, and 3.
mmc2 is used eMMC and slot is marked PERMANENT and 8 bit device.
mmc1 is used for Wifi and slot is marked PERMANENT

Note: eMMC (mmc2) is set to initialize first to workaround a problem
where booting in logical order requires mmc create work queue
to be multi-threaded otherwise boot process hangs.  BUG report
send to linux-mmc and linux-kernel mailing list.

Wifi (mmc1) requires we enable power on the device by toggling
the gpio lines for power and reset.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 arch/arm/mach-mmp/brownstone.c |   42 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.c
index 7bb78fd..36d5b82 100644
--- a/arch/arm/mach-mmp/brownstone.c
+++ b/arch/arm/mach-mmp/brownstone.c
@@ -19,6 +19,7 @@
 #include <linux/regulator/max8649.h>
 #include <linux/regulator/fixed.h>
 #include <linux/mfd/max8925.h>
+#include <linux/delay.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -180,6 +181,45 @@ static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc0 = {
 	.max_speed	= 25000000,
 };
 
+static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc1 = {
+	.flags		= PXA_FLAG_CARD_PERMANENT,
+};
+
+static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc2 = {
+	.flags		= PXA_FLAG_CARD_PERMANENT |
+				PXA_FLAG_SD_8_BIT_CAPABLE_SLOT,
+};
+
+static void __init mmc_sdio_wifi(void)
+{
+	int poweron;
+	int reset;
+
+	poweron = mfp_to_gpio(GPIO57_GPIO);
+	reset = mfp_to_gpio(GPIO58_GPIO);
+
+	if(gpio_request(reset, "sd8xxx reset")) {
+		printk(KERN_INFO "gpio %d request failed\n", reset);
+		return;
+	}
+
+	if(gpio_request(poweron, "sd8xxx PDn")) {
+		gpio_free(reset);
+		printk(KERN_INFO "gpio %d request failed\n", poweron);
+		return;
+	}
+
+	gpio_direction_output(poweron, 1);
+	msleep (1);
+	gpio_direction_output(reset, 0);
+	msleep (1);
+	gpio_direction_output(reset, 1);
+	gpio_free(reset);
+	gpio_free(poweron);
+
+	mmp2_add_sdhost(1, &mmp2_sdh_platdata_mmc1); /* Wifi */
+}
+
 static void __init brownstone_init(void)
 {
 	mfp_config(ARRAY_AND_SIZE(brownstone_pin_config));
@@ -188,7 +228,9 @@ static void __init brownstone_init(void)
 	mmp2_add_uart(1);
 	mmp2_add_uart(3);
 	mmp2_add_twsi(1, NULL, ARRAY_AND_SIZE(brownstone_twsi1_info));
+	mmp2_add_sdhost(2, &mmp2_sdh_platdata_mmc2); /* eMMC */
 	mmp2_add_sdhost(0, &mmp2_sdh_platdata_mmc0); /* SD/MMC */
+	mmc_sdio_wifi();
 
 	/* enable 5v regulator */
 	platform_device_register(&brownstone_v_5vp_device);
-- 
1.7.0.4