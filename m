From: Philip Rakity <prakity@marvell.com>
Subject: RE: ARM: mmp2: support sdio with regulator vsdio
Date: Thu, 21 Jul 2011 17:12:17 -0700
Message-ID: <95D75AEA-6086-4F45-B19B-43375EC252E0@marvell.com>
References: <37C1B996-A455-4EA9-A916-F4ED8C034167@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:40386 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751822Ab1GVASL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 21 Jul 2011 20:18:11 -0400
In-Reply-To: <37C1B996-A455-4EA9-A916-F4ED8C034167@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhangfei Gao <zgao6@marvell.com>
Cc: Chris Ball <cjb@laptop.org>, Ohad Ben-Cohen <ohad@wizery.com>, Daniel Drake <dsd@laptop.org>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Bing Zhao <bzhao@marvell.com>, Frank Huang <frankh@marvell.com>


With correct subject

On Jul 21, 2011, at 5:10 PM, Philip Rakity wrote:

> Hi Zhangfei,
> 
> Comments below.
> 
> Philip
> 
> 
>> Add regulator vsdio, which controled by mmc core to handle sdio chip power
>> 
>> Test With CONFIG_PM_RUNTIME=y
>> 8787 power is enabled if any client module over sdio is insmod, and disbled automatically after all client modules over sdio are rmmod
>> Also 8787 power could be controled by mmc_start/stop_host
>> 
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>> 
>> ---
>> arch/arm/mach-mmp/brownstone.c |   60 ++++++++++++++++++++++++++++++++++++++-
>> 1 files changed, 58 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.c
>> index c79162a..63315e2 100644
>> --- a/arch/arm/mach-mmp/brownstone.c
>> +++ b/arch/arm/mach-mmp/brownstone.c
>> @@ -89,6 +89,9 @@ static unsigned long brownstone_pin_config[] __initdata = {
>> 	GPIO41_MMC2_CMD | MFP_PULL_HIGH,
>> 	GPIO42_MMC2_CLK,
>> 
>> +	GPIO57_GPIO | MFP_LPM_DRIVE_HIGH | MFP_PULL_HIGH,
>> +	GPIO58_GPIO | MFP_LPM_DRIVE_HIGH | MFP_PULL_HIGH,
>> +
>> 	/* MMC2 */
>> 	GPIO165_MMC3_DAT7 | MFP_PULL_HIGH,
>> 	GPIO162_MMC3_DAT6 | MFP_PULL_HIGH,
>> @@ -180,12 +183,66 @@ static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc0 = {
>> 	.clk_delay_cycles = 0x1f,
>> };
>> 
>> +static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc1 = {
>> +	.flags = PXA_FLAG_CARD_PERMANENT,
>> +};
>> +
>> static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc2 = {
>> 	.clk_delay_cycles = 0x1f,
>> 	.flags = PXA_FLAG_CARD_PERMANENT
>> 		| PXA_FLAG_SD_8_BIT_CAPABLE_SLOT,
>> };
>> 
>> +static struct regulator_consumer_supply sdio_power_supplies[] = {
>> +	REGULATOR_SUPPLY("vsdio", "sdhci-pxav3.1"),
>> +};
>> +
>> +static struct regulator_init_data sdio_power_data = {
>> +	.constraints	= {
>> +		.valid_ops_mask		= REGULATOR_CHANGE_STATUS,
>> +	},
>> +	.num_consumer_supplies	= ARRAY_SIZE(sdio_power_supplies),
>> +	.consumer_supplies	= sdio_power_supplies,
>> +};
>> +
>> +static struct fixed_voltage_config sdio_power = {
>> +	.supply_name		= "vsdio",
>> +	.microvolts		= 3000000,
>> +	.gpio			= mfp_to_gpio(MFP_PIN_GPIO57),
>> +	.enable_high		= 1,
>> +	.enabled_at_boot	= 0,
>> +	.init_data		= &sdio_power_data,
>> +};
>> +
>> +static struct platform_device sdio_power_device = {
>> +	.name		= "reg-fixed-voltage",
>> +	.id		= 2,
>> +	.dev = {
>> +		.platform_data = &sdio_power,
>> +	},
>> +};
>> +
>> +static int __init brownstone_init_mmc(void)
>> +{
>> +	/*
>> +	 * PDn: GPIO58; RESETn: GPIO57
>> +	 * 8787, RESETn keeps high, PDn control power
>> +	 * on: PDn 1; off: PDn 0;
>> +	 */
> 
> Comment unclear
> 
> GPIO57 is power
> GPIO58 is reset
> 
> 
> 
>> +	int RESETn = mfp_to_gpio(MFP_PIN_GPIO58);
>> +
>> +	if (gpio_request(RESETn, "sdio RESETn")) {
>> +		pr_err("Failed to request sdio RESETn gpio\n");
>> +		return -EIO;
>> +	}
>> +	gpio_direction_output(RESETn, 1);
>> +	gpio_free(RESETn);
> 
> 
> The 8787  data sheet indicated that PDn should be inactive as well as reset before
> initiating power up.
> 
> Pull PDn high.
> 
> 
>> +
>> +	platform_device_register(&sdio_power_device);
>> +	mmp2_add_sdhost(0, &mmp2_sdh_platdata_mmc0); /* SD/MMC */
>> +	mmp2_add_sdhost(1, &mmp2_sdh_platdata_mmc1); /* sdio */
>> +	mmp2_add_sdhost(2, &mmp2_sdh_platdata_mmc2); /* eMMC */
>> +}
>> 
>> static void __init brownstone_init(void)
>> {
>> @@ -195,8 +252,7 @@ static void __init brownstone_init(void)
>> 	mmp2_add_uart(1);
>> 	mmp2_add_uart(3);
>> 	mmp2_add_twsi(1, NULL, ARRAY_AND_SIZE(brownstone_twsi1_info));
>> -	mmp2_add_sdhost(0, &mmp2_sdh_platdata_mmc0); /* SD/MMC */
>> -	mmp2_add_sdhost(2, &mmp2_sdh_platdata_mmc2); /* eMMC */
>> +	brownstone_init_mmc();
>> 
>> 	/* enable 5v regulator */
>> 	platform_device_register(&brownstone_v_5vp_device);

