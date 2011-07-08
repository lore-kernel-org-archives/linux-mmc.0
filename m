From: Ido Yariv <ido@wizery.com>
Subject: Re: [PATCH 5/5] arm: davinci: DA850: Add wl12xx expansion board
 support
Date: Fri, 8 Jul 2011 17:27:50 +0300
Message-ID: <20110708142750.GH2176@WorkStation>
References: <1310074390-4277-1-git-send-email-ido@wizery.com>
 <1310074390-4277-6-git-send-email-ido@wizery.com>
 <4E16DE64.5090205@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:35316 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752757Ab1GHO2E (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Jul 2011 10:28:04 -0400
Received: by wyg8 with SMTP id 8so1347304wyg.19
        for <linux-mmc@vger.kernel.org>; Fri, 08 Jul 2011 07:28:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E16DE64.5090205@mvista.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, linux-arm-kernel@lists.arm.linux.org.uk, linux-mmc@vger.kernel.org

Hi,

On Fri, Jul 08, 2011 at 02:39:32PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 08-07-2011 1:33, Ido Yariv wrote:
> 
> >The DA850 supports an optional wl12xx based expansion board, adding WLAN
> >&  BT capabilities. The wl12xx is a 4-wire, 1.8V, embedded SDIO WLAN
> >device with an external IRQ line and is power-controlled by a GPIO-based
> >fixed regulator.
> 
> >This patch adds support for the WLAN capabilities of this expansion
> >board.
> 
> >Signed-off-by: Ido Yariv<ido@wizery.com>
> >---
> >  arch/arm/mach-davinci/Kconfig            |   31 +++++++
> >  arch/arm/mach-davinci/board-da850-evm.c  |  128 ++++++++++++++++++++++++++++++
> >  arch/arm/mach-davinci/da850.c            |    9 ++
> >  arch/arm/mach-davinci/include/mach/mux.h |   10 +++
> >  4 files changed, 178 insertions(+), 0 deletions(-)
> 
> >diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
> >index c0deaca..1a9149c 100644
> >--- a/arch/arm/mach-davinci/Kconfig
> >+++ b/arch/arm/mach-davinci/Kconfig
> >@@ -192,6 +192,37 @@ config DA850_UI_RMII
> >
> >  endchoice
> >
> >+config DA850_WL12XX
> >+	bool "DA850 wl12xx expansion board"
> >+	depends on MACH_DAVINCI_DA850_EVM
> >+	---help---
> >+	  Say Y if you want to use a wl12xx expansion board connected to the
> >+	  DA850 EVM.
> 
>    If I don't mistake, this expansion board is rather used with AM180x EVM?

I'm actually not sure about the compatibility between the two, so yes,
it might be a good idea to rename the configuration option and
description.

[...]

> >+config DA850_WL12XX_FREF_19_2
> >+	bool "19.2MHz"
> >+config DA850_WL12XX_FREF_26
> >+	bool "26MHz"
> >+config DA850_WL12XX_FREF_38_4
> >+	bool "38.4MHz"
> >+config DA850_WL12XX_FREF_52
> >+	bool "52MHz"
> >+config DA850_WL12XX_FREF_XTAL_26
> >+	bool "XTAL 26MHz"
> >+config DA850_WL12XX_FREF_XTAL_38_4
> >+	bool "XTAL 38MHz"
> 
>    Could you add emoty lines between items?

Sure.

[...]

> >+static int da850_wl12xx_fref = -1;
> >+
> >+static int __init setup_da850_wl12xx_fref(char *fref)
> >+{
> >+	if (!strcmp(fref, "19.2"))
> >+		da850_wl12xx_fref = WL12XX_REFCLOCK_19;
> >+	else if (!strcmp(fref, "26"))
> >+		da850_wl12xx_fref = WL12XX_REFCLOCK_26;
> >+	else if (!strcmp(fref, "38.4"))
> >+		da850_wl12xx_fref = WL12XX_REFCLOCK_38;
> >+	else if (!strcmp(fref, "52"))
> >+		da850_wl12xx_fref = WL12XX_REFCLOCK_52;
> >+	else if (!strcmp(fref, "XTAL26"))
> >+		da850_wl12xx_fref = WL12XX_REFCLOCK_26_XTAL;
> >+	else if (!strcmp(fref, "XTAL38.4"))
> >+		da850_wl12xx_fref = WL12XX_REFCLOCK_38_XTAL;
> >+	else
> >+		pr_info("da850_wl12xx_fref is invalid. Valid options: "
> >+			"19.2, 26, 38.4, 52, XTAL26 or XTAL38.4\n");
> >+	return 0;
> >+}
> >+__setup("da850_wl12xx_fref=", setup_da850_wl12xx_fref);
> 
>    Why then also have a Kconfig 'choice' for that?

We could choose a default value arbitrarily, but AFAIK there isn't a
good one. The two currently available expansion boards use different
reference clocks, so one of them will not work out of the box.

Having it configurable by a boot argument can be handy when switching
between expansion boards during development. Naturally, it's not a must.

> >+static void wl12xx_set_power(int slot, bool power_on)
> >+{
> >+	static bool power_state;
> >+
> >+	pr_debug("Powering %s wl12xx", (power_on ? "on" : "off"));
> 
>    Parens not needed around ?:.

Sure, will be fixed.

> 
> >+	if (power_on) {
> >+		/* Power up sequence required for wl127x devices */
> >+		gpio_set_value(DA850_WLAN_EN, 1);
> >+		mdelay(15);
> >+		gpio_set_value(DA850_WLAN_EN, 0);
> >+		mdelay(1);
> >+		gpio_set_value(DA850_WLAN_EN, 1);
> >+		mdelay(70);
> 
>    Perhaps msleep()?

Sure, will be fixed.

> >+static void da850_wl12xx_init(void)
> >+{
> >+	int ret;
> >+
> >+	ret = davinci_cfg_reg_list(da850_evm_mmc_wl12xx_pins);
> >+	if (ret)
> >+		pr_warning("da850_evm_init: wl12xx/mmc mux setup failed:"
> >+			   " %d\n", ret);
> >+
> >+	ret = da850_register_mmcsd1(&da850_mmc_wl12xx_config);
> >+	if (ret)
> >+		pr_warning("da850_evm_init: wl12xx/mmc registration failed:"
> >+			   " %d\n", ret);
> 
>    If these fail, does it makse sense to continue? I doubt it...

Right, will be fixed.

> 
> >+	if (gpio_request(DA850_WLAN_EN, "wl12xx_en") ||
> >+	    gpio_direction_output(DA850_WLAN_EN, 0))
> 
>    Use gpio_request_one() instead of this pair.
> 
> >+		pr_err("Error initializing the wl12xx enable gpio\n");
> >+
> >+	if (gpio_request(DA850_WLAN_IRQ, "wl12xx_irq") ||
> >+	    gpio_direction_input(DA850_WLAN_IRQ))
> 
>    Same here.

Sure, will be fixed.

> >diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
> >index 133aac4..bfe9b71 100644
> >--- a/arch/arm/mach-davinci/da850.c
> >+++ b/arch/arm/mach-davinci/da850.c
> >@@ -525,6 +525,13 @@ static const struct mux_config da850_pins[] = {
> >  	MUX_CFG(DA850, MMCSD0_DAT_3,	10,	20,	15,	2,	false)
> >  	MUX_CFG(DA850, MMCSD0_CLK,	10,	0,	15,	2,	false)
> >  	MUX_CFG(DA850, MMCSD0_CMD,	10,	4,	15,	2,	false)
> >+	/* MMC/SD1 function */
> >+	MUX_CFG(DA850, MMCSD1_DAT_0,	18,	8,	15,	2,	false)
> >+	MUX_CFG(DA850, MMCSD1_DAT_1,	19,	16,	15,	2,	false)
> >+	MUX_CFG(DA850, MMCSD1_DAT_2,	19,	12,	15,	2,	false)
> >+	MUX_CFG(DA850, MMCSD1_DAT_3,	19,	8,	15,	2,	false)
> >+	MUX_CFG(DA850, MMCSD1_CLK,	18,	12,	15,	2,	false)
> >+	MUX_CFG(DA850, MMCSD1_CMD,	18,	16,	15,	2,	false)
> >  	/* EMIF2.5/EMIFA function */
> >  	MUX_CFG(DA850, EMA_D_7,		9,	0,	15,	1,	false)
> >  	MUX_CFG(DA850, EMA_D_6,		9,	4,	15,	1,	false)
> >@@ -583,6 +590,8 @@ static const struct mux_config da850_pins[] = {
> >  	MUX_CFG(DA850, GPIO3_13,	7,	8,	15,	8,	false)
> >  	MUX_CFG(DA850, GPIO4_0,		10,	28,	15,	8,	false)
> >  	MUX_CFG(DA850, GPIO4_1,		10,	24,	15,	8,	false)
> >+	MUX_CFG(DA850, GPIO6_9,		13,	24,	15,	8,	false)
> >+	MUX_CFG(DA850, GPIO6_10,	13,	20,	15,	8,	false)
> >  	MUX_CFG(DA850, GPIO6_13,	13,	8,	15,	8,	false)
> >  	MUX_CFG(DA850, RTC_ALARM,	0,	28,	15,	2,	false)
> >  #endif
> 
> >diff --git a/arch/arm/mach-davinci/include/mach/mux.h b/arch/arm/mach-davinci/include/mach/mux.h
> >index 5d4e0fe..a7e92fc 100644
> >--- a/arch/arm/mach-davinci/include/mach/mux.h
> >+++ b/arch/arm/mach-davinci/include/mach/mux.h
> >@@ -857,6 +857,14 @@ enum davinci_da850_index {
> >  	DA850_MMCSD0_CLK,
> >  	DA850_MMCSD0_CMD,
> >
> >+	/* MMC/SD1 function */
> >+	DA850_MMCSD1_DAT_0,
> >+	DA850_MMCSD1_DAT_1,
> >+	DA850_MMCSD1_DAT_2,
> >+	DA850_MMCSD1_DAT_3,
> >+	DA850_MMCSD1_CLK,
> >+	DA850_MMCSD1_CMD,
> >+
> >  	/* EMIF2.5/EMIFA function */
> >  	DA850_EMA_D_7,
> >  	DA850_EMA_D_6,
> >@@ -916,6 +924,8 @@ enum davinci_da850_index {
> >  	DA850_GPIO3_13,
> >  	DA850_GPIO4_0,
> >  	DA850_GPIO4_1,
> >+	DA850_GPIO6_9,
> >+	DA850_GPIO6_10,
> >  	DA850_GPIO6_13,
> >  	DA850_RTC_ALARM,
> >  };
> 
>    Please modify these 2 files a sperate patch. Maybe even 2
> patches: one for MMC1 pins and one for GPIO pins...

Sure, will be fixed.

Thanks for your review,
Ido.
