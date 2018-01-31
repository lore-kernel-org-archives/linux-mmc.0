From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: MMC_SDHI_{SYS,INTERNAL}_DMAC should depend on HAS_DMA
Date: Wed, 31 Jan 2018 11:31:40 +0100
Message-ID: <CAPDyKFqRwGgZ17eteN8nytS2ub-tqoY2kHec7N05GK6ipAUUcg@mail.gmail.com>
References: <1517318680-14918-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:39977 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752492AbeAaKbl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Jan 2018 05:31:41 -0500
Received: by mail-io0-f195.google.com with SMTP id t22so14674989ioa.7
        for <linux-mmc@vger.kernel.org>; Wed, 31 Jan 2018 02:31:41 -0800 (PST)
In-Reply-To: <1517318680-14918-1-git-send-email-geert@linux-m68k.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 30 January 2018 at 14:24, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> If NO_DMA=y:
>
>     ERROR: "bad_dma_ops" [drivers/mmc/host/renesas_sdhi_sys_dmac.ko] undefined!
>     ERROR: "bad_dma_ops" [drivers/mmc/host/renesas_sdhi_internal_dmac.ko] undefined!
>
> Add dependencies on HAS_DMA to fix this.
>
> Fixes: e578afab6e5f57e7 ("mmc: renesas_sdhi: remove wrong depends on to enable compile test")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>  drivers/mmc/host/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 67bd3344dd03a1ae..0eae619419d9ddeb 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -605,7 +605,7 @@ config MMC_SDHI
>
>  config MMC_SDHI_SYS_DMAC
>         tristate "DMA for SDHI SD/SDIO controllers using SYS-DMAC"
> -       depends on MMC_SDHI
> +       depends on MMC_SDHI && HAS_DMA
>         default MMC_SDHI if (SUPERH || ARM)
>         help
>           This provides DMA support for SDHI SD/SDIO controllers
> @@ -615,7 +615,7 @@ config MMC_SDHI_SYS_DMAC
>  config MMC_SDHI_INTERNAL_DMAC
>         tristate "DMA for SDHI SD/SDIO controllers using on-chip bus mastering"
>         depends on ARM64 || COMPILE_TEST
> -       depends on MMC_SDHI
> +       depends on MMC_SDHI && HAS_DMA
>         default MMC_SDHI if ARM64
>         help
>           This provides DMA support for SDHI SD/SDIO controllers
> --
> 2.7.4
>
