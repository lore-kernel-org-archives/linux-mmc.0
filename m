From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/2] mmc: tmio: mmc: tmio: tmio_mmc_data has .chan_priv_?x
Date: Thu, 5 Mar 2015 10:56:51 +0000
Message-ID: <20150305105651.GB31098@x1>
References: <878ufo12qq.wl%kuninori.morimoto.gx@renesas.com>
 <877fv812pm.wl%kuninori.morimoto.gx@renesas.com>
 <CAPDyKFoHYiNieRpZQGieEj+j4O9xgjJ5mJBDJHtvPW2VVuPnyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFoHYiNieRpZQGieEj+j4O9xgjJ5mJBDJHtvPW2VVuPnyA@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Vinod Koul <vinod.koul@intel.com>, Simon <horms@verge.net.au>, Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 05 Mar 2015, Ulf Hansson wrote:

> + Lee Jones.
>=20
> On 24 February 2015 at 03:06, Kuninori Morimoto
> <kuninori.morimoto.gx@renesas.com> wrote:
> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >
> > dma_request_slave_channel_compat() in tmio_mmc_dma
> > needs .chan_priv_tx/.chan_priv_rx. But these are copied from
> > sh_mobile_sdhi only, and sh_mobile_sdhi_info is now almost
> > same as tmio_mmc_data except .chan_priv_?x.
> > sh_mobile_sdhi_info can be replaced to tmio_mmc_data, but it is
> > used from ${LINUX}/arch/arm/mach-shmobile, ${LINUX}/arch/sh.
> > So, this patch adds .chan_priv_?x into tmio_mmc_data as 1st step,
> > and sh_mobile_sdhi driver has dummy operation for now.
> > It will be replaced/removed together with platform data replace.
> >
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
>=20
> Note, since this touches mfd, you need an ack from Lee as well.

Acked-by: Lee Jones <lee.jones@linaro.org>

> > ---
> >  drivers/mmc/host/sh_mobile_sdhi.c |   44 +++++++++++++++++++++++--=
------------
> >  drivers/mmc/host/tmio_mmc.h       |    2 --
> >  drivers/mmc/host/tmio_mmc_dma.c   |    6 ++---
> >  include/linux/mfd/tmio.h          |    2 ++
> >  4 files changed, 32 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/s=
h_mobile_sdhi.c
> > index 11991f5..3137e29 100644
> > --- a/drivers/mmc/host/sh_mobile_sdhi.c
> > +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> > @@ -201,6 +201,7 @@ static int sh_mobile_sdhi_probe(struct platform=
_device *pdev)
> >                 of_match_device(sh_mobile_sdhi_of_match, &pdev->dev=
);
> >         struct sh_mobile_sdhi *priv;
> >         struct tmio_mmc_data *mmc_data;
> > +       struct tmio_mmc_data *mmd =3D pdev->dev.platform_data;
> >         struct sh_mobile_sdhi_info *p =3D pdev->dev.platform_data;
> >         struct tmio_mmc_host *host;
> >         struct resource *res;
> > @@ -245,28 +246,37 @@ static int sh_mobile_sdhi_probe(struct platfo=
rm_device *pdev)
> >         else
> >                 host->bus_shift =3D 0;
> >
> > -       mmc_data->capabilities =3D MMC_CAP_MMC_HIGHSPEED;
> > -       if (p) {
> > -               mmc_data->flags =3D p->tmio_flags;
> > -               mmc_data->ocr_mask =3D p->tmio_ocr_mask;
> > -               mmc_data->capabilities |=3D p->tmio_caps;
> > -               mmc_data->capabilities2 |=3D p->tmio_caps2;
> > -               mmc_data->cd_gpio =3D p->cd_gpio;
> > -
> > -               if (p->dma_slave_tx > 0 && p->dma_slave_rx > 0) {
> > -                       /*
> > -                        * Yes, we have to provide slave IDs twice =
to TMIO:
> > -                        * once as a filter parameter and once for =
channel
> > -                        * configuration as an explicit slave ID
> > -                        */
> > -                       dma_priv->chan_priv_tx =3D (void *)p->dma_s=
lave_tx;
> > -                       dma_priv->chan_priv_rx =3D (void *)p->dma_s=
lave_rx;
> > -               }
> > +       if (mmd) {
> > +               /*
> > +                * FIXME
> > +                *
> > +                * sh_mobile_sdhi_info will be replaced to tmio_mmc=
_data soon.
> > +                * But, sh_mobile_sdhi_info is used under
> > +                * ${LINUX}/arch/arm/mach-shmobile/
> > +                * ${LINUX}/arch/sh/
> > +                * To separate large patch into "tmio_mmc_data has =
=2Echan_priv_?x"
> > +                * and "replace sh_mobile_sdhi_info in tmio_mmc_dat=
a",
> > +                * here has dummy method.
> > +                * These should be removed.
> > +                */
> > +               struct tmio_mmc_data m;
> > +
> > +               mmd =3D &m;
> > +               m.flags         =3D p->tmio_flags;
> > +               m.ocr_mask      =3D p->tmio_ocr_mask;
> > +               m.capabilities  =3D p->tmio_caps;
> > +               m.capabilities2 =3D p->tmio_caps2;
> > +               m.cd_gpio       =3D p->cd_gpio;
> > +               m.chan_priv_tx  =3D (void *)p->dma_slave_tx;
> > +               m.chan_priv_rx  =3D (void *)p->dma_slave_rx;
> > +
> > +               *mmc_data =3D *mmd;
> >         }
> >         dma_priv->filter =3D shdma_chan_filter;
> >         dma_priv->enable =3D sh_mobile_sdhi_enable_dma;
> >
> >         mmc_data->alignment_shift =3D 1; /* 2-byte alignment */
> > +       mmc_data->capabilities |=3D MMC_CAP_MMC_HIGHSPEED;
> >
> >         /*
> >          * All SDHI blocks support 2-byte and larger block sizes in=
 4-bit
> > diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mm=
c.h
> > index 1aea5c6..4a597f5a 100644
> > --- a/drivers/mmc/host/tmio_mmc.h
> > +++ b/drivers/mmc/host/tmio_mmc.h
> > @@ -43,8 +43,6 @@ struct tmio_mmc_data;
> >  struct tmio_mmc_host;
> >
> >  struct tmio_mmc_dma {
> > -       void *chan_priv_tx;
> > -       void *chan_priv_rx;
> >         enum dma_slave_buswidth dma_buswidth;
> >         bool (*filter)(struct dma_chan *chan, void *arg);
> >         void (*enable)(struct tmio_mmc_host *host, bool enable);
> > diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmi=
o_mmc_dma.c
> > index 8dbd785..e4b05db 100644
> > --- a/drivers/mmc/host/tmio_mmc_dma.c
> > +++ b/drivers/mmc/host/tmio_mmc_dma.c
> > @@ -261,7 +261,7 @@ void tmio_mmc_request_dma(struct tmio_mmc_host =
*host, struct tmio_mmc_data *pdat
> >  {
> >         /* We can only either use DMA for both Tx and Rx or not use=
 it at all */
> >         if (!host->dma || (!host->pdev->dev.of_node &&
> > -               (!host->dma->chan_priv_tx || !host->dma->chan_priv_=
rx)))
> > +               (!pdata->chan_priv_tx || !pdata->chan_priv_rx)))
> >                 return;
> >
> >         if (!host->chan_tx && !host->chan_rx) {
> > @@ -278,7 +278,7 @@ void tmio_mmc_request_dma(struct tmio_mmc_host =
*host, struct tmio_mmc_data *pdat
> >                 dma_cap_set(DMA_SLAVE, mask);
> >
> >                 host->chan_tx =3D dma_request_slave_channel_compat(=
mask,
> > -                                       host->dma->filter, host->dm=
a->chan_priv_tx,
> > +                                       host->dma->filter, pdata->c=
han_priv_tx,
> >                                         &host->pdev->dev, "tx");
> >                 dev_dbg(&host->pdev->dev, "%s: TX: got channel %p\n=
", __func__,
> >                         host->chan_tx);
> > @@ -297,7 +297,7 @@ void tmio_mmc_request_dma(struct tmio_mmc_host =
*host, struct tmio_mmc_data *pdat
> >                         goto ecfgtx;
> >
> >                 host->chan_rx =3D dma_request_slave_channel_compat(=
mask,
> > -                                       host->dma->filter, host->dm=
a->chan_priv_rx,
> > +                                       host->dma->filter, pdata->c=
han_priv_rx,
> >                                         &host->pdev->dev, "rx");
> >                 dev_dbg(&host->pdev->dev, "%s: RX: got channel %p\n=
", __func__,
> >                         host->chan_rx);
> > diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
> > index 6058128..24b86d5 100644
> > --- a/include/linux/mfd/tmio.h
> > +++ b/include/linux/mfd/tmio.h
> > @@ -111,6 +111,8 @@ struct dma_chan;
> >   * data for the MMC controller
> >   */
> >  struct tmio_mmc_data {
> > +       void                            *chan_priv_tx;
> > +       void                            *chan_priv_rx;
> >         unsigned int                    hclk;
> >         unsigned long                   capabilities;
> >         unsigned long                   capabilities2;
> >

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
