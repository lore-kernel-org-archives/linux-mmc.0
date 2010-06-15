From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH 2/3] ARM: S5PV210: Add support SDMMC WP through EXT_INT on
	SMDKV210
Date: Tue, 15 Jun 2010 20:52:45 +0900
Message-ID: <AANLkTimQwmFGwRgXASba1ECwYDJaay_D1q4_L6tvIo9y@mail.gmail.com>
References: <1276601268-7226-1-git-send-email-kgene.kim@samsung.com>
	<1276601268-7226-3-git-send-email-kgene.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:36421 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757700Ab0FOLwq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Jun 2010 07:52:46 -0400
In-Reply-To: <1276601268-7226-3-git-send-email-kgene.kim@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, Lee Hyuk <hyuk1.lee@samsung.com>

On Tue, Jun 15, 2010 at 8:27 PM, Kukjin Kim <kgene.kim@samsung.com> wro=
te:
> From: Lee Hyuk <hyuk1.lee@samsung.com>
>
> S5PV210 HSMMC host controller doesn't have the Write Protection pin w=
hich
> should be connnected with SDMMC card WP pin. So allocated a GPIO in o=
rder to
> get the data from SDMMC card WP pin with EXT_INT and implement get_ro=
 and
> cfg_wp function.
>
> Signed-off-by: Hyuk Lee <hyuk1.lee@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
> =A0arch/arm/mach-s5pv210/mach-smdkv210.c | =A0 =A02 +
> =A0arch/arm/mach-s5pv210/setup-sdhci.c =A0 | =A0 72 +++++++++++++++++=
++++++++++++++++
> =A02 files changed, 74 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5=
pv210/mach-smdkv210.c
> index b08f376..18cdb8c 100644
> --- a/arch/arm/mach-s5pv210/mach-smdkv210.c
> +++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
> @@ -27,6 +27,7 @@
> =A0#include <plat/cpu.h>
> =A0#include <plat/adc.h>
> =A0#include <plat/ts.h>
> +#include <plat/sdhci.h>
>
> =A0/* Following are default values for UCON, ULCON and UFCON UART reg=
isters */
> =A0#define S5PV210_UCON_DEFAULT =A0 (S3C2410_UCON_TXILEVEL | =A0 =A0 =
=A0 =A0\
> @@ -101,6 +102,7 @@ static void __init smdkv210_map_io(void)
> =A0static void __init smdkv210_machine_init(void)
> =A0{
> =A0 =A0 =A0 =A0s3c24xx_ts_set_platdata(&s3c_ts_platform);
> + =A0 =A0 =A0 s3c_sdhci_set_platdata();
> =A0 =A0 =A0 =A0platform_add_devices(smdkv210_devices, ARRAY_SIZE(smdk=
v210_devices));
> =A0}
>
> diff --git a/arch/arm/mach-s5pv210/setup-sdhci.c b/arch/arm/mach-s5pv=
210/setup-sdhci.c
> index 51815ec..b553b36 100644
> --- a/arch/arm/mach-s5pv210/setup-sdhci.c
> +++ b/arch/arm/mach-s5pv210/setup-sdhci.c
> @@ -15,13 +15,17 @@
> =A0#include <linux/interrupt.h>
> =A0#include <linux/platform_device.h>
> =A0#include <linux/io.h>
> +#include <linux/gpio.h>
>
> =A0#include <linux/mmc/card.h>
> =A0#include <linux/mmc/host.h>
>
> +#include <plat/gpio-cfg.h>
> =A0#include <plat/regs-sdhci.h>
> =A0#include <plat/sdhci.h>
>
> +#include <mach/map.h>
> +
> =A0/* clock sources for the mmc bus clock, order as for the ctrl2[5..=
4] */
>
> =A0char *s5pv210_hsmmc_clksrcs[4] =3D {
> @@ -61,3 +65,71 @@ void s5pv210_setup_sdhci_cfg_card(struct platform_=
device *dev,
> =A0 =A0 =A0 =A0writel(ctrl2, r + S3C_SDHCI_CONTROL2);
> =A0 =A0 =A0 =A0writel(ctrl3, r + S3C_SDHCI_CONTROL3);
> =A0}
> +
> +static int s5pv210_sdhci_get_ro(struct mmc_host *mmc)
> +{
> + =A0 =A0 =A0 int gpio_dat;
> +
> + =A0 =A0 =A0 if ((mmc->index =3D=3D 0 && s3c_hsmmc0_def_platdata.cfg=
_wp !=3D NULL) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mmc->index =3D=3D 1 && s3c_hsmmc1_def_=
platdata.cfg_wp !=3D NULL)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_dat =3D __raw_readl((S5P_VA_GPIO +=
 0xC00) + 0x04);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return !!(gpio_dat & 0x80);

It's GPIO values, and it's smdk specific values. So it should go smdk
board files instead of platform common one.

> + =A0 =A0 =A0 } else if (mmc->index =3D=3D 2 && s3c_hsmmc2_def_platda=
ta.cfg_wp !=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_dat =3D __raw_readl((S5P_VA_GPIO +=
 0xC00) + 0x64);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return !!(gpio_dat & 0x2);
> + =A0 =A0 =A0 } else if (mmc->index =3D=3D 3 && s3c_hsmmc3_def_platda=
ta.cfg_wp !=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_dat =3D __raw_readl((S5P_VA_GPIO +=
 0xC00) + 0x24);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return !!(gpio_dat & 0x1);
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +}
> +
> +static void s5pv210_setup_sdhci_gpio_wp(int dev_id)
> +{
> + =A0 =A0 =A0 switch (dev_id) {
> + =A0 =A0 =A0 case 0:
> + =A0 =A0 =A0 case 1:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c_gpio_cfgpin(S5PV210_GPH0(7), S3C_GP=
IO_INPUT);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c_gpio_setpull(S5PV210_GPH0(7), S3C_G=
PIO_PULL_UP);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 2:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c_gpio_cfgpin(S5PV210_GPH3(1), S3C_GP=
IO_INPUT);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c_gpio_setpull(S5PV210_GPH3(1), S3C_G=
PIO_PULL_UP);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 3:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c_gpio_cfgpin(S5PV210_GPH1(0), S3C_GP=
IO_INPUT);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c_gpio_setpull(S5PV210_GPH1(0), S3C_G=
PIO_PULL_UP);

Ditto. board specific configurations. should go smdk board file.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +}
> +
> +static struct s3c_sdhci_platdata hsmmc0_platdata =3D {
> + =A0 =A0 =A0 .cfg_wp =A0 =A0 =A0 =A0 =3D s5pv210_setup_sdhci_gpio_wp=
,
> + =A0 =A0 =A0 .get_ro =A0 =A0 =A0 =A0 =3D s5pv210_sdhci_get_ro,
> +};
> +
> +static struct s3c_sdhci_platdata hsmmc1_platdata =3D {
> + =A0 =A0 =A0 .cfg_wp =A0 =A0 =A0 =A0 =3D s5pv210_setup_sdhci_gpio_wp=
,
> + =A0 =A0 =A0 .get_ro =A0 =A0 =A0 =A0 =3D s5pv210_sdhci_get_ro,
> +};
> +
> +static struct s3c_sdhci_platdata hsmmc2_platdata =3D {
> + =A0 =A0 =A0 .cfg_wp =A0 =A0 =A0 =A0 =3D s5pv210_setup_sdhci_gpio_wp=
,
> + =A0 =A0 =A0 .get_ro =A0 =A0 =A0 =A0 =3D s5pv210_sdhci_get_ro,
> +};
> +
> +static struct s3c_sdhci_platdata hsmmc3_platdata =3D {
> + =A0 =A0 =A0 .cfg_wp =A0 =A0 =A0 =A0 =3D s5pv210_setup_sdhci_gpio_wp=
,
> + =A0 =A0 =A0 .get_ro =A0 =A0 =A0 =A0 =3D s5pv210_sdhci_get_ro,
> +};
> +
> +void s3c_sdhci_set_platdata(void)
> +{
> + =A0 =A0 =A0 s3c_sdhci0_set_platdata(&hsmmc0_platdata);
> + =A0 =A0 =A0 s3c_sdhci1_set_platdata(&hsmmc1_platdata);
> + =A0 =A0 =A0 s3c_sdhci2_set_platdata(&hsmmc2_platdata);
> + =A0 =A0 =A0 s3c_sdhci3_set_platdata(&hsmmc3_platdata);
> +}
> +EXPORT_SYMBOL(s3c_sdhci_set_platdata);

I think all added lines should go smdk totally.

Thank you,
Kyungmin Park

> --
> 1.6.2.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
