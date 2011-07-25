From: "Nori, Sekhar" <nsekhar@ti.com>
Subject: RE: [PATCH v2 6/6] arm: davinci: DA850: Add wl1271/wlan support
Date: Mon, 25 Jul 2011 23:10:55 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024DD2CEC2__10714.8246992894$1311615708$gmane$org@dbde02.ent.ti.com>
References: <1310303679-17936-1-git-send-email-ido@wizery.com>
 <1310303679-17936-7-git-send-email-ido@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52835 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752375Ab1GYRl2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Jul 2011 13:41:28 -0400
In-Reply-To: <1310303679-17936-7-git-send-email-ido@wizery.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ido Yariv <ido@wizery.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-ker>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, Thomas Gleixner <tglx@linutronix.de>, "Hilman, Kevin" <khilman@ti.com>

On Sun, Jul 10, 2011 at 18:44:39, Ido Yariv wrote:
> The wl1271 daughter card for AM18x EVMs is a combo wireless connectivity
> add-on card, based on the LS Research TiWi module with Texas
> Instruments' wl1271 solution.
> It is a 4-wire, 1.8V, embedded SDIO WLAN device with an external IRQ
> line and is power-controlled by a GPIO-based fixed regulator.
> 
> This patch adds support for the WLAN capabilities of this expansion
> board.
> 
> Signed-off-by: Ido Yariv <ido@wizery.com>
> ---

> diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
> index a7b41bf..2dae1a1 100644
> --- a/arch/arm/mach-davinci/board-da850-evm.c
> +++ b/arch/arm/mach-davinci/board-da850-evm.c
> @@ -31,6 +31,8 @@

> +#ifdef CONFIG_DA850_WL12XX
> +
> +static int da850_wl12xx_fref = WL12XX_REFCLOCK_38;
> +
> +static int __init setup_da850_wl12xx_fref(char *fref)
> +{
> +	if (!strcmp(fref, "19.2"))
> +		da850_wl12xx_fref = WL12XX_REFCLOCK_19;
> +	else if (!strcmp(fref, "26"))
> +		da850_wl12xx_fref = WL12XX_REFCLOCK_26;
> +	else if (!strcmp(fref, "38.4"))
> +		da850_wl12xx_fref = WL12XX_REFCLOCK_38;
> +	else if (!strcmp(fref, "52"))
> +		da850_wl12xx_fref = WL12XX_REFCLOCK_52;
> +	else if (!strcmp(fref, "XTAL26"))
> +		da850_wl12xx_fref = WL12XX_REFCLOCK_26_XTAL;
> +	else if (!strcmp(fref, "XTAL38.4"))
> +		da850_wl12xx_fref = WL12XX_REFCLOCK_38_XTAL;
> +	else
> +		pr_info("da850_wl12xx_fref is invalid. Valid options: "
> +			"19.2, 26, 38.4, 52, XTAL26 or XTAL38.4\n");
> +	return 0;
> +}
> +__setup("da850_wl12xx_fref=", setup_da850_wl12xx_fref);

Adding a new kernel parameter requires update to
Documentation/kernel-parameters.txt as well.

I am Ccing a couple of folks in case they have ideas on
whether there is a better way to pass this information
to the kernel. I assume there is no way to detect
this from hardware.

> +static struct davinci_mmc_config da850_mmc_wl12xx_config = {
> +	.get_ro		= NULL,
> +	.get_cd		= NULL,

You can get rid of these NULL initializers.

> +	.set_power	= wl12xx_set_power,
> +	.wires		= 4,
> +	.max_freq	= 25000000,
> +	.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_NONREMOVABLE |
> +			  MMC_CAP_POWER_OFF_CARD,
> +	.version	= MMC_CTLR_VERSION_2,
> +};

> +static void da850_wl12xx_init(void)
> +{
> +	int ret;
> +
> +	ret = davinci_cfg_reg_list(da850_evm_mmc_wl12xx_pins);
> +	if (ret) {
> +		pr_warning("da850_evm_init: wl12xx/mmc mux setup failed:"
> +			   " %d\n", ret);
> +		return;
> +	}
> +
> +	ret = da850_register_mmcsd1(&da850_mmc_wl12xx_config);
> +	if (ret) {
> +		pr_warning("da850_evm_init: wl12xx/mmc registration failed:"
> +			   " %d\n", ret);
> +		return;
> +	}
> +
> +	ret = gpio_request_one(DA850_WLAN_EN, GPIOF_OUT_INIT_LOW, "wl12xx_en");
> +	if (ret) {
> +		pr_err("Error initializing the wl12xx enable gpio: %d\n", ret);
> +		return;
> +	}
> +
> +	ret = gpio_request_one(DA850_WLAN_IRQ, GPIOF_IN, "wl12xx_irq");
> +	if (ret) {
> +		pr_err("Error initializing the wl12xx irq gpio: %d\n", ret);
> +		gpio_free(DA850_WLAN_EN);
> +		return;
> +	}
> +
> +	da850_wl12xx_wlan_data.irq = gpio_to_irq(DA850_WLAN_IRQ);
> +	da850_wl12xx_wlan_data.board_ref_clock = da850_wl12xx_fref;
> +
> +	ret = wl12xx_set_platform_data(&da850_wl12xx_wlan_data);
> +	if (ret) {
> +		pr_err("Error setting wl12xx data: %d\n", ret);
> +		gpio_free(DA850_WLAN_IRQ);
> +		gpio_free(DA850_WLAN_EN);

Why not just use the traditional goto based bail out
mechanism? You will avoid the multiple gpio_free() calls.

Thanks,
Sekhar

