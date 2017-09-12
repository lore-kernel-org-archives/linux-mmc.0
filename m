From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: 4.13 on thinkpad x220: oops when writing to SD card
Date: Tue, 12 Sep 2017 11:42:20 +0200
Message-ID: <CACRpkdb84DnU=f8RpRH2fiUcT6OYcbVLUEiLBfOdApo9g9Ehww@mail.gmail.com>
References: <20170905194739.GA31241@amd> <8f0f7310-ea4d-a200-75fd-23509947fb38@rock-chips.com>
 <6689241f-a4d8-7a3e-9f0b-482b034e5710@intel.com> <CAPDyKFqXaDFrJH1-YSSCx0xPXfMN99AM_Wu_sWQf5A6bw+zjdQ@mail.gmail.com>
 <CACRpkdb263SS-7H1wcp0THAwzKO7A-kE0DVUdTiuxTnuXtWVVw@mail.gmail.com> <b640c98b-c534-9d66-3136-d7ca47387af9@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:35491 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751398AbdILJmW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Sep 2017 05:42:22 -0400
Received: by mail-io0-f174.google.com with SMTP id g32so25653565ioj.2
        for <linux-mmc@vger.kernel.org>; Tue, 12 Sep 2017 02:42:22 -0700 (PDT)
In-Reply-To: <b640c98b-c534-9d66-3136-d7ca47387af9@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>, Seraphime Kirkovski <kirkseraph@gmail.com>

On Fri, Sep 8, 2017 at 4:51 AM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> On 2017/9/8 4:02, Linus Walleij wrote:
>> On Thu, Sep 7, 2017 at 9:18 AM, Ulf Hansson <ulf.hansson@linaro.org>
>> wrote:
>>
>>> Even if this fixes the problem it seems like we are papering over the
>>> real issue, which earlier fixes also did during the release cycle for
>>> v4.13.
>>
>>
>> I think this is the real solution to the issue.
>>
>>>> Another unrelated issue with mmc_init_request() is that
>>>> mmc_exit_request()
>>>> is not called if mmc_init_request() fails, which means
>>>> mmc_init_request()
>>>> must free anything it allocates when it fails.
>>>
>>>
>>> Yes, the situations it's just too fragile. We need to fix the behavior
>>> properly, although I haven't myself been able to investigate exactly
>>> how yet.
>>>
>>> Adding, Linus, perhaps he has some ideas.
>>
>>
>> Maybe we should simply bite the bullet and do what was suggested
>> by another contributor when I refactored the bounce buffer handling:
>> simply delete the bounce buffer code and let any remaining (few?)
>> legacy devices suffer a bit (performancewise) at the gain of way
>> simpler code?
>
> Are you in the same page with what Adrian pointed to?
>
> IIUC, the issue is:
> init_rq_fn will be called each time when trying to create new reuqest
> from the pre-allocated request_list memeory pool, and exit_rq_fn will is
> in the corresponding routine to free request from request_list
> (blk_free_request) when finished. But if alloc_request_size fails, it
> won't call exit_rq_fn, so you need to prevent memory leak on your own
> error path of init_rq_fn.

Yes and that is what the current patch fixes, is it not?

> But you seem to talk about removing the bounce buffer and so finally
> get rid of registering init_rq_fn/exit_rq_fn?

That is in direct response to Ulf's statement
"the situations it's just too fragile" and what can be done about
that is not make the code even more complex but make it
simpler and easier to follow.

One way to achieve that in the long term, is to delete bounce
buffer handling since it adds overhead and complexity.

> That is another thing,
> and what we right now need to do is to fix the pontential memory leak.
> It's quite a simple action, right? :)

It is another thing.

This patch fixes a memory leak, but Ulf is asking how we may
avoid fragile behaviour.

>> I am a bit hesitant about that because Pierre Ossman said it was
>> actually a big win on the SDHC hosts that made use of it at one
>> point.
>
> You had removed packed cmd support to simplify the code, so I think
> this is another trade-off need to ask: What you want? and keep
> consistent with the direction you insisted on.

Packed command could be removed because it was not used by
any in-tree code. See
commit 03d640ae1f9b24b1d2a11f747143a1ecc0745019

Bounce buffers on the other hand, as this patch shows, is very much
in use. So if they e.g. improve throughput on these systems
(mainly laptops I think?) it should definately be kept around.

It might be a good idea to make a patch to remove the bounce
buffers and ask people to do before/after throughput tests,
because I do not have this hardware myself. If it doesn't provide
any throughput improvements to any system in use, it should
be deleted. But I don't know that yet.

Yours,
Linus Walleij
