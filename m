From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH] plat-pxa: Enable ability to adjust SD/MMC clocks
Date: Wed, 27 Apr 2011 13:49:45 -0700
Message-ID: <1F336A22-BAC3-41E3-8D4E-5DF27874D1EA@marvell.com>
References: <59C2B513-EC04-4CA2-818B-9901CAF3E554@marvell.com>
 <20110427093328.GU17290@n2100.arm.linux.org.uk>
 <161C3F6C-0986-4364-B458-DBA4D08456FD@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:34496 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756121Ab1D0UxN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Apr 2011 16:53:13 -0400
In-Reply-To: <161C3F6C-0986-4364-B458-DBA4D08456FD@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Zhangfei Gao <zgao6@marvell.com>


The patches were submitted a while ago.

Enclosed.


>From dc965baa7f96b347178c9e5e7f2426a03475f1e5 Mon Sep 17 00:00:00 2001
From: Philip Rakity <prakity@marvell.com>
Date: Mon, 7 Feb 2011 11:49:53 -0800
Subject: [PATCH 12/12] arm: mach-mmp: brownstone.c support multiple sd slots

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






>From 6081a571dede58782688bf908ecc16b410536a63 Mon Sep 17 00:00:00 2001
From: Philip Rakity <prakity@marvell.com>
Date: Mon, 20 Dec 2010 14:42:22 -0800
Subject: [PATCH] mach-mmp: Support for SD/MMC clock adjustment in brownstone

Set timing for brownstone for SD/MMC cards to enable detection
timing adjustments are needed when speed > 25MHz
remove limitation on maximum speed of 25MHz

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 arch/arm/mach-mmp/brownstone.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.c
index 36d5b82..55e891a 100644
--- a/arch/arm/mach-mmp/brownstone.c
+++ b/arch/arm/mach-mmp/brownstone.c
@@ -178,14 +178,22 @@ static struct i2c_board_info brownstone_twsi1_info[] = {
 };
 
 static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc0 = {
-	.max_speed	= 25000000,
+	.adjust_clocks	= 1,
+	.clk_select	= 1,
+	.clk_delay	= 31,
 };
 
 static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc1 = {
+	.adjust_clocks	= 1,
+	.clk_select	= 1,
+	.clk_delay	= 15,
 	.flags		= PXA_FLAG_CARD_PERMANENT,
 };
 
 static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc2 = {
+	.adjust_clocks	= 1,
+	.clk_select	= 1,
+	.clk_delay	= 31,
 	.flags		= PXA_FLAG_CARD_PERMANENT |
 				PXA_FLAG_SD_8_BIT_CAPABLE_SLOT,
 };
-- 
1.7.0.4



On Apr 27, 2011, at 8:02 AM, Philip Rakity wrote:

> 
> 
> 
> 
> Begin forwarded message:
> 
>> From: Philip Rakity <prakity@marvell.com>
>> Date: April 22, 2011 1:18:33 PM PDT
>> To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
>> Cc: Zhangfei Gao <zgao6@marvell.com>
>> Subject: [PATCH] sdhci: sdhci-pxa.c: Add post reset processing for chip specific registers 
>> 
>> 
>> RESET_ALL resets chips private registers.
>> Reset to values specified in board file.
>> 
>> depends on board specific mach-mmp/plat-pxa sdhci.h definitions
>> 
>> Signed-off-by: Philip Rakity <prakity@marvell.com>
>> ---
>> drivers/mmc/host/sdhci-pxa.c |   42 ++++++++++++++++++++++++++++++++++++++++++
>> 1 files changed, 42 insertions(+), 0 deletions(-)
>> 
>> diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
>> index c8abf0f..1dc0988 100644
>> --- a/drivers/mmc/host/sdhci-pxa.c
>> +++ b/drivers/mmc/host/sdhci-pxa.c
>> @@ -29,6 +29,13 @@
>> 
>> #define DRIVER_NAME	"sdhci-pxa"
>> 
>> +#define SD_CLOCK_AND_BURST_SIZE_SETUP   0x10A
>> +#define SDCLK_DELAY_MASK     0x1F
>> +#define SDCLK_SEL_MASK       0x1
>> +#define SDCLK_DELAY_SHIFT    9
>> +#define SDCLK_SEL_SHIFT      8
>> +
>> +
>> struct sdhci_pxa {
>> 	struct sdhci_host		*host;
>> 	struct sdhci_pxa_platdata	*pdata;
>> @@ -53,7 +60,42 @@ static void enable_clock(struct sdhci_host *host)
>> 	}
>> }
>> 
>> +static void set_clock_and_burst_size(struct sdhci_host *host)
>> +{
>> +	u16 tmp;
>> +	struct sdhci_pxa *pxa = sdhci_priv(host);
>> +
>> +	pr_debug("%s:%s: adjust = %d\n",
>> +		__func__, mmc_hostname(host->mmc), pxa->pdata->adjust_clocks);
>> +
>> +	if (pxa->pdata->adjust_clocks) {
>> +		tmp = readw(host->ioaddr + SD_CLOCK_AND_BURST_SIZE_SETUP);
>> +		pr_debug("%s:%s: (B) SD_CLOCK_AND_BURST = %04X, "
>> +			"delay = %d, sel = %d\n",
>> +			__func__, mmc_hostname(host->mmc), tmp,
>> +			pxa->pdata->clk_delay, pxa->pdata->clk_select);
>> +		tmp &= ~(SDCLK_DELAY_MASK << SDCLK_DELAY_SHIFT);
>> +		tmp &= ~(SDCLK_SEL_MASK << SDCLK_SEL_SHIFT);
>> +		tmp |= (pxa->pdata->clk_delay & SDCLK_DELAY_MASK) <<
>> +			SDCLK_DELAY_SHIFT;
>> +		tmp |= (pxa->pdata->clk_select & SDCLK_SEL_MASK) <<
>> +			SDCLK_SEL_SHIFT;
>> +		writew(tmp, host->ioaddr + SD_CLOCK_AND_BURST_SIZE_SETUP);
>> +		pr_debug("%s:%s: (A) SD_CLOCK_AND_BURST_SIZE_SETUP = %04X\n",
>> +			__func__, mmc_hostname(host->mmc), tmp);
>> +	}
>> +}
>> +
>> +static void platform_reset_exit(struct sdhci_host *host, u8 mask)
>> +{
>> +	if (mask == SDHCI_RESET_ALL) {
>> +		/* reset private registers */
>> +		set_clock_and_burst_size(host);
>> +	}
>> +}
>> +
>> static struct sdhci_ops sdhci_pxa_ops = {
>> +	.platform_reset_exit = platform_reset_exit,
>> };
>> 
>> /*****************************************************************************\
>> -- 
>> 1.7.0.4
>> 
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> On Apr 27, 2011, at 2:33 AM, Russell King - ARM Linux wrote:
> 
>> On Fri, Apr 22, 2011 at 01:13:28PM -0700, Philip Rakity wrote:
>>> The PXA168, PXA910, and MMP2 SoC have the ability to adjust the SD/MMC
>>> clock.  This feature is useful and required depending on the board
>>> design.  Add infrastructure to support SD clock tuning.
>> 
>> It just adds fields to a structure which remain unused.  On its own this
>> patch is useless, and I don't see a patch which makes use of these new
>> fields in any way.  Did you forget to copy it to the linux-arm-kernel
>> list?
> 

