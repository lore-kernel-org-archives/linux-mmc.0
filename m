From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: block: Move files to core
Date: Mon, 12 Dec 2016 16:42:41 +0100
Message-ID: <CAPDyKFqJvZAngzcDDQ649Kwh6fXMcoj6OOFJfAPc97zRZ5WOZQ@mail.gmail.com>
References: <CGME20161208234917epcas4p4ecd9cfb88927dc4bcf72ebf015d63a32@epcas4p4.samsung.com>
 <1481240892-2431-1-git-send-email-ulf.hansson@linaro.org> <30bf2f3e-ccc2-f84a-7b05-053933a46c94@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wj0-f171.google.com ([209.85.210.171]:35278 "EHLO
        mail-wj0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752188AbcLLPmo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Dec 2016 10:42:44 -0500
Received: by mail-wj0-f171.google.com with SMTP id v7so75727634wjy.2
        for <linux-mmc@vger.kernel.org>; Mon, 12 Dec 2016 07:42:43 -0800 (PST)
In-Reply-To: <30bf2f3e-ccc2-f84a-7b05-053933a46c94@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

On 9 December 2016 at 01:14, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Dear Ulf,
>
> On 12/09/2016 08:48 AM, Ulf Hansson wrote:
>> Once upon a time it made sense to keep the mmc block device driver and its
>> related code, in its own directory called card. Over time, more an more
>> functions/structures have become shared through generic mmc header files,
>> between the core and the card directory. In other words, the relationship
>> between them has become closer.
>>
>> By sharing functions/structures via generic header files, it becomes easy
>> for outside users to abuse them. In a way to avoid that from happen, let's
>> move the files from card directory into the core directory, as it enables
>> us to move definitions of functions/structures into mmc core specific
>> header files.
>>
>> Note, this is only the first step in providing a cleaner mmc interface for
>> outside users. Following changes will do the actual cleanup, as that is not
>> part of this change.
>
> Just minor question, Does it keep the below comments?
>
> drivers/mmc/core/mmc_test.c:2: *  linux/drivers/mmc/card/mmc_test.c
> drivers/mmc/core/queue.c:2: *  linux/drivers/mmc/card/queue.c
> drivers/mmc/core/sdio_uart.c:2: * linux/drivers/mmc/card/sdio_uart.c - SDIO UART/GPS driver
>
> After moving files to core, can they be changed?
> Is it more comfortable than changing now?

I have applied this change for my next branch, with the changes you
recommend above. Thanks for noticing this!

I will send a second PR for 4.10, with only this change - as to get a
nice and fresh start for 4.11.

[...]

Kind regards
Uffe
