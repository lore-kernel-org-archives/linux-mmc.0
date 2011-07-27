From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH 2/2] ARM: mmp2: support sdio device 8787
Date: Wed, 27 Jul 2011 10:57:32 -0700
Message-ID: <1EA87C4D-1B63-40E4-AA86-20D2A02A17B7@marvell.com>
References: <1654B53E-123B-43F5-B526-49D19D39D1F0@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:44267 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754654Ab1G0R56 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Jul 2011 13:57:58 -0400
In-Reply-To: <1654B53E-123B-43F5-B526-49D19D39D1F0@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


On Jul 27, 2011, at 10:55 AM, Philip Rakity wrote:

> Support 8787 device, provide regulator vmmc
> 
> With CONFIG_PM_RUNTIME=y
> 8787 power is enabled if any client module over sdio is insmod, and disbled automatically after all client modules over sdio are rmmod
> Also 8787 power could be controled by mmc_start/stop_host via debugfs
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> ---
> arch/arm/mach-mmp/brownstone.c |   60 ++++++++++++++++++++++++++++++++++++++-
> 1 files changed, 58 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.c
> index c79162a..46a67b9 100644
> --- a/arch/arm/mach-mmp/brownstone.c
> +++ b/arch/arm/mach-mmp/brownstone.c
> @@ -89,6 +89,9 @@ static unsigned long brownstone_pin_config[] __initdata = {
> 	GPIO41_MMC2_CMD | MFP_PULL_HIGH,
> 	GPIO42_MMC2_CLK,
> 
> +	GPIO57_GPIO | MFP_LPM_DRIVE_HIGH | MFP_PULL_HIGH,
> +	GPIO58_GPIO | MFP_LPM_DRIVE_HIGH | MFP_PULL_HIGH,
> +
> 	/* MMC2 */
> 	GPIO165_MMC3_DAT7 | MFP_PULL_HIGH,
> 	GPIO162_MMC3_DAT6 | MFP_PULL_HIGH,
> @@ -180,12 +183,66 @@ static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc0 = {
> 	.clk_delay_cycles = 0x1f,
> };
> 
> +static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc1 = {
> +	.flags = PXA_FLAG_CARD_PERMANENT,
> +};
> +
> static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc2 = {
> 	.clk_delay_cycles = 0x1f,
> 	.flags = PXA_FLAG_CARD_PERMANENT
> 		| PXA_FLAG_SD_8_BIT_CAPABLE_SLOT,
> };
> 
> +static struct regulator_consumer_supply sdio_power_supplies[] = {
> +	REGULATOR_SUPPLY("vmmc", "sdhci-pxav3.1"),
> +};
> +
> +static struct regulator_init_data sdio_power_data = {
> +	.constraints	= {
> +		.valid_ops_mask		= REGULATOR_CHANGE_STATUS,
> +	},
> +	.num_consumer_supplies	= ARRAY_SIZE(sdio_power_supplies),
> +	.consumer_supplies	= sdio_power_supplies,
> +};
> +
> +static struct fixed_voltage_config sdio_power = {
> +	.supply_name		= "vmmc",
> +	.microvolts		= 3000000,
> +	.gpio			= mfp_to_gpio(MFP_PIN_GPIO57),
> +	.enable_high		= 1,
> +	.enabled_at_boot	= 0,
> +	.init_data		= &sdio_power_data,
> +};
> +

ldo7 is the power source.   The 8787 is the consumer and the code should reflect this.
GPIO57 is an on/off switch to the 8787.


> +static struct platform_device sdio_power_device = {
> +	.name		= "reg-fixed-voltage",
> +	.id		= 2,
> +	.dev = {
> +		.platform_data = &sdio_power,
> +	},
> +};
> +
> +static void __init brownstone_init_mmc(void)
> +{
> +	/*
> +	 * PDn: GPIO57; RESETn: GPIO58
> +	 * 8787, RESETn keeps high, PDn control power
> +	 * on: PDn 1; off: PDn 0;
> +	 */
> +	int RESETn = mfp_to_gpio(MFP_PIN_GPIO58);
> +
> +	if (gpio_request(RESETn, "sdio RESETn")) {
> +		pr_err("Failed to request sdio RESETn gpio\n");
> +		return;
> +	}
> +	gpio_direction_output(RESETn, 1);
> +	gpio_free(RESETn);
> +
> +	platform_device_register(&sdio_power_device);
> +	mmp2_add_sdhost(0, &mmp2_sdh_platdata_mmc0); /* SD/MMC */
> +	mmp2_add_sdhost(1, &mmp2_sdh_platdata_mmc1); /* sdio */
> +	mmp2_add_sdhost(2, &mmp2_sdh_platdata_mmc2); /* eMMC */
> +}
> 
> static void __init brownstone_init(void)
> {
> @@ -195,8 +252,7 @@ static void __init brownstone_init(void)
> 	mmp2_add_uart(1);
> 	mmp2_add_uart(3);
> 	mmp2_add_twsi(1, NULL, ARRAY_AND_SIZE(brownstone_twsi1_info));
> -	mmp2_add_sdhost(0, &mmp2_sdh_platdata_mmc0); /* SD/MMC */
> -	mmp2_add_sdhost(2, &mmp2_sdh_platdata_mmc2); /* eMMC */
> +	brownstone_init_mmc();
> 
> 	/* enable 5v regulator */
> 	platform_device_register(&brownstone_v_5vp_device);
> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

