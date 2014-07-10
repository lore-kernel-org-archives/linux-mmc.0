From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/3] mmc: MMC_OMAP_HS should depend on HAS_DMA
Date: Thu, 10 Jul 2014 14:46:54 +0200
Message-ID: <CAPDyKFrVJ5zsrtbx-irFEM_oX5+xJtTay1UZTWHs+vw3Hyx8qA@mail.gmail.com>
References: <1404931962-25917-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1404931962-25917-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 9 July 2014 20:52, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> If NO_DMA=y:
>
>     drivers/built-in.o: In function `omap_hsmmc_pre_dma_transfer':
>     omap_hsmmc.c:(.text+0x5a0928): undefined reference to `dma_map_sg'
>     drivers/built-in.o: In function `omap_hsmmc_dma_cleanup':
>     omap_hsmmc.c:(.text+0x5a0e8e): undefined reference to `dma_unmap_sg'
>     drivers/built-in.o: In function `omap_hsmmc_dma_callback':
>     omap_hsmmc.c:(.text+0x5a1f58): undefined reference to `dma_unmap_sg'
>     drivers/built-in.o: In function `omap_hsmmc_post_req':
>     omap_hsmmc.c:(.text+0x5a2082): undefined reference to `dma_unmap_sg'
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
>  drivers/mmc/host/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index a5652548230a..97f6452e0d23 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -303,6 +303,7 @@ config MMC_OMAP
>
>  config MMC_OMAP_HS
>         tristate "TI OMAP High Speed Multimedia Card Interface support"
> +       depends on HAS_DMA
>         depends on ARCH_OMAP2PLUS || COMPILE_TEST
>         help
>           This selects the TI OMAP High Speed Multimedia card Interface.
> --
> 1.9.1
>
