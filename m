From: Andrew Bresticker <abrestic@chromium.org>
Subject: Re: [PATCH] mmc: dw_mmc: Turn the card clock off at suspend time
Date: Wed, 19 Nov 2014 11:49:32 -0800
Message-ID: <CAL1qeaFcdaxLYQu5y4pz-d29SdRA79TpkrRA9VjUYaMfnoSeVw@mail.gmail.com>
References: <1416423073-8105-1-git-send-email-dianders@chromium.org>
	<CAL1qeaGkQVimrFNtGgfTJEHNemG_QUTecQwH4=nXu1_u1rWwhg@mail.gmail.com>
	<CAD=FV=UjvQ5Sgfv_-WzvZpOvofA=7Vpzh36LavCwqGV1-0_aHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f178.google.com ([209.85.220.178]:64938 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755576AbaKSTtd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Nov 2014 14:49:33 -0500
Received: by mail-vc0-f178.google.com with SMTP id hq11so120690vcb.9
        for <linux-mmc@vger.kernel.org>; Wed, 19 Nov 2014 11:49:32 -0800 (PST)
In-Reply-To: <CAD=FV=UjvQ5Sgfv_-WzvZpOvofA=7Vpzh36LavCwqGV1-0_aHQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Heiko Stuebner <heiko@sntech.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Chris Ball <chris@printf.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Doug,

On Wed, Nov 19, 2014 at 11:30 AM, Doug Anderson <dianders@chromium.org> wrote:
> Andrew,
>
> On Wed, Nov 19, 2014 at 11:03 AM, Andrew Bresticker
> <abrestic@chromium.org> wrote:
>> Doug,
>>
>> On Wed, Nov 19, 2014 at 10:51 AM, Doug Anderson <dianders@chromium.org> wrote:
>>> Since the dw_mmc driver was first added to Linux it's had a TODO in it
>>> that we should turn off the card clock during suspend.  I have no idea
>>> for sure why it wasn't done originally, but if I had to guess I'd
>>> guess it was related to the lack of a common clock framework.  Let's
>>> do it now.
>>>
>>> There is no reason for the card clock to be left on during suspend and
>>> most systems will eventually turn it off anyway (when whole clock
>>> trees are disabled).  However, it's good to be explicit that it's
>>> disabled at the time that the MMC subsystem is disabled.
>>
>> Should the bus clock (biu) be disabled as well?
>
> Good question.  I'm slightly hesitant to turn biu_clk off in this
> patch, though.  Specifically interrupts are still enabled at this
> point in suspend.  I  guess most interrupts shouldn't be going off
> right now (nobody is accessing storage, right?), but I could imagine
> that a card detect or an SDIO interrupt at just the wrong time could
> cause our ISR to go off _after_ this function is called.  The
> interrupt handling function doesn't know to turn the BIU clock back on
> so you'd get a hang.

Perhaps interrupts should be disabled as well across suspend/resume,
like the sdhci-based hosts do?  Would would happen if we tried to
service an interrupt with the ciu clock disabled?
