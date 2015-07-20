From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: MMC_MTK should depend on HAS_DMA
Date: Mon, 20 Jul 2015 16:21:05 +0200
Message-ID: <CAPDyKFqTsfVJuLnbVXpq8ivshLBtNFPtGdvKR719si7w4+5FqA@mail.gmail.com>
References: <1435320566-5069-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1435320566-5069-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 26 June 2015 at 14:09, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> If NO_DMA=y:
>
>     ERROR: "dma_alloc_coherent" [drivers/mmc/host/mtk-sd.ko] undefined!
>     ERROR: "dma_unmap_sg" [drivers/mmc/host/mtk-sd.ko] undefined!
>     ERROR: "dma_map_sg" [drivers/mmc/host/mtk-sd.ko] undefined!
>     ERROR: "dma_free_coherent" [drivers/mmc/host/mtk-sd.ko] undefined!
>
> Add a dependency on HAS_DMA to fix this.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks, applied for fixes.

Kind regards
Uffe

> ---
>  drivers/mmc/host/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index fd9a58e216a50ffd..6a0f9c79be2652bd 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -779,6 +779,7 @@ config MMC_TOSHIBA_PCI
>
>  config MMC_MTK
>         tristate "MediaTek SD/MMC Card Interface support"
> +       depends on HAS_DMA
>         help
>           This selects the MediaTek(R) Secure digital and Multimedia card Interface.
>           If you have a machine with a integrated SD/MMC card reader, say Y or M here.
> --
> 1.9.1
>
