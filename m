From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 06/10] mmc: dw_mmc-pltfm: add Rockchip variant
Date: Thu, 6 Jun 2013 23:01:21 +0300
Message-ID: <CAHp75VdpdP6Xtrv3o0EAKMPBvsMDROTVRQqbb54jpAH=LjFx1A@mail.gmail.com>
References: <201306030055.15413.heiko@sntech.de>
	<201306030059.03783.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:38367 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754277Ab3FFUBW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Jun 2013 16:01:22 -0400
In-Reply-To: <201306030059.03783.heiko@sntech.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mike Turquette <mturquette@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Linus Walleij <linus.walleij@linaro.org>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Mon, Jun 3, 2013 at 1:59 AM, Heiko St=C3=BCbner <heiko@sntech.de> wr=
ote:
> Cortex-A9 SoCs from Rockchip use a slightly modified variant of dw_mm=
c
> controllers that seems to require the SDMMC_CMD_USE_HOLD_REG bit to
> always be set.
>
> There also seem to be no other modifications (additional register etc=
)
> present, so to keep the footprint low, add this small variant to the
> pltfm driver.

=46ew comments below.

> --- a/drivers/mmc/host/dw_mmc-pltfm.c
> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> @@ -24,6 +24,16 @@
>
>  #include "dw_mmc.h"
>
> +

No need to add extra empty line here.

> +static void dw_mci_rockchip_prepare_command(struct dw_mci *host, u32=
 *cmdr)

> @@ -63,20 +73,6 @@ int dw_mci_pltfm_register(struct platform_device *=
pdev,
>  }
>  EXPORT_SYMBOL_GPL(dw_mci_pltfm_register);
>
> -static int dw_mci_pltfm_probe(struct platform_device *pdev)
> -{
> -       return dw_mci_pltfm_register(pdev, NULL);
> -}
> -
> -int dw_mci_pltfm_remove(struct platform_device *pdev)
> -{
> -       struct dw_mci *host =3D platform_get_drvdata(pdev);
> -
> -       dw_mci_remove(host);
> -       return 0;
> -}
> -EXPORT_SYMBOL_GPL(dw_mci_pltfm_remove);
> -

If you want to move those through code, please do separate patch.

--
With Best Regards,
Andy Shevchenko
