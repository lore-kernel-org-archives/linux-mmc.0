From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/7 v3] mmc: use .multi_io_quirk on tmio_mmc
Date: Mon, 8 Sep 2014 12:11:18 +0100
Message-ID: <20140908111118.GC24563@lee--X1>
References: <87r3zvzohj.wl%kuninori.morimoto.gx@gmail.com>
 <87bnqx78xr.wl%kuninori.morimoto.gx@gmail.com>
 <877g1l78v9.wl%kuninori.morimoto.gx@gmail.com>
 <CAPDyKFoVQjO7CLAQM-9DX12H5bOwwP6aqJtb=y3uRMNaWqV89A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:55027 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752962AbaIHLLY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Sep 2014 07:11:24 -0400
Received: by mail-ig0-f172.google.com with SMTP id h15so2491707igd.17
        for <linux-mmc@vger.kernel.org>; Mon, 08 Sep 2014 04:11:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPDyKFoVQjO7CLAQM-9DX12H5bOwwP6aqJtb=y3uRMNaWqV89A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On Mon, 08 Sep 2014, Ulf Hansson wrote:

> On 3 September 2014 04:09, Kuninori Morimoto
> <kuninori.morimoto.gx@gmail.com> wrote:
> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >
> > Now, tmio_mmc can use .multi_io_quirk callback
> > instead of MMC_CAP2_NO_MULTI_READ flags.
> > let's use it.
> >
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> > v2 -> v3
> >
> >  - blk_size_workaround -> multi_io_quirk
> >
> >  drivers/mmc/host/tmio_mmc_pio.c |   13 +++++++++++++
> >  include/linux/mfd/tmio.h        |    4 ++++
>=20
> "mfd"? That was an odd place for storing the tmio mmc specific platfo=
rm data.
>=20
> So, we need an ack for the mfd maintainer on this one as well. Lee,
> can you have a look?
>=20
> Future wise, I would also suggest the include/linux/mfd/tmio.h to be
> split up in proper pieces.

struct tmio_mmc_data looks like it's populated in the MFD driver, thus
this is probably the correct place for it.

> >  2 files changed, 17 insertions(+)
> >
> > diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmi=
o_mmc_pio.c
> > index ba45413..ff5ff0f 100644
> > --- a/drivers/mmc/host/tmio_mmc_pio.c
> > +++ b/drivers/mmc/host/tmio_mmc_pio.c
> > @@ -970,12 +970,25 @@ static int tmio_mmc_get_ro(struct mmc_host *m=
mc)
> >         return ret;
> >  }
> >
> > +static int tmio_multi_io_quirk(struct mmc_card *card,
> > +                              unsigned int direction, int blk_size=
)
> > +{
> > +       struct tmio_mmc_host *host =3D mmc_priv(card->host);
> > +       struct tmio_mmc_data *pdata =3D host->pdata;
> > +
> > +       if (pdata->multi_io_quirk)
> > +               return pdata->multi_io_quirk(card, direction, blk_s=
ize);
> > +
> > +       return blk_size;
> > +}
> > +
> >  static const struct mmc_host_ops tmio_mmc_ops =3D {
> >         .request        =3D tmio_mmc_request,
> >         .set_ios        =3D tmio_mmc_set_ios,
> >         .get_ro         =3D tmio_mmc_get_ro,
> >         .get_cd         =3D mmc_gpio_get_cd,
> >         .enable_sdio_irq =3D tmio_mmc_enable_sdio_irq,
> > +       .multi_io_quirk =3D tmio_multi_io_quirk,
> >  };
> >
> >  static int tmio_mmc_init_ocr(struct tmio_mmc_host *host)
> > diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
> > index 90436d5..dec750e 100644
> > --- a/include/linux/mfd/tmio.h
> > +++ b/include/linux/mfd/tmio.h
> > @@ -1,10 +1,12 @@
> >  #ifndef MFD_TMIO_H
> >  #define MFD_TMIO_H
> >
> > +#include <linux/blkdev.h>
>=20
> This isn't needed, right?
>=20
> >  #include <linux/device.h>
> >  #include <linux/fb.h>
> >  #include <linux/io.h>
> >  #include <linux/jiffies.h>
> > +#include <linux/mmc/card.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_runtime.h>
> >
> > @@ -142,6 +144,8 @@ struct tmio_mmc_data {
> >         /* clock management callbacks */
> >         int (*clk_enable)(struct platform_device *pdev, unsigned in=
t *f);
> >         void (*clk_disable)(struct platform_device *pdev);
> > +       int (*multi_io_quirk)(struct mmc_card *card,
> > +                             unsigned int direction, int blk_size)=
;
>=20
> Do you really need to invent new platform callbacks for this? Wouldn'=
t
> it be possible to let the driver handle the quirk by itself?

Obviously I can't Ack this patch until Ulf is satisfied.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
