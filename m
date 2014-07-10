From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 2/3] mmc: MMC_SH_MMCIF should depend on HAS_DMA
Date: Thu, 10 Jul 2014 14:47:36 +0200
Message-ID: <CAPDyKFoNoFMTFCm59+SEN7jgELPkVAU6=8tqwWTR13Ag7nje1A@mail.gmail.com>
References: <1404931962-25917-1-git-send-email-geert@linux-m68k.org>
	<1404931962-25917-2-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:61330 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909AbaGJMrh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Jul 2014 08:47:37 -0400
Received: by mail-qg0-f53.google.com with SMTP id i50so7536379qgf.40
        for <linux-mmc@vger.kernel.org>; Thu, 10 Jul 2014 05:47:36 -0700 (PDT)
In-Reply-To: <1404931962-25917-2-git-send-email-geert@linux-m68k.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 9 July 2014 20:52, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> If NO_DMA=y:
>
>     drivers/built-in.o: In function `sh_mmcif_start_dma_tx':
>     sh_mmcif.c:(.text+0x5a3286): undefined reference to `dma_map_sg'
>     drivers/built-in.o: In function `sh_mmcif_start_dma_rx':
>     sh_mmcif.c:(.text+0x5a33fc): undefined reference to `dma_map_sg'
>     drivers/built-in.o: In function `sh_mmcif_end_cmd':
>     sh_mmcif.c:(.text+0x5a3668): undefined reference to `dma_unmap_sg'
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks! Applied for next.

Kind regards
Uffe


> ---
> v2:
>   - Add Acked-by
> ---
>  drivers/mmc/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 97f6452e0d23..9ac9d8387df0 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -624,7 +624,7 @@ config MMC_DW_PCI
>
>  config MMC_SH_MMCIF
>         tristate "SuperH Internal MMCIF support"
> -       depends on MMC_BLOCK
> +       depends on MMC_BLOCK && HAS_DMA
>         depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
>         help
>           This selects the MMC Host Interface controller (MMCIF).
> --
> 1.9.1
>
