From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH] dma: add new DMA control commands
Date: Thu, 18 Oct 2012 10:16:06 +0200
Message-ID: <201210181016.06782.marex@denx.de>
References: <1350538335-29026-1-git-send-email-b32955@freescale.com> <201210180914.58527.marex@denx.de> <507FB495.7050104@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <507FB495.7050104-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Vinod Koul <vinod.koul-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, djbw-b10kYP2dOMg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, artem.bityutskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, Huang Shijie <shijie8-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>artem.bityutskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Dear Huang Shijie,

> =E4=BA=8E 2012=E5=B9=B410=E6=9C=8818=E6=97=A5 15:14, Marek Vasut =E5=86=
=99=E9=81=93:
> > Dear Huang Shijie,
> >=20
> > Why such massive CC ?
> >=20
> >> =E4=BA=8E 2012=E5=B9=B410=E6=9C=8818=E6=97=A5 14:18, Vinod Koul =E5=
=86=99=E9=81=93:
> >>> Why cant you do start (prepare clock etc) when you submit the
> >>> descriptor to dmaengine. Can be done in tx_submit callback.
> >>> Similarly remove the clock when dma transaction gets completed.
> >>=20
> >> I ever thought this method too.
> >>=20
> >> But it will become low efficient in the following case:
> >>     Assuming the gpmi-nand driver has to read out 1024 pages in on=
e
> >>=20
> >> _SINGLE_ read operation.
> >> The gpmi-nand will submit the descriptor to dmaengine per page.
> >=20
> > It will? Then GPMI NAND is flat our broken ... again.
>=20
> yes.
>=20
> Please read the NAND chip spec about the comand READ PAGE(00h-30h) an=
d
> the code
> nand_do_read_ops(). The nand chip limits us only read one page out on=
e
> time. So the driver will submit the descriptor to dmaengine per page.

So we can't stream data from the chip? About time to adjust the MTD fra=
mework to=20
allow that. Maybe implement a command queue?

> >> So with
> >> your method,
> >> the system will repeat the enable/disable dma clock 1024 time.
> >=20
> > Yes, it is the driver that's wrong.
>=20
> not the driver.
>=20
> >> At every
> >> enable/disable dma clock,
> >> the system has to enable the clock chain and it's parents ...
> >>=20
> >> But with this patch, we only need to enable/disable dma clock one =
time,
> >> just at we select the nand chip.
> >=20
> > You are fixing a driver problem at a framework level, wrong.
> >=20
> > So, check how the MXS SPI driver handles descriptor chaining. Indee=
d, the
> > Sigmatel screwed the DMA stuff good. But if you analyze the SPI dri=
ver,
> > you'll notice a few important points that might come handy when you=
 fix
> > the GPMI NAND driver properly.
> >=20
> > The direction to take here is:
> > 1) Implement DMA chaining into the GPMI NAND driver
>=20
> How can i implement the DMA chain if the nand chip READ-PAGE command
> gives us the one page limit?

This smells like a time to extend the MTD api ?

> thanks
> Huang Shijie
>=20
> > 2) You might need to do one PIO transfer to reconfigure the IP regi=
sters
> > between each segment of the DMA chain (just as MXS SPI does it)
> > 3) You might run out of DMA descriptors when doing too long chains =
-- so
> > you might need to fix that part of the mxs DMA driver.

Best regards,
Marek Vasut
