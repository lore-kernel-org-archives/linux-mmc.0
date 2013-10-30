From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/7] mmc: sh_mmcif: Convert to use runtime PM at
 request idle
Date: Thu, 31 Oct 2013 00:03:32 +0100
Message-ID: <CAPDyKFq1JaB=ss+t0egbECf1V1dNi+gwV5usYtN=nLWZ1LOMRg@mail.gmail.com>
References: <1382450846-17144-1-git-send-email-ulf.hansson@linaro.org>
	<CAPDyKFoF_tZHTLcKSE_HjRXEohDwPkRn7ewhvuUfKQs7uoJS9Q@mail.gmail.com>
	<Pine.LNX.4.64.1310302328390.25391@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qe0-f46.google.com ([209.85.128.46]:54488 "EHLO
	mail-qe0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247Ab3J3XDd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Oct 2013 19:03:33 -0400
Received: by mail-qe0-f46.google.com with SMTP id s14so1271824qeb.5
        for <linux-mmc@vger.kernel.org>; Wed, 30 Oct 2013 16:03:32 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1310302328390.25391@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 30 October 2013 23:41, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> Hi Ulf
>
> On Tue, 29 Oct 2013, Ulf Hansson wrote:
>
>> On 22 October 2013 16:07, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> > In a step in removing CONFIG_MMC_CLKGATE, host drivers can implement same
>> > functionality through runtime PM. This patchset is converting the sh_mmcif
>> > accordingly.
>> >
>> > On the way, it was reasonable to include some minor cleanups to simplify code.
>> > The first patch has beend sent through an another patchset recently, but since
>> > it touches related code to this patchset, I decided to fold it in here as well.
>> >
>> > An important note, this patchset has only been compile tested. I hope someone
>> > can help out with proper testing.
>> >
>> > Changes in v2:
>> >         - Adapted "mmc: sh_mmcif: Move clock handling into runtime PM callbacks"
>> >         patch to maintain behavior of handling clk_get_rate.
>> >         - Rebased patches on top of the above change.
>> >
>> > Ulf Hansson (7):
>> >   mmc: sh_mmcif: Move away from using deprecated APIs
>> >   mmc: sh_mmcif: Convert to PM macros when defining dev_pm_ops
>> >   mmc: sh_mmcif: Convert to clk_prepare|unprepare
>> >   mmc: sh_mmcif: Use runtime PM to keep resourses active during I/O
>> >   mmc: sh_mmcif: Move clock handling into runtime PM callbacks
>> >   mmc: sh_mmcif: Simplify clock and power setup in set_ios
>> >   mmc: sh_mmcif: Extend clock gating routine for runtime suspend
>> >
>> >  drivers/mmc/host/sh_mmcif.c |  138 ++++++++++++++++++++++++-------------------
>> >  1 file changed, 76 insertions(+), 62 deletions(-)
>> >
>> > --
>> > 1.7.9.5
>> >
>>
>> Hi Guennadi.
>>
>> Just wanted to send you a kind ping on this. I would very much
>> appreciate any further comments from you.
>
> Sorry for a delay. I didn't reply, because I actually don't have much to
> say concerning the main topic of the series - the PM conversion. Patch 1/7
> is already upstream, I acked patches 2 and 3, that's about as much as I
> can do, sorry. Beginning with patch 4 things get complicated. And even
> though I did confirm, that your approach could be implemented to replace
> MMC aggressive clock gating, I don't think I'm able to verify correctness
> of those your patches by just looking at them. They really seem to change
> the behaviour a lot to me, and as such I personally cannot follow all the
> possibilities on all supported platforms in my head. I think this change,
> if really desired, should be done by someone with access to all or at
> least a few of affected SoC versions with different configurations -
> hot-pluggable cards, eMMC, system suspend / resume, PM domains, DMA and
> PIO, etc. I'm pretty sure I could begin asking questiong to your patch(es)
> like what if here this happens, or how will that be handled, but that
> would be a waste of time for both of us IMHO. I'm not maintaining the
> driver, so, a maintainer can just decide to pick up your patches and see
> if anything breaks, or they can be dropped until someone does the tests.
>
> Thanks
> Guennadi

Hi Guennadi,

Thanks for your response and for your review. I kind of assumed you
had some related hw to test the patches on. :-) Do you have any advise
on whom I could ask for help here then?

I really would like to the see the MMC_CLKGATE code to go away and an
option could be to just remove it, especially since no defconfig make
use of it. My posted patches for sh_mmcif could then if needed be
picked up as a later task.

BTW, I have prepared similar patches done for sh_mmcif to
tmio/sh_mobile, soon ready for posting.

Any thoughts?

Kind regards
Ulf Hansson

> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
