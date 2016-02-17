From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: SDIO wifi card is not detected with 4.5-rc kernels
Date: Wed, 17 Feb 2016 22:11:36 +0000
Message-ID: <20160217221136.GL19428@n2100.arm.linux.org.uk>
References: <CA+7w51i3Kf2Jm=AXP5QhDj_8ZmzhUowbwwNEtu8UgiNkWwMYxg@mail.gmail.com>
 <CAOMZO5DzhVMaE76Y_ZVzRMpCMyovSs4seWXKyCqeA9f=nb2CJg@mail.gmail.com>
 <20160217211818.GI19428@n2100.arm.linux.org.uk>
 <CAEG3pNDW6FefMhrgmJAFj+hGcoOZTuFDOx+NaA9sNSfD-ko+dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:59153 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965230AbcBQWLn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Feb 2016 17:11:43 -0500
Content-Disposition: inline
In-Reply-To: <CAEG3pNDW6FefMhrgmJAFj+hGcoOZTuFDOx+NaA9sNSfD-ko+dQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: Fabio Estevam <festevam@gmail.com>, Laszlo Fiat <laszlo.fiat@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Wed, Feb 17, 2016 at 02:03:47PM -0800, Michael Turquette wrote:
> Hi Russell, all,
> 
> On Wed, Feb 17, 2016 at 1:18 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > [   52.175162] match->alloc failed: -517
> > [   52.178874] sdhci-esdhc-imx 2190000.usdhc: mmc_of_parse failed: -517
> > [   52.185271] sdhci-esdhc-imx 2190000.usdhc: imx probe failed
> >
> > -517 is -EPROBE_DEFER, and looking at what's in the clk_summary
> > debugfs file, my guess is that the clk_sdio gpio-gate-clock is not
> > being registered for some unknown reason.  Adding Michael - any
> > ideas why gpio-gate-clock has stopped working between 4.4 and
> > present?
> 
> So you are missing a gpio-gate clk in v4.5-rc1 that is present in v4.4?

It seems so.

arch/arm/boot/dts/imx6qdl-microsom.dtsi has:

        clk_sdio: sdio-clock {
                compatible = "gpio-gate-clock";
                #clock-cells = <0>;
                pinctrl-names = "default";
                pinctrl-0 = <&pinctrl_microsom_brcm_osc>;
                enable-gpios = <&gpio5 5 GPIO_ACTIVE_HIGH>;
        };

and if I boot the kernel with that:

# grep sdio /sys/kernel/debug/clk/clk_summary
#

If I look at a system with v4.4 booted:

# grep sdio /sys/kernel/debug/clk/clk_summary
 sdio-clock                               1            1           0          0    0

So, this appears to be a regression.

> There isn't much to go on here, but mmc_of_parse can fail with
> mmc_gpiod_request_cd and mmc_gpiod_request_ro, in addition to
> mmc_pwrseq_alloc. I didn't follow the call chain to see if either of
> those are capable of spitting out -EPROBE_DEFER.

Yes, there's other possible failures, but:

[   52.175162] match->alloc failed: -517

points to the mmc_pwrseq_alloc stuff - because that message is printed
from inside there.  The pwrseq stuff consists of:

        usdhc1_pwrseq: usdhc1_pwrseq {
                compatible = "mmc-pwrseq-simple";
                reset-gpios = <&gpio5 26 GPIO_ACTIVE_LOW>,
                              <&gpio6 0 GPIO_ACTIVE_LOW>;
                clocks = <&clk_sdio>;
                clock-names = "ext_clock";
        };

some GPIOs, and that clock - the GPIOs are definitely present, and the
sdio clock is clearly missing from clk_summary.

> clk patches affecting the gpio-gate from 4.4 to 4.5-rc1 are:
> 
> 7ed88aa clk: fix clk-gpio.c with optional clock= DT property
> 0b2e788 clk: gpio: handle error codes for of_clk_get_parent_count()
> c76eb11 clk: gpio: fix memory leak
> f66541b clk: gpio: Get parent clk names in of_gpio_clk_setup()
> 
> Anyone that can reproduce, care to bisect?

This isn't -next, this is 4.5-rc4 that I'm seeing the failure on.
4.5-rc4 still has clk-gpio.c with:

CLK_OF_DECLARE(gpio_gate_clk, "gpio-gate-clock", of_gpio_gate_clk_setup);

Annoyingly, it's silent in the boot log about what's going on wrt
this clock.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
