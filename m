From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 08/10] mmc: block: respect bool returned from blk_end_request()
Date: Mon, 6 Feb 2017 13:08:50 +0100
Message-ID: <CAPDyKFq-Rd5pHLVMoCxCvN+0NTZKfg5DKm7pAQk3Y4uCX_+46g@mail.gmail.com>
References: <20170201124800.13865-1-linus.walleij@linaro.org>
 <20170201124800.13865-9-linus.walleij@linaro.org> <CAPDyKFq8YygebEL7OSo0ApoeVXUk1tuu5k1K1ZuCWozd8yFsTg@mail.gmail.com>
 <CACRpkdZY6r+8DVETo5KYC6Ph=vDXKMfgHgmh6dg=yk2Gw=pMHQ@mail.gmail.com>
 <CAK8P3a05c25nVb4rhh2wkgn9o-W1R5j0kbPeMehN8ViYVA1t1w@mail.gmail.com>
 <CAPDyKFpgeqEf7u4==4u6YWidK+n59TX2CL+Hp4vSXyg5EanvHw@mail.gmail.com> <CACRpkdbb8ehG5Ci4EU0a6YKbeuukqYZsdoOxFsSic-c80afoOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38256 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751895AbdBFMIw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Feb 2017 07:08:52 -0500
Received: by mail-wm0-f42.google.com with SMTP id r141so111144395wmg.1
        for <linux-mmc@vger.kernel.org>; Mon, 06 Feb 2017 04:08:52 -0800 (PST)
In-Reply-To: <CACRpkdbb8ehG5Ci4EU0a6YKbeuukqYZsdoOxFsSic-c80afoOA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>

>> Perhaps something like this is the best?
>>
>> while (1) {
>>      ret = do_something();
>>      if (!ret)
>>          break;
>> }
>
> Actually in this case the whole while() thing looks a bit bogus:
> it is just hammering the block layer to end the request.
>
> I guess since there is no way to return any unfinished status
> upward.
>
> True, I preserved that strange semantic, but what should we
> really do? Timeout and complain in dmesg?
>
> It just looks dangerous.
>
> Anyways let's address any issues with follow-up patches...

Agreed!

Kind regards
Uffe
