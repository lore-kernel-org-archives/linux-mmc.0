From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3] s3cmci: port DMA code to dmaengine API
Date: Tue, 8 Jul 2014 14:51:01 +0200
Message-ID: <CAPDyKFoVtJLyBrjwyQYKK6h=8aNd7+SMYU9bS8iStcSZkWs3Fw@mail.gmail.com>
References: <1401643329-6460-1-git-send-email-anarsoul@gmail.com>
	<CA+E=qVf2QWk+HxPTjwFK8BkD3C+EGbvLDMM4ro1_nYEThe=LtQ@mail.gmail.com>
	<CA+E=qVeS8DXTz6b9NnVNi4gFufMkf+iUrOU1A0+Ja8ehnBsrhQ@mail.gmail.com>
	<201407072312.40687.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:56914 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753598AbaGHMvJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Jul 2014 08:51:09 -0400
Received: by mail-qa0-f45.google.com with SMTP id s7so793174qap.32
        for <linux-mmc@vger.kernel.org>; Tue, 08 Jul 2014 05:51:08 -0700 (PDT)
In-Reply-To: <201407072312.40687.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, arm-linux <linux-arm-kernel@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Jaehoon Chung <jh80.chung@samsung.com>, Mark Brown <broonie@kernel.org>, Ben Dooks <ben-linux@fluff.org>

On 7 July 2014 23:12, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 07 July 2014, Vasily Khoruzhick wrote:
>> On Mon, Jun 30, 2014 at 10:03 PM, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>> > On Mon, Jun 23, 2014 at 2:31 PM, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>> >>
>> >> On 1 June 2014 20:22:09 Vasily Khoruzhick wrote:
>> >> > Utilise new s3c24xx-dma dmaengine driver for DMA ops.
>> >> >
>> >> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
>> >> > ---
>> >> > v2: - Don't store async dma descriptor, it's not used
>> >> >     - Request DMA channel via dma_request_slave_channel_compat() and use
>> >> >       hardcoded DMA channel.
>> >> >     - Add dependency on S3C24XX_DMAC (s3cmci uses filter function from it)
>> >> > v3: - Use 'depends' instead of 'select' in Kconfig
>> >> >     - Drop useless controller registers reads from dma completion callback
>> >>
>> >> Ping?
>> >
>> > Ping?
>>
>> Could anyone tell me through which tree this patch should be merged?
>> I'm pretty sure that I've included everyone from get_maintainer.pl
>> output
>> except LKML, but no response from maintainer so far.
>
> I think you did everything right, Ulf or Chris should really pick up this
> patch. The one thing you could improve is the changeset text which you
> wrote as "Utilise new s3c24xx-dma dmaengine driver for DMA ops." What we
> really need here is an explanation of why we want this, e.g. what problems
> are solved by it etc. I definitely really want this patch as part of 3.17
> so we can enabled multiplatform for the platforms that use this driver.
>
> You should also list the
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> line under your "Signed-off-by" line.
>
>         Arnd


Sorry for the delay.

Thanks! Applied for next with Arnd's ack.

Kind regards
Uffe
