From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: wbsd: implement check for dma mapping error
Date: Fri, 18 Nov 2016 15:29:27 +0100
Message-ID: <CAPDyKFoZS+Fp3jPdsRnOX3r1_KLVZ64w1yq0nXBj6VtqW_r5CQ@mail.gmail.com>
References: <1478900564-5086-1-git-send-email-khoroshilov@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478900564-5086-1-git-send-email-khoroshilov@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Pierre Ossman <pierre@ossman.eu>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ldv-project@linuxtesting.org
List-Id: linux-mmc@vger.kernel.org

On 11 November 2016 at 22:42, Alexey Khoroshilov <khoroshilov@ispras.ru> wrote:
> wbsd_request_dma() does not check for dma mapping errors.
>
> Found by Linux Driver Verification project (linuxtesting.org).
>
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/wbsd.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
> index c3fd16d997ca..80a3b11f3217 100644
> --- a/drivers/mmc/host/wbsd.c
> +++ b/drivers/mmc/host/wbsd.c
> @@ -1395,23 +1395,25 @@ static void wbsd_request_dma(struct wbsd_host *host, int dma)
>          */
>         host->dma_addr = dma_map_single(mmc_dev(host->mmc), host->dma_buffer,
>                 WBSD_DMA_SIZE, DMA_BIDIRECTIONAL);
> +       if (dma_mapping_error(mmc_dev(host->mmc), host->dma_addr))
> +               goto kfree;
>
>         /*
>          * ISA DMA must be aligned on a 64k basis.
>          */
>         if ((host->dma_addr & 0xffff) != 0)
> -               goto kfree;
> +               goto unmap;
>         /*
>          * ISA cannot access memory above 16 MB.
>          */
>         else if (host->dma_addr >= 0x1000000)
> -               goto kfree;
> +               goto unmap;
>
>         host->dma = dma;
>
>         return;
>
> -kfree:
> +unmap:
>         /*
>          * If we've gotten here then there is some kind of alignment bug
>          */
> @@ -1421,6 +1423,7 @@ static void wbsd_request_dma(struct wbsd_host *host, int dma)
>                 WBSD_DMA_SIZE, DMA_BIDIRECTIONAL);
>         host->dma_addr = 0;
>
> +kfree:
>         kfree(host->dma_buffer);
>         host->dma_buffer = NULL;
>
> @@ -1434,7 +1437,7 @@ static void wbsd_request_dma(struct wbsd_host *host, int dma)
>
>  static void wbsd_release_dma(struct wbsd_host *host)
>  {
> -       if (host->dma_addr) {
> +       if (!dma_mapping_error(mmc_dev(host->mmc), host->dma_addr)) {
>                 dma_unmap_single(mmc_dev(host->mmc), host->dma_addr,
>                         WBSD_DMA_SIZE, DMA_BIDIRECTIONAL);
>         }
> --
> 2.7.4
>
