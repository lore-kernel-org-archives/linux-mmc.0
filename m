From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 00/16] omap_hsmmc: regulator usage cleanup and fixes
Date: Fri, 21 Aug 2015 00:41:31 -0700
Message-ID: <20150821074131.GK4215@atomide.com>
References: <1438604801-11823-1-git-send-email-kishon@ti.com>
 <55D5C9B3.80802@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:45565 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751576AbbHUHlf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 21 Aug 2015 03:41:35 -0400
Content-Disposition: inline
In-Reply-To: <55D5C9B3.80802@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: ulf.hansson@linaro.org, afenkart@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com

* Kishon Vijay Abraham I <kishon@ti.com> [150820 05:39]:
> Hi,
> 
> On Monday 03 August 2015 05:56 PM, Kishon Vijay Abraham I wrote:
> > Changes from v1:
> > *) return on -EPROBE_DEFER and other fatal errors. (Don't return only
> >    if the return value is -ENODEV)
> > *) Remove the beagle x15 dts patch. It can be part of a different
> >    series.
> > *) Avoid using regulator_is_enabled for vqmmc since if the regulator
> >    is shared and the other users are not using regulator_is_enabled
> >    then there can be unbalanced regulator_enable/regulator_disable
> > 
> > This patch series does the following
> > *) Uses devm_regulator_get_optional() for vmmc and then removes the
> >    CONFIG_REGULATOR check altogether.
> > *) return on -EPROBE_DEFER and any other fatal errors
> > *) enable/disable vmmc_aux regulator based on prior state
> > 
> > I've pushed this patch series to
> > git://git.ti.com/linux-phy/linux-phy.git mmc_regulator_cleanup_fixes_v2
> > 
> > Please note the branch also has the pbias fixes [1] & [2].
> > [1] -> https://lkml.org/lkml/2015/7/27/358
> > [2] -> https://lkml.org/lkml/2015/7/27/391
> > 
> > This series is in preparation for implementing the voltage switch
> > sequence so that UHS cards can be supported.
> > 
> > Did basic read/write test in J6, J6 Eco, Beagle-x15, AM437x EVM,
> > Beaglebone black, OMAP5 uEVM and OMAP4 PANDA.
> 
> I have now done read/write test in omap3 beagle-xm with this series!

Great thanks for doing that. Also gave this series a try here
with my off idle MMC SDIO WLAN card test and things still work
for me. That's not really testing the PBIAS regulator though,
but a good torture test for saving and restoring context. So
FWIW:

Tested-by: Tony Lindgren <tony@atomide.com>

If you need a PM torture test for PBIAS regulator, you could try
to do the following on your beagle xm MMC card with
oamp2plus_defconfig:

1. Make sure EHCI modules are not loaded and OTG USB cable is
   not connected

2. Enable UART timeouts and off idle with something like:

!/bin/bash

uarts=$(find /sys/class/tty/tty[SO]*/device/power/ -type d)
for uart in $uarts; do
        echo 3000 > $uart/autosuspend_delay_ms 2>&1
done

modprobe leds-gpio
modprobe ledtrig-default-on

uarts=$(find /sys/class/tty/tty[SO]*/power/ -type d 2>/dev/null)
for uart in $uarts; do
        echo enabled > $uart/wakeup 2>&1
        echo auto > $uart/control 2>&1
done

echo 1 > /sys/kernel/debug/pm_debug/enable_off_mode

3. Make sure you start seeing core_pwrdm OFF count increasing
   with cat /sys/kernel/debug/pm_debug/count

MMC should keep on working when hitting idle, if not, something
is not saved or restored properly. And SDIO WLAN cards should
wake up the system and respond to ping if the wakeirq is
configured in the dts file for the MMC controller. At least
mwifiex_sdio cards work for this :)

Regards,

Tony
