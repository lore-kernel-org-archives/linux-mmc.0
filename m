From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH v3] arm: mach-mmp: brownstone.c support multiple sd slots
Date: Tue, 5 Jul 2011 13:20:37 -0700
Message-ID: <67F311C7-B489-41E6-BC85-C06DACC7263A@marvell.com>
References: <59C2B513-EC04-4CA2-818B-9901CAF3E554@marvell.com>
 <20110427093328.GU17290@n2100.arm.linux.org.uk>
 <161C3F6C-0986-4364-B458-DBA4D08456FD@marvell.com>
 <1F336A22-BAC3-41E3-8D4E-5DF27874D1EA@marvell.com>
 <20110428095127.GX17290@n2100.arm.linux.org.uk>
 <3BFCE791-3BAD-42ED-BC87-A27F40D6C77C@marvell.com>
 <CAMPhdO-TTRP-k7J-zrG2_rQJsmNDRhTgpqiiX2yqW+Egf8+t2A@mail.gmail.com>
 <CAMj5BkiK17RMY-vEENDqQiDOmfG0Esnp7QDooKWVrhkQL4g6Ow@mail.gmail.com>
 <CAMPhdO-b_dpC2ueexEFujr6p_NRb2JwDc0-UEx3cfOSVcZ-d6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:53499 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753857Ab1GEUUx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 5 Jul 2011 16:20:53 -0400
In-Reply-To: <CAMPhdO-b_dpC2ueexEFujr6p_NRb2JwDc0-UEx3cfOSVcZ-d6w@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: zhangfei gao <zhangfei.gao@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Zhangfei Gao <zgao6@marvell.com>

Subject: [PATCH V3] arm: mach-mmp: brownstone.c support multiple sd slots

V3
==
Change since V2 -- delete mmc3 since it was committed
to linux next.

enable mmc1 used for wifi (8688) and marked PERMANENT.
Wifi requires enabling of power on the device by
toggling the gpio lines for power and reset.  Enable eMMC first to work
around problem in booting order due to workqueue bug.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 arch/arm/mach-mmp/brownstone.c |   41 +++++++++++++++++++++++++++++++++++++++-
 1 files changed, 40 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.c
index c79162a..940982c 100644
--- a/arch/arm/mach-mmp/brownstone.c
+++ b/arch/arm/mach-mmp/brownstone.c
@@ -19,6 +19,7 @@
 #include <linux/regulator/max8649.h>
 #include <linux/regulator/fixed.h>
 #include <linux/mfd/max8925.h>
+#include <linux/delay.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -180,6 +181,11 @@ static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc0 = {
 	.clk_delay_cycles = 0x1f,
 };
 
+static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc1 = {
+	.clk_delay_cycles = 0x1f,
+	.flags		= PXA_FLAG_CARD_PERMANENT,
+};
+
 static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc2 = {
 	.clk_delay_cycles = 0x1f,
 	.flags = PXA_FLAG_CARD_PERMANENT
@@ -187,6 +193,38 @@ static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc2 = {
 };
 
 
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
+	gpio_direction_output(poweron, 0);
+	msleep(1);
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
@@ -195,8 +233,9 @@ static void __init brownstone_init(void)
 	mmp2_add_uart(1);
 	mmp2_add_uart(3);
 	mmp2_add_twsi(1, NULL, ARRAY_AND_SIZE(brownstone_twsi1_info));
-	mmp2_add_sdhost(0, &mmp2_sdh_platdata_mmc0); /* SD/MMC */
 	mmp2_add_sdhost(2, &mmp2_sdh_platdata_mmc2); /* eMMC */
+	mmp2_add_sdhost(0, &mmp2_sdh_platdata_mmc0); /* SD/MMC */
+	mmc_sdio_wifi();
 
 	/* enable 5v regulator */
 	platform_device_register(&brownstone_v_5vp_device);
-- 
1.7.0.4


On Jul 5, 2011, at 12:20 AM, Eric Miao wrote:

> On Tue, Jul 5, 2011 at 3:05 PM, zhangfei gao <zhangfei.gao@gmail.com> wrote:
>> On Tue, Jul 5, 2011 at 2:52 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
>>> On Fri, Apr 29, 2011 at 4:45 AM, Philip Rakity <prakity@marvell.com> wrote:
>>>> 
>>>> Support multiple sd/eMMC interfaces. enable mmc1, 2, and 3.
>>>> mmc2 is used eMMC and slot is marked PERMANENT and 8 bit device.
>>>> mmc1 is used for Wifi and slot is marked PERMANENT
>>>> 
>>>> Note: eMMC (mmc2) is set to initialize first to workaround a problem
>>>> where booting in logical order requires mmc create work queue
>>>> to be multi-threaded otherwise boot process hangs.  BUG report
>>>> send to linux-mmc and linux-kernel mailing list.
>>>> 
>>>> Wifi (mmc1) requires we enable power on the device by toggling
>>>> the gpio lines for power and reset.
>>>> 
>>>> Signed-off-by: Philip Rakity <prakity@marvell.com>
>>> 
>>> Applied. Though the email client was fiddling the spaces/CR-LF a bit.
>>> 
>>>> ---
>>>>  arch/arm/mach-mmp/brownstone.c |   52 +++++++++++++++++++++++++++++++++++++++-
>>>>  1 files changed, 51 insertions(+), 1 deletions(-)
>>>> 
>> 
>> Hi, Eric
>> 
>> arch/arm/mach-mmp/brownstone.c has already been modified from
>> mmc-next, here will have conflict.
>> Sorry for inconvenience.
> 
> 'K, I'll drop it then.
> 
>> 
>> Thanks
>> 

