From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCH 1/5] ARM: S5PV310: Add HSMMC support and SDHCI configuration
Date: Mon, 04 Oct 2010 13:03:44 +0200
Message-ID: <012d01cb63b3$d26bb140$774313c0$%szyprowski@samsung.com>
References: <1284626223-18944-1-git-send-email-jeongbae.seo@samsung.com>
 <1284626223-18944-2-git-send-email-jeongbae.seo@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:23604 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753907Ab0JDLD5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Oct 2010 07:03:57 -0400
In-reply-to: <1284626223-18944-2-git-send-email-jeongbae.seo@samsung.com>
Content-language: pl
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Jeongbae Seo' <jeongbae.seo@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: akpm@linux-foundation.org, kgene.kim@samsung.com, 'Hyuk Lee' <hyuk1.lee@samsung.com>, ben-linux@fluff.org

Hello,

On Thursday, September 16, 2010 10:37 AM Jeongbae Seo wrote:

> From: Hyuk Lee <hyuk1.lee@samsung.com>
> 
> This patch adds to support HSMMC for S5PV310 and S5PC210 and setup for
> HSMMC host controller and also related GPIO.
> At most 4 channel can be used at the same time.
> A user can configure SDHCI data bus as 8bit or 4bit.
> 
> Signed-off-by: Hyuk Lee <hyuk1.lee@samsung.com>
> Signed-off-by: Jeongbae Seo <jeongbae.seo@samsung.com>
> ---
>  arch/arm/mach-s5pv310/Kconfig            |   39 ++++++++
>  arch/arm/mach-s5pv310/Makefile           |    2 +
>  arch/arm/mach-s5pv310/setup-sdhci-gpio.c |  156 ++++++++++++++++++++++++++++++
>  arch/arm/mach-s5pv310/setup-sdhci.c      |   69 +++++++++++++
>  4 files changed, 266 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-s5pv310/setup-sdhci-gpio.c
>  create mode 100644 arch/arm/mach-s5pv310/setup-sdhci.c
> 

<snip>

> diff --git a/arch/arm/mach-s5pv310/setup-sdhci-gpio.c b/arch/arm/mach-s5pv310/setup-sdhci-gpio.c
> new file mode 100644
> index 0000000..8db8c81
> --- /dev/null
> +++ b/arch/arm/mach-s5pv310/setup-sdhci-gpio.c
> @@ -0,0 +1,156 @@
> +/* linux/arch/arm/mach-s5pv310/setup-sdhci-gpio.c
> + *
> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com/
> + *
> + * S5PV310 - Helper functions for setting up SDHCI device(s) GPIO (HSMMC)
> + *
> + * This program is free software; you can redistribute it and/or modify
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
> +void s5pv310_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
> +{
> +	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
> +	unsigned int gpio;
> +
> +	/* Set all the necessary GPK0[0:1] pins to special-function 2 */
> +	for (gpio = S5PV310_GPK0(0); gpio < S5PV310_GPK0(2); gpio++) {
> +		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
> +		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
> +	}
> +
> +	switch (width) {
> +	case 8:
> +		for (gpio = S5PV310_GPK1(3); gpio <= S5PV310_GPK1(6); gpio++) {
> +			/* Data pin GPK1[3:6] to special-funtion 3 */
> +			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
> +			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_UP);
> +
> +			/* Setup Drive Strength */
> +			s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
> +		}
> +	case 4:
> +		for (gpio = S5PV310_GPK0(3); gpio <= S5PV310_GPK0(6); gpio++) {
> +			/* Data pin GPK0[3:6] to special-funtion 2 */
> +			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
> +			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_UP);
> +
> +			/* Setup Drive Strength */
> +			s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
> +		}
> +	default:
> +		break;
> +	}
> +
> +	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
> +		s3c_gpio_cfgpin(S5PV310_GPK0(2), S3C_GPIO_SFN(2));
> +		s3c_gpio_setpull(S5PV310_GPK0(2), S3C_GPIO_PULL_UP);
> +	}
> +}
> +
> +void s5pv310_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
> +{
> +	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
> +	unsigned int gpio;
> +
> +	/* Set all the necessary GPK1[0:1] pins to special-function 2 */
> +	for (gpio = S5PV310_GPK1(0); gpio < S5PV310_GPK1(2); gpio++) {
> +		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
> +		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
> +	}
> +
> +	for (gpio = S5PV310_GPK1(3); gpio <= S5PV310_GPK1(6); gpio++) {
> +		/* Data pin GPK1[3:6] to special-function 2 */
> +		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
> +		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_UP);
> +
> +		/* Setup Drive Strength */
> +		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
> +	}
> +
> +	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
> +		s3c_gpio_cfgpin(S5PV310_GPK1(2), S3C_GPIO_SFN(2));
> +		s3c_gpio_setpull(S5PV310_GPK1(2), S3C_GPIO_PULL_UP);
> +	}
> +}
> +
> +void s5pv310_setup_sdhci2_cfg_gpio(struct platform_device *dev, int width)
> +{
> +	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
> +	unsigned int gpio;
> +
> +	/* Set all the necessary GPK2[0:1] pins to special-function 2 */
> +	for (gpio = S5PV310_GPK2(0); gpio < S5PV310_GPK2(2); gpio++) {
> +		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
> +		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);

Lack of "s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4)" here causes problems with 
Universal C210 and external SD-card. IMHO driver strength should be set for all MMC
pins, not only for data pins like below (and do this for all MMC blocks of course). 

> +	}
> +
> +	switch (width) {
> +	case 8:
> +		for (gpio = S5PV310_GPK3(3); gpio <= S5PV310_GPK3(6); gpio++) {
> +			/* Data pin GPK3[3:6] to special-function 3 */
> +			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
> +			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_UP);
> +
> +			/* Setup Drive Strength */
> +			s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
> +		}
> +	case 4:
> +		for (gpio = S5PV310_GPK2(3); gpio <= S5PV310_GPK2(6); gpio++) {
> +			/* Data pin GPK2[3:6] to special-function 2 */
> +			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
> +			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_UP);
> +
> +			/* Setup Drive Strength */
> +			s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
> +		}
> +	default:
> +		break;
> +	}
> +
> +	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
> +		s3c_gpio_cfgpin(S5PV310_GPK2(2), S3C_GPIO_SFN(2));
> +		s3c_gpio_setpull(S5PV310_GPK2(2), S3C_GPIO_PULL_UP);
> +	}
> +}
> +
> +void s5pv310_setup_sdhci3_cfg_gpio(struct platform_device *dev, int width)
> +{
> +	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
> +	unsigned int gpio;
> +
> +	/* Set all the necessary GPK3[0:1] pins to special-function 2 */
> +	for (gpio = S5PV310_GPK3(0); gpio < S5PV310_GPK3(2); gpio++) {
> +		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
> +		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
> +	}
> +
> +	for (gpio = S5PV310_GPK3(3); gpio <= S5PV310_GPK3(6); gpio++) {
> +		/* Data pin GPK3[3:6] to special-function 2 */
> +		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
> +		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_UP);
> +
> +		/* Setup Drive Strength */
> +		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
> +	}
> +
> +	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
> +		s3c_gpio_cfgpin(S5PV310_GPK3(2), S3C_GPIO_SFN(2));
> +		s3c_gpio_setpull(S5PV310_GPK3(2), S3C_GPIO_PULL_UP);
> +	}
> +}

<snip>

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center


