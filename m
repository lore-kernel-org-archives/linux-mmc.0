From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 3/3] mmc: dw_mmc: Add locking to the CTO timer
Date: Wed, 11 Oct 2017 16:53:45 -0700
Message-ID: <CAD=FV=UcV20_Kt1LU6taXt8H-a1pmoRKjN+-XTGVZgrrS2J=EQ@mail.gmail.com>
References: <20170927205631.31559-1-dianders@chromium.org> <20170927205631.31559-4-dianders@chromium.org>
 <fa1eff8e-0fbe-caa5-6311-168e3b4c55b7@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f170.google.com ([209.85.217.170]:46512 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751459AbdJKXxr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Oct 2017 19:53:47 -0400
Received: by mail-ua0-f170.google.com with SMTP id w45so2090769uac.3
        for <linux-mmc@vger.kernel.org>; Wed, 11 Oct 2017 16:53:46 -0700 (PDT)
In-Reply-To: <fa1eff8e-0fbe-caa5-6311-168e3b4c55b7@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Brian Norris <briannorris@chromium.org>, Alexandru M Stan <amstan@chromium.org>, Ziyuan Xu <xzy.xu@rock-chips.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Emil Renner Berthing <kernel@esmil.dk>

Hi,

On Mon, Oct 9, 2017 at 12:41 AM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> Hi Doug,
>
> On 2017/9/28 4:56, Douglas Anderson wrote:
>>
>> This attempts to instill a bit of paranoia to the code dealing with
>> the CTO timer.  It's believed that this will make the CTO timer more
>> robust in the case that we're having very long interrupt latencies.
>>
>
> I have already got reports about the similar problem that on one of
> the Rockchip platforms, some IP cyclicity idle the bus too long,
> so that cto timer fires but actually it shouldn't.

So presumably this patch fixes them?


>> Note that I originally thought that perhaps this patch was being
>> overly paranoid and wasn't really needed, but then while I was running
>> mmc_test on an rk3399 board I saw one instance of the message:
>>    dwmmc_rockchip fe320000.dwmmc: Unexpected interrupt latency
>>
>
> The intention of introducing CTO and DRTO timers is simply to break the
> dead loop due to the bug of controller itself but it seems the timer
> should take more factors into consideration. So it's more complicated
> than expected, expecially we should also fix the drto case like what
> this patch does...
>
> How about combining the cto and drto timer and re-new a catch-all
> timer like what SDHCI did?

I don't think that having separate timers really adds a lot of
overhead though, does it?  gdb shows "struct timer_list" on arm64 as
being 112 bytes so I guess there's some overhead there.  ...but
presumably you'd then need to add some code to differentiate the
command timeout and data timeout.  That adds more code and more
changes and makes this patch series riskier to backport to stable
trees (and, since it fixes a regression, I think it should be
backported assuming we don't land this in time for 4.14, which is
looking unlikely).

So I guess I'd say I'll keep them as separate timers in my patch
series unless someone is really upset by it and if someone wants to
see if things are cleaner by changing it to one timer then it'd be
great!


>> @@ -2600,6 +2633,8 @@ static irqreturn_t dw_mci_interrupt(int irq, void
>> *dev_id)
>>         struct dw_mci *host = dev_id;
>>         u32 pending;
>>         struct dw_mci_slot *slot = host->slot;
>> +       unsigned long irqflags;
>> +       int i;

It was pointed out by Emil that I messed up while merging this from
the Chromium OS tree (on kernel 4.4) and accidentally added "i" in
here.  While the patch submitted compiles and works it introduces a
stupid compiler warning.

I'll re-post tomorrow.
