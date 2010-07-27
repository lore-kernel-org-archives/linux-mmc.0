From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH v3 3/3] sdhci-s3c: Add SDHCI_QUIRK_NO_WP_BIT quirk for
	Samsung SoC
Date: Tue, 27 Jul 2010 21:21:47 +0900
Message-ID: <001101cb2d86$4afddd90$e0f998b0$%kim@samsung.com>
References: <1279886191-9197-1-git-send-email-kgene.kim@samsung.com>
 <1279886191-9197-4-git-send-email-kgene.kim@samsung.com>
 <AANLkTiktYdBpgVtYUt69qfas4FHXvKvSEO4y9kf+DArE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <AANLkTiktYdBpgVtYUt69qfas4FHXvKvSEO4y9kf+DArE@mail.gmail.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Kyungmin Park' <kmpark@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, ben-linux@fluff.org, akpm@linux-foundation.org, 'Hyuk Lee' <hyuk1.lee@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Kyungmin Park wrote:
>=20
> On Fri, Jul 23, 2010 at 8:56 PM, Kukjin Kim <kgene.kim@samsung.com> w=
rote:
> > From: Hyuk Lee <hyuk1.lee@samsung.com>
> >
> > If host controller doesn't have WP pin which should be connnected w=
ith
SDMMC
> > card WP pin, can implement get_ro function with using the allocated
gpio.
> > In order to use this quirk wp_gpio in the platform data must be set=
=2E
> >
> > Signed-off-by: Hyuk Lee <hyuk1.lee@samsung.com>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > ---
> > =A0drivers/mmc/host/sdhci-s3c.c | =A0 43
> ++++++++++++++++++++++++++++++++++++++++++
> > =A0drivers/mmc/host/sdhci.c =A0 =A0 | =A0 =A03 ++
> > =A0drivers/mmc/host/sdhci.h =A0 =A0 | =A0 =A03 ++
> > =A03 files changed, 49 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-=
s3c.c
> > index 0d25285..0b75e57 100644
> > --- a/drivers/mmc/host/sdhci-s3c.c
> > +++ b/drivers/mmc/host/sdhci-s3c.c
> > @@ -22,6 +22,7 @@
> >
> > =A0#include <linux/mmc/host.h>
> >
> > +#include <plat/gpio-cfg.h>
> > =A0#include <plat/sdhci.h>
> > =A0#include <plat/regs-sdhci.h>
> >
> > @@ -213,6 +214,36 @@ static void sdhci_s3c_set_clock(struct sdhci_h=
ost
*host,
> unsigned int clock)
> > =A0}
> >
> > =A0/**
> > + * sdhci_s3c_get_ro - callback for get_ro
> > + * @host: The SDHCI host being changed
> > + *
> > + * If the WP pin is connected with GPIO, can get the value which
indicates
> > + * the card is locked or not.
> > +*/
> > +static int sdhci_s3c_get_ro(struct mmc_host *mmc)
> > +{
> > + =A0 =A0 =A0 struct sdhci_s3c *sc;
> > + =A0 =A0 =A0 struct sdhci_host *host;
> > +
> > + =A0 =A0 =A0 host =3D mmc_priv(mmc);
> > + =A0 =A0 =A0 sc =3D sdhci_priv(host);
> > +
> > + =A0 =A0 =A0 return gpio_get_value(sc->pdata->wp_gpio);
> > +}
> > +
> > +/**
> > + * sdhci_s3c_cfg_wp - configure GPIO for WP pin
> > + * @gpio_num: GPIO number which connected with WP line from SD/MMC=
 slot
> > + *
> > + * Configure GPIO for using WP line
> > +*/
> > +static void sdhci_s3c_cfg_wp(unsigned int gpio_num)
> > +{
> > + =A0 =A0 =A0 s3c_gpio_cfgpin(gpio_num, S3C_GPIO_INPUT);
> > + =A0 =A0 =A0 s3c_gpio_setpull(gpio_num, S3C_GPIO_PULL_UP);
> > +}
> > +
> > +/**
> > =A0* sdhci_s3c_get_min_clock - callback to get minimal supported cl=
ock
value
> > =A0* @host: The SDHCI host being queried
> > =A0*
> > @@ -375,6 +406,9 @@ static int __devinit sdhci_s3c_probe(struct
> platform_device *pdev)
> > =A0 =A0 =A0 =A0if (pdata->cfg_gpio)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdata->cfg_gpio(pdev, pdata->max_wid=
th);
> >
> > + =A0 =A0 =A0 if (gpio_is_valid(pdata->wp_gpio))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_s3c_ops.get_ro =3D sdhci_s3c_ge=
t_ro;
> > +
> > =A0 =A0 =A0 =A0host->hw_name =3D "samsung-hsmmc";
> > =A0 =A0 =A0 =A0host->ops =3D &sdhci_s3c_ops;
> > =A0 =A0 =A0 =A0host->quirks =3D 0;
> > @@ -408,6 +442,15 @@ static int __devinit sdhci_s3c_probe(struct
> platform_device *pdev)
> > =A0 =A0 =A0 =A0host->quirks |=3D (SDHCI_QUIRK_32BIT_DMA_ADDR |
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SDHCI_QUIRK_32BIT_D=
MA_SIZE);
> >
> > + =A0 =A0 =A0 /* Controller's WP pin donsn't connected with SD card=
 and there
is an
> > + =A0 =A0 =A0 =A0* allocated GPIO for getting WP data form SD card,=
 use this
quirk and
> > + =A0 =A0 =A0 =A0* send the GPIO number in pdata->wp_gpio. */
> > + =A0 =A0 =A0 host->quirks |=3D SDHCI_QUIRK_NO_WP_BIT;
> > +
> > + =A0 =A0 =A0 /* to configure gpio pin as a card write protection s=
ignal */
> > + =A0 =A0 =A0 if (gpio_is_valid(pdata->wp_gpio))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_s3c_cfg_wp(pdata->wp_gpio);
> > +
>=20
> Put it just one place like this.
>=20
> if (gpio_is_valid(pdata->wp_gpio)) {
>    sdhci_s3c_cfg_wp(pdata->wp_gpio);
> sdhci_s3c_ops.get_ro =3D sdhci_s3c_get_ro;
>    host->quirks |=3D SDHCI_QUIRK_NO_WP_BIT;
> }
>=20
> It reduce the below quirks check by one. If you add the quriks as you=
r
> patch, host->quirks are always true whether WP use or not.
>=20
Ok..thanks for your suggestion.

Will re-submit as per your comments.

> Thank you,
> Kyungmin Park
> > =A0 =A0 =A0 =A0ret =3D sdhci_add_host(host);
> > =A0 =A0 =A0 =A0if (ret) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "sdhci_add_host() faile=
d\n");
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index f9ca4c6..7fba401 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -1198,6 +1198,9 @@ static int sdhci_get_ro(struct mmc_host *mmc)
> >
> > =A0 =A0 =A0 =A0host =3D mmc_priv(mmc);
> >
> > + =A0 =A0 =A0 if ((host->quirks & SDHCI_QUIRK_NO_WP_BIT) && host->o=
ps->get_ro)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return host->ops->get_ro(mmc);
> > +
> > =A0 =A0 =A0 =A0spin_lock_irqsave(&host->lock, flags);
> >
> > =A0 =A0 =A0 =A0if (host->flags & SDHCI_DEVICE_DEAD)
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index 0de8b38..dd9a233 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -247,6 +247,8 @@ struct sdhci_host {
> > =A0#define SDHCI_QUIRK_MISSING_CAPS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 (1<<28)
> > =A0/* Controller has nonstandard clock management */
> > =A0#define SDHCI_QUIRK_NONSTANDARD_MINCLOCK =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (1<<29)
> > +/* Controller has no write-protect pin connected with SD card */
> > +#define SDHCI_QUIRK_NO_WP_BIT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0(1<<30)
> >
> > =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq; =A0=
 =A0 =A0 =A0 =A0 =A0/* Device IRQ */
> > =A0 =A0 =A0 =A0void __iomem * =A0 =A0 =A0 =A0 =A0ioaddr; =A0 =A0 =A0=
 =A0 /* Mapped address */
> > @@ -321,6 +323,7 @@ struct sdhci_ops {
> > =A0 =A0 =A0 =A0unsigned int =A0 =A0(*get_max_clock)(struct sdhci_ho=
st *host);
> > =A0 =A0 =A0 =A0unsigned int =A0 =A0(*get_min_clock)(struct sdhci_ho=
st *host);
> > =A0 =A0 =A0 =A0unsigned int =A0 =A0(*get_timeout_clock)(struct sdhc=
i_host *host);
> > + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 (*get_ro)(struct mmc_host=
 *mmc);
> > =A0};
> >
> > =A0#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> > --
> > 1.6.2.5
> >
> > --

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
