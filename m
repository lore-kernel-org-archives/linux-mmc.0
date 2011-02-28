From: Zhu Richard-R65037 <R65037@freescale.com>
Subject: RE: [PATCH V3 1/4] ARM: imx53_loco: add esdhc device support
Date: Mon, 28 Feb 2011 11:39:17 +0000
Message-ID: <010C9052C42A00499CE76D637FA5EE900C7A26@039-SN1MPN1-001.039d.mgd.msft.net>
References: <1298892725-23672-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:29824 "EHLO
	TX2EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753346Ab1B1LjU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Feb 2011 06:39:20 -0500
In-Reply-To: <1298892725-23672-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhu Richard-R65037 <R65037@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "avorontsov@ru.mvista.com" <avorontsov@ru.mvista.com>, "eric@eukrea.com" <eric@eukrea.com>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>, "linuxzsc@gmail.com" <linuxzsc@gmail.com>, Zhao Richard-B20223 <B20223@freescale.com>, "Freescale@lists.linaro.org" <Freescale@lists.linaro.org>, "eric.miao@linaro.org" <eric.miao@linaro.org>

Cc the patchs to linaro guys.

Best Regards
Richard Zhu


> -----Original Message-----
> From: Zhu Richard-R65037
> Sent: Monday, February 28, 2011 7:32 PM
> To: linux-arm-kernel@lists.infradead.org
> Cc: kernel@pengutronix.de; linux-mmc@vger.kernel.org; cjb@laptop.org;
> avorontsov@ru.mvista.com; eric@eukrea.com; w.sang@pengutronix.de;
> linuxzsc@gmail.com; Zhao Richard-B20223; Freescale@lists.linaro.org;
> eric.miao@linaro.org; Zhu Richard-R65037
> Subject: [PATCH V3 1/4] ARM: imx53_loco: add esdhc device support
>
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> ---
>  arch/arm/mach-mx5/Kconfig           |    1 +
>  arch/arm/mach-mx5/board-mx53_loco.c |    2 ++
>  2 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig index
> f065a0d..a72c833 100644
> --- a/arch/arm/mach-mx5/Kconfig
> +++ b/arch/arm/mach-mx5/Kconfig
> @@ -162,6 +162,7 @@ config MACH_MX53_LOCO
>       select IMX_HAVE_PLATFORM_IMX2_WDT
>       select IMX_HAVE_PLATFORM_IMX_I2C
>       select IMX_HAVE_PLATFORM_IMX_UART
> +     select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
>       help
>         Include support for MX53 LOCO platform. This includes specific
>         configurations for the board and its peripherals.
> diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-
> mx5/board-mx53_loco.c
> index 160899e..0a18f8d 100644
> --- a/arch/arm/mach-mx5/board-mx53_loco.c
> +++ b/arch/arm/mach-mx5/board-mx53_loco.c
> @@ -213,6 +213,8 @@ static void __init mx53_loco_board_init(void)
>       imx53_add_imx2_wdt(0, NULL);
>       imx53_add_imx_i2c(0, &mx53_loco_i2c_data);
>       imx53_add_imx_i2c(1, &mx53_loco_i2c_data);
> +     imx53_add_sdhci_esdhc_imx(0, NULL);
> +     imx53_add_sdhci_esdhc_imx(2, NULL);
>  }
>
>  static void __init mx53_loco_timer_init(void)
> --
> 1.7.1


