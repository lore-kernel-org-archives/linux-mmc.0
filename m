From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 5/5] arm: davinci: DA850: Add wl12xx expansion board support
Date: Fri, 08 Jul 2011 14:39:32 +0400
Message-ID: <4E16DE64.5090205@mvista.com>
References: <1310074390-4277-1-git-send-email-ido@wizery.com> <1310074390-4277-6-git-send-email-ido@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:50098 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930Ab1GHKko (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Jul 2011 06:40:44 -0400
Received: by fxd18 with SMTP id 18so1934014fxd.11
        for <linux-mmc@vger.kernel.org>; Fri, 08 Jul 2011 03:40:42 -0700 (PDT)
In-Reply-To: <1310074390-4277-6-git-send-email-ido@wizery.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ido Yariv <ido@wizery.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, linux-arm-kernel@lists.arm.linux.org.uk, linux-mmc@vger.kernel.org

Hello.

On 08-07-2011 1:33, Ido Yariv wrote:

> The DA850 supports an optional wl12xx based expansion board, adding WLAN
> &  BT capabilities. The wl12xx is a 4-wire, 1.8V, embedded SDIO WLAN
> device with an external IRQ line and is power-controlled by a GPIO-based
> fixed regulator.

> This patch adds support for the WLAN capabilities of this expansion
> board.

> Signed-off-by: Ido Yariv<ido@wizery.com>
> ---
>   arch/arm/mach-davinci/Kconfig            |   31 +++++++
>   arch/arm/mach-davinci/board-da850-evm.c  |  128 ++++++++++++++++++++++++++++++
>   arch/arm/mach-davinci/da850.c            |    9 ++
>   arch/arm/mach-davinci/include/mach/mux.h |   10 +++
>   4 files changed, 178 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
> index c0deaca..1a9149c 100644
> --- a/arch/arm/mach-davinci/Kconfig
> +++ b/arch/arm/mach-davinci/Kconfig
> @@ -192,6 +192,37 @@ config DA850_UI_RMII
>
>   endchoice
>
> +config DA850_WL12XX
> +	bool "DA850 wl12xx expansion board"
> +	depends on MACH_DAVINCI_DA850_EVM
> +	---help---
> +	  Say Y if you want to use a wl12xx expansion board connected to the
> +	  DA850 EVM.

    If I don't mistake, this expansion board is rather used with AM180x EVM?

> +
> +choice
> +	prompt "FREF reference clock used by the wl12XX expansion board"
> +	default DA850_WL12XX_FREF_38_4
> +	depends on DA850_WL12XX
> +	help
> +	  There are currently two kinds of such daughter boards, one made by
> +	  Mistral and another by LS Research. These (and perhaps others) use
> +	  different FREF reference clocks. Select the correct one according to
> +	  the daughter board's type.
> +
> +config DA850_WL12XX_FREF_19_2
> +	bool "19.2MHz"
> +config DA850_WL12XX_FREF_26
> +	bool "26MHz"
> +config DA850_WL12XX_FREF_38_4
> +	bool "38.4MHz"
> +config DA850_WL12XX_FREF_52
> +	bool "52MHz"
> +config DA850_WL12XX_FREF_XTAL_26
> +	bool "XTAL 26MHz"
> +config DA850_WL12XX_FREF_XTAL_38_4
> +	bool "XTAL 38MHz"

    Could you add emoty lines between items?

> diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
> index a7b41bf..a567379 100644
> --- a/arch/arm/mach-davinci/board-da850-evm.c
> +++ b/arch/arm/mach-davinci/board-da850-evm.c
[...]
> @@ -1117,6 +1122,127 @@ static __init int da850_evm_init_cpufreq(void)
>   static __init int da850_evm_init_cpufreq(void) { return 0; }
>   #endif
>
> +#ifdef CONFIG_DA850_WL12XX
> +
> +static int da850_wl12xx_fref = -1;
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

    Why then also have a Kconfig 'choice' for that?

> +static void wl12xx_set_power(int slot, bool power_on)
> +{
> +	static bool power_state;
> +
> +	pr_debug("Powering %s wl12xx", (power_on ? "on" : "off"));

    Parens not needed around ?:.

> +	if (power_on) {
> +		/* Power up sequence required for wl127x devices */
> +		gpio_set_value(DA850_WLAN_EN, 1);
> +		mdelay(15);
> +		gpio_set_value(DA850_WLAN_EN, 0);
> +		mdelay(1);
> +		gpio_set_value(DA850_WLAN_EN, 1);
> +		mdelay(70);

    Perhaps msleep()?

> +static void da850_wl12xx_init(void)
> +{
> +	int ret;
> +
> +	ret = davinci_cfg_reg_list(da850_evm_mmc_wl12xx_pins);
> +	if (ret)
> +		pr_warning("da850_evm_init: wl12xx/mmc mux setup failed:"
> +			   " %d\n", ret);
> +
> +	ret = da850_register_mmcsd1(&da850_mmc_wl12xx_config);
> +	if (ret)
> +		pr_warning("da850_evm_init: wl12xx/mmc registration failed:"
> +			   " %d\n", ret);

    If these fail, does it makse sense to continue? I doubt it...

> +	if (gpio_request(DA850_WLAN_EN, "wl12xx_en") ||
> +	    gpio_direction_output(DA850_WLAN_EN, 0))

    Use gpio_request_one() instead of this pair.

> +		pr_err("Error initializing the wl12xx enable gpio\n");
> +
> +	if (gpio_request(DA850_WLAN_IRQ, "wl12xx_irq") ||
> +	    gpio_direction_input(DA850_WLAN_IRQ))

    Same here.

> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
> index 133aac4..bfe9b71 100644
> --- a/arch/arm/mach-davinci/da850.c
> +++ b/arch/arm/mach-davinci/da850.c
> @@ -525,6 +525,13 @@ static const struct mux_config da850_pins[] = {
>   	MUX_CFG(DA850, MMCSD0_DAT_3,	10,	20,	15,	2,	false)
>   	MUX_CFG(DA850, MMCSD0_CLK,	10,	0,	15,	2,	false)
>   	MUX_CFG(DA850, MMCSD0_CMD,	10,	4,	15,	2,	false)
> +	/* MMC/SD1 function */
> +	MUX_CFG(DA850, MMCSD1_DAT_0,	18,	8,	15,	2,	false)
> +	MUX_CFG(DA850, MMCSD1_DAT_1,	19,	16,	15,	2,	false)
> +	MUX_CFG(DA850, MMCSD1_DAT_2,	19,	12,	15,	2,	false)
> +	MUX_CFG(DA850, MMCSD1_DAT_3,	19,	8,	15,	2,	false)
> +	MUX_CFG(DA850, MMCSD1_CLK,	18,	12,	15,	2,	false)
> +	MUX_CFG(DA850, MMCSD1_CMD,	18,	16,	15,	2,	false)
>   	/* EMIF2.5/EMIFA function */
>   	MUX_CFG(DA850, EMA_D_7,		9,	0,	15,	1,	false)
>   	MUX_CFG(DA850, EMA_D_6,		9,	4,	15,	1,	false)
> @@ -583,6 +590,8 @@ static const struct mux_config da850_pins[] = {
>   	MUX_CFG(DA850, GPIO3_13,	7,	8,	15,	8,	false)
>   	MUX_CFG(DA850, GPIO4_0,		10,	28,	15,	8,	false)
>   	MUX_CFG(DA850, GPIO4_1,		10,	24,	15,	8,	false)
> +	MUX_CFG(DA850, GPIO6_9,		13,	24,	15,	8,	false)
> +	MUX_CFG(DA850, GPIO6_10,	13,	20,	15,	8,	false)
>   	MUX_CFG(DA850, GPIO6_13,	13,	8,	15,	8,	false)
>   	MUX_CFG(DA850, RTC_ALARM,	0,	28,	15,	2,	false)
>   #endif

> diff --git a/arch/arm/mach-davinci/include/mach/mux.h b/arch/arm/mach-davinci/include/mach/mux.h
> index 5d4e0fe..a7e92fc 100644
> --- a/arch/arm/mach-davinci/include/mach/mux.h
> +++ b/arch/arm/mach-davinci/include/mach/mux.h
> @@ -857,6 +857,14 @@ enum davinci_da850_index {
>   	DA850_MMCSD0_CLK,
>   	DA850_MMCSD0_CMD,
>
> +	/* MMC/SD1 function */
> +	DA850_MMCSD1_DAT_0,
> +	DA850_MMCSD1_DAT_1,
> +	DA850_MMCSD1_DAT_2,
> +	DA850_MMCSD1_DAT_3,
> +	DA850_MMCSD1_CLK,
> +	DA850_MMCSD1_CMD,
> +
>   	/* EMIF2.5/EMIFA function */
>   	DA850_EMA_D_7,
>   	DA850_EMA_D_6,
> @@ -916,6 +924,8 @@ enum davinci_da850_index {
>   	DA850_GPIO3_13,
>   	DA850_GPIO4_0,
>   	DA850_GPIO4_1,
> +	DA850_GPIO6_9,
> +	DA850_GPIO6_10,
>   	DA850_GPIO6_13,
>   	DA850_RTC_ALARM,
>   };

    Please modify these 2 files a sperate patch. Maybe even 2 patches: one for 
MMC1 pins and one for GPIO pins...

WBR, Sergei
