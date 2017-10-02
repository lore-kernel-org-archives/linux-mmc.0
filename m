From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: 4.14-rc2 on thinkpad x220: out of memory when inserting mmc card
Date: Mon, 2 Oct 2017 16:09:57 +0200
Message-ID: <CACRpkdYirC+rh_KALgVqKZMjq2DgbW4oi9MJkmrzwn+1O+94-g@mail.gmail.com>
References: <20170905194739.GA31241@amd> <20171001093704.GA12626@amd>
 <20171001102647.GA23908@amd> <201710011957.ICF15708.OOLOHFSQMFFVJt@I-love.SAKURA.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:54649 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751101AbdJBOJ7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Oct 2017 10:09:59 -0400
Received: by mail-io0-f170.google.com with SMTP id h66so4801898ioh.11
        for <linux-mmc@vger.kernel.org>; Mon, 02 Oct 2017 07:09:58 -0700 (PDT)
In-Reply-To: <201710011957.ICF15708.OOLOHFSQMFFVJt@I-love.SAKURA.ne.jp>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Pavel Machek <pavel@ucw.cz>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-mm@kvack.org

On Sun, Oct 1, 2017 at 12:57 PM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:

>> > I inserted u-SD card, only to realize that it is not detected as it
>> > should be. And dmesg indeed reveals:
>>
>> Tetsuo asked me to report this to linux-mm.
>>
>> But 2^4 is 16 pages, IIRC that can't be expected to work reliably, and
>> thus this sounds like MMC bug, not mm bug.


I'm not sure I fully understand this error message:
"worker/2:1: page allocation failure: order:4"

What I guess from context is that the mmc_init_request()
call is failing to allocate 16 pages, meaning for 4K pages
64KB which is the typical bounce buffer.

This is what the code has always allocated as bounce buffer,
but it used to happen upfront, when probing the MMC block layer,
rather than when allocating the requests.

Now it happens later, and that fails sometimes apparently.

> Yes, 16 pages is costly allocations which will fail without invoking the
> OOM killer. But I thought this is an interesting case, for mempool
> allocation should be able to handle memory allocation failure except
> initial allocations, and initial allocation is failing.
>
> I think that using kvmalloc() (and converting corresponding kfree() to
> kvfree()) will make initial allocations succeed, but that might cause
> needlessly succeeding subsequent mempool allocations under memory pressure?

Using kvmalloc() is against the design of the bounce buffer if that
means we allocate virtual (non-contigous) memory. These bounce
buffers exist exactly to be contigous.

I think it is better to delete the bounce buffer handling altogether since
it anyways turns out that noone is using them or getting any
benefit from them. AFAICT.
i.e. just cherry-pick commit a16a2cc4f37d4a35df7cdc5c976465f9867985c2
("mmc: Delete bounce buffer handling").

This should be fine to cherry-pick for fixes.

What we figured out is that bounce buffers are almost always enabled
but very seldom actually used by the drivers. It is only used by
drivers with max_segs == 1.

This MMC host driver (which one?) appears to be having max_segs == 1.
This doesn't mean that the bounce buffers actually provide a speedup.
Most probably not. It just happens that code enables them if
you have max_segs == 1.

Can you try cherry-picking the above patch, also here:
https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git/commit/?h=next&id=a16a2cc4f37d4a35df7cdc5c976465f9867985c2

And see if this solves your problem?

Yours,
Linus Walleij
