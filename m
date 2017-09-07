From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: 4.13 on thinkpad x220: oops when writing to SD card
Date: Thu, 7 Sep 2017 09:18:50 +0200
Message-ID: <CAPDyKFqXaDFrJH1-YSSCx0xPXfMN99AM_Wu_sWQf5A6bw+zjdQ@mail.gmail.com>
References: <20170905194739.GA31241@amd> <8f0f7310-ea4d-a200-75fd-23509947fb38@rock-chips.com>
 <6689241f-a4d8-7a3e-9f0b-482b034e5710@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:36400 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754279AbdIGHSv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Sep 2017 03:18:51 -0400
Received: by mail-io0-f179.google.com with SMTP id d16so2204649ioj.3
        for <linux-mmc@vger.kernel.org>; Thu, 07 Sep 2017 00:18:51 -0700 (PDT)
In-Reply-To: <6689241f-a4d8-7a3e-9f0b-482b034e5710@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Pavel Machek <pavel@ucw.cz>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>, Seraphime Kirkovski <kirkseraph@gmail.com>, Linus Walleij <linus.walleij@linaro.org>

+ Linus

On 6 September 2017 at 08:03, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 06/09/17 05:44, Shawn Lin wrote:
>> + Seraphime
>>
>> On 2017/9/6 3:47, Pavel Machek wrote:
>>> Hi!
>>>
>>> I tried to write to the MMC card; process hung and I got this in the
>>> dmesg.
>>
>>
>> A similar report for 4.13 cycle was here:
>>
>> https://lkml.org/lkml/2017/8/10/824
>>
>> Seems 4.13-rc4 was already broken for that but unfortuantely I didn't
>> reproduce that. So maybe Seraphime can do git-bisect as he said "I get
>> it everytime" for which I assume it could be easy for him to find out
>> the problematic commit?
>>
>
> One obvious weakness in the new mmc_init_request() is the possibility
> that it might be called before card->bouncesz is set up.  That could
> result in bouncing being done but mq_rq->bounce_sg is null.
> This might help:
>
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index affa7370ba82..ad3e53e63abb 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -242,6 +242,8 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
>         if (mmc_dev(host)->dma_mask && *mmc_dev(host)->dma_mask)
>                 limit = (u64)dma_max_pfn(mmc_dev(host)) << PAGE_SHIFT;
>
> +       card->bouncesz = mmc_queue_calc_bouncesz(host);
> +
>         mq->card = card;
>         mq->queue = blk_alloc_queue(GFP_KERNEL);
>         if (!mq->queue)
> @@ -265,7 +267,6 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
>         if (mmc_can_erase(card))
>                 mmc_queue_setup_discard(mq->queue, card);
>
> -       card->bouncesz = mmc_queue_calc_bouncesz(host);
>         if (card->bouncesz) {
>                 blk_queue_max_hw_sectors(mq->queue, card->bouncesz / 512);
>                 blk_queue_max_segments(mq->queue, card->bouncesz / 512);
>

Even if this fixes the problem it seems like we are papering over the
real issue, which earlier fixes also did during the release cycle for
v4.13.

Anyway I am happy to apply this as fix for 4.14, if Seraphime/Pavel
can report it solved the problem. Could you send a proper patch with
some changlog please?

I would also appreciate if can add you a small comment in the code,
why moving this line is needed.

>
> Another unrelated issue with mmc_init_request() is that mmc_exit_request()
> is not called if mmc_init_request() fails, which means mmc_init_request()
> must free anything it allocates when it fails.

Yes, the situations it's just too fragile. We need to fix the behavior
properly, although I haven't myself been able to investigate exactly
how yet.

Adding, Linus, perhaps he has some ideas.

Kind regards
Uffe
