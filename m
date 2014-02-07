From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: UHS-1 cards with iMX6Q
Date: Fri, 7 Feb 2014 23:59:23 +0800
Message-ID: <20140207155920.GA10195@S2101-09.ap.freescale.net>
References: <20140207152951.GB26684@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe005.messaging.microsoft.com ([216.32.180.188]:15482
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752711AbaBGP7M (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Feb 2014 10:59:12 -0500
Content-Disposition: inline
In-Reply-To: <20140207152951.GB26684@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Dong Aisheng <b29396@freescale.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Fri, Feb 07, 2014 at 03:29:51PM +0000, Russell King - ARM Linux wrote:
> Hi,
> 
> I have a Samsung 8GB UHS-1 card which I'm trying with iMX6Q, and it's
> not behaving very well with the voltage switch.  With MMC debugging
> enabled - and augmented with additional debug for the ESDHC_VENDOR
> register, I'm seeing this with 3.14-rc1:
> 
> [    2.771270] mmc1: starting CMD11 arg 00000000 flags 00000015
> [    2.771575] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000080
> [    2.771613] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
> [    2.771632] mmc1: req done (CMD11): 0: 00000320 00000000 00000000 00000000
> [    2.772669] mmc1: clock 0Hz busmode 2 powermode 2 cs 0 Vdd 21 width 0 timing 0
> [    2.772679] mmc1: clearing ESDHC_VENDOR_SPEC_FRC_SDCLK_ON
> [    2.772687] mmc1: ESDHC_VENDOR_SPEC_VSELECT is clear
> [    2.772695] mmc1: clearing ESDHC_VENDOR_SPEC_VSELECT
> [    2.772703] mmc1: clearing ESDHC_VENDOR_SPEC_FRC_SDCLK_ON
> [    2.772713] sdhci-esdhc-imx 2194000.usdhc: change pinctrl state for uhs 0
> [    2.772719] mmc1: clearing ESDHC_VENDOR_SPEC_FRC_SDCLK_ON
> [    2.772729] mmc1: ESDHC_VENDOR_SPEC_VSELECT is clear
> [    2.772735] mmc1: setting ESDHC_VENDOR_SPEC_VSELECT
> [    2.778276] mmc1: ESDHC_VENDOR_SPEC_VSELECT is sett
> [    2.786482] mmc1: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 0 timing 0
> [    2.786502] sdhci-esdhc-imx 2194000.usdhc: desired SD clock: 400000, actual: 386718
> [    2.786511] mmc1: setting ESDHC_VENDOR_SPEC_FRC_SDCLK_ON
> [    2.787515] mmc1: ESDHC_VENDOR_SPEC_VSELECT is sett
> [    2.787522] mmc1: setting ESDHC_VENDOR_SPEC_VSELECT
> [    2.787529] mmc1: clearing ESDHC_VENDOR_SPEC_FRC_SDCLK_ON
> [    2.787536] sdhci-esdhc-imx 2194000.usdhc: change pinctrl state for uhs 0
> [    2.787548] sdhci-esdhc-imx 2194000.usdhc: desired SD clock: 400000, actual: 386718
> [    2.787554] mmc1: setting ESDHC_VENDOR_SPEC_FRC_SDCLK_ON
> [    2.789560] mmc1: card failed to indicate switch to low voltage mode
> 
> This appears to correspond with the sequence:
> 
> CMD11 -> clock off -> set vselect -> clock on -> clock off ->
> set pinctrl -> clock on -> test D[3:0]
> 
> which appears not to be the expected sequence - the expected sequence
> should be:
> 
> CMD11 -> clock off -> set vselect -> clock on -> test D[3:0]
> 
> maybe with the setting of the IOMUX settings somewhere in there -
> probably at the point where the clock is off - the additional clock
> off/clock on step looks to me incorrect.
> 
> In any case, I've also augmented the other failure paths in
> mmc_set_signal_voltage(), and it's always this one (the last step)
> which fails:
> 
>         if (host->ops->card_busy && host->ops->card_busy(host)) {
>                 pr_debug("%s: card failed to indicate switch to low voltage mode\n",
>                          mmc_hostname(host));
>                 err = -EAGAIN;
>         }
> 
> Any ideas?

I'm not sure if it's the cause or you have it set up or not, but I
remember that we need to have 3 pinctrl states for 50MHz, 100MHz and
200MHz to get UHS card to work.  You can look at
arch/arm/boot/dts/imx6qdl-sabreauto.dtsi for example.

Shawn

