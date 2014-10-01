From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH V2 1/3] mmc: dw_mmc: use mmc_regulator_get_supply to handle
 regulators
Date: Wed, 01 Oct 2014 15:06:41 +0200
Message-ID: <15187164.uVE1eDb0Di@amdc1032>
References: <1408715272-13833-1-git-send-email-yuvaraj.cd@samsung.com>
 <28242432.noIRZ0lve1@amdc1032>
 <CAD=FV=W_KiXUU7SmGxTu-JzagW-zEs6AYAbrRMFU3KvppVk_BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:21683 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbaJANHS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Oct 2014 09:07:18 -0400
In-reply-to: <CAD=FV=W_KiXUU7SmGxTu-JzagW-zEs6AYAbrRMFU3KvppVk_BA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@google.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Sonny Rao <sonnyrao@chromium.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, sunil joshi <joshi@samsung.com>, Prashanth G <prashanth.g@samsung.com>, ALIM AKHTAR <alim.akhtar@samsung.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, ABHILASH KESAVAN <a.kesavan@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>


Hi,

On Tuesday, September 30, 2014 10:22:34 AM Doug Anderson wrote:
> Bartlomiej
> 
> On Mon, Sep 29, 2014 at 5:31 AM, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
> >
> > Hi,
> >
> > On Friday, August 29, 2014 01:34:44 PM Ulf Hansson wrote:
> >> On 22 August 2014 15:47, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com> wrote:
> >> > This patch makes use of mmc_regulator_get_supply() to handle
> >> > the vmmc and vqmmc regulators.Also it moves the code handling
> >> > the these regulators to dw_mci_set_ios().It turned on the vmmc
> >> > and vqmmc during MMC_POWER_UP and MMC_POWER_ON,and turned off
> >> > during MMC_POWER_OFF.
> >> >
> >> > Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
> >>
> >> Thanks! Applied for next.
> >
> > Unfortunately this patch breaks mmc1 card (Kingston 32GB micro SDHC)
> > detection on Exynos5420 Arndale Octa for me:
> >
> > [   10.797979] dwmmc_exynos 12220000.mmc: no support for card's volts
> > [   10.797998] mmc1: error -22 whilst initialising SD card
> >
> > Without the patch:
> >
> > [   10.866926] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 50000000Hz, actual 50000000HZ div = 0)
> > [   10.866977] mmc1: new high speed SDHC card at address 1234
> > [   10.868730] mmcblk1: mmc1:1234 SA32G 29.3 GiB
> > [   10.915054]  mmcblk1: p1 p2 p3
> >
> > The config is attached (exynos_defconfig doesn't work correctly for
> > this board yet).
> 
> Yup, this is an expected behavior, unfortunately.  This was talked
> about extensively during the review of this patch series.

Do you mean that a patch with a known regression has been merged
into next branch of mmc tree?  It would be quite sad if it would be
true.

> I believe that patch #3 in Yuvaraj's series would fix your problem.
> Specifically <https://patchwork.kernel.org/patch/4763891/>.

Unfortunately this patch doesn't fix the problem (there is no longer
a lockup on regulators initialization but -22 error is still present).

> The current summary of this issue is (Ulf, please correct me if I got
> anything wrong):
> 
> 1. If nothing else, Yuvaraj's patch should probably be split in two.
> One half should be the MMC core half that I originally sent Yuvaraj.
> I just rebased and re-uploaed it at
> <https://chromium-review.googlesource.com/220560> in case you're
> curious.  The second half should be the dw_mmc piece that Yuvaraj
> wrote.
> 
> 2. Ulf has indicated that he thinks that the MMC core change (and thus
> Yuvaraj's patch) is ugly and not necessary.  He advocates instead
> using the MMC_CAP_NEEDS_POLL on all affected platforms.  That means
> we'll turn on the power every second, check for the card, then turn
> off power.
> 
> 3. I'm still of the opinion that the MMC core change isn't _that_
> ugly.  Given that there are a large number of systems affected (across

It also doesn't look that bad for me and well, when the hardware is
quirky then the resulting code can't be esthetically perfect..

> at least two SoC vendors) and that it would be nice if those systems
> didn't have to poll, I'd still be happy if the MMC core change could
> go in.  ...but I'm a pragmatist and know that the polling isn't
> _terrible_, so if that's the way we need to go then so be it.
> 
> --
> 
> My understanding was that Yuvaraj was going to spin his patch to use a
> similar type of scheme to autodetect affected SoCs (looking for SoCs
> known to have this problem where the platform data shows them using
> the built-in card detect) and then enable MMC_CAP_NEEDS_POLL.  I
> haven't seen a patch from him, so maybe you could post this up?

I worry that I have too little time and MMC code expertise to do this.

> Note: the reason why exynos5250-snow and some other boards aren't
> affected yet is that the regulator is simply not specified in the
> device tree (it's just left always on).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

