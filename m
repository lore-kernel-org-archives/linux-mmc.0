From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: sdhci: remove mdelay in eMMC tuning
Date: Wed, 14 May 2014 14:18:23 +0200
Message-ID: <5285574.Jh25nVnT1D@wuerfel>
References: <1399427558-8478-1-git-send-email-nsanders@chromium.org> <CAPDyKFpsm_M2oY3OuVHZ-MCNezT6xwo-HPwfo1pxfrw5ySKfOg@mail.gmail.com> <CANEJEGt1-BYD2kaHJisQ=YBj6k4CJU5-7_bjW+M5TZ_yuMY_TQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:57111 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbaENMS3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 May 2014 08:18:29 -0400
In-Reply-To: <CANEJEGt1-BYD2kaHJisQ=YBj6k4CJU5-7_bjW+M5TZ_yuMY_TQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Grundler <grundler@chromium.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>, Nick Sanders <nsanders@chromium.org>, linux-mmc <linux-mmc@vger.kernel.org>, Doug Anderson <dianders@chromium.org>, Chang-Eun Choi-SSI <cu.choi@ssi.samsung.com>

On Tuesday 13 May 2014 18:13:30 Grant Grundler wrote:
> On Wed, May 7, 2014 at 1:35 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On 7 May 2014 03:52, Nick Sanders <nsanders@chromium.org> wrote:
> >> This patch removes an unneccesary 1ms mdelay in the HS200 tuning
> >> loop, called 40 times per retuning. Currently this causes a latency
> >> of >40ms on any emmc accesses triggering wake from runtime PM,
> >> which can occur for a significant portion of reads on a mostly idle system.
> >
> > Aha, so you are actually using "MMC_CAP_RUNTIME_RESUME" here - cool :-).
> >
> > I suppose those patches that enables the "cap" has not reached
> > mainline yet. Any plans on sending them?
> >
> >>
> >> The delay is left in place for SD Cards, which use
> >> MMC_SEND_TUNING_BLOCK rather than MMC_SEND_TUNING_BLOCK_HS200.
> >> I'm not able to find evidence that this is required for SD in the
> >> specs I have access to, however this delay has been present from
> >> initial checkin for SD so I have preserved the original behavior for
> >> compatibility.
> >>
> >> This has been verified to fix observed glitching on local audio
> >> playback and recording on apps with inbuilt assumptions on storage
> >> latency.
> >>
> >> Signed-off-by: Nick Sanders <nsanders@chromium.org>
> >> Reviewed-by: Grant Grundler <grundler@chromium.org>
> >> Reviewed-by: Doug Anderson <dianders@chromium.org>
> >
> > Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Ulf,
> Is your ACK enough to get this to land upstream or does cjb need to
> respond it's been accepted?
> 
> It doesn't appear to have landed in mmc-next branch yet:
>     http://git.kernel.org/cgit/linux/kernel/git/cjb/mmc.git/log/?h=mmc-next
> 
> apologies if it appears I am being impatient...but it's been almost a week now.
> 

I just stumbled over this thread. Looking at the callers of the
execute_tuning() function, I see that all three come from non-atomic
context. How about an add-on patch to turn the mdelay(1) into an
msleep(1)? That would be much friendlier to other tasks running
concurrently.

	Arnd
