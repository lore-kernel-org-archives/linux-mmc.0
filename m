From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [GIT PULL] MMC fixes for v.4.12 rc3 - take 2/2
Date: Mon, 29 May 2017 12:22:36 +0200
Message-ID: <20170529102236.GB2192@mai>
References: <CAPDyKFofp6qdgcqha6uNWJz4ApEc2y5dEkEo51LQyq-U3onpgQ@mail.gmail.com>
 <CAOesGMj=jG9RHy1WdNFy18kaCY8GjF2-srypigP1wuWzPzw5qQ@mail.gmail.com>
 <CAPDyKFr8xHRsztpMHjodpQZXH4bNMfVh_ZZvYDLpWS0Rc0JBMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFr8xHRsztpMHjodpQZXH4bNMfVh_ZZvYDLpWS0Rc0JBMQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Olof Johansson <olof@lixom.net>, Linus <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arm@kernel.org" <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-mmc@vger.kernel.org

On Sun, May 28, 2017 at 12:26:00PM +0200, Ulf Hansson wrote:
> Hi Olof,
> 
> +Daniel
> 
> On 26 May 2017 at 18:24, Olof Johansson <olof@lixom.net> wrote:
> > Hi Ulf,
> >
> >
> > On Fri, May 26, 2017 at 6:08 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >> Hi Linus,
> >>
> >> Here are a couple of mmc and arm64-dts fixes intended for v4.12 rc3.
> >> They are based on v4.12-rc2.
> >>
> >> Details are as usual found in the signed tag. Please pull this in!
> >>
> >> Kind regards
> >> Ulf Hansson
> >>
> >>
> >> The following changes since commit 08332893e37af6ae779367e78e444f8f9571511d:
> >>
> >>   Linux 4.12-rc2 (2017-05-21 19:30:23 -0700)
> >>
> >> are available in the git repository at:
> >>
> >>   git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.12-rc2
> >>
> >> for you to fetch changes up to ea452678734eb782126f999bf5c4fb3e71d3b196:
> >>
> >>   arm64: dts: hikey: Fix WiFi support (2017-05-23 14:18:10 +0200)
> >>
> >> ----------------------------------------------------------------
> >> This pull request contains fixes to make the WiFi work again for the ARM64
> >> Hikey board.  Together with a couple of DTS updates for the Hikey board we have
> >> also extended the mmc pwrseq_simple, to support a new power-off-delay-us DT
> >> property, as that was required to enable a graceful power off sequence for the
> >> WiFi chip.
> >>
> >> ----------------------------------------------------------------
> >> Daniel Lezcano (2):
> >>       mfd: dts: hi655x: Add clock binding for the pmic
> >>       arm64: dts: hikey: Add clock for the pmic mfd
> >>
> >> Ulf Hansson (6):
> >>       mmc: dt: pwrseq-simple: Invent power-off-delay-us
> >>       mmc: pwrseq_simple: Parse DTS for the power-off-delay-us property
> >>       arm64: dts: hi6220: Move the fixed_5v_hub regulator to the hikey dts
> >>       arm64: dts: hikey: Add the SYS_5V and the VDD_3V3 regulators
> >>       arm64: dts: hi6220: Move board data from the dwmmc nodes to hikey dts
> >>       arm64: dts: hikey: Fix WiFi support
> >
> >
> > These are a lot of changes to fix a regression. How was it introduced?
> 
> It was several releases ago it got broken, exactly which one I can't
> really tell.
> 
> I suspect this also is related to an upgrade of the boot loader, as in
> the earlier version of the series there where a pmic clock driver
> included, however it got picked up for 4.12.
> 
> Looping in Daniel, just to see if he have some comments on this.

Depending on the version of the bootloader, the sdio/mmc2 was not correctly set
up and raised a hung task warning.

This one has been fixed with the commit:

commit 0fbdf9953b41c28845fe8d05007ff09634ee3000
Author: Daniel Lezcano <daniel.lezcano@linaro.org>
Date:   Thu Mar 16 15:03:24 2017 +0100

    arm64: dts: hi6220: Reset the mmc hosts
    
    The MMC hosts could be left in an unconsistent or uninitialized state from
    the firmware. Instead of assuming, the firmware did the right things, let's
    reset the host controllers.
    
    This change fixes a bug when the mmc2/sdio is initialized leading to a hung
    task:
    
    [  242.704294] INFO: task kworker/7:1:675 blocked for more than 120 seconds.
    [  242.711129]       Not tainted 4.9.0-rc8-00017-gcf0251f #3
    [  242.716571] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
    [  242.724435] kworker/7:1     D    0   675      2 0x00000000
    [  242.729973] Workqueue: events_freezable mmc_rescan
    [  242.734796] Call trace:
    [  242.737269] [<ffff00000808611c>] __switch_to+0xa8/0xb4
    [  242.742437] [<ffff000008d07c04>] __schedule+0x1c0/0x67c
    [  242.747689] [<ffff000008d08254>] schedule+0x40/0xa0
    [  242.752594] [<ffff000008d0b284>] schedule_timeout+0x1c4/0x35c
    [  242.758366] [<ffff000008d08e38>] wait_for_common+0xd0/0x15c
    [  242.763964] [<ffff000008d09008>] wait_for_completion+0x28/0x34
    [  242.769825] [<ffff000008a1a9f4>] mmc_wait_for_req_done+0x40/0x124
    [  242.775949] [<ffff000008a1ab98>] mmc_wait_for_req+0xc0/0xf8
    [  242.781549] [<ffff000008a1ac3c>] mmc_wait_for_cmd+0x6c/0x84
    [  242.787149] [<ffff000008a26610>] mmc_io_rw_direct_host+0x9c/0x114
    [  242.793270] [<ffff000008a26aa0>] sdio_reset+0x34/0x7c
    [  242.798347] [<ffff000008a1d46c>] mmc_rescan+0x2fc/0x360
    
    [ ... ]
    

For the story, this mmc/sdio is for the WiFi and this one was working for some
version of the bootloader which initialized the clock and set the enable line
for the chip. That is bad because the WiFi is working as a side effect from the
boot loader.

In order to properly make support for the WiFi in the kernel, we need to sort
out this by:

 - Reset the mmc
 - Implement the clock at the pmic level
 - Add the mfd clock cell
 - Add the DT definition

The three first patches are merged, the first commit is described above, then we have:

------------------------------------------------------------------------------

commit ac03fec1d7d889192cce35edac6fef6026a4d6a1
Author: Daniel Lezcano <daniel.lezcano@linaro.org>
Date:   Fri Mar 17 08:58:50 2017 +0100

    mfd: hi655x: Add the clock cell to provide WiFi and Bluetooth
    
    The hi655x is a PMIC with regulator but also provides a clock for the WiFi
    and the bluetooth which is missing in the current implementation.
    
    Add the clock cell so it can be used in the next patch via the dts.

------------------------------------------------------------------------------

commit b68adc23bc3d0c81a08b69cf1ba0bf0405c9d868
Author: Daniel Lezcano <daniel.lezcano@linaro.org>
Date:   Mon Apr 17 19:19:25 2017 +0200

    clk: hi6220: Add the hi655x's pmic clock
    
    The hi655x multi function device is a PMIC providing regulators.
    
    The PMIC also provides a clock for the WiFi and the Bluetooth, let's implement
    this clock in order to add it in the hi655x MFD and allow proper wireless
    initialization.

------------------------------------------------------------------------------
 

The fourth patch was missed somehow and Ulf recaugth it in its series.

Why?

The wl18xx documentation tells if the enable line is set *before* the clock,
that may damage the chip. By taking the series, we make sure the patches are in
the right order (clock followed by the enable line with a delay in between as
specified in the documentation).

That said, I don't have a strong opinion on which version this series should
go. The latest wl18xx driver version needs an update of the firmware, I'm not
sure it is a good a idea to enable the WiFi in -rc as every hi6220 users will
have to upgrade their firmware, on the other side it is not really a big deal.

  -- Daniel
 
> No matter what, I still think it makes sense to pick this for 4.12
> rcs, because it also simplifies for us for how to deal with the
> mmc+arm64 dependency, since this needs to go together (to avoid
> damaging the WiFi chip when power off)
> 
> >
> > It would also have been useful if you pointed out the DT contents was
> > already acked by Arnd (I had to go look at the contents since you only
> > looped him in, and no other ARM-SoC maintainers).
> >
> 
> Apologize about that! I will make that clear, if/when next time!
> 
> >
> > -Olof
> 
> Kind regards
> Uffe

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
