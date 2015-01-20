From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 02/17] mmc: tmio: tmio_mmc_host has .dma
Date: Tue, 20 Jan 2015 09:37:59 +0000
Message-ID: <20150120093759.GJ5767@x1>
References: <87twzvuvl1.wl%kuninori.morimoto.gx@renesas.com>
 <87r3uzuviy.wl%kuninori.morimoto.gx@renesas.com>
 <CAPDyKFqQ8+cDZjwgooDAVG++sBtg+58-hXHwpDNgbKDa9R7Ntg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFqQ8+cDZjwgooDAVG++sBtg+58-hXHwpDNgbKDa9R7Ntg@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, 20 Jan 2015, Ulf Hansson wrote:

> + MFD maintainer
>=20
> On 13 January 2015 at 05:57, Kuninori Morimoto
> <kuninori.morimoto.gx@renesas.com> wrote:
> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >
> > Current .dma is implemented under tmio_mmc_data.
> > It goes to tmio_mmc_host by this patch.
> >
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> >  drivers/mmc/host/sh_mobile_sdhi.c |    4 ++--
> >  drivers/mmc/host/tmio_mmc.h       |   11 +++++++++++
> >  drivers/mmc/host/tmio_mmc_dma.c   |   24 +++++++++++-------------
> >  include/linux/mfd/tmio.h          |   11 -----------

Acked-by: Lee Jones <lee.jones@linaro.org>

> >  4 files changed, 24 insertions(+), 26 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/s=
h_mobile_sdhi.c
> > index cf062c4..288e78d 100644
> > --- a/drivers/mmc/host/sh_mobile_sdhi.c
> > +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> > @@ -213,6 +213,8 @@ static int sh_mobile_sdhi_probe(struct platform=
_device *pdev)
> >                 goto eprobe;
> >         }
> >
> > +       host->dma               =3D dma_priv;
> > +
> >         mmc_data->clk_enable =3D sh_mobile_sdhi_clk_enable;
> >         mmc_data->clk_disable =3D sh_mobile_sdhi_clk_disable;
> >         mmc_data->capabilities =3D MMC_CAP_MMC_HIGHSPEED;
> > @@ -241,8 +243,6 @@ static int sh_mobile_sdhi_probe(struct platform=
_device *pdev)
> >         dma_priv->alignment_shift =3D 1; /* 2-byte alignment */
> >         dma_priv->filter =3D shdma_chan_filter;
> >
> > -       mmc_data->dma =3D dma_priv;
> > -
> >         /*
> >          * All SDHI blocks support 2-byte and larger block sizes in=
 4-bit
> >          * bus width mode.
> > diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mm=
c.h
> > index 60d6747..49a2559 100644
> > --- a/drivers/mmc/host/tmio_mmc.h
> > +++ b/drivers/mmc/host/tmio_mmc.h
> > @@ -40,6 +40,16 @@
> >
> >  struct tmio_mmc_data;
> >
> > +struct tmio_mmc_dma {
> > +       void *chan_priv_tx;
> > +       void *chan_priv_rx;
> > +       int slave_id_tx;
> > +       int slave_id_rx;
> > +       int alignment_shift;
> > +       dma_addr_t dma_rx_offset;
> > +       bool (*filter)(struct dma_chan *chan, void *arg);
> > +};
> > +
> >  struct tmio_mmc_host {
> >         void __iomem *ctl;
> >         struct mmc_command      *cmd;
> > @@ -59,6 +69,7 @@ struct tmio_mmc_host {
> >
> >         struct platform_device *pdev;
> >         struct tmio_mmc_data *pdata;
> > +       struct tmio_mmc_dma     *dma;
> >
> >         /* DMA support */
> >         bool                    force_pio;
> > diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmi=
o_mmc_dma.c
> > index 7d07738..6c214d6 100644
> > --- a/drivers/mmc/host/tmio_mmc_dma.c
> > +++ b/drivers/mmc/host/tmio_mmc_dma.c
> > @@ -49,11 +49,10 @@ static void tmio_mmc_start_dma_rx(struct tmio_m=
mc_host *host)
> >         struct scatterlist *sg =3D host->sg_ptr, *sg_tmp;
> >         struct dma_async_tx_descriptor *desc =3D NULL;
> >         struct dma_chan *chan =3D host->chan_rx;
> > -       struct tmio_mmc_data *pdata =3D host->pdata;
> >         dma_cookie_t cookie;
> >         int ret, i;
> >         bool aligned =3D true, multiple =3D true;
> > -       unsigned int align =3D (1 << pdata->dma->alignment_shift) -=
 1;
> > +       unsigned int align =3D (1 << host->dma->alignment_shift) - =
1;
> >
> >         for_each_sg(sg, sg_tmp, host->sg_len, i) {
> >                 if (sg_tmp->offset & align)
> > @@ -126,11 +125,10 @@ static void tmio_mmc_start_dma_tx(struct tmio=
_mmc_host *host)
> >         struct scatterlist *sg =3D host->sg_ptr, *sg_tmp;
> >         struct dma_async_tx_descriptor *desc =3D NULL;
> >         struct dma_chan *chan =3D host->chan_tx;
> > -       struct tmio_mmc_data *pdata =3D host->pdata;
> >         dma_cookie_t cookie;
> >         int ret, i;
> >         bool aligned =3D true, multiple =3D true;
> > -       unsigned int align =3D (1 << pdata->dma->alignment_shift) -=
 1;
> > +       unsigned int align =3D (1 << host->dma->alignment_shift) - =
1;
> >
> >         for_each_sg(sg, sg_tmp, host->sg_len, i) {
> >                 if (sg_tmp->offset & align)
> > @@ -262,8 +260,8 @@ out:
> >  void tmio_mmc_request_dma(struct tmio_mmc_host *host, struct tmio_=
mmc_data *pdata)
> >  {
> >         /* We can only either use DMA for both Tx and Rx or not use=
 it at all */
> > -       if (!pdata->dma || (!host->pdev->dev.of_node &&
> > -               (!pdata->dma->chan_priv_tx || !pdata->dma->chan_pri=
v_rx)))
> > +       if (!host->dma || (!host->pdev->dev.of_node &&
> > +               (!host->dma->chan_priv_tx || !host->dma->chan_priv_=
rx)))
> >                 return;
> >
> >         if (!host->chan_tx && !host->chan_rx) {
> > @@ -280,7 +278,7 @@ void tmio_mmc_request_dma(struct tmio_mmc_host =
*host, struct tmio_mmc_data *pdat
> >                 dma_cap_set(DMA_SLAVE, mask);
> >
> >                 host->chan_tx =3D dma_request_slave_channel_compat(=
mask,
> > -                                       pdata->dma->filter, pdata->=
dma->chan_priv_tx,
> > +                                       host->dma->filter, host->dm=
a->chan_priv_tx,
> >                                         &host->pdev->dev, "tx");
> >                 dev_dbg(&host->pdev->dev, "%s: TX: got channel %p\n=
", __func__,
> >                         host->chan_tx);
> > @@ -288,8 +286,8 @@ void tmio_mmc_request_dma(struct tmio_mmc_host =
*host, struct tmio_mmc_data *pdat
> >                 if (!host->chan_tx)
> >                         return;
> >
> > -               if (pdata->dma->chan_priv_tx)
> > -                       cfg.slave_id =3D pdata->dma->slave_id_tx;
> > +               if (host->dma->chan_priv_tx)
> > +                       cfg.slave_id =3D host->dma->slave_id_tx;
> >                 cfg.direction =3D DMA_MEM_TO_DEV;
> >                 cfg.dst_addr =3D res->start + (CTL_SD_DATA_PORT << =
host->pdata->bus_shift);
> >                 cfg.dst_addr_width =3D DMA_SLAVE_BUSWIDTH_2_BYTES;
> > @@ -299,7 +297,7 @@ void tmio_mmc_request_dma(struct tmio_mmc_host =
*host, struct tmio_mmc_data *pdat
> >                         goto ecfgtx;
> >
> >                 host->chan_rx =3D dma_request_slave_channel_compat(=
mask,
> > -                                       pdata->dma->filter, pdata->=
dma->chan_priv_rx,
> > +                                       host->dma->filter, host->dm=
a->chan_priv_rx,
> >                                         &host->pdev->dev, "rx");
> >                 dev_dbg(&host->pdev->dev, "%s: RX: got channel %p\n=
", __func__,
> >                         host->chan_rx);
> > @@ -307,10 +305,10 @@ void tmio_mmc_request_dma(struct tmio_mmc_hos=
t *host, struct tmio_mmc_data *pdat
> >                 if (!host->chan_rx)
> >                         goto ereqrx;
> >
> > -               if (pdata->dma->chan_priv_rx)
> > -                       cfg.slave_id =3D pdata->dma->slave_id_rx;
> > +               if (host->dma->chan_priv_rx)
> > +                       cfg.slave_id =3D host->dma->slave_id_rx;
> >                 cfg.direction =3D DMA_DEV_TO_MEM;
> > -               cfg.src_addr =3D cfg.dst_addr + pdata->dma->dma_rx_=
offset;
> > +               cfg.src_addr =3D cfg.dst_addr + host->dma->dma_rx_o=
ffset;
> >                 cfg.src_addr_width =3D DMA_SLAVE_BUSWIDTH_2_BYTES;
> >                 cfg.dst_addr =3D 0;
> >                 ret =3D dmaengine_slave_config(host->chan_rx, &cfg)=
;
> > diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
> > index c7d9af0..8d708c7 100644
> > --- a/include/linux/mfd/tmio.h
> > +++ b/include/linux/mfd/tmio.h
> > @@ -112,16 +112,6 @@ void tmio_core_mmc_clk_div(void __iomem *cnf, =
int shift, int state);
> >
> >  struct dma_chan;
> >
> > -struct tmio_mmc_dma {
> > -       void *chan_priv_tx;
> > -       void *chan_priv_rx;
> > -       int slave_id_tx;
> > -       int slave_id_rx;
> > -       int alignment_shift;
> > -       dma_addr_t dma_rx_offset;
> > -       bool (*filter)(struct dma_chan *chan, void *arg);
> > -};
> > -
> >  struct tmio_mmc_host;
> >
> >  /*
> > @@ -134,7 +124,6 @@ struct tmio_mmc_data {
> >         unsigned long                   flags;
> >         unsigned long                   bus_shift;
> >         u32                             ocr_mask;       /* availabl=
e voltages */
> > -       struct tmio_mmc_dma             *dma;
> >         unsigned int                    cd_gpio;
> >         void (*set_pwr)(struct platform_device *host, int state);
> >         void (*set_clk_div)(struct platform_device *host, int state=
);
> >

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
