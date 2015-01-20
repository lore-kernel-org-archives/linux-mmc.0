From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 09/17] mmc: tmio: tmio_mmc_data has .dma_rx_offset
Date: Tue, 20 Jan 2015 09:34:16 +0000
Message-ID: <20150120093416.GC5767@x1>
References: <87twzvuvl1.wl%kuninori.morimoto.gx@renesas.com>
 <87h9vvuvgo.wl%kuninori.morimoto.gx@renesas.com>
 <CAPDyKFpk-Zi_3ad4nDptkYC_hnjWoSWO-Qi4PzawW-8qyZu0jQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFpk-Zi_3ad4nDptkYC_hnjWoSWO-Qi4PzawW-8qyZu0jQ@mail.gmail.com>
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
> > Current .dma_rx_offset is implemented under tmio_mmc_dma.
> > It goes to tmio_mmc_data by this patch.
> >
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> >  drivers/mmc/host/sh_mobile_sdhi.c |    2 +-
> >  drivers/mmc/host/tmio_mmc.h       |    1 -
> >  drivers/mmc/host/tmio_mmc_dma.c   |    2 +-
> >  include/linux/mfd/tmio.h          |    1 +
> >  4 files changed, 3 insertions(+), 3 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

> > diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/s=
h_mobile_sdhi.c
> > index 782d8cf..c06e93b 100644
> > --- a/drivers/mmc/host/sh_mobile_sdhi.c
> > +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> > @@ -276,7 +276,7 @@ static int sh_mobile_sdhi_probe(struct platform=
_device *pdev)
> >                 mmc_data->flags |=3D of_data->tmio_flags;
> >                 mmc_data->capabilities |=3D of_data->capabilities;
> >                 mmc_data->capabilities2 |=3D of_data->capabilities2=
;
> > -               dma_priv->dma_rx_offset =3D of_data->dma_rx_offset;
> > +               mmc_data->dma_rx_offset =3D of_data->dma_rx_offset;
> >         }
> >
> >         ret =3D tmio_mmc_host_probe(host, mmc_data);
> > diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mm=
c.h
> > index 9482abc..c9a8469 100644
> > --- a/drivers/mmc/host/tmio_mmc.h
> > +++ b/drivers/mmc/host/tmio_mmc.h
> > @@ -45,7 +45,6 @@ struct tmio_mmc_dma {
> >         void *chan_priv_rx;
> >         int slave_id_tx;
> >         int slave_id_rx;
> > -       dma_addr_t dma_rx_offset;
> >         bool (*filter)(struct dma_chan *chan, void *arg);
> >  };
> >
> > diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmi=
o_mmc_dma.c
> > index d2b02de..634b2700c 100644
> > --- a/drivers/mmc/host/tmio_mmc_dma.c
> > +++ b/drivers/mmc/host/tmio_mmc_dma.c
> > @@ -308,7 +308,7 @@ void tmio_mmc_request_dma(struct tmio_mmc_host =
*host, struct tmio_mmc_data *pdat
> >                 if (host->dma->chan_priv_rx)
> >                         cfg.slave_id =3D host->dma->slave_id_rx;
> >                 cfg.direction =3D DMA_DEV_TO_MEM;
> > -               cfg.src_addr =3D cfg.dst_addr + host->dma->dma_rx_o=
ffset;
> > +               cfg.src_addr =3D cfg.dst_addr + host->pdata->dma_rx=
_offset;
> >                 cfg.src_addr_width =3D DMA_SLAVE_BUSWIDTH_2_BYTES;
> >                 cfg.dst_addr =3D 0;
> >                 ret =3D dmaengine_slave_config(host->chan_rx, &cfg)=
;
> > diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
> > index 28a12d1..807ecfb 100644
> > --- a/include/linux/mfd/tmio.h
> > +++ b/include/linux/mfd/tmio.h
> > @@ -123,6 +123,7 @@ struct tmio_mmc_data {
> >         u32                             ocr_mask;       /* availabl=
e voltages */
> >         unsigned int                    cd_gpio;
> >         int                             alignment_shift;
> > +       dma_addr_t                      dma_rx_offset;
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
