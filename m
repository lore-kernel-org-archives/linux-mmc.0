From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 03/17] mmc: tmio: tmio_mmc_host has .write16_hook
Date: Tue, 20 Jan 2015 09:37:29 +0000
Message-ID: <20150120093729.GI5767@x1>
References: <87twzvuvl1.wl%kuninori.morimoto.gx@renesas.com>
 <87ppajuvip.wl%kuninori.morimoto.gx@renesas.com>
 <CAPDyKFo2v8TLOMuxJOZwjqRji4+QmYRkk3CSGgi-JCbVriP7MQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFo2v8TLOMuxJOZwjqRji4+QmYRkk3CSGgi-JCbVriP7MQ@mail.gmail.com>
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
> > Current .write16_hook is implemented under tmio_mmc_data.
> > It goes to tmio_mmc_host by this patch.
> >
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> >  drivers/mmc/host/sh_mobile_sdhi.c |    2 +-
> >  drivers/mmc/host/tmio_mmc.h       |    4 +++-
> >  drivers/mmc/host/tmio_mmc_pio.c   |    2 +-
> >  include/linux/mfd/tmio.h          |    3 ---

Acked-by: Lee Jones <lee.jones@linaro.org>

> >  4 files changed, 5 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/s=
h_mobile_sdhi.c
> > index 288e78d..77ff062 100644
> > --- a/drivers/mmc/host/sh_mobile_sdhi.c
> > +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> > @@ -214,11 +214,11 @@ static int sh_mobile_sdhi_probe(struct platfo=
rm_device *pdev)
> >         }
> >
> >         host->dma               =3D dma_priv;
> > +       host->write16_hook      =3D sh_mobile_sdhi_write16_hook;
> >
> >         mmc_data->clk_enable =3D sh_mobile_sdhi_clk_enable;
> >         mmc_data->clk_disable =3D sh_mobile_sdhi_clk_disable;
> >         mmc_data->capabilities =3D MMC_CAP_MMC_HIGHSPEED;
> > -       mmc_data->write16_hook =3D sh_mobile_sdhi_write16_hook;
> >         mmc_data->multi_io_quirk =3D sh_mobile_sdhi_multi_io_quirk;
> >         if (p) {
> >                 mmc_data->flags =3D p->tmio_flags;
> > diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mm=
c.h
> > index 49a2559..3fa96b1 100644
> > --- a/drivers/mmc/host/tmio_mmc.h
> > +++ b/drivers/mmc/host/tmio_mmc.h
> > @@ -94,6 +94,8 @@ struct tmio_mmc_host {
> >         struct mutex            ios_lock;       /* protect set_ios(=
) context */
> >         bool                    native_hotplug;
> >         bool                    sdio_irq_enabled;
> > +
> > +       int (*write16_hook)(struct tmio_mmc_host *host, int addr);
> >  };
> >
> >  struct tmio_mmc_host *tmio_mmc_host_alloc(struct platform_device *=
pdev);
> > @@ -183,7 +185,7 @@ static inline void sd_ctrl_write16(struct tmio_=
mmc_host *host, int addr, u16 val
> >         /* If there is a hook and it returns non-zero then there
> >          * is an error and the write should be skipped
> >          */
> > -       if (host->pdata->write16_hook && host->pdata->write16_hook(=
host, addr))
> > +       if (host->write16_hook && host->write16_hook(host, addr))
> >                 return;
> >         writew(val, host->ctl + (addr << host->pdata->bus_shift));
> >  }
> > diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmi=
o_mmc_pio.c
> > index 1a9a13f..fe434cc 100644
> > --- a/drivers/mmc/host/tmio_mmc_pio.c
> > +++ b/drivers/mmc/host/tmio_mmc_pio.c
> > @@ -1090,7 +1090,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host =
*_host,
> >         tmio_mmc_of_parse(pdev, pdata);
> >
> >         if (!(pdata->flags & TMIO_MMC_HAS_IDLE_WAIT))
> > -               pdata->write16_hook =3D NULL;
> > +               _host->write16_hook =3D NULL;
> >
> >         res_ctl =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >         if (!res_ctl)
> > diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
> > index 8d708c7..0872ca1 100644
> > --- a/include/linux/mfd/tmio.h
> > +++ b/include/linux/mfd/tmio.h
> > @@ -112,8 +112,6 @@ void tmio_core_mmc_clk_div(void __iomem *cnf, i=
nt shift, int state);
> >
> >  struct dma_chan;
> >
> > -struct tmio_mmc_host;
> > -
> >  /*
> >   * data for the MMC controller
> >   */
> > @@ -127,7 +125,6 @@ struct tmio_mmc_data {
> >         unsigned int                    cd_gpio;
> >         void (*set_pwr)(struct platform_device *host, int state);
> >         void (*set_clk_div)(struct platform_device *host, int state=
);
> > -       int (*write16_hook)(struct tmio_mmc_host *host, int addr);
> >         /* clock management callbacks */
> >         int (*clk_enable)(struct platform_device *pdev, unsigned in=
t *f);
> >         void (*clk_disable)(struct platform_device *pdev);
> >

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
