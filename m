From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: meson-gx: Free irq in release() callback
Date: Mon, 14 Jan 2019 12:45:07 +0100
Message-ID: <CAPDyKFokQOr1wyeJqe9=CLmw47jNXaQEmK0ZJYHwPkReSHcRXg@mail.gmail.com>
References: <20190110230135.19555-1-repk@triplefau.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190110230135.19555-1-repk@triplefau.lt>
Sender: linux-kernel-owner@vger.kernel.org
To: Remi Pommarel <repk@triplefau.lt>
Cc: Kevin Hilman <khilman@baylibre.com>, Elie Roudninski <xademax@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 10 Jan 2019 at 23:52, Remi Pommarel <repk@triplefau.lt> wrote:
>
> Because the irq was requested through device managed resources API
> (devm_request_threaded_irq()) it was freed after meson_mmc_remove()
> completion, thus after mmc_free_host() has reclaimed meson_host memory.
> As this irq is IRQF_SHARED, while using CONFIG_DEBUG_SHIRQ, its handler
> get called by free_irq(). So meson_mmc_irq() was called after the
> meson_host memory reclamation and was using invalid memory.
>
> We ended up with the following scenario:
> device_release_driver()
>         meson_mmc_remove()
>                 mmc_free_host() /* Freeing host memory */
>         ...
>         devres_release_all()
>                 devm_irq_release()
>                         __free_irq()
>                                 meson_mmc_irq() /* Uses freed memory */
>
> To avoid this, the irq is released in meson_mmc_remove() and in
> mseon_mmc_probe() error path before mmc_free_host() gets called.
>
> This fixes https://marc.info/?l=linux-mmc&m=154707415208716.
>
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>

Applied for fixes! I also added a stable tag and a reported-by tag
from Elie, thanks!

Kind regards
Uffe


> ---
> Changes since v1:
> - Fix it also in the error handling of probe callback
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index c2690c1a50ff..f115d7c63ffe 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -179,6 +179,8 @@ struct meson_host {
>         struct sd_emmc_desc *descs;
>         dma_addr_t descs_dma_addr;
>
> +       int irq;
> +
>         bool vqmmc_enabled;
>  };
>
> @@ -1231,7 +1233,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
>         struct resource *res;
>         struct meson_host *host;
>         struct mmc_host *mmc;
> -       int ret, irq;
> +       int ret;
>
>         mmc = mmc_alloc_host(sizeof(struct meson_host), &pdev->dev);
>         if (!mmc)
> @@ -1276,8 +1278,8 @@ static int meson_mmc_probe(struct platform_device *pdev)
>                 goto free_host;
>         }
>
> -       irq = platform_get_irq(pdev, 0);
> -       if (irq <= 0) {
> +       host->irq = platform_get_irq(pdev, 0);
> +       if (host->irq <= 0) {
>                 dev_err(&pdev->dev, "failed to get interrupt resource.\n");
>                 ret = -EINVAL;
>                 goto free_host;
> @@ -1331,9 +1333,8 @@ static int meson_mmc_probe(struct platform_device *pdev)
>         writel(IRQ_CRC_ERR | IRQ_TIMEOUTS | IRQ_END_OF_CHAIN,
>                host->regs + SD_EMMC_IRQ_EN);
>
> -       ret = devm_request_threaded_irq(&pdev->dev, irq, meson_mmc_irq,
> -                                       meson_mmc_irq_thread, IRQF_SHARED,
> -                                       NULL, host);
> +       ret = request_threaded_irq(host->irq, meson_mmc_irq,
> +                       meson_mmc_irq_thread, IRQF_SHARED, NULL, host);
>         if (ret)
>                 goto err_init_clk;
>
> @@ -1351,7 +1352,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
>         if (host->bounce_buf == NULL) {
>                 dev_err(host->dev, "Unable to map allocate DMA bounce buffer.\n");
>                 ret = -ENOMEM;
> -               goto err_init_clk;
> +               goto err_free_irq;
>         }
>
>         host->descs = dma_alloc_coherent(host->dev, SD_EMMC_DESC_BUF_LEN,
> @@ -1370,6 +1371,8 @@ static int meson_mmc_probe(struct platform_device *pdev)
>  err_bounce_buf:
>         dma_free_coherent(host->dev, host->bounce_buf_size,
>                           host->bounce_buf, host->bounce_dma_addr);
> +err_free_irq:
> +       free_irq(host->irq, host);
>  err_init_clk:
>         clk_disable_unprepare(host->mmc_clk);
>  err_core_clk:
> @@ -1387,6 +1390,7 @@ static int meson_mmc_remove(struct platform_device *pdev)
>
>         /* disable interrupts */
>         writel(0, host->regs + SD_EMMC_IRQ_EN);
> +       free_irq(host->irq, host);
>
>         dma_free_coherent(host->dev, SD_EMMC_DESC_BUF_LEN,
>                           host->descs, host->descs_dma_addr);
> --
> 2.20.1
>
