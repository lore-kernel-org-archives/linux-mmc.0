From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH v2] arm: mach-mmp: brownstone.c support multiple sd slots
Date: Thu, 28 Apr 2011 13:45:43 -0700
Message-ID: <3BFCE791-3BAD-42ED-BC87-A27F40D6C77C@marvell.com>
References: <59C2B513-EC04-4CA2-818B-9901CAF3E554@marvell.com>
 <20110427093328.GU17290@n2100.arm.linux.org.uk>
 <161C3F6C-0986-4364-B458-DBA4D08456FD@marvell.com>
 <1F336A22-BAC3-41E3-8D4E-5DF27874D1EA@marvell.com>
 <20110428095127.GX17290@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:42324 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754685Ab1D1Usj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 28 Apr 2011 16:48:39 -0400
In-Reply-To: <20110428095127.GX17290@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Zhangfei Gao <zgao6@marvell.com>, Eric Miao <eric.y.miao@gmail.com>


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
 arch/arm/mach-mmp/brownstone.c |   52 +++++++++++++++++++++++++++++++++++++++-
 1 files changed, 51 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.c
index 7bb78fd..577e8de 100644
--- a/arch/arm/mach-mmp/brownstone.c
+++ b/arch/arm/mach-mmp/brownstone.c
@@ -19,6 +19,7 @@
 #include <linux/regulator/max8649.h>
 #include <linux/regulator/fixed.h>
 #include <linux/mfd/max8925.h>
+#include <linux/delay.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -177,9 +178,56 @@ static struct i2c_board_info brownstone_twsi1_info[] = {
 };
 
 static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc0 = {
-	.max_speed	= 25000000,
+	.adjust_clocks	= 1,
+	.clk_select	= 1,
+	.clk_delay	= 31,
 };
 
+static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc1 = {
+	.adjust_clocks	= 1,
+	.clk_select	= 1,
+	.clk_delay	= 15,
+	.flags		= PXA_FLAG_CARD_PERMANENT,
+};
+
+static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc2 = {
+	.adjust_clocks	= 1,
+	.clk_select	= 1,
+	.clk_delay	= 31,
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
+	if (gpio_request(reset, "sd8xxx reset")) {
+		printk(KERN_INFO "gpio %d request failed\n", reset);
+		return;
+	}
+
+	if (gpio_request(poweron, "sd8xxx PDn")) {
+		gpio_free(reset);
+		printk(KERN_INFO "gpio %d request failed\n", poweron);
+		return;
+	}
+
+	gpio_direction_output(poweron, 1);
+	msleep(1);
+	gpio_direction_output(reset, 0);
+	msleep(1);
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
@@ -188,7 +236,9 @@ static void __init brownstone_init(void)
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


