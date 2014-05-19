From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] s3cmci: port DMA code to dmaengine API
Date: Mon, 19 May 2014 21:02:55 +0200
Message-ID: <4667090.Oyf6jd3Lyk@wuerfel>
References: <1400522593-6366-1-git-send-email-anarsoul@gmail.com> <7633675.1cAc12AFAY@wuerfel> <CA+E=qVeG8bXowBvdhKpVSYSL08n6ZUVG2LkjhPwjBnbv+egNLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:64797 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753704AbaESTC7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 May 2014 15:02:59 -0400
In-Reply-To: <CA+E=qVeG8bXowBvdhKpVSYSL08n6ZUVG2LkjhPwjBnbv+egNLw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Chris Ball <chris@printf.net>, Ben Dooks <ben-linux@fluff.org>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, arm-linux <linux-arm-kernel@lists.infradead.org>

On Monday 19 May 2014 21:54:28 Vasily Khoruzhick wrote:
> On Mon, May 19, 2014 at 9:18 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Monday 19 May 2014 21:03:13 Vasily Khoruzhick wrote:
> >> Utilise new s3c24xx-dma dmaengine driver for DMA ops.
> >>
> >> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> 
> > - I did not remove MMC_S3C_PIODMA, but I don't see anything wrong
> >   with yours there
> 
> It didn't work even with legacy code for me. I don't want to fix it,
> so it's just dropped.
> Anyway, I don't see much sense in PIODMA mode.

Ah, that makes sense.

> > - the slave config setup is slightly different
> 
> Yep.
> 
> > - I hardcode the DMA request number, while you pass it as a resource.
> >   Actually both are wrong I guess, it should be platform data instead.
> 
> Well, at least s3c64xx uses resources for passing dma channel number,
> and so did I.
> Btw, It'll make transition to device tree a bit easier.

Actually it doesn't help with the transition to DT at all, because DT
does not use resources for DMA requests. Instead there is a
dma_request_slave_channel() interface that gets passed a string to
match the DT descriptor of the DMA channel. If you want to enable
DT probing while keeping the traditional way alive, you can
use dma_request_slave_channel_compat(), although I find it not
much easier than open-coding it.

There is one issue with dma_request_slave_channel_compat and
dma_request_channel, which is that you need a pointer to the
filter function. In portable drivers that pointer should get passed
in platform_data for the non-DT case, along with the data it
needs, because there are dma engines that need more than just
an integer to identify a slave.

For this driver, you don't have to go that far, as long as it's
ensure that the pointer to the filter function is available to
the driver, i.e. you can't have a built-in s3mci driver when the
dmaengine driver is a loadable module.

> There's one more difference: original s3cmci doesn't restore prescaler
> value when necessary on s3c2410,
> my version has a fix for it.

Ok.

	Arnd
