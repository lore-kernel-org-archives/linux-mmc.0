From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 08/10] mmc: block: respect bool returned from blk_end_request()
Date: Mon, 6 Feb 2017 10:07:34 +0100
Message-ID: <CAK8P3a05c25nVb4rhh2wkgn9o-W1R5j0kbPeMehN8ViYVA1t1w@mail.gmail.com>
References: <20170201124800.13865-1-linus.walleij@linaro.org>
 <20170201124800.13865-9-linus.walleij@linaro.org> <CAPDyKFq8YygebEL7OSo0ApoeVXUk1tuu5k1K1ZuCWozd8yFsTg@mail.gmail.com>
 <CACRpkdZY6r+8DVETo5KYC6Ph=vDXKMfgHgmh6dg=yk2Gw=pMHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34768 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750953AbdBFJHf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Feb 2017 04:07:35 -0500
Received: by mail-oi0-f68.google.com with SMTP id w144so6028199oiw.1
        for <linux-mmc@vger.kernel.org>; Mon, 06 Feb 2017 01:07:34 -0800 (PST)
In-Reply-To: <CACRpkdZY6r+8DVETo5KYC6Ph=vDXKMfgHgmh6dg=yk2Gw=pMHQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>

On Fri, Feb 3, 2017 at 1:57 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>>>         if (mmc_card_removed(card))
>>>                 req->rq_flags |= RQF_QUIET;
>>> -       while (ret)
>>> -               ret = blk_end_request(req, -EIO,
>>> -                                     blk_rq_cur_bytes(req));
>>> +       while (blk_end_request(req, -EIO, blk_rq_cur_bytes(req)))
>>> +       {
>>> +       }
>>
>> These brackets isn't needed, so am going to change this before applying.
>>
>> while (blk_end_request(req, -EIO, blk_rq_cur_bytes(req)));
>
> Aha you know your C syntax better than me. Looks like something that
> checkpatch should catch actually, but I ran this through checkpatch and
> it didn't complain.

IIRC gcc-7 will warn about Ulf's version, as it is a bit misleading and can
lead to subtle bugs like

   int ret = 0;
   while (!ret);
        ret = do_something();

which would pass a casual review but is actually an endless loop.

    Arnd
