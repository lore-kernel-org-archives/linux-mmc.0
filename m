From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: pxamci: fix the device-tree probe deferral path
Date: Mon, 8 Feb 2016 10:19:12 +0100
Message-ID: <CAPDyKFoKyRYSz+T0xCX5Pdfs3BDEw4nMEg+d0ji-cmn=x5e1WA@mail.gmail.com>
References: <1454793294-7256-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454793294-7256-1-git-send-email-robert.jarzmik@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 6 February 2016 at 22:14, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> When the gpio driver is probed after the mmc one, the read/write gpio
> and card detection one return -EPROBE_DEFER. Unfortunately, the memory
> region remains requested, and upon the next probe, the probe will fail
> anyway with -EBUSY.
>
> Fix this by releasing the memory resource upon probe failure.
>
> More broadly, this patch uses devm_*() primitives whenever possible in
> the probe function.

There's actually also clocks and regulators that may be converted to
use the devm* functions.
Do you want to do that as a part of this patch as well? Otherwise I
can apply as is.

Kind regards
Uffe

>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
> Since v1: broaden the devm_*() enveloppe
> ---
>  drivers/mmc/host/pxamci.c | 24 +++++++-----------------
>  1 file changed, 7 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> index 28a057fae0a1..a672b9259d34 100644
> --- a/drivers/mmc/host/pxamci.c
> +++ b/drivers/mmc/host/pxamci.c
> @@ -654,12 +654,8 @@ static int pxamci_probe(struct platform_device *pdev)
>
>         r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         irq = platform_get_irq(pdev, 0);
> -       if (!r || irq < 0)
> -               return -ENXIO;
> -
> -       r = request_mem_region(r->start, SZ_4K, DRIVER_NAME);
> -       if (!r)
> -               return -EBUSY;
> +       if (irq < 0)
> +               return irq;
>
>         mmc = mmc_alloc_host(sizeof(struct pxamci_host), &pdev->dev);
>         if (!mmc) {
> @@ -727,9 +723,9 @@ static int pxamci_probe(struct platform_device *pdev)
>         host->irq = irq;
>         host->imask = MMC_I_MASK_ALL;
>
> -       host->base = ioremap(r->start, SZ_4K);
> -       if (!host->base) {
> -               ret = -ENOMEM;
> +       host->base = devm_ioremap_resource(&pdev->dev, r);
> +       if (IS_ERR(host->base)) {
> +               ret = PTR_ERR(host->base);
>                 goto out;
>         }
>
> @@ -742,7 +738,8 @@ static int pxamci_probe(struct platform_device *pdev)
>         writel(64, host->base + MMC_RESTO);
>         writel(host->imask, host->base + MMC_I_MASK);
>
> -       ret = request_irq(host->irq, pxamci_irq, 0, DRIVER_NAME, host);
> +       ret = devm_request_irq(&pdev->dev, host->irq, pxamci_irq, 0,
> +                              DRIVER_NAME, host);
>         if (ret)
>                 goto out;
>
> @@ -833,14 +830,11 @@ out:
>                         dma_release_channel(host->dma_chan_rx);
>                 if (host->dma_chan_tx)
>                         dma_release_channel(host->dma_chan_tx);
> -               if (host->base)
> -                       iounmap(host->base);
>                 if (host->clk)
>                         clk_put(host->clk);
>         }
>         if (mmc)
>                 mmc_free_host(mmc);
> -       release_resource(r);
>         return ret;
>  }
>
> @@ -870,17 +864,13 @@ static int pxamci_remove(struct platform_device *pdev)
>                        END_CMD_RES|PRG_DONE|DATA_TRAN_DONE,
>                        host->base + MMC_I_MASK);
>
> -               free_irq(host->irq, host);
>                 dmaengine_terminate_all(host->dma_chan_rx);
>                 dmaengine_terminate_all(host->dma_chan_tx);
>                 dma_release_channel(host->dma_chan_rx);
>                 dma_release_channel(host->dma_chan_tx);
> -               iounmap(host->base);
>
>                 clk_put(host->clk);
>
> -               release_resource(host->res);
> -
>                 mmc_free_host(mmc);
>         }
>         return 0;
> --
> 2.1.4
>
