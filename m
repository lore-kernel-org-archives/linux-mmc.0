From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH 2/3] ARM: S5PV210: Add support SDMMC WP through EXT_INT on
 SMDKV210
Date: Sat, 03 Jul 2010 10:11:59 +0900
Message-ID: <009201cb1a4c$bea62fb0$3bf28f10$%kim@samsung.com>
References: <1276601268-7226-1-git-send-email-kgene.kim@samsung.com>
 <1276601268-7226-3-git-send-email-kgene.kim@samsung.com>
 <4C1769D0.7040904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:32220 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752916Ab0GCBL4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Jul 2010 21:11:56 -0400
In-reply-to: <4C1769D0.7040904@gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Maurus Cuelenaere' <mcuelenaere@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, 'Lee Hyuk' <hyuk1.lee@samsung.com>

Maurus Cuelenaere wrote:
> 
> Op 15-06-10 13:27, Kukjin Kim schreef:
> > From: Lee Hyuk <hyuk1.lee@samsung.com>
> >
> > S5PV210 HSMMC host controller doesn't have the Write Protection pin which
> > should be connnected with SDMMC card WP pin. So allocated a GPIO in order
> to
> > get the data from SDMMC card WP pin with EXT_INT and implement get_ro and
> > cfg_wp function.
> >
> > Signed-off-by: Hyuk Lee <hyuk1.lee@samsung.com>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > ---
> >  arch/arm/mach-s5pv210/mach-smdkv210.c |    2 +
> >  arch/arm/mach-s5pv210/setup-sdhci.c   |   72
> +++++++++++++++++++++++++++++++++
> >  2 files changed, 74 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-
> s5pv210/mach-smdkv210.c
> > index b08f376..18cdb8c 100644
> > --- a/arch/arm/mach-s5pv210/mach-smdkv210.c
> > +++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
> > @@ -27,6 +27,7 @@
> >  #include <plat/cpu.h>
> >  #include <plat/adc.h>
> >  #include <plat/ts.h>
> > +#include <plat/sdhci.h>
> >
> >  /* Following are default values for UCON, ULCON and UFCON UART registers
> */
> >  #define S5PV210_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
> > @@ -101,6 +102,7 @@ static void __init smdkv210_map_io(void)
> >  static void __init smdkv210_machine_init(void)
> >  {
> >  	s3c24xx_ts_set_platdata(&s3c_ts_platform);
> > +	s3c_sdhci_set_platdata();
> >
> 
> Wouldn't it be better to name this s5pv210_sdhci_set_platdata() ?
> Also, see below.
> 
Ok..so used s3c_sdhciX_set_platdata() instead of using above.

> >  	platform_add_devices(smdkv210_devices,
> ARRAY_SIZE(smdkv210_devices));
> >  }
> >
> > diff --git a/arch/arm/mach-s5pv210/setup-sdhci.c b/arch/arm/mach-
> s5pv210/setup-sdhci.c
> > index 51815ec..b553b36 100644
> > --- a/arch/arm/mach-s5pv210/setup-sdhci.c
> > +++ b/arch/arm/mach-s5pv210/setup-sdhci.c
> > @@ -15,13 +15,17 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/io.h>
> > +#include <linux/gpio.h>
> >
> >  #include <linux/mmc/card.h>
> >  #include <linux/mmc/host.h>
> >
> > +#include <plat/gpio-cfg.h>
> >  #include <plat/regs-sdhci.h>
> >  #include <plat/sdhci.h>
> >
> > +#include <mach/map.h>
> > +
> >  /* clock sources for the mmc bus clock, order as for the ctrl2[5..4] */
> >
> >  char *s5pv210_hsmmc_clksrcs[4] = {
> > @@ -61,3 +65,71 @@ void s5pv210_setup_sdhci_cfg_card(struct
> platform_device *dev,
> >  	writel(ctrl2, r + S3C_SDHCI_CONTROL2);
> >  	writel(ctrl3, r + S3C_SDHCI_CONTROL3);
> >  }
> > +
> > +static int s5pv210_sdhci_get_ro(struct mmc_host *mmc)
> > +{
> > +	int gpio_dat;
> > +
> > +	if ((mmc->index == 0 && s3c_hsmmc0_def_platdata.cfg_wp != NULL) ||
> > +		(mmc->index == 1 && s3c_hsmmc1_def_platdata.cfg_wp !=
> NULL)) {
> > +		gpio_dat = __raw_readl((S5P_VA_GPIO + 0xC00) + 0x04);
> > +		return !!(gpio_dat & 0x80);
> > +	} else if (mmc->index == 2 && s3c_hsmmc2_def_platdata.cfg_wp !=
> NULL) {
> > +		gpio_dat = __raw_readl((S5P_VA_GPIO + 0xC00) + 0x64);
> > +		return !!(gpio_dat & 0x2);
> > +	} else if (mmc->index == 3 && s3c_hsmmc3_def_platdata.cfg_wp !=
> NULL) {
> > +		gpio_dat = __raw_readl((S5P_VA_GPIO + 0xC00) + 0x24);
> > +		return !!(gpio_dat & 0x1);
> > +	} else
> > +		return 0;
> > +}
> > +
> > +static void s5pv210_setup_sdhci_gpio_wp(int dev_id)
> > +{
> > +	switch (dev_id) {
> > +	case 0:
> > +	case 1:
> > +		s3c_gpio_cfgpin(S5PV210_GPH0(7), S3C_GPIO_INPUT);
> > +		s3c_gpio_setpull(S5PV210_GPH0(7), S3C_GPIO_PULL_UP);
> > +		break;
> > +	case 2:
> > +		s3c_gpio_cfgpin(S5PV210_GPH3(1), S3C_GPIO_INPUT);
> > +		s3c_gpio_setpull(S5PV210_GPH3(1), S3C_GPIO_PULL_UP);
> > +		break;
> > +	case 3:
> > +		s3c_gpio_cfgpin(S5PV210_GPH1(0), S3C_GPIO_INPUT);
> > +		s3c_gpio_setpull(S5PV210_GPH1(0), S3C_GPIO_PULL_UP);
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +}
> > +
> > +static struct s3c_sdhci_platdata hsmmc0_platdata = {
> > +	.cfg_wp         = s5pv210_setup_sdhci_gpio_wp,
> > +	.get_ro         = s5pv210_sdhci_get_ro,
> > +};
> > +
> > +static struct s3c_sdhci_platdata hsmmc1_platdata = {
> > +	.cfg_wp         = s5pv210_setup_sdhci_gpio_wp,
> > +	.get_ro         = s5pv210_sdhci_get_ro,
> > +};
> > +
> > +static struct s3c_sdhci_platdata hsmmc2_platdata = {
> > +	.cfg_wp         = s5pv210_setup_sdhci_gpio_wp,
> > +	.get_ro         = s5pv210_sdhci_get_ro,
> > +};
> > +
> > +static struct s3c_sdhci_platdata hsmmc3_platdata = {
> > +	.cfg_wp         = s5pv210_setup_sdhci_gpio_wp,
> > +	.get_ro         = s5pv210_sdhci_get_ro,
> > +};
> > +
> > +void s3c_sdhci_set_platdata(void)
> > +{
> > +	s3c_sdhci0_set_platdata(&hsmmc0_platdata);
> > +	s3c_sdhci1_set_platdata(&hsmmc1_platdata);
> > +	s3c_sdhci2_set_platdata(&hsmmc2_platdata);
> > +	s3c_sdhci3_set_platdata(&hsmmc3_platdata);
> > +}
> > +EXPORT_SYMBOL(s3c_sdhci_set_platdata);
> >
> 
> Why do you export this function? I don't see this being used anywhere
> except in mach-s5pv210.
> 
You're right..so machine specific functions moved in the machine file.
And removed unnecessary above function. EXPORT_SYMBOL also.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

