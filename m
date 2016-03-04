From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sh_mmcif, tmio: Use ARCH_RENESAS
Date: Fri, 4 Mar 2016 10:41:41 +0100
Message-ID: <CAPDyKFoVSrwspS2yx5h6ZWzHr6OHyPYZDmC7Yw_mGM0BOk+Qxw@mail.gmail.com>
References: <1456281573-16458-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1456281573-16458-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Ian Molton <ian@mnementh.co.uk>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 24 February 2016 at 03:39, Simon Horman <horms+renesas@verge.net.au> wrote:
> Make use of ARCH_RENESAS in place of ARCH_SHMOBILE.
>
> This is part of an ongoing process to migrate from ARCH_SHMOBILE to
> ARCH_RENESAS the motivation for which being that RENESAS seems to be a more
> appropriate name than SHMOBILE for the majority of Renesas ARM based SoCs.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
>  Based on mmc/next
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index d9a9d92fa837..04feea8354cb 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -561,7 +561,7 @@ config MMC_TMIO
>  config MMC_SDHI
>         tristate "SH-Mobile SDHI SD/SDIO controller support"
>         depends on SUPERH || ARM || ARM64
> -       depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
> +       depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
>         select MMC_TMIO_CORE
>         help
>           This provides support for the SDHI SD/SDIO controller found in
> @@ -674,7 +674,7 @@ config MMC_DW_ROCKCHIP
>  config MMC_SH_MMCIF
>         tristate "SuperH Internal MMCIF support"
>         depends on HAS_DMA
> -       depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
> +       depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
>         help
>           This selects the MMC Host Interface controller (MMCIF).
>
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
