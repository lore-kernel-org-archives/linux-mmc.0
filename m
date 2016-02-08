From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mmc_spi: add checks for dma mapping error
Date: Mon, 8 Feb 2016 16:23:39 +0100
Message-ID: <CAPDyKFpc118zhWv4KFo0EHhZyu6RnPu0ot1mDWygXcKmuVQ3Cw@mail.gmail.com>
References: <1454715395-9462-1-git-send-email-khoroshilov@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454715395-9462-1-git-send-email-khoroshilov@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ldv-project@linuxtesting.org
List-Id: linux-mmc@vger.kernel.org

On 6 February 2016 at 00:36, Alexey Khoroshilov <khoroshilov@ispras.ru> wrote:
> There is no checks for dma mapping errors in mmc_spi.
> Tha patch fixes that and by the way it adds dma_unmap_single(ones_dma)
> that was left on a failure path mmc_spi_probe().
>
> Found by Linux Driver Verification project (linuxtesting.org).
>
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>  drivers/mmc/host/mmc_spi.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 1c1b45ef3faf..3446097a43c0 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -925,6 +925,10 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
>
>                         dma_addr = dma_map_page(dma_dev, sg_page(sg), 0,
>                                                 PAGE_SIZE, dir);
> +                       if (dma_mapping_error(dma_dev, dma_addr)) {
> +                               data->error = -EFAULT;
> +                               break;
> +                       }
>                         if (direction == DMA_TO_DEVICE)
>                                 t->tx_dma = dma_addr + sg->offset;
>                         else
> @@ -1393,10 +1397,12 @@ static int mmc_spi_probe(struct spi_device *spi)
>                 host->dma_dev = dev;
>                 host->ones_dma = dma_map_single(dev, ones,
>                                 MMC_SPI_BLOCKSIZE, DMA_TO_DEVICE);
> +               if (dma_mapping_error(dev, host->ones_dma))
> +                       goto fail_ones_dma;
>                 host->data_dma = dma_map_single(dev, host->data,
>                                 sizeof(*host->data), DMA_BIDIRECTIONAL);
> -
> -               /* REVISIT in theory those map operations can fail... */
> +               if (dma_mapping_error(dev, host->data_dma))
> +                       goto fail_data_dma;
>
>                 dma_sync_single_for_cpu(host->dma_dev,
>                                 host->data_dma, sizeof(*host->data),
> @@ -1462,6 +1468,11 @@ fail_glue_init:
>         if (host->dma_dev)
>                 dma_unmap_single(host->dma_dev, host->data_dma,
>                                 sizeof(*host->data), DMA_BIDIRECTIONAL);
> +fail_data_dma:
> +       if (host->dma_dev)
> +               dma_unmap_single(host->dma_dev, host->ones_dma,
> +                               MMC_SPI_BLOCKSIZE, DMA_TO_DEVICE);
> +fail_ones_dma:
>         kfree(host->data);
>
>  fail_nobuf1:
> --
> 1.9.1
>
