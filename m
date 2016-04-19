From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/6] mmc: sh_mobile_sdhi: remove obsolete irq_by_name
 registration
Date: Tue, 19 Apr 2016 11:37:13 +0200
Message-ID: <20160419093713.GC1521@katana>
References: <1459934734-3613-1-git-send-email-wsa@the-dreams.de>
 <1459934734-3613-3-git-send-email-wsa@the-dreams.de>
 <CAPDyKFqixO2EGxdx4ERy=DSTR+KBunrYyfR26+AYN0k5_dVHiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="69pVuxX8awAiJ7fD"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFqixO2EGxdx4ERy=DSTR+KBunrYyfR26+AYN0k5_dVHiw@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: linux-mmc@vger.kernel.org


--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 18, 2016 at 10:21:41AM +0200, Ulf Hansson wrote:
> On 6 April 2016 at 11:25, Wolfram Sang <wsa@the-dreams.de> wrote:
> > From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >
> > There is no user left in the kernel, so this code can be removed.
> > (Legacy, non-DT sh_mobile boards have been removed a while ago.) The
> > diff looks more complicated than it is: The if-block for multiplexed isr
> > is now the main code path, the rest is removed. A number of sh boards
> > included the now deleted include file without needing it. Remove that,
> > too.
> >
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > ---
> >  arch/sh/boards/board-sh7757lcr.c     |  1 -
> >  arch/sh/boards/mach-ap325rxa/setup.c |  1 -
> >  arch/sh/boards/mach-ecovec24/setup.c |  1 -
> >  arch/sh/boards/mach-kfr2r09/setup.c  |  1 -
> >  arch/sh/boards/mach-migor/setup.c    |  1 -
> >  arch/sh/boards/mach-se/7724/setup.c  |  1 -
> >  drivers/mmc/host/sh_mobile_sdhi.c    | 57 +++++-----------------------=
--------
> >  include/linux/mmc/sh_mobile_sdhi.h   | 10 -------
> >  8 files changed, 8 insertions(+), 65 deletions(-)
> >  delete mode 100644 include/linux/mmc/sh_mobile_sdhi.h
>=20
> Hi Wolfram,
>=20
> I need and ack from the Superh arch maintainer to apply this one.
>=20
> It seems like you didn't include them on "to/cc" list, perhaps repost!?

I hoped adding the sh-list will be enough. Adding them to this mail
explicitly now, maybe this will do?

@SH-maintainers: some SH board files include a file with platform_data
they are not really using. Since I want to remove the platform_data
file, I remove inclusion of this file. That's all to it. Build bot was
happy, too.

Thanks,

   Wolfram

>=20
> Kind regards
> Uffe
>=20
> >
> > diff --git a/arch/sh/boards/board-sh7757lcr.c b/arch/sh/boards/board-sh=
7757lcr.c
> > index 324599bfad1420..0104c8199c48fe 100644
> > --- a/arch/sh/boards/board-sh7757lcr.c
> > +++ b/arch/sh/boards/board-sh7757lcr.c
> > @@ -20,7 +20,6 @@
> >  #include <linux/mfd/tmio.h>
> >  #include <linux/mmc/host.h>
> >  #include <linux/mmc/sh_mmcif.h>
> > -#include <linux/mmc/sh_mobile_sdhi.h>
> >  #include <linux/sh_eth.h>
> >  #include <linux/sh_intc.h>
> >  #include <linux/usb/renesas_usbhs.h>
> > diff --git a/arch/sh/boards/mach-ap325rxa/setup.c b/arch/sh/boards/mach=
-ap325rxa/setup.c
> > index 62c3b81300ed28..de8393cb7313bc 100644
> > --- a/arch/sh/boards/mach-ap325rxa/setup.c
> > +++ b/arch/sh/boards/mach-ap325rxa/setup.c
> > @@ -15,7 +15,6 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/mmc/host.h>
> > -#include <linux/mmc/sh_mobile_sdhi.h>
> >  #include <linux/mtd/physmap.h>
> >  #include <linux/mtd/sh_flctl.h>
> >  #include <linux/mfd/tmio.h>
> > diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach=
-ecovec24/setup.c
> > index a9c0c07386fddd..6d612792f6b8ec 100644
> > --- a/arch/sh/boards/mach-ecovec24/setup.c
> > +++ b/arch/sh/boards/mach-ecovec24/setup.c
> > @@ -13,7 +13,6 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/mmc/host.h>
> >  #include <linux/mmc/sh_mmcif.h>
> > -#include <linux/mmc/sh_mobile_sdhi.h>
> >  #include <linux/mtd/physmap.h>
> >  #include <linux/mfd/tmio.h>
> >  #include <linux/gpio.h>
> > diff --git a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-=
kfr2r09/setup.c
> > index 6bd9230e64e300..5deb2d82f19f78 100644
> > --- a/arch/sh/boards/mach-kfr2r09/setup.c
> > +++ b/arch/sh/boards/mach-kfr2r09/setup.c
> > @@ -11,7 +11,6 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/mmc/host.h>
> > -#include <linux/mmc/sh_mobile_sdhi.h>
> >  #include <linux/mfd/tmio.h>
> >  #include <linux/mtd/physmap.h>
> >  #include <linux/mtd/onenand.h>
> > diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-mi=
gor/setup.c
> > index 7a04da3efce402..5de60a77eaa1ab 100644
> > --- a/arch/sh/boards/mach-migor/setup.c
> > +++ b/arch/sh/boards/mach-migor/setup.c
> > @@ -13,7 +13,6 @@
> >  #include <linux/input.h>
> >  #include <linux/input/sh_keysc.h>
> >  #include <linux/mmc/host.h>
> > -#include <linux/mmc/sh_mobile_sdhi.h>
> >  #include <linux/mtd/physmap.h>
> >  #include <linux/mfd/tmio.h>
> >  #include <linux/mtd/nand.h>
> > diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-=
se/7724/setup.c
> > index e0e1df136642cd..f1fecd395679ae 100644
> > --- a/arch/sh/boards/mach-se/7724/setup.c
> > +++ b/arch/sh/boards/mach-se/7724/setup.c
> > @@ -15,7 +15,6 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/mmc/host.h>
> > -#include <linux/mmc/sh_mobile_sdhi.h>
> >  #include <linux/mfd/tmio.h>
> >  #include <linux/mtd/physmap.h>
> >  #include <linux/delay.h>
> > diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mo=
bile_sdhi.c
> > index 9beee48d2e280d..51d8dbd5b06a3e 100644
> > --- a/drivers/mmc/host/sh_mobile_sdhi.c
> > +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> > @@ -28,7 +28,6 @@
> >  #include <linux/of_device.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/mmc/host.h>
> > -#include <linux/mmc/sh_mobile_sdhi.h>
> >  #include <linux/mfd/tmio.h>
> >  #include <linux/sh_dma.h>
> >  #include <linux/delay.h>
> > @@ -315,7 +314,6 @@ static int sh_mobile_sdhi_probe(struct platform_dev=
ice *pdev)
> >         struct tmio_mmc_host *host;
> >         struct resource *res;
> >         int irq, ret, i =3D 0;
> > -       bool multiplexed_isr =3D true;
> >         struct tmio_mmc_dma *dma_priv;
> >
> >         res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > @@ -405,62 +403,23 @@ static int sh_mobile_sdhi_probe(struct platform_d=
evice *pdev)
> >         if (ret < 0)
> >                 goto efree;
> >
> > -       /*
> > -        * Allow one or more specific (named) ISRs or
> > -        * one or more multiplexed (un-named) ISRs.
> > -        */
> > -
> > -       irq =3D platform_get_irq_byname(pdev, SH_MOBILE_SDHI_IRQ_CARD_D=
ETECT);
> > -       if (irq >=3D 0) {
> > -               multiplexed_isr =3D false;
> > -               ret =3D devm_request_irq(&pdev->dev, irq, tmio_mmc_card=
_detect_irq, 0,
> > +       while (1) {
> > +               irq =3D platform_get_irq(pdev, i);
> > +               if (irq < 0)
> > +                       break;
> > +               i++;
> > +               ret =3D devm_request_irq(&pdev->dev, irq, tmio_mmc_irq,=
 0,
> >                                   dev_name(&pdev->dev), host);
> >                 if (ret)
> >                         goto eirq;
> >         }
> >
> > -       irq =3D platform_get_irq_byname(pdev, SH_MOBILE_SDHI_IRQ_SDIO);
> > -       if (irq >=3D 0) {
> > -               multiplexed_isr =3D false;
> > -               ret =3D devm_request_irq(&pdev->dev, irq, tmio_mmc_sdio=
_irq, 0,
> > -                                 dev_name(&pdev->dev), host);
> > -               if (ret)
> > -                       goto eirq;
> > -       }
> > -
> > -       irq =3D platform_get_irq_byname(pdev, SH_MOBILE_SDHI_IRQ_SDCARD=
);
> > -       if (irq >=3D 0) {
> > -               multiplexed_isr =3D false;
> > -               ret =3D devm_request_irq(&pdev->dev, irq, tmio_mmc_sdca=
rd_irq, 0,
> > -                                 dev_name(&pdev->dev), host);
> > -               if (ret)
> > -                       goto eirq;
> > -       } else if (!multiplexed_isr) {
> > -               dev_err(&pdev->dev,
> > -                       "Principal SD-card IRQ is missing among named i=
nterrupts\n");
> > +       /* There must be at least one IRQ source */
> > +       if (!i) {
> >                 ret =3D irq;
> >                 goto eirq;
> >         }
> >
> > -       if (multiplexed_isr) {
> > -               while (1) {
> > -                       irq =3D platform_get_irq(pdev, i);
> > -                       if (irq < 0)
> > -                               break;
> > -                       i++;
> > -                       ret =3D devm_request_irq(&pdev->dev, irq, tmio_=
mmc_irq, 0,
> > -                                         dev_name(&pdev->dev), host);
> > -                       if (ret)
> > -                               goto eirq;
> > -               }
> > -
> > -               /* There must be at least one IRQ source */
> > -               if (!i) {
> > -                       ret =3D irq;
> > -                       goto eirq;
> > -               }
> > -       }
> > -
> >         dev_info(&pdev->dev, "%s base at 0x%08lx max clock rate %u MHz\=
n",
> >                  mmc_hostname(host->mmc), (unsigned long)
> >                  (platform_get_resource(pdev, IORESOURCE_MEM, 0)->start=
),
> > diff --git a/include/linux/mmc/sh_mobile_sdhi.h b/include/linux/mmc/sh_=
mobile_sdhi.h
> > deleted file mode 100644
> > index 95d6f0314a7ded..00000000000000
> > --- a/include/linux/mmc/sh_mobile_sdhi.h
> > +++ /dev/null
> > @@ -1,10 +0,0 @@
> > -#ifndef LINUX_MMC_SH_MOBILE_SDHI_H
> > -#define LINUX_MMC_SH_MOBILE_SDHI_H
> > -
> > -#include <linux/types.h>
> > -
> > -#define SH_MOBILE_SDHI_IRQ_CARD_DETECT "card_detect"
> > -#define SH_MOBILE_SDHI_IRQ_SDCARD      "sdcard"
> > -#define SH_MOBILE_SDHI_IRQ_SDIO                "sdio"
> > -
> > -#endif /* LINUX_MMC_SH_MOBILE_SDHI_H */
> > --
> > 2.7.0
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

--69pVuxX8awAiJ7fD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXFfxJAAoJEBQN5MwUoCm2xv0P/A/au8pF9kbfo0xMCULiS2Dv
tKMNxp1mFOSg7wpdQOnN/4ZjW6bTqoeXmMVAmv5zZhPS9f8Hx1pBZun0a9LAhQLB
WRTPqq6O8Q8pkHLgxL4LkXsdjk2/jY4iRdD6+2TbeIYpaEGkPZq6PG/QkM31VnPz
6awGkLu1Kwp/LQkfD7RXV56Ra/RRzB5extiPPTt5SvQwRWz1gm/EPpPUz6X9gocg
fVRU24SdfuWhFma952HOqSvLmIoc+4CNN35L5aifWkIVrOvoU2EiiO1DgHdnhWR4
sUryNXflPixGit3mE/2H18pGArZBqjB3t1ZEzjMfhprqQ3SlVt3QJzCQiAvlhiEb
AOl4JoFXO8iIGJaKcLoR0n8yveZyDuWFWxPxsskTSZ241IV/aPHQqRUGI/oSSxh+
v0gZFGTQn5mPWrx2eCCegNFwLvbYRiSASJ+k9zTD4G5xN6Xo1hv6T+ze70T4pW5F
HvGfinAsv0lEYPM8iOf+U5NecEEP5ki9LbDLI0yqyM6pcYQuJTbBsRZ0luxij6ae
nvyp6kYXjKSsrRSWFVGscKT2/DCUMBTWhDYltNfgGBEXAqh/UJalB668uoSv/au4
jrAuZMAKWbHOhLZSeC7vvd+C4kSgfSn6slE+tCme4wqgrtx3Lm48cCBqff1rcqIB
RgxiOgqqkNcO+Ly2WJjF
=J1hD
-----END PGP SIGNATURE-----

--69pVuxX8awAiJ7fD--
