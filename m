From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 1/1] mmc: host: Kconfig: Update SDHCI S3C entry
Date: Wed, 25 Jun 2014 09:55:50 -0700
Message-ID: <CAD=FV=UwEwP73wTa8Lm=u4WLcJBUu7PEzoJKoBuiaf21ciCeuw@mail.gmail.com>
References: <1403690286-1264-1-git-send-email-sachin.kamat@samsung.com>
	<4605637.HIkriDj1YF@wuerfel>
	<CAK5sBcHp74qqa=EU5TfSpCO+VWbYnQx+QFQado6S75bhRfiCDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve0-f171.google.com ([209.85.128.171]:61971 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757426AbaFYQzw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Jun 2014 12:55:52 -0400
Received: by mail-ve0-f171.google.com with SMTP id jz11so2329542veb.30
        for <linux-mmc@vger.kernel.org>; Wed, 25 Jun 2014 09:55:50 -0700 (PDT)
In-Reply-To: <CAK5sBcHp74qqa=EU5TfSpCO+VWbYnQx+QFQado6S75bhRfiCDQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sachin Kamat <spk.linux@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>

Arnd,

On Wed, Jun 25, 2014 at 3:57 AM, Sachin Kamat <spk.linux@gmail.com> wrote:
> On Wed, Jun 25, 2014 at 3:38 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Wednesday 25 June 2014 15:28:06 Sachin Kamat wrote:
>>> All Exynos4 SoC based boards have SDHCI controller and mostly
>>> use SD mounted filesystem. Hence it makes sense to default it
>>> to yes on Exynos4 platform. While at it also fix a couple of
>>> typos in the help text.
>>>
>>> Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
>>> Cc: Doug Anderson <dianders@chromium.org>
>>>
>>
>> I'm not following that reasoning. We don't normally 'default y'
>> peripheral drivers at all, but just enable them in the defconfig.
>
> Doug and I had a small private discussion whereby defaulting commonly
> used features across platforms to 'yes' seemed sensible to avoid end users
> from trying to figure out the options and dependencies themselves when
> trying to build their own configs.
>
> Probably Doug can add more or correct me here.

Yeah, you can blame me here.  If you hate this then we can drop it.  I
spent a lot of time recently trying to track down the right magic set
of config options to get my exynos-based board to boot.  Some of the
things I tracked down could be very obviously solved with
dependencies.  Like: if you've got exynos5420 / 5800 enabled and
SMP=y, you absolutely need MCPM.  If you try to boot exynos5420 / 5800
with SMP and without MCPM it will likely keel over and die.  It's just
not a valid config.


I also found that a bunch of new configs were needed (since 3.15) to
make USB work properly all of a sudden.  Some of these were just legit
changes, but some of them seemed rather a pain (like tracking down the
exact set of PHY configs that I needed to turn on, despite having
enabled support for USB, EHCI, and the exynos5250 SoC I still needed
to specifically figure out which PHY I needed to enable?).  It seemed
like in the very least the PHY could have been enabled automatically
based on me enabling EHCI and exynos5250.


The above was made worse by the fact that exynos defconfig wasn't
being updated and I think the "multi_v7" hadn't been updated yet
either, so I had no real reference to look at.  Sure, I figured it out
but it felt like a big waste of time.


It seemed to me that for an SoC like exynos that the config system
could help you out a little bit and enable by default (but not force
on) a reasonable set of things that most people would use.  I would
believe that the large majority (if not all) exynos4 users have SDHCI
enabled since it can be used for MMC, SD, and WiFi.  On exynos5 it's
almost certain that dw_mmc should be enabled.  ...and USB should
probably also be enabled by default for exynos SoCs.  If "default y"
isn't about enabling what most people would want then why does it
exist?


Anyway, if people don't think that's useful then I won't keep pushing
for it and we can just fix the obvious ones like auto-enabling MCPM if
needed, possibly helping figure out the right USB PHY drivers...


-Doug
