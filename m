From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 08/10] mmc: block: respect bool returned from blk_end_request()
Date: Fri, 3 Feb 2017 13:57:37 +0100
Message-ID: <CACRpkdZY6r+8DVETo5KYC6Ph=vDXKMfgHgmh6dg=yk2Gw=pMHQ@mail.gmail.com>
References: <20170201124800.13865-1-linus.walleij@linaro.org>
 <20170201124800.13865-9-linus.walleij@linaro.org> <CAPDyKFq8YygebEL7OSo0ApoeVXUk1tuu5k1K1ZuCWozd8yFsTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:36658 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752496AbdBCM5j (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Feb 2017 07:57:39 -0500
Received: by mail-io0-f173.google.com with SMTP id j13so16561178iod.3
        for <linux-mmc@vger.kernel.org>; Fri, 03 Feb 2017 04:57:38 -0800 (PST)
In-Reply-To: <CAPDyKFq8YygebEL7OSo0ApoeVXUk1tuu5k1K1ZuCWozd8yFsTg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>

On Fri, Feb 3, 2017 at 10:52 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> [...]
>>  static void mmc_blk_rw_cmd_abort(struct mmc_card *card, struct request *req)
>>  {
>> -       int ret = 1;
>> -
>>         if (mmc_card_removed(card))
>>                 req->rq_flags |= RQF_QUIET;
>> -       while (ret)
>> -               ret = blk_end_request(req, -EIO,
>> -                                     blk_rq_cur_bytes(req));
>> +       while (blk_end_request(req, -EIO, blk_rq_cur_bytes(req)))
>> +       {
>> +       }
>
> These brackets isn't needed, so am going to change this before applying.
>
> while (blk_end_request(req, -EIO, blk_rq_cur_bytes(req)));

Aha you know your C syntax better than me. Looks like something that
checkpatch should catch actually, but I ran this through checkpatch and
it didn't complain.

Yours,
Linus Walleij
