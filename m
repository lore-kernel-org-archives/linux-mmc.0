From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH 1/5] ARM: S5PV310: Add HSMMC support and SDHCI configuration
Date: Thu, 16 Sep 2010 18:13:02 +0900
Message-ID: <AANLkTi=Vx42siGBno7sLrirCRSiMvEr=2-toHHYU7405@mail.gmail.com>
References: <1284626223-18944-1-git-send-email-jeongbae.seo@samsung.com>
	<1284626223-18944-2-git-send-email-jeongbae.seo@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1284626223-18944-2-git-send-email-jeongbae.seo@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jeongbae Seo <jeongbae.seo@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, ben-linux@fluff.org, kgene.kim@samsung.com, akpm@linux-foundation.org, Hyuk Lee <hyuk1.lee@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, Sep 16, 2010 at 5:36 PM, Jeongbae Seo <jeongbae.seo@samsung.com=
> wrote:
> From: Hyuk Lee <hyuk1.lee@samsung.com>
>
> This patch adds to support HSMMC for S5PV310 and S5PC210 and setup fo=
r
> HSMMC host controller and also related GPIO.
> At most 4 channel can be used at the same time.
> A user can configure SDHCI data bus as 8bit or 4bit.
>
> Signed-off-by: Hyuk Lee <hyuk1.lee@samsung.com>
> Signed-off-by: Jeongbae Seo <jeongbae.seo@samsung.com>
> ---
> =A0arch/arm/mach-s5pv310/Kconfig =A0 =A0 =A0 =A0 =A0 =A0| =A0 39 ++++=
++++
> =A0arch/arm/mach-s5pv310/Makefile =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +
> =A0arch/arm/mach-s5pv310/setup-sdhci-gpio.c | =A0156 ++++++++++++++++=
++++++++++++++
> =A0arch/arm/mach-s5pv310/setup-sdhci.c =A0 =A0 =A0| =A0 69 ++++++++++=
+++
> =A04 files changed, 266 insertions(+), 0 deletions(-)
> =A0create mode 100644 arch/arm/mach-s5pv310/setup-sdhci-gpio.c
> =A0create mode 100644 arch/arm/mach-s5pv310/setup-sdhci.c
>
> diff --git a/arch/arm/mach-s5pv310/Kconfig b/arch/arm/mach-s5pv310/Kc=
onfig
> index 9ac29fe..6a07968 100644
> --- a/arch/arm/mach-s5pv310/Kconfig
> +++ b/arch/arm/mach-s5pv310/Kconfig
> @@ -25,6 +25,17 @@ config S5PV310_SETUP_I2C2
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0Common setup code for i2c bus 2.
>
> +config S5PV310_SETUP_SDHCI
> + =A0 =A0 =A0 bool
> + =A0 =A0 =A0 select S5PV310_SETUP_SDHCI_GPIO
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Internal helper functions for S5PV310 based SDHCI s=
ystems.
> +
> +config S5PV310_SETUP_SDHCI_GPIO
> + =A0 =A0 =A0 bool
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Common setup code for SDHCI gpio.
> +
> =A0# machine support
>
> =A0menu "S5PC210 Machines"
> @@ -33,6 +44,11 @@ config MACH_SMDKC210
> =A0 =A0 =A0 =A0bool "SMDKC210"
> =A0 =A0 =A0 =A0select CPU_S5PV310
> =A0 =A0 =A0 =A0select ARCH_SPARSEMEM_ENABLE
> + =A0 =A0 =A0 select S3C_DEV_HSMMC
> + =A0 =A0 =A0 select S3C_DEV_HSMMC1
> + =A0 =A0 =A0 select S3C_DEV_HSMMC2
> + =A0 =A0 =A0 select S3C_DEV_HSMMC3
> + =A0 =A0 =A0 select S5PV310_SETUP_SDHCI
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0Machine support for Samsung SMDKC210
> =A0 =A0 =A0 =A0 =A0S5PC210(MCP) is one of package option of S5PV310
> @@ -53,9 +69,32 @@ config MACH_SMDKV310
> =A0 =A0 =A0 =A0bool "SMDKV310"
> =A0 =A0 =A0 =A0select CPU_S5PV310
> =A0 =A0 =A0 =A0select ARCH_SPARSEMEM_ENABLE
> + =A0 =A0 =A0 select S3C_DEV_HSMMC
> + =A0 =A0 =A0 select S3C_DEV_HSMMC1
> + =A0 =A0 =A0 select S3C_DEV_HSMMC2
> + =A0 =A0 =A0 select S3C_DEV_HSMMC3
> + =A0 =A0 =A0 select S5PV310_SETUP_SDHCI
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0Machine support for Samsung SMDKV310
>
> =A0endmenu
>
> +comment "Configuration for HSMMC bus width"
> +
> +menu "Use 8-bit bus width"
> +
> +config S5PV310_SDHCI_CH0_8BIT
> + =A0 =A0 =A0 bool "Channel 0 with 8-bit bus"
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Support HSMMC Channel 0 8-bit bus.
> + =A0 =A0 =A0 =A0 If selected, Channel 1 is disabled.
> +
> +config S5PV310_SDHCI_CH2_8BIT
> + =A0 =A0 =A0 bool "Channel 2 with 8-bit bus"
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Support HSMMC Channel 2 8-bit bus.
> + =A0 =A0 =A0 =A0 If selected, Channel 3 is disabled.

I think it's not needed since most boards have fixed bandwith and
cfg_gpio handle it regardless these configuration.
Also we use the select state if needed, e.g., when MMC0 uses
8-buswidth then don't select MMC1.
I saw the SMDK board use this configuration. but just choose bandwidth =
4 or 8.

Others good.

Thank you,
Kyungmin Park
> +
> +endmenu
> +
> =A0endif
> diff --git a/arch/arm/mach-s5pv310/Makefile b/arch/arm/mach-s5pv310/M=
akefile
> index aefb14f..c89b6b0 100644
> --- a/arch/arm/mach-s5pv310/Makefile
> +++ b/arch/arm/mach-s5pv310/Makefile
> @@ -29,3 +29,5 @@ obj-$(CONFIG_MACH_UNIVERSAL_C210) =A0 =A0 +=3D mach=
-universal_c210.o
>
> =A0obj-$(CONFIG_S5PV310_SETUP_I2C1) =A0 =A0 =A0 +=3D setup-i2c1.o
> =A0obj-$(CONFIG_S5PV310_SETUP_I2C2) =A0 =A0 =A0 +=3D setup-i2c2.o
> +obj-$(CONFIG_S5PV310_SETUP_SDHCI) =A0 =A0 =A0+=3D setup-sdhci.o
> +obj-$(CONFIG_S5PV310_SETUP_SDHCI_GPIO) +=3D setup-sdhci-gpio.o
> diff --git a/arch/arm/mach-s5pv310/setup-sdhci-gpio.c b/arch/arm/mach=
-s5pv310/setup-sdhci-gpio.c
> new file mode 100644
> index 0000000..8db8c81
> --- /dev/null
> +++ b/arch/arm/mach-s5pv310/setup-sdhci-gpio.c
> @@ -0,0 +1,156 @@
> +/* linux/arch/arm/mach-s5pv310/setup-sdhci-gpio.c
> + *
> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> + * =A0 =A0 =A0 =A0 =A0 =A0 http://www.samsung.com/
> + *
> + * S5PV310 - Helper functions for setting up SDHCI device(s) GPIO (H=
SMMC)
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/gpio.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/card.h>
> +
> +#include <plat/gpio-cfg.h>
> +#include <plat/regs-sdhci.h>
> +#include <plat/sdhci.h>
> +
> +void s5pv310_setup_sdhci0_cfg_gpio(struct platform_device *dev, int =
width)
> +{
> + =A0 =A0 =A0 struct s3c_sdhci_platdata *pdata =3D dev->dev.platform_=
data;
> + =A0 =A0 =A0 unsigned int gpio;
> +
> + =A0 =A0 =A0 /* Set all the necessary GPK0[0:1] pins to special-func=
tion 2 */
> + =A0 =A0 =A0 for (gpio =3D S5PV310_GPK0(0); gpio < S5PV310_GPK0(2); =
gpio++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NO=
NE);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 switch (width) {
> + =A0 =A0 =A0 case 8:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (gpio =3D S5PV310_GPK1(3); gpio <=3D=
 S5PV310_GPK1(6); gpio++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Data pin GPK1[3:6] t=
o special-funtion 3 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c_gpio_cfgpin(gpio, S=
3C_GPIO_SFN(3));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c_gpio_setpull(gpio, =
S3C_GPIO_PULL_UP);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Setup Drive Strength=
 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_gpio_set_drvstr(gpi=
o, S5P_GPIO_DRVSTR_LV4);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 case 4:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (gpio =3D S5PV310_GPK0(3); gpio <=3D=
 S5PV310_GPK0(6); gpio++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Data pin GPK0[3:6] t=
o special-funtion 2 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c_gpio_cfgpin(gpio, S=
3C_GPIO_SFN(2));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c_gpio_setpull(gpio, =
S3C_GPIO_PULL_UP);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Setup Drive Strength=
 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_gpio_set_drvstr(gpi=
o, S5P_GPIO_DRVSTR_LV4);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (pdata->cd_type =3D=3D S3C_SDHCI_CD_INTERNAL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c_gpio_cfgpin(S5PV310_GPK0(2), S3C_GP=
IO_SFN(2));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c_gpio_setpull(S5PV310_GPK0(2), S3C_G=
PIO_PULL_UP);
> + =A0 =A0 =A0 }
> +}
> +
> +void s5pv310_setup_sdhci1_cfg_gpio(struct platform_device *dev, int =
width)
> +{
> + =A0 =A0 =A0 struct s3c_sdhci_platdata *pdata =3D dev->dev.platform_=
data;
> + =A0 =A0 =A0 unsigned int gpio;
> +
> + =A0 =A0 =A0 /* Set all the necessary GPK1[0:1] pins to special-func=
tion 2 */
> + =A0 =A0 =A0 for (gpio =3D S5PV310_GPK1(0); gpio < S5PV310_GPK1(2); =
gpio++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NO=
NE);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 for (gpio =3D S5PV310_GPK1(3); gpio <=3D S5PV310_GPK1(6=
); gpio++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Data pin GPK1[3:6] to special-functi=
on 2 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c_gpio_setpull(gpio, S3C_GPIO_PULL_UP=
);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Setup Drive Strength */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVS=
TR_LV4);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (pdata->cd_type =3D=3D S3C_SDHCI_CD_INTERNAL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c_gpio_cfgpin(S5PV310_GPK1(2), S3C_GP=
IO_SFN(2));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c_gpio_setpull(S5PV310_GPK1(2), S3C_G=
PIO_PULL_UP);
> + =A0 =A0 =A0 }
> +}
> +
> +void s5pv310_setup_sdhci2_cfg_gpio(struct platform_device *dev, int =
width)
> +{
> + =A0 =A0 =A0 struct s3c_sdhci_platdata *pdata =3D dev->dev.platform_=
data;
> + =A0 =A0 =A0 unsigned int gpio;
> +
> + =A0 =A0 =A0 /* Set all the necessary GPK2[0:1] pins to special-func=
tion 2 */
> + =A0 =A0 =A0 for (gpio =3D S5PV310_GPK2(0); gpio < S5PV310_GPK2(2); =
gpio++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NO=
NE);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 switch (width) {
> + =A0 =A0 =A0 case 8:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (gpio =3D S5PV310_GPK3(3); gpio <=3D=
 S5PV310_GPK3(6); gpio++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Data pin GPK3[3:6] t=
o special-function 3 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c_gpio_cfgpin(gpio, S=
3C_GPIO_SFN(3));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c_gpio_setpull(gpio, =
S3C_GPIO_PULL_UP);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Setup Drive Strength=
 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_gpio_set_drvstr(gpi=
o, S5P_GPIO_DRVSTR_LV4);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 case 4:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (gpio =3D S5PV310_GPK2(3); gpio <=3D=
 S5PV310_GPK2(6); gpio++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Data pin GPK2[3:6] t=
o special-function 2 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c_gpio_cfgpin(gpio, S=
3C_GPIO_SFN(2));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c_gpio_setpull(gpio, =
S3C_GPIO_PULL_UP);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Setup Drive Strength=
 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_gpio_set_drvstr(gpi=
o, S5P_GPIO_DRVSTR_LV4);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (pdata->cd_type =3D=3D S3C_SDHCI_CD_INTERNAL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c_gpio_cfgpin(S5PV310_GPK2(2), S3C_GP=
IO_SFN(2));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c_gpio_setpull(S5PV310_GPK2(2), S3C_G=
PIO_PULL_UP);
> + =A0 =A0 =A0 }
> +}
> +
> +void s5pv310_setup_sdhci3_cfg_gpio(struct platform_device *dev, int =
width)
> +{
> + =A0 =A0 =A0 struct s3c_sdhci_platdata *pdata =3D dev->dev.platform_=
data;
> + =A0 =A0 =A0 unsigned int gpio;
> +
> + =A0 =A0 =A0 /* Set all the necessary GPK3[0:1] pins to special-func=
tion 2 */
> + =A0 =A0 =A0 for (gpio =3D S5PV310_GPK3(0); gpio < S5PV310_GPK3(2); =
gpio++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NO=
NE);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 for (gpio =3D S5PV310_GPK3(3); gpio <=3D S5PV310_GPK3(6=
); gpio++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Data pin GPK3[3:6] to special-functi=
on 2 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c_gpio_setpull(gpio, S3C_GPIO_PULL_UP=
);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Setup Drive Strength */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVS=
TR_LV4);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (pdata->cd_type =3D=3D S3C_SDHCI_CD_INTERNAL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c_gpio_cfgpin(S5PV310_GPK3(2), S3C_GP=
IO_SFN(2));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c_gpio_setpull(S5PV310_GPK3(2), S3C_G=
PIO_PULL_UP);
> + =A0 =A0 =A0 }
> +}
> diff --git a/arch/arm/mach-s5pv310/setup-sdhci.c b/arch/arm/mach-s5pv=
310/setup-sdhci.c
> new file mode 100644
> index 0000000..db8358f
> --- /dev/null
> +++ b/arch/arm/mach-s5pv310/setup-sdhci.c
> @@ -0,0 +1,69 @@
> +/* linux/arch/arm/mach-s5pv310/setup-sdhci.c
> + *
> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> + * =A0 =A0 =A0 =A0 =A0 =A0 http://www.samsung.com/
> + *
> + * S5PV310 - Helper functions for settign up SDHCI device(s) (HSMMC)
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +
> +#include <linux/mmc/card.h>
> +#include <linux/mmc/host.h>
> +
> +#include <plat/regs-sdhci.h>
> +
> +/* clock sources for the mmc bus clock, order as for the ctrl2[5..4]=
 */
> +
> +char *s5pv310_hsmmc_clksrcs[4] =3D {
> + =A0 =A0 =A0 [0] =3D NULL,
> + =A0 =A0 =A0 [1] =3D NULL,
> + =A0 =A0 =A0 [2] =3D "sclk_mmc", =A0 =A0 =A0 /* mmc_bus */
> + =A0 =A0 =A0 [3] =3D NULL,
> +};
> +
> +void s5pv310_setup_sdhci_cfg_card(struct platform_device *dev, void =
__iomem *r,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 str=
uct mmc_ios *ios, struct mmc_card *card)
> +{
> + =A0 =A0 =A0 u32 ctrl2, ctrl3;
> +
> + =A0 =A0 =A0 /* don't need to alter anything acording to card-type *=
/
> +
> + =A0 =A0 =A0 ctrl2 =3D readl(r + S3C_SDHCI_CONTROL2);
> +
> + =A0 =A0 =A0 /* select base clock source to HCLK */
> +
> + =A0 =A0 =A0 ctrl2 &=3D S3C_SDHCI_CTRL2_SELBASECLK_MASK;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* clear async mode, enable conflict mask, rx feedbac=
k ctrl, SD
> + =A0 =A0 =A0 =A0* clk hold and no use debounce count
> + =A0 =A0 =A0 =A0*/
> +
> + =A0 =A0 =A0 ctrl2 |=3D (S3C64XX_SDHCI_CTRL2_ENSTAASYNCCLR |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 S3C64XX_SDHCI_CTRL2_ENCMDCNFMSK |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 S3C_SDHCI_CTRL2_ENFBCLKRX |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 S3C_SDHCI_CTRL2_DFCNT_NONE |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 S3C_SDHCI_CTRL2_ENCLKOUTHOLD);
> +
> + =A0 =A0 =A0 /* Tx and Rx feedback clock delay control */
> +
> + =A0 =A0 =A0 if (ios->clock < 25 * 1000000)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl3 =3D (S3C_SDHCI_CTRL3_FCSEL3 |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0S3C_SDHCI_CTRL3_FCSE=
L2 |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0S3C_SDHCI_CTRL3_FCSE=
L1 |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0S3C_SDHCI_CTRL3_FCSE=
L0);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl3 =3D (S3C_SDHCI_CTRL3_FCSEL1 | S3C=
_SDHCI_CTRL3_FCSEL0);
> +
> + =A0 =A0 =A0 writel(ctrl2, r + S3C_SDHCI_CONTROL2);
> + =A0 =A0 =A0 writel(ctrl3, r + S3C_SDHCI_CONTROL3);
> +}
> --
> 1.6.2.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsu=
ng-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
