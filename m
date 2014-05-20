From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] s3cmci: port DMA code to dmaengine API
Date: Tue, 20 May 2014 12:39:52 +0200
Message-ID: <6897537.JWQLgZ3Zsx@wuerfel>
References: <1400522593-6366-1-git-send-email-anarsoul@gmail.com> <4667090.Oyf6jd3Lyk@wuerfel> <CA+E=qVch0K+raN4dkPK6XzXqOQc4t433UyCJ2Qnc2uymgTq7cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:61351 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752772AbaETKkF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 May 2014 06:40:05 -0400
In-Reply-To: <CA+E=qVch0K+raN4dkPK6XzXqOQc4t433UyCJ2Qnc2uymgTq7cA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ben Dooks <ben-linux@fluff.org>, broonie@kernel.org

On Tuesday 20 May 2014 13:22:35 Vasily Khoruzhick wrote:
> Hi Arnd,
> 
> On Mon, May 19, 2014 at 10:02 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > For this driver, you don't have to go that far, as long as it's
> > ensure that the pointer to the filter function is available to
> > the driver, i.e. you can't have a built-in s3mci driver when the
> > dmaengine driver is a loadable module.
> 
> OK, so I guess I need to add explicit dependency on
> CONFIG_S3C24XX_DMAC for s3cmci driver.
> 
> Btw, I didn't understand if it's acceptable to pass DMA channel number
> through DMA resource for non-DT case or not?

It's commonly done on certain SoCs, but I'd prefer to not start doing
it on those that don't do it today.

At the moment, we do it only on s3c64xx, s5p, davinci, omap1, and pxa
on ARM, as well as arch/blackfin and one MIPS machine.
I suppose we have to introduce it on s3c24xx in order to keep
supporting sound, unless we put the audio dma channels into
s3c_audio_pdata.

I think that would be a better approach, given that you also need
to put the filter function pointer for the audio stuff somewhere.

Maybe Mark Brown has a strong preference to how he wants this done
in the audio drivers, then you can do it the same way for s3cmci.


	Arnd
