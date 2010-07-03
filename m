From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH 2/3] ARM: S5PV210: Add support SDMMC WP through EXT_INT on
	SMDKV210
Date: Sat, 03 Jul 2010 10:08:01 +0900
Message-ID: <009101cb1a4c$3105a000$9310e000$%kim@samsung.com>
References: <1276601268-7226-1-git-send-email-kgene.kim@samsung.com>
 <1276601268-7226-3-git-send-email-kgene.kim@samsung.com>
 <AANLkTimQwmFGwRgXASba1ECwYDJaay_D1q4_L6tvIo9y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <AANLkTimQwmFGwRgXASba1ECwYDJaay_D1q4_L6tvIo9y@mail.gmail.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Kyungmin Park' <kmpark@infradead.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, 'Lee Hyuk' <hyuk1.lee@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Kyungmin Park wrote:
>=20
> On Tue, Jun 15, 2010 at 8:27 PM, Kukjin Kim <kgene.kim@samsung.com> w=
rote:
> > From: Lee Hyuk <hyuk1.lee@samsung.com>
> >
> > S5PV210 HSMMC host controller doesn't have the Write Protection pin
which
> > should be connnected with SDMMC card WP pin. So allocated a GPIO in
order
> to
> > get the data from SDMMC card WP pin with EXT_INT and implement get_=
ro
and
> > cfg_wp function.
> >
> > Signed-off-by: Hyuk Lee <hyuk1.lee@samsung.com>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > ---
> > =A0arch/arm/mach-s5pv210/mach-smdkv210.c | =A0 =A02 +
> > =A0arch/arm/mach-s5pv210/setup-sdhci.c =A0 | =A0 72
> +++++++++++++++++++++++++++++++++
> > =A02 files changed, 74 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-
> s5pv210/mach-smdkv210.c
> > index b08f376..18cdb8c 100644
> > --- a/arch/arm/mach-s5pv210/mach-smdkv210.c
> > +++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
> > @@ -27,6 +27,7 @@
> > =A0#include <plat/cpu.h>
> > =A0#include <plat/adc.h>
> > =A0#include <plat/ts.h>
> > +#include <plat/sdhci.h>
> >
> > =A0/* Following are default values for UCON, ULCON and UFCON UART
registers */
> > =A0#define S5PV210_UCON_DEFAULT =A0 (S3C2410_UCON_TXILEVEL | =A0 =A0=
 =A0 =A0\
> > @@ -101,6 +102,7 @@ static void __init smdkv210_map_io(void)
> > =A0static void __init smdkv210_machine_init(void)
> > =A0{
> > =A0 =A0 =A0 =A0s3c24xx_ts_set_platdata(&s3c_ts_platform);
> > + =A0 =A0 =A0 s3c_sdhci_set_platdata();
> > =A0 =A0 =A0 =A0platform_add_devices(smdkv210_devices,
> ARRAY_SIZE(smdkv210_devices));
> > =A0}
> >
> > diff --git a/arch/arm/mach-s5pv210/setup-sdhci.c b/arch/arm/mach-
> s5pv210/setup-sdhci.c
> > index 51815ec..b553b36 100644
> > --- a/arch/arm/mach-s5pv210/setup-sdhci.c
> > +++ b/arch/arm/mach-s5pv210/setup-sdhci.c
> > @@ -15,13 +15,17 @@
> > =A0#include <linux/interrupt.h>
> > =A0#include <linux/platform_device.h>
> > =A0#include <linux/io.h>
> > +#include <linux/gpio.h>
> >
> > =A0#include <linux/mmc/card.h>
> > =A0#include <linux/mmc/host.h>
> >
> > +#include <plat/gpio-cfg.h>
> > =A0#include <plat/regs-sdhci.h>
> > =A0#include <plat/sdhci.h>
> >
> > +#include <mach/map.h>
> > +
> > =A0/* clock sources for the mmc bus clock, order as for the ctrl2[5=
=2E.4] */
> >
> > =A0char *s5pv210_hsmmc_clksrcs[4] =3D {
> > @@ -61,3 +65,71 @@ void s5pv210_setup_sdhci_cfg_card(struct
> platform_device *dev,
> > =A0 =A0 =A0 =A0writel(ctrl2, r + S3C_SDHCI_CONTROL2);
> > =A0 =A0 =A0 =A0writel(ctrl3, r + S3C_SDHCI_CONTROL3);
> > =A0}
> > +
> > +static int s5pv210_sdhci_get_ro(struct mmc_host *mmc)
> > +{
> > + =A0 =A0 =A0 int gpio_dat;
> > +
> > + =A0 =A0 =A0 if ((mmc->index =3D=3D 0 && s3c_hsmmc0_def_platdata.c=
fg_wp !=3D NULL)
||
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mmc->index =3D=3D 1 && s3c_hsmmc1_de=
f_platdata.cfg_wp !=3D
> NULL)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_dat =3D __raw_readl((S5P_VA_GPIO=
 + 0xC00) + 0x04);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return !!(gpio_dat & 0x80);
>=20
> It's GPIO values, and it's smdk specific values. So it should go smdk
> board files instead of platform common one.
>=20
Yes, you're right..moved.

> > + =A0 =A0 =A0 } else if (mmc->index =3D=3D 2 && s3c_hsmmc2_def_plat=
data.cfg_wp !=3D
> NULL) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_dat =3D __raw_readl((S5P_VA_GPIO=
 + 0xC00) + 0x64);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return !!(gpio_dat & 0x2);
> > + =A0 =A0 =A0 } else if (mmc->index =3D=3D 3 && s3c_hsmmc3_def_plat=
data.cfg_wp !=3D
> NULL) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_dat =3D __raw_readl((S5P_VA_GPIO=
 + 0xC00) + 0x24);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return !!(gpio_dat & 0x1);
> > + =A0 =A0 =A0 } else
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> > +}
> > +
> > +static void s5pv210_setup_sdhci_gpio_wp(int dev_id)
> > +{
> > + =A0 =A0 =A0 switch (dev_id) {
> > + =A0 =A0 =A0 case 0:
> > + =A0 =A0 =A0 case 1:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c_gpio_cfgpin(S5PV210_GPH0(7), S3C_=
GPIO_INPUT);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c_gpio_setpull(S5PV210_GPH0(7), S3C=
_GPIO_PULL_UP);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > + =A0 =A0 =A0 case 2:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c_gpio_cfgpin(S5PV210_GPH3(1), S3C_=
GPIO_INPUT);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c_gpio_setpull(S5PV210_GPH3(1), S3C=
_GPIO_PULL_UP);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > + =A0 =A0 =A0 case 3:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c_gpio_cfgpin(S5PV210_GPH1(0), S3C_=
GPIO_INPUT);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c_gpio_setpull(S5PV210_GPH1(0), S3C=
_GPIO_PULL_UP);
>=20
> Ditto. board specific configurations. should go smdk board file.
>=20
Moved.

> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > + =A0 =A0 =A0 default:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > + =A0 =A0 =A0 }
> > +}
> > +
> > +static struct s3c_sdhci_platdata hsmmc0_platdata =3D {
> > + =A0 =A0 =A0 .cfg_wp =A0 =A0 =A0 =A0 =3D s5pv210_setup_sdhci_gpio_=
wp,
> > + =A0 =A0 =A0 .get_ro =A0 =A0 =A0 =A0 =3D s5pv210_sdhci_get_ro,
> > +};
> > +
> > +static struct s3c_sdhci_platdata hsmmc1_platdata =3D {
> > + =A0 =A0 =A0 .cfg_wp =A0 =A0 =A0 =A0 =3D s5pv210_setup_sdhci_gpio_=
wp,
> > + =A0 =A0 =A0 .get_ro =A0 =A0 =A0 =A0 =3D s5pv210_sdhci_get_ro,
> > +};
> > +
> > +static struct s3c_sdhci_platdata hsmmc2_platdata =3D {
> > + =A0 =A0 =A0 .cfg_wp =A0 =A0 =A0 =A0 =3D s5pv210_setup_sdhci_gpio_=
wp,
> > + =A0 =A0 =A0 .get_ro =A0 =A0 =A0 =A0 =3D s5pv210_sdhci_get_ro,
> > +};
> > +
> > +static struct s3c_sdhci_platdata hsmmc3_platdata =3D {
> > + =A0 =A0 =A0 .cfg_wp =A0 =A0 =A0 =A0 =3D s5pv210_setup_sdhci_gpio_=
wp,
> > + =A0 =A0 =A0 .get_ro =A0 =A0 =A0 =A0 =3D s5pv210_sdhci_get_ro,
> > +};
> > +
> > +void s3c_sdhci_set_platdata(void)
> > +{
> > + =A0 =A0 =A0 s3c_sdhci0_set_platdata(&hsmmc0_platdata);
> > + =A0 =A0 =A0 s3c_sdhci1_set_platdata(&hsmmc1_platdata);
> > + =A0 =A0 =A0 s3c_sdhci2_set_platdata(&hsmmc2_platdata);
> > + =A0 =A0 =A0 s3c_sdhci3_set_platdata(&hsmmc3_platdata);
> > +}
> > +EXPORT_SYMBOL(s3c_sdhci_set_platdata);
>=20
> I think all added lines should go smdk totally.
>=20
=46ixed in v2 patches as your comments.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
