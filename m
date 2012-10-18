From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH] dma: add new DMA control commands
Date: Thu, 18 Oct 2012 09:14:58 +0200
Message-ID: <201210180914.58527.marex@denx.de>
References: <1350538335-29026-1-git-send-email-b32955@freescale.com> <1350541111.5263.3.camel@vkoul-udesk3> <507FA595.4020507@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <507FA595.4020507-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Vinod Koul <vinod.koul-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, djbw-b10kYP2dOMg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, artem.bityutskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, Huang Shijie <shijie8-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Dear Huang Shijie,

Why such massive CC ?

> =E4=BA=8E 2012=E5=B9=B410=E6=9C=8818=E6=97=A5 14:18, Vinod Koul =E5=86=
=99=E9=81=93:
> > Why cant you do start (prepare clock etc) when you submit the descr=
iptor
> > to dmaengine. Can be done in tx_submit callback.
> > Similarly remove the clock when dma transaction gets completed.
>=20
> I ever thought this method too.
>=20
> But it will become low efficient in the following case:
>=20
>    Assuming the gpmi-nand driver has to read out 1024 pages in one
> _SINGLE_ read operation.
> The gpmi-nand will submit the descriptor to dmaengine per page.

It will? Then GPMI NAND is flat our broken ... again.

> So with
> your method,
> the system will repeat the enable/disable dma clock 1024 time.

Yes, it is the driver that's wrong.

> At every
> enable/disable dma clock,
> the system has to enable the clock chain and it's parents ...
>=20
> But with this patch, we only need to enable/disable dma clock one tim=
e,
> just at we select the nand chip.

You are fixing a driver problem at a framework level, wrong.

So, check how the MXS SPI driver handles descriptor chaining. Indeed, t=
he=20
Sigmatel screwed the DMA stuff good. But if you analyze the SPI driver,=
 you'll=20
notice a few important points that might come handy when you fix the GP=
MI NAND=20
driver properly.

The direction to take here is:
1) Implement DMA chaining into the GPMI NAND driver
2) You might need to do one PIO transfer to reconfigure the IP register=
s between=20
each segment of the DMA chain (just as MXS SPI does it)
3) You might run out of DMA descriptors when doing too long chains -- s=
o you=20
might need to fix that part of the mxs DMA driver.

> thanks
> Huang Shijie

Best regards,
Marek Vasut
