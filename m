From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: Remove MMC_CLKGATE
Date: Mon, 12 Oct 2015 13:01:27 +0200
Message-ID: <CAPDyKFpzT_GARg5_uK5POCWxbgcjThCmB5E09MTWOHnRRbAZ-g@mail.gmail.com>
References: <1443776171-7127-1-git-send-email-ulf.hansson@linaro.org>
	<CAPDyKFooaDekXEf9uEkU6Wgd2dhS409RK8i_qi3eB5-GVUHVQw@mail.gmail.com>
	<CALk7dXpj=LdLb3pYbVV1e3Qt1KWAvtfaoEu2eQVdSdPmGLyrTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:36659 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbbJLLB2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Oct 2015 07:01:28 -0400
Received: by wicgb1 with SMTP id gb1so144195279wic.1
        for <linux-mmc@vger.kernel.org>; Mon, 12 Oct 2015 04:01:27 -0700 (PDT)
In-Reply-To: <CALk7dXpj=LdLb3pYbVV1e3Qt1KWAvtfaoEu2eQVdSdPmGLyrTQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>

On 12 October 2015 at 09:53, Ritesh Harjani <ritesh.list@gmail.com> wrote:
> Hi Ulf,
>
> Wanted to understand this better, related to clk-gating and runtime-PM
> before we completely remove clk-gating functionality.
> Inline queries -
>
>
> On Thu, Oct 8, 2015 at 11:05 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 2 October 2015 at 10:56, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> MMC_CLKGATE was once invented to save power by gating the bus clock at
>>> request inactivity. At that time it served its purpose. The modern way to
>>> deal with power saving for these scenarios, is by using runtime PM.
>
> Inactivity duration of clk-gating and runtime PM can actually vary largely.
> clk-gating can be used to turn the clks-off after a very short
> duration of request inactivity say 200ms - (which can be used to save
> the power of some voltage rail or something)
> While runtime-PM would need ~10sec since it involves chain of devices
> to be suspended.

What do you mean by "chain of devices"?

You may refer to that runtime PM respect parent/child relations, but
even so, each device can be runtime PM managed on its own.

Regarding the inactivity duration, currently most mmc host drivers
which have enabled the runtime PM autosuspend feature, uses 50 ms as
the *default* timeout value.
I haven't heard of anyone considering a ~10s or in that range, but if
that's the case I guess power saving is just less important for these
cases.

>
> For that to happen, we would need a longer duration of request
> inactivity otherwise we would end up loosing power
> if suspend keeps failing and often resumes are done to serve the request.

Why would suspend fail?

>
>
> So, do you suggest to use runtime-PM in a way that can be used to gate
> the clks-off in shorter duration and
> then schedule the work for suspending of devices after longer duration
> of request inactivity.

Well, what I suggested was to remove MMC_CLKGATE and use runtime PM instead. :-)

It seem like you think you need an intermediate phase, where clock
gating make sense in the first phase and the actual runtime_suspend of
the device in second phase. I have yet understood why, but if I assume
that's the case one could potentially use the ->runtime_idle()
callback and friends, to deal with this.

>
> Sorry, if I am sounding foolish at any place, but I would like to
> understand how are we handling the above problem if we remove
> clk-gating?

No, worries - thanks for you comments!

Kind regards
Uffe
