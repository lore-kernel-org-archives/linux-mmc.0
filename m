From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/6] mmc: omap_hsmmc: use devm_clk_get
Date: Mon, 12 May 2014 10:33:07 +0200
Message-ID: <CAPDyKFpQ43168D4FVpbKExHuBPAfkyPrhiy4mG7c=481cpncmQ@mail.gmail.com>
References: <1399654013-28262-1-git-send-email-balajitk@ti.com>
	<1399654013-28262-2-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1399654013-28262-2-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 9 May 2014 18:46, Balaji T K <balajitk@ti.com> wrote:
> With devm_clk_get conversion clk_put can be removed in clean up path
>
> Signed-off-by: Balaji T K <balajitk@ti.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c |   15 ++++-----------
>  1 files changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index b4de63b..b8ae7ee 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1922,7 +1922,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>
>         spin_lock_init(&host->irq_lock);
>
> -       host->fclk = clk_get(&pdev->dev, "fck");
> +       host->fclk = devm_clk_get(&pdev->dev, "fck");
>         if (IS_ERR(host->fclk)) {
>                 ret = PTR_ERR(host->fclk);
>                 host->fclk = NULL;
> @@ -1941,7 +1941,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>
>         omap_hsmmc_context_save(host);
>
> -       host->dbclk = clk_get(&pdev->dev, "mmchsdb_fck");
> +       host->dbclk = devm_clk_get(&pdev->dev, "mmchsdb_fck");
>         /*
>          * MMC can still work without debounce clock.
>          */
> @@ -1949,7 +1949,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>                 host->dbclk = NULL;
>         } else if (clk_prepare_enable(host->dbclk) != 0) {
>                 dev_warn(mmc_dev(host->mmc), "Failed to enable debounce clk\n");
> -               clk_put(host->dbclk);
>                 host->dbclk = NULL;

You should use the IS_ERR macro, no need to reset dbclk to NULL.

>         }
>
> @@ -2105,11 +2104,8 @@ err_irq:
>                 dma_release_channel(host->rx_chan);
>         pm_runtime_put_sync(host->dev);
>         pm_runtime_disable(host->dev);
> -       clk_put(host->fclk);
> -       if (host->dbclk) {
> +       if (host->dbclk)

Use IS_ERR instead.

>                 clk_disable_unprepare(host->dbclk);
> -               clk_put(host->dbclk);
> -       }
>  err1:
>         iounmap(host->base);
>         mmc_free_host(mmc);
> @@ -2144,11 +2140,8 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
>
>         pm_runtime_put_sync(host->dev);
>         pm_runtime_disable(host->dev);
> -       clk_put(host->fclk);
> -       if (host->dbclk) {
> +       if (host->dbclk)

Use IS_ERR instead.

>                 clk_disable_unprepare(host->dbclk);
> -               clk_put(host->dbclk);
> -       }
>
>         omap_hsmmc_gpio_free(host->pdata);
>         iounmap(host->base);
> --
> 1.7.5.4
>

Kind regards
Ulf Hansson
