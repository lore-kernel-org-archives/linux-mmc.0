From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-of-at91: remove bogus MMC_SDHCI_IO_ACCESSORS select
Date: Mon, 5 Dec 2016 14:18:46 +0100
Message-ID: <CAPDyKFrF8EJDypqDO9MR0kzcq2GXyAktNePDcKBv3X6tvaLiUw@mail.gmail.com>
References: <1480565146-4857-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wj0-f174.google.com ([209.85.210.174]:36317 "EHLO
        mail-wj0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750951AbcLENSs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Dec 2016 08:18:48 -0500
Received: by mail-wj0-f174.google.com with SMTP id qp4so290177434wjc.3
        for <linux-mmc@vger.kernel.org>; Mon, 05 Dec 2016 05:18:48 -0800 (PST)
In-Reply-To: <1480565146-4857-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stefan Wahren <stefan.wahren@i2se.com>, Al Cooper <alcooperx@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Andrei Pistirica <andrei.pistirica@microchip.com>, Simon Horman <horms+renesas@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>

On 1 December 2016 at 05:05, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> I see no override of read/write callbacks in sdhci-of-at91.c.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
> BTW, this config may not be so useful in recent multi-platforms.
> Perhaps, is it better to remove this config entirely instead of
> the AT91 fix only.
>
>
>  drivers/mmc/host/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 39f6f96..8ac1640 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -135,7 +135,6 @@ config MMC_SDHCI_OF_AT91
>         tristate "SDHCI OF support for the Atmel SDMMC controller"
>         depends on MMC_SDHCI_PLTFM
>         depends on OF
> -       select MMC_SDHCI_IO_ACCESSORS
>         help
>           This selects the Atmel SDMMC driver
>
> --
> 2.7.4
>
