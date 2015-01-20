From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 07/17] mmc: tmio: tmio_mmc_host has .bus_shift
Date: Tue, 20 Jan 2015 09:35:21 +0000
Message-ID: <20150120093521.GE5767@x1>
References: <87twzvuvl1.wl%kuninori.morimoto.gx@renesas.com>
 <87k30ruvhn.wl%kuninori.morimoto.gx@renesas.com>
 <CAPDyKFojRTY51FEe=0H072VVA8hCFGfuT+wJLvdKEJ8DWs-+2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFojRTY51FEe=0H072VVA8hCFGfuT+wJLvdKEJ8DWs-+2w@mail.gmail.com>
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
> > Current .bus_shift is implemented under tmio_mmc_data.
> > It goes to tmio_mmc_host by this patch.
> >
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> >  drivers/mmc/host/sh_mobile_sdhi.c |    5 ++---
> >  drivers/mmc/host/tmio_mmc.c       |    5 +++--
> >  drivers/mmc/host/tmio_mmc.h       |   17 +++++++++--------
> >  drivers/mmc/host/tmio_mmc_dma.c   |    2 +-
> >  include/linux/mfd/tmio.h          |    1 -

Acked-by: Lee Jones <lee.jones@linaro.org>

> >  5 files changed, 15 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/s=
h_mobile_sdhi.c
> > index c92efe5..0db2a0a 100644
> > --- a/drivers/mmc/host/sh_mobile_sdhi.c
> > +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> > @@ -218,6 +218,8 @@ static int sh_mobile_sdhi_probe(struct platform=
_device *pdev)
> >         host->clk_enable        =3D sh_mobile_sdhi_clk_enable;
> >         host->clk_disable       =3D sh_mobile_sdhi_clk_disable;
> >         host->multi_io_quirk    =3D sh_mobile_sdhi_multi_io_quirk;
> > +       /* SD control register space size is 0x100, 0x200 for bus_s=
hift=3D1 */
> > +       host->bus_shift         =3D resource_size(res) >> 9;
> >
> >         mmc_data->capabilities =3D MMC_CAP_MMC_HIGHSPEED;
> >         if (p) {
> > @@ -277,9 +279,6 @@ static int sh_mobile_sdhi_probe(struct platform=
_device *pdev)
> >                 dma_priv->dma_rx_offset =3D of_data->dma_rx_offset;
> >         }
> >
> > -       /* SD control register space size is 0x100, 0x200 for bus_s=
hift=3D1 */
> > -       mmc_data->bus_shift =3D resource_size(res) >> 9;
> > -
> >         ret =3D tmio_mmc_host_probe(host, mmc_data);
> >         if (ret < 0)
> >                 goto efree;
> > diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mm=
c.c
> > index f47ae08..9e8723d 100644
> > --- a/drivers/mmc/host/tmio_mmc.c
> > +++ b/drivers/mmc/host/tmio_mmc.c
> > @@ -88,14 +88,15 @@ static int tmio_mmc_probe(struct platform_devic=
e *pdev)
> >         if (!res)
> >                 return -EINVAL;
> >
> > -       /* SD control register space size is 0x200, 0x400 for bus_s=
hift=3D1 */
> > -       pdata->bus_shift =3D resource_size(res) >> 10;
> >         pdata->flags |=3D TMIO_MMC_HAVE_HIGH_REG;
> >
> >         host =3D tmio_mmc_host_alloc(pdev);
> >         if (!host)
> >                 goto cell_disable;
> >
> > +       /* SD control register space size is 0x200, 0x400 for bus_s=
hift=3D1 */
> > +       host->bus_shift =3D resource_size(res) >> 10;
> > +
> >         ret =3D tmio_mmc_host_probe(host, pdata);
> >         if (ret)
> >                 goto host_free;
> > diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mm=
c.h
> > index 263256c..a5d30bf 100644
> > --- a/drivers/mmc/host/tmio_mmc.h
> > +++ b/drivers/mmc/host/tmio_mmc.h
> > @@ -66,6 +66,7 @@ struct tmio_mmc_host {
> >         struct scatterlist      *sg_orig;
> >         unsigned int            sg_len;
> >         unsigned int            sg_off;
> > +       unsigned long           bus_shift;
> >
> >         struct platform_device *pdev;
> >         struct tmio_mmc_data *pdata;
> > @@ -169,19 +170,19 @@ int tmio_mmc_host_runtime_resume(struct devic=
e *dev);
> >
> >  static inline u16 sd_ctrl_read16(struct tmio_mmc_host *host, int a=
ddr)
> >  {
> > -       return readw(host->ctl + (addr << host->pdata->bus_shift));
> > +       return readw(host->ctl + (addr << host->bus_shift));
> >  }
> >
> >  static inline void sd_ctrl_read16_rep(struct tmio_mmc_host *host, =
int addr,
> >                 u16 *buf, int count)
> >  {
> > -       readsw(host->ctl + (addr << host->pdata->bus_shift), buf, c=
ount);
> > +       readsw(host->ctl + (addr << host->bus_shift), buf, count);
> >  }
> >
> >  static inline u32 sd_ctrl_read32(struct tmio_mmc_host *host, int a=
ddr)
> >  {
> > -       return readw(host->ctl + (addr << host->pdata->bus_shift)) =
|
> > -              readw(host->ctl + ((addr + 2) << host->pdata->bus_sh=
ift)) << 16;
> > +       return readw(host->ctl + (addr << host->bus_shift)) |
> > +              readw(host->ctl + ((addr + 2) << host->bus_shift)) <=
< 16;
> >  }
> >
> >  static inline void sd_ctrl_write16(struct tmio_mmc_host *host, int=
 addr, u16 val)
> > @@ -191,19 +192,19 @@ static inline void sd_ctrl_write16(struct tmi=
o_mmc_host *host, int addr, u16 val
> >          */
> >         if (host->write16_hook && host->write16_hook(host, addr))
> >                 return;
> > -       writew(val, host->ctl + (addr << host->pdata->bus_shift));
> > +       writew(val, host->ctl + (addr << host->bus_shift));
> >  }
> >
> >  static inline void sd_ctrl_write16_rep(struct tmio_mmc_host *host,=
 int addr,
> >                 u16 *buf, int count)
> >  {
> > -       writesw(host->ctl + (addr << host->pdata->bus_shift), buf, =
count);
> > +       writesw(host->ctl + (addr << host->bus_shift), buf, count);
> >  }
> >
> >  static inline void sd_ctrl_write32(struct tmio_mmc_host *host, int=
 addr, u32 val)
> >  {
> > -       writew(val, host->ctl + (addr << host->pdata->bus_shift));
> > -       writew(val >> 16, host->ctl + ((addr + 2) << host->pdata->b=
us_shift));
> > +       writew(val, host->ctl + (addr << host->bus_shift));
> > +       writew(val >> 16, host->ctl + ((addr + 2) << host->bus_shif=
t));
> >  }
> >
> >
> > diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmi=
o_mmc_dma.c
> > index 6c214d6..ee0131e 100644
> > --- a/drivers/mmc/host/tmio_mmc_dma.c
> > +++ b/drivers/mmc/host/tmio_mmc_dma.c
> > @@ -289,7 +289,7 @@ void tmio_mmc_request_dma(struct tmio_mmc_host =
*host, struct tmio_mmc_data *pdat
> >                 if (host->dma->chan_priv_tx)
> >                         cfg.slave_id =3D host->dma->slave_id_tx;
> >                 cfg.direction =3D DMA_MEM_TO_DEV;
> > -               cfg.dst_addr =3D res->start + (CTL_SD_DATA_PORT << =
host->pdata->bus_shift);
> > +               cfg.dst_addr =3D res->start + (CTL_SD_DATA_PORT << =
host->bus_shift);
> >                 cfg.dst_addr_width =3D DMA_SLAVE_BUSWIDTH_2_BYTES;
> >                 cfg.src_addr =3D 0;
> >                 ret =3D dmaengine_slave_config(host->chan_tx, &cfg)=
;
> > diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
> > index 3edaa17..7a5c279 100644
> > --- a/include/linux/mfd/tmio.h
> > +++ b/include/linux/mfd/tmio.h
> > @@ -120,7 +120,6 @@ struct tmio_mmc_data {
> >         unsigned long                   capabilities;
> >         unsigned long                   capabilities2;
> >         unsigned long                   flags;
> > -       unsigned long                   bus_shift;
> >         u32                             ocr_mask;       /* availabl=
e voltages */
> >         unsigned int                    cd_gpio;
> >         void (*set_pwr)(struct platform_device *host, int state);
> >

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
