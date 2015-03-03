From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] mmc: sdio: support switching to 1-bit before turning
 off clocks
Date: Tue, 3 Mar 2015 14:53:55 -0800
Message-ID: <20150303225355.GE3756@atomide.com>
References: <20150224024023.22719.32436.stgit@notabene.brown>
 <20150224024223.22719.91536.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150224024223.22719.91536.stgit@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Andreas Fenkart <afenkart@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, GTA04 owners <gta04-owner@goldelico.com>, NeilBrown <neil@brown.name>, linux-omap <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Ash Charles <ash@gumstix.com>
List-Id: linux-mmc@vger.kernel.org

* NeilBrown <neilb@suse.de> [150223 18:47]:
> According to section 7.1.2 of
> 
> http://www.sandisk.com/media/File/OEM/Manuals/SD_SDIO_specsv1.pdf
> 
>     In the case where the interrupt mechanism is used to wake the host while
>     the card is in a low power state (i.e. no clocks), Both the card and the
>     host shall be placed into the 1-bit SD mode prior to stopping the clock.
> 
> This is particularly important for the Marvell "libertas" wifi chip
> in the GTA04.  While in 4-bit mode it will only signal an interrupt
> when the clock is running (which is why setting CLKEXTFREE is
> important).
> In 1-bit mode, the interrupt is asynchronous (explained in OMAP3
> TRM description of the CIRQ flag to MMCHS_STAT:
> 
>   In 1-bit mode, interrupt source is asynchronous (can be a source of
>   asynchronous wakeup).
>   In 4-bit mode, interrupt source is sampled during the interrupt
>   cycle.
> 
> )
> 
> It is awkward to simply set 1-bit mode in ->runtime_suspend
> as that will call mmc_set_ios which calls ops->set_ios(),
> which will likely call pm_runtime_get_sync(), on the device that
> is currently suspending.  This deadlocks.
> 
> So:
>  - create a work_struct to schedule setting of 1-bit mode
>  - introduce an 'sdio_narrowed' state flag which transitions:
>      0 (normal) -> 1 (convert to 1-bit pending) ->
>          2 (have switch to 1-bit mode) -> 0 (normal)
>  - create a function mmc_sdio_want_no_clocks() which can be called
>    when the driver wants to turn off clocks (presumably after an
>    idle timeout).  This either succeeds (in 1-bit mode) or fails
>    and schedules the work to switch to 1-bit mode.
>  - when the host is claimed, if sdio_narrowed is 2, restore the
>    4-bit bus
>  - When the host is released, if sdio_narrowed is 1, then some
>    caller other  than our worker claimed the host first, so
>    clear sdio_narrowed.
> 
> This all allows a graceful and race-free switch to 1-bit mode
> before switching off the clocks, if SDIO interrupts are enabled.
> 
> A host should call mmc_sdio_want_no_clocks() when about to turn off
> clocks if sdio interrupts are enabled, and the ->disable() function
> should not use a timeout (pm_runtime_put_autosuspend) if
> ->sdio_narrowed is 2.

Wow! A mystery finally solved for why libertas_sdio using devices
like overo won't work for the wakeirqs.. The interface has to be
in 1-bit mode for libertas to produce any SDIO interrupts..

Below is a patch enabling some more SDIO wakeirqs. Seems to work
on overo now too :) So tor the whole series, please feel free to
add:

Tested-by: Tony Lindgren <tony@atomide.com>

8< -------------------
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 26 Feb 2015 16:16:03 -0800
Subject: [PATCH] ARM: dts: Fix omap3 SDIO wakeirqs for devices using sdio_libertas

Turns out the the MMC interface needs to be in 1-bit mode for the
libertas card to send any SDIO interrupts as pointed out by
NeilBrown <neilb@suse.de>. Now that the MMC framework is getting
fixed for setting 1-bit mode for idle, we can enable SDIO wakeirqs
for libertas using devices too.

Cc: Andreas Fenkart <afenkart@gmail.com>
Cc: Ash Charles <ash@gumstix.com>
Cc: Florian Vaussard <florian.vaussard@epfl.ch>
Cc: NeilBrown <neil@brown.name>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -367,6 +367,7 @@
 };
 
 &mmc2 {
+	interrupts-extended = <&intc 86 &omap3_pmx_core 0x12e>;
 	vmmc-supply = <&vaux4>;
 	bus-width = <4>;
 	ti,non-removable;
--- a/arch/arm/boot/dts/omap3-overo-base.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-base.dtsi
@@ -185,6 +185,7 @@
 &mmc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_pins>;
+	interrupts-extended = <&intc 86 &omap3_pmx_core 0x12e>;
 	vmmc-supply = <&w3cbw003c_npoweron>;
 	vqmmc-supply = <&w3cbw003c_bt_nreset>;
 	vmmc_aux-supply = <&w3cbw003c_wifi_nreset>;
