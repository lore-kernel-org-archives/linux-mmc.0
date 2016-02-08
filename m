From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3] mmc: pxamci: fix the device-tree probe deferral path
Date: Mon, 8 Feb 2016 16:23:33 +0100
Message-ID: <CAPDyKFrs=8hUgGL4OMYo9+LoG6E0CbS0b7ywO-2JzMN-yHBQaA@mail.gmail.com>
References: <1454941077-12042-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454941077-12042-1-git-send-email-robert.jarzmik@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 8 February 2016 at 15:17, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> When the gpio driver is probed after the mmc one, the read/write gpio
> and card detection one return -EPROBE_DEFER. Unfortunately, the memory
> region remains requested, and upon the next probe, the probe will fail
> anyway with -EBUSY.
>
> Fix this by releasing the memory resource upon probe failure.
>
> More broadly, this patch uses devm_*() primitives whenever possible in
> the probe function.
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>

Thanks, applied for fixes!

Kind regards
Uffe

> ---
> Since v1: broaden the devm_*() enveloppe
> Since v2: further broaden devm_*(): regulator + clock
> ---
>  drivers/mmc/host/pxamci.c | 35 +++++++++--------------------------
>  1 file changed, 9 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> index 28a057fae0a1..da824772bbb4 100644
> --- a/drivers/mmc/host/pxamci.c
> +++ b/drivers/mmc/host/pxamci.c
> @@ -86,7 +86,7 @@ struct pxamci_host {
>  static inline void pxamci_init_ocr(struct pxamci_host *host)
>  {
>  #ifdef CONFIG_REGULATOR
> -       host->vcc = regulator_get_optional(mmc_dev(host->mmc), "vmmc");
> +       host->vcc = devm_regulator_get_optional(mmc_dev(host->mmc), "vmmc");
>
>         if (IS_ERR(host->vcc))
>                 host->vcc = NULL;
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
> @@ -695,7 +691,7 @@ static int pxamci_probe(struct platform_device *pdev)
>         host->pdata = pdev->dev.platform_data;
>         host->clkrt = CLKRT_OFF;
>
> -       host->clk = clk_get(&pdev->dev, NULL);
> +       host->clk = devm_clk_get(&pdev->dev, NULL);
>         if (IS_ERR(host->clk)) {
>                 ret = PTR_ERR(host->clk);
>                 host->clk = NULL;
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
> @@ -833,14 +830,9 @@ out:
>                         dma_release_channel(host->dma_chan_rx);
>                 if (host->dma_chan_tx)
>                         dma_release_channel(host->dma_chan_tx);
> -               if (host->base)
> -                       iounmap(host->base);
> -               if (host->clk)
> -                       clk_put(host->clk);
>         }
>         if (mmc)
>                 mmc_free_host(mmc);
> -       release_resource(r);
>         return ret;
>  }
>
> @@ -859,9 +851,6 @@ static int pxamci_remove(struct platform_device *pdev)
>                         gpio_ro = host->pdata->gpio_card_ro;
>                         gpio_power = host->pdata->gpio_power;
>                 }
> -               if (host->vcc)
> -                       regulator_put(host->vcc);
> -
>                 if (host->pdata && host->pdata->exit)
>                         host->pdata->exit(&pdev->dev, mmc);
>
> @@ -870,16 +859,10 @@ static int pxamci_remove(struct platform_device *pdev)
>                        END_CMD_RES|PRG_DONE|DATA_TRAN_DONE,
>                        host->base + MMC_I_MASK);
>
> -               free_irq(host->irq, host);
>                 dmaengine_terminate_all(host->dma_chan_rx);
>                 dmaengine_terminate_all(host->dma_chan_tx);
>                 dma_release_channel(host->dma_chan_rx);
>                 dma_release_channel(host->dma_chan_tx);
> -               iounmap(host->base);
> -
> -               clk_put(host->clk);
> -
> -               release_resource(host->res);
>
>                 mmc_free_host(mmc);
>         }
> --
> 2.1.4
>
