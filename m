From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH] s3cmci: port DMA code to dmaengine API
Date: Mon, 19 May 2014 21:54:28 +0300
Message-ID: <CA+E=qVeG8bXowBvdhKpVSYSL08n6ZUVG2LkjhPwjBnbv+egNLw@mail.gmail.com>
References: <1400522593-6366-1-git-send-email-anarsoul@gmail.com> <7633675.1cAc12AFAY@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:49639 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302AbaESSyu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 May 2014 14:54:50 -0400
Received: by mail-oa0-f47.google.com with SMTP id i7so6722152oag.6
        for <linux-mmc@vger.kernel.org>; Mon, 19 May 2014 11:54:49 -0700 (PDT)
In-Reply-To: <7633675.1cAc12AFAY@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Chris Ball <chris@printf.net>, Ben Dooks <ben-linux@fluff.org>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, arm-linux <linux-arm-kernel@lists.infradead.org>

On Mon, May 19, 2014 at 9:18 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 19 May 2014 21:03:13 Vasily Khoruzhick wrote:
>> Utilise new s3c24xx-dma dmaengine driver for DMA ops.
>>
>> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

Hi Arnd,

> Very nice!

Thanks! :)

> I had done a similar conversion earlier but not tested and only
> posted in a reply to another thread. I'd assume that your
> version is better and that you have actually tested it, but just
> for reference, here is what I had. Maybe it helps you to take
> a look at my version to see if there is something you missed.

Hm, I did search for s3c24xx-i2s conversion, but didn't for s3cmci, my fault.
Your version looks pretty close to mine, however I don't think that
much variations
are possible here. I've tested mine on s3c2410 machine.

> Here are the differences I found:
>
> - I don't save the 'desc' pointer as you do, but I don't see it used
>   anywhere.

Yeah, I should remove it. Will send v2 shortly.

> - I did not remove MMC_S3C_PIODMA, but I don't see anything wrong
>   with yours there

It didn't work even with legacy code for me. I don't want to fix it,
so it's just dropped.
Anyway, I don't see much sense in PIODMA mode.

> - the slave config setup is slightly different

Yep.

> - I hardcode the DMA request number, while you pass it as a resource.
>   Actually both are wrong I guess, it should be platform data instead.

Well, at least s3c64xx uses resources for passing dma channel number,
and so did I.
Btw, It'll make transition to device tree a bit easier.

There's one more difference: original s3cmci doesn't restore prescaler
value when necessary on s3c2410,
my version has a fix for it.

>         Arnd

Regards
Vasily
