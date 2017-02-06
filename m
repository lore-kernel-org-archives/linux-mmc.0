From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 08/10] mmc: block: respect bool returned from blk_end_request()
Date: Mon, 6 Feb 2017 11:36:02 +0100
Message-ID: <CACRpkdbb8ehG5Ci4EU0a6YKbeuukqYZsdoOxFsSic-c80afoOA@mail.gmail.com>
References: <20170201124800.13865-1-linus.walleij@linaro.org>
 <20170201124800.13865-9-linus.walleij@linaro.org> <CAPDyKFq8YygebEL7OSo0ApoeVXUk1tuu5k1K1ZuCWozd8yFsTg@mail.gmail.com>
 <CACRpkdZY6r+8DVETo5KYC6Ph=vDXKMfgHgmh6dg=yk2Gw=pMHQ@mail.gmail.com>
 <CAK8P3a05c25nVb4rhh2wkgn9o-W1R5j0kbPeMehN8ViYVA1t1w@mail.gmail.com> <CAPDyKFpgeqEf7u4==4u6YWidK+n59TX2CL+Hp4vSXyg5EanvHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:35632 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751093AbdBFKgE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Feb 2017 05:36:04 -0500
Received: by mail-io0-f182.google.com with SMTP id j18so62270668ioe.2
        for <linux-mmc@vger.kernel.org>; Mon, 06 Feb 2017 02:36:03 -0800 (PST)
In-Reply-To: <CAPDyKFpgeqEf7u4==4u6YWidK+n59TX2CL+Hp4vSXyg5EanvHw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>

On Mon, Feb 6, 2017 at 10:54 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 6 February 2017 at 10:07, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Fri, Feb 3, 2017 at 1:57 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>>>>>         if (mmc_card_removed(card))
>>>>>                 req->rq_flags |= RQF_QUIET;
>>>>> -       while (ret)
>>>>> -               ret = blk_end_request(req, -EIO,
>>>>> -                                     blk_rq_cur_bytes(req));
>>>>> +       while (blk_end_request(req, -EIO, blk_rq_cur_bytes(req)))
>>>>> +       {
>>>>> +       }
>>>>
>>>> These brackets isn't needed, so am going to change this before applying.
>>>>
>>>> while (blk_end_request(req, -EIO, blk_rq_cur_bytes(req)));
>>>
>>> Aha you know your C syntax better than me. Looks like something that
>>> checkpatch should catch actually, but I ran this through checkpatch and
>>> it didn't complain.
>>
>> IIRC gcc-7 will warn about Ulf's version, as it is a bit misleading and can
>> lead to subtle bugs like
>>
>>    int ret = 0;
>>    while (!ret);
>>         ret = do_something();
>>
>> which would pass a casual review but is actually an endless loop.
>>
>>     Arnd
>
> Okay, seems reasonable. However mine version is already being used at
> some places in the kernel.
>
> Linus version, was actually complained by checkpatch. Perhaps me an
> Linus ran different versions of check patch.

I might have missed it. It complained when I had:

while (cond)
{
};

about the semicolon in the end... maybe there was another complaint
too.

> So, then which version is preferred here?
>
> Perhaps something like this is the best?
>
> while (1) {
>      ret = do_something();
>      if (!ret)
>          break;
> }

Actually in this case the whole while() thing looks a bit bogus:
it is just hammering the block layer to end the request.

I guess since there is no way to return any unfinished status
upward.

True, I preserved that strange semantic, but what should we
really do? Timeout and complain in dmesg?

It just looks dangerous.

Anyways let's address any issues with follow-up patches...

Yours,
Linus Walleij
