From: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH] dma: add new DMA control commands
Date: Thu, 18 Oct 2012 14:45:41 +0800
Message-ID: <507FA595.4020507@freescale.com>
References: <1350538335-29026-1-git-send-email-b32955@freescale.com> <1350541111.5263.3.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1350541111.5263.3.camel@vkoul-udesk3>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vinod Koul <vinod.koul-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: djbw-b10kYP2dOMg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, artem.bityutskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, Huang Shijie <shijie8-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

=E4=BA=8E 2012=E5=B9=B410=E6=9C=8818=E6=97=A5 14:18, Vinod Koul =E5=86=99=
=E9=81=93:
> Why cant you do start (prepare clock etc) when you submit the descrip=
tor
> to dmaengine. Can be done in tx_submit callback.
> Similarly remove the clock when dma transaction gets completed.
I ever thought this method too.

But it will become low efficient in the following case:

   Assuming the gpmi-nand driver has to read out 1024 pages in one=20
_SINGLE_ read operation.
The gpmi-nand will submit the descriptor to dmaengine per page. So with=
=20
your method,
the system will repeat the enable/disable dma clock 1024 time. At every=
=20
enable/disable dma clock,
the system has to enable the clock chain and it's parents ...

But with this patch, we only need to enable/disable dma clock one time,=
=20
just at we select the nand chip.

thanks
Huang Shijie
