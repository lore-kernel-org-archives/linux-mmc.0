From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] MMC fixes for v.4.12 rc3 - take 2/2
Date: Thu, 1 Jun 2017 17:05:22 -0700
Message-ID: <20170602000522.GH13314@localhost>
References: <CAPDyKFofp6qdgcqha6uNWJz4ApEc2y5dEkEo51LQyq-U3onpgQ@mail.gmail.com>
 <CAOesGMj=jG9RHy1WdNFy18kaCY8GjF2-srypigP1wuWzPzw5qQ@mail.gmail.com>
 <CAPDyKFr8xHRsztpMHjodpQZXH4bNMfVh_ZZvYDLpWS0Rc0JBMQ@mail.gmail.com>
 <20170529102236.GB2192@mai>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36378 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751129AbdFBAOO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Jun 2017 20:14:14 -0400
Received: by mail-lf0-f67.google.com with SMTP id h4so5428812lfj.3
        for <linux-mmc@vger.kernel.org>; Thu, 01 Jun 2017 17:14:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170529102236.GB2192@mai>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Linus <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arm@kernel.org" <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>

Hi,

On Mon, May 29, 2017 at 12:22:36PM +0200, Daniel Lezcano wrote:
> On Sun, May 28, 2017 at 12:26:00PM +0200, Ulf Hansson wrote:
> > Hi Olof,
> > 
> > +Daniel
> > 
> > On 26 May 2017 at 18:24, Olof Johansson <olof@lixom.net> wrote:
> > > Hi Ulf,
> > >
> > >
> > > On Fri, May 26, 2017 at 6:08 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >> Hi Linus,
> > >>
> > >> Here are a couple of mmc and arm64-dts fixes intended for v4.12 rc3.
> > >> They are based on v4.12-rc2.
> > >>
> > >> Details are as usual found in the signed tag. Please pull this in!
> > >>
> > >> Kind regards
> > >> Ulf Hansson
> > >>
> > >>
> > >> The following changes since commit 08332893e37af6ae779367e78e444f8f9571511d:
> > >>
> > >>   Linux 4.12-rc2 (2017-05-21 19:30:23 -0700)
> > >>
> > >> are available in the git repository at:
> > >>
> > >>   git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.12-rc2
> > >>
> > >> for you to fetch changes up to ea452678734eb782126f999bf5c4fb3e71d3b196:
> > >>
> > >>   arm64: dts: hikey: Fix WiFi support (2017-05-23 14:18:10 +0200)
> > >>
> > >> ----------------------------------------------------------------
> > >> This pull request contains fixes to make the WiFi work again for the ARM64
> > >> Hikey board.  Together with a couple of DTS updates for the Hikey board we have
> > >> also extended the mmc pwrseq_simple, to support a new power-off-delay-us DT
> > >> property, as that was required to enable a graceful power off sequence for the
> > >> WiFi chip.
> > >>
> > >> ----------------------------------------------------------------
> > >> Daniel Lezcano (2):
> > >>       mfd: dts: hi655x: Add clock binding for the pmic
> > >>       arm64: dts: hikey: Add clock for the pmic mfd
> > >>
> > >> Ulf Hansson (6):
> > >>       mmc: dt: pwrseq-simple: Invent power-off-delay-us
> > >>       mmc: pwrseq_simple: Parse DTS for the power-off-delay-us property
> > >>       arm64: dts: hi6220: Move the fixed_5v_hub regulator to the hikey dts
> > >>       arm64: dts: hikey: Add the SYS_5V and the VDD_3V3 regulators
> > >>       arm64: dts: hi6220: Move board data from the dwmmc nodes to hikey dts
> > >>       arm64: dts: hikey: Fix WiFi support
> > >
> > >
> > > These are a lot of changes to fix a regression. How was it introduced?
> > 
> > It was several releases ago it got broken, exactly which one I can't
> > really tell.
> > 
> > I suspect this also is related to an upgrade of the boot loader, as in
> > the earlier version of the series there where a pmic clock driver
> > included, however it got picked up for 4.12.
> > 
> > Looping in Daniel, just to see if he have some comments on this.
> 
> Depending on the version of the bootloader, the sdio/mmc2 was not correctly set
> up and raised a hung task warning.
> 
> This one has been fixed with the commit:
> 
> commit 0fbdf9953b41c28845fe8d05007ff09634ee3000
> Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> Date:   Thu Mar 16 15:03:24 2017 +0100
> 
>     arm64: dts: hi6220: Reset the mmc hosts
>     
>     The MMC hosts could be left in an unconsistent or uninitialized state from
>     the firmware. Instead of assuming, the firmware did the right things, let's
>     reset the host controllers.
>     
>     This change fixes a bug when the mmc2/sdio is initialized leading to a hung
>     task:
>     
>     [  242.704294] INFO: task kworker/7:1:675 blocked for more than 120 seconds.
>     [  242.711129]       Not tainted 4.9.0-rc8-00017-gcf0251f #3
>     [  242.716571] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>     [  242.724435] kworker/7:1     D    0   675      2 0x00000000
>     [  242.729973] Workqueue: events_freezable mmc_rescan
>     [  242.734796] Call trace:
>     [  242.737269] [<ffff00000808611c>] __switch_to+0xa8/0xb4
>     [  242.742437] [<ffff000008d07c04>] __schedule+0x1c0/0x67c
>     [  242.747689] [<ffff000008d08254>] schedule+0x40/0xa0
>     [  242.752594] [<ffff000008d0b284>] schedule_timeout+0x1c4/0x35c
>     [  242.758366] [<ffff000008d08e38>] wait_for_common+0xd0/0x15c
>     [  242.763964] [<ffff000008d09008>] wait_for_completion+0x28/0x34
>     [  242.769825] [<ffff000008a1a9f4>] mmc_wait_for_req_done+0x40/0x124
>     [  242.775949] [<ffff000008a1ab98>] mmc_wait_for_req+0xc0/0xf8
>     [  242.781549] [<ffff000008a1ac3c>] mmc_wait_for_cmd+0x6c/0x84
>     [  242.787149] [<ffff000008a26610>] mmc_io_rw_direct_host+0x9c/0x114
>     [  242.793270] [<ffff000008a26aa0>] sdio_reset+0x34/0x7c
>     [  242.798347] [<ffff000008a1d46c>] mmc_rescan+0x2fc/0x360
>     
>     [ ... ]
>     
> 
> For the story, this mmc/sdio is for the WiFi and this one was working for some
> version of the bootloader which initialized the clock and set the enable line
> for the chip. That is bad because the WiFi is working as a side effect from the
> boot loader.
> 
> In order to properly make support for the WiFi in the kernel, we need to sort
> out this by:
> 
>  - Reset the mmc
>  - Implement the clock at the pmic level
>  - Add the mfd clock cell
>  - Add the DT definition

Ok, that's all fine but it's not really what we would call a fix. Hardware
bringup and enabling of major drivers is usually done through the release
cycle and merged in the merge window, not as "fixes" after it's closed.

It's not causing problems in this case, but if it happens often it runs
the risk of causing a mess due to conflicting contributions from different
subsystem maintainers (i.e. in particular the DT contents updates),
and in general circumvents the development model we're keeping where
things are tested in -next before merge, etc.

Anyway, water under the bridge but it's stuff to think about for next time
around.


-Olof

