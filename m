From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 08/17] mmc: tmio: tmio_mmc_data has .alignment_shift
Date: Tue, 20 Jan 2015 09:34:52 +0000
Message-ID: <20150120093451.GD5767@x1>
References: <87twzvuvl1.wl%kuninori.morimoto.gx@renesas.com>
 <87iogbuvgx.wl%kuninori.morimoto.gx@renesas.com>
 <CAPDyKFoY1PdWSjFiUA3suehnB=e88OJX4Pn-o5MrT0PYjnZoqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFoY1PdWSjFiUA3suehnB=e88OJX4Pn-o5MrT0PYjnZoqg@mail.gmail.com>
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
> > Current .alignment_shift is implemented under tmio_mmc_dma.
> > It goes to tmio_mmc_data by this patch.
> >
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> >  drivers/mmc/host/sh_mobile_sdhi.c |    4 ++--
> >  drivers/mmc/host/tmio_mmc.h       |    1 -
> >  drivers/mmc/host/tmio_mmc_dma.c   |    4 ++--
> >  include/linux/mfd/tmio.h          |    1 +

Acked-by: Lee Jones <lee.jones@linaro.org>

> >  4 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/s=
h_mobile_sdhi.c
> > index 0db2a0a..782d8cf 100644
> > --- a/drivers/mmc/host/sh_mobile_sdhi.c
> > +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> > @@ -241,10 +241,10 @@ static int sh_mobile_sdhi_probe(struct platfo=
rm_device *pdev)
> >                         dma_priv->slave_id_rx =3D p->dma_slave_rx;
> >                 }
> >         }
> > -
> > -       dma_priv->alignment_shift =3D 1; /* 2-byte alignment */
> >         dma_priv->filter =3D shdma_chan_filter;
> >
> > +       mmc_data->alignment_shift =3D 1; /* 2-byte alignment */
> > +
> >         /*
> >          * All SDHI blocks support 2-byte and larger block sizes in=
 4-bit
> >          * bus width mode.
> > diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mm=
c.h
> > index a5d30bf..9482abc 100644
> > --- a/drivers/mmc/host/tmio_mmc.h
> > +++ b/drivers/mmc/host/tmio_mmc.h
> > @@ -45,7 +45,6 @@ struct tmio_mmc_dma {
> >         void *chan_priv_rx;
> >         int slave_id_tx;
> >         int slave_id_rx;
> > -       int alignment_shift;
> >         dma_addr_t dma_rx_offset;
> >         bool (*filter)(struct dma_chan *chan, void *arg);
> >  };
> > diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmi=
o_mmc_dma.c
> > index ee0131e..d2b02de 100644
> > --- a/drivers/mmc/host/tmio_mmc_dma.c
> > +++ b/drivers/mmc/host/tmio_mmc_dma.c
> > @@ -52,7 +52,7 @@ static void tmio_mmc_start_dma_rx(struct tmio_mmc=
_host *host)
> >         dma_cookie_t cookie;
> >         int ret, i;
> >         bool aligned =3D true, multiple =3D true;
> > -       unsigned int align =3D (1 << host->dma->alignment_shift) - =
1;
> > +       unsigned int align =3D (1 << host->pdata->alignment_shift) =
- 1;
> >
> >         for_each_sg(sg, sg_tmp, host->sg_len, i) {
> >                 if (sg_tmp->offset & align)
> > @@ -128,7 +128,7 @@ static void tmio_mmc_start_dma_tx(struct tmio_m=
mc_host *host)
> >         dma_cookie_t cookie;
> >         int ret, i;
> >         bool aligned =3D true, multiple =3D true;
> > -       unsigned int align =3D (1 << host->dma->alignment_shift) - =
1;
> > +       unsigned int align =3D (1 << host->pdata->alignment_shift) =
- 1;
> >
> >         for_each_sg(sg, sg_tmp, host->sg_len, i) {
> >                 if (sg_tmp->offset & align)
> > diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
> > index 7a5c279..28a12d1 100644
> > --- a/include/linux/mfd/tmio.h
> > +++ b/include/linux/mfd/tmio.h
> > @@ -122,6 +122,7 @@ struct tmio_mmc_data {
> >         unsigned long                   flags;
> >         u32                             ocr_mask;       /* availabl=
e voltages */
> >         unsigned int                    cd_gpio;
> > +       int                             alignment_shift;
> >         void (*set_pwr)(struct platform_device *host, int state);
> >         void (*set_clk_div)(struct platform_device *host, int state=
);
> >  };
> >

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
