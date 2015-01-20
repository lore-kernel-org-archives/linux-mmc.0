From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 06/17] mmc: tmio: tmio_mmc_host has .multi_io_quirk
Date: Tue, 20 Jan 2015 09:35:48 +0000
Message-ID: <20150120093548.GF5767@x1>
References: <87twzvuvl1.wl%kuninori.morimoto.gx@renesas.com>
 <87lhl7uvhx.wl%kuninori.morimoto.gx@renesas.com>
 <CAPDyKFpjYH_Txt1g8AjMFncnXvyT_-E5CKmdY+cDoNk+sC2ujg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFpjYH_Txt1g8AjMFncnXvyT_-E5CKmdY+cDoNk+sC2ujg@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, 20 Jan 2015, Ulf Hansson wrote:

> + MFD maintainer
>=20
> On 13 January 2015 at 05:58, Kuninori Morimoto
> <kuninori.morimoto.gx@renesas.com> wrote:
> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >
> > Current .multi_io_quirk is implemented under tmio_mmc_data.
> > It goes to tmio_mmc_host by this patch.
> >
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> >  drivers/mmc/host/sh_mobile_sdhi.c |    2 +-
> >  drivers/mmc/host/tmio_mmc.h       |    2 ++
> >  drivers/mmc/host/tmio_mmc_pio.c   |    5 ++---
> >  include/linux/mfd/tmio.h          |    3 ---

Acked-by: Lee Jones <lee.jones@linaro.org>

> >  4 files changed, 5 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/s=
h_mobile_sdhi.c
> > index 5e02a6a..c92efe5 100644
> > --- a/drivers/mmc/host/sh_mobile_sdhi.c
> > +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> > @@ -217,9 +217,9 @@ static int sh_mobile_sdhi_probe(struct platform=
_device *pdev)
> >         host->write16_hook      =3D sh_mobile_sdhi_write16_hook;
> >         host->clk_enable        =3D sh_mobile_sdhi_clk_enable;
> >         host->clk_disable       =3D sh_mobile_sdhi_clk_disable;
> > +       host->multi_io_quirk    =3D sh_mobile_sdhi_multi_io_quirk;
> >
> >         mmc_data->capabilities =3D MMC_CAP_MMC_HIGHSPEED;
> > -       mmc_data->multi_io_quirk =3D sh_mobile_sdhi_multi_io_quirk;
> >         if (p) {
> >                 mmc_data->flags =3D p->tmio_flags;
> >                 mmc_data->ocr_mask =3D p->tmio_ocr_mask;
> > diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mm=
c.h
> > index 28234ec..263256c 100644
> > --- a/drivers/mmc/host/tmio_mmc.h
> > +++ b/drivers/mmc/host/tmio_mmc.h
> > @@ -98,6 +98,8 @@ struct tmio_mmc_host {
> >         int (*write16_hook)(struct tmio_mmc_host *host, int addr);
> >         int (*clk_enable)(struct platform_device *pdev, unsigned in=
t *f);
> >         void (*clk_disable)(struct platform_device *pdev);
> > +       int (*multi_io_quirk)(struct mmc_card *card,
> > +                             unsigned int direction, int blk_size)=
;
> >  };
> >
> >  struct tmio_mmc_host *tmio_mmc_host_alloc(struct platform_device *=
pdev);
> > diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmi=
o_mmc_pio.c
> > index 94fbf4a..67c8182 100644
> > --- a/drivers/mmc/host/tmio_mmc_pio.c
> > +++ b/drivers/mmc/host/tmio_mmc_pio.c
> > @@ -1004,10 +1004,9 @@ static int tmio_multi_io_quirk(struct mmc_ca=
rd *card,
> >                                unsigned int direction, int blk_size=
)
> >  {
> >         struct tmio_mmc_host *host =3D mmc_priv(card->host);
> > -       struct tmio_mmc_data *pdata =3D host->pdata;
> >
> > -       if (pdata->multi_io_quirk)
> > -               return pdata->multi_io_quirk(card, direction, blk_s=
ize);
> > +       if (host->multi_io_quirk)
> > +               return host->multi_io_quirk(card, direction, blk_si=
ze);
> >
> >         return blk_size;
> >  }
> > diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
> > index a3f78da..3edaa17 100644
> > --- a/include/linux/mfd/tmio.h
> > +++ b/include/linux/mfd/tmio.h
> > @@ -125,9 +125,6 @@ struct tmio_mmc_data {
> >         unsigned int                    cd_gpio;
> >         void (*set_pwr)(struct platform_device *host, int state);
> >         void (*set_clk_div)(struct platform_device *host, int state=
);
> > -
> > -       int (*multi_io_quirk)(struct mmc_card *card,
> > -                             unsigned int direction, int blk_size)=
;
> >  };
> >
> >  /*
> >

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
