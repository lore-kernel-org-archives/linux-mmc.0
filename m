From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 5/8] mmc: sunxi: Move resources management to separate
 functions
Date: Thu, 15 Mar 2018 11:24:06 +0100
Message-ID: <CAPDyKFq8w_MuZUAYPpG8hrWxFgQhhS2ZVUpPL31L-=VUHEYEdg@mail.gmail.com>
References: <cover.e1acb3dc84e043c8342166e7fb45f79be36ab154.1520520655.git-series.maxime.ripard@bootlin.com>
 <ae107f83803778d4e34e43161c4670930c260f62.1520520655.git-series.maxime.ripard@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <ae107f83803778d4e34e43161c4670930c260f62.1520520655.git-series.maxime.ripard@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Quentin Schulz <quentin.schulz@bootlin.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 8 March 2018 at 15:52, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> We've had all our resources management, and especially the clocks and reset
> sequence, done directly as part of the probe.
>
> As we want to implement runtime_pm, we'll obviously want to have that
> moved outside of the probe so that we can call do it in our runtime suspend
> and resume hooks without too much duplication.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sunxi-mmc.c | 142 ++++++++++++++++++++----------------
>  1 file changed, 82 insertions(+), 60 deletions(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index e4b44c4adb8f..34bc90bc04b2 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -265,6 +265,7 @@ struct sunxi_mmc_cfg {
>  };
>
>  struct sunxi_mmc_host {
> +       struct device *dev;
>         struct mmc_host *mmc;
>         struct reset_control *reset;
>         const struct sunxi_mmc_cfg *cfg;
> @@ -1183,6 +1184,80 @@ static const struct of_device_id sunxi_mmc_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, sunxi_mmc_of_match);
>
> +static int sunxi_mmc_enable(struct sunxi_mmc_host *host)
> +{
> +       int ret;
> +
> +       ret = clk_prepare_enable(host->clk_ahb);
> +       if (ret) {
> +               dev_err(dev, "Couldn't enable the bus clocks (%d)\n", ret);
> +               return ret;
> +       }
> +
> +       ret = clk_prepare_enable(host->clk_mmc);
> +       if (ret) {
> +               dev_err(host->dev, "Enable mmc clk err %d\n", ret);
> +               goto error_disable_clk_ahb;
> +       }
> +
> +       ret = clk_prepare_enable(host->clk_output);
> +       if (ret) {
> +               dev_err(host->dev, "Enable output clk err %d\n", ret);
> +               goto error_disable_clk_mmc;
> +       }
> +
> +       ret = clk_prepare_enable(host->clk_sample);
> +       if (ret) {
> +               dev_err(host->dev, "Enable sample clk err %d\n", ret);
> +               goto error_disable_clk_output;
> +       }
> +
> +       if (!IS_ERR(host->reset)) {
> +               ret = reset_control_reset(host->reset);
> +               if (ret) {
> +                       dev_err(dev, "Couldn't reset the MMC controller (%d)\n",
> +                               ret);
> +                       goto error_disable_clk_sample;
> +               }
> +       }
> +
> +       /*
> +        * Sometimes the controller asserts the irq on boot for some reason,
> +        * make sure the controller is in a sane state before enabling irqs.
> +        */
> +       ret = sunxi_mmc_reset_host(host);
> +       if (ret)
> +               goto error_assert_reset;
> +
> +       return 0;
> +
> +error_assert_reset:
> +       if (!IS_ERR(host->reset))
> +               reset_control_assert(host->reset);
> +error_disable_clk_sample:
> +       clk_disable_unprepare(host->clk_sample);
> +error_disable_clk_output:
> +       clk_disable_unprepare(host->clk_output);
> +error_disable_clk_mmc:
> +       clk_disable_unprepare(host->clk_mmc);
> +error_disable_clk_ahb:
> +       clk_disable_unprepare(host->clk_ahb);
> +       return ret;
> +}
> +
> +static void sunxi_mmc_disable(struct sunxi_mmc_host *host)
> +{
> +       sunxi_mmc_reset_host(host);
> +
> +       if (!IS_ERR(host->reset))
> +               reset_control_assert(host->reset);
> +
> +       clk_disable_unprepare(host->clk_sample);
> +       clk_disable_unprepare(host->clk_output);
> +       clk_disable_unprepare(host->clk_mmc);
> +       clk_disable_unprepare(host->clk_ahb);
> +}
> +
>  static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
>                                       struct platform_device *pdev)
>  {
> @@ -1232,66 +1307,21 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
>         if (PTR_ERR(host->reset) == -EPROBE_DEFER)
>                 return PTR_ERR(host->reset);
>
> -       ret = clk_prepare_enable(host->clk_ahb);
> -       if (ret) {
> -               dev_err(&pdev->dev, "Enable ahb clk err %d\n", ret);
> -               return ret;
> -       }
> -
> -       ret = clk_prepare_enable(host->clk_mmc);
> -       if (ret) {
> -               dev_err(&pdev->dev, "Enable mmc clk err %d\n", ret);
> -               goto error_disable_clk_ahb;
> -       }
> -
> -       ret = clk_prepare_enable(host->clk_output);
> -       if (ret) {
> -               dev_err(&pdev->dev, "Enable output clk err %d\n", ret);
> -               goto error_disable_clk_mmc;
> -       }
> -
> -       ret = clk_prepare_enable(host->clk_sample);
> -       if (ret) {
> -               dev_err(&pdev->dev, "Enable sample clk err %d\n", ret);
> -               goto error_disable_clk_output;
> -       }
> -
> -       if (!IS_ERR(host->reset)) {
> -               ret = reset_control_reset(host->reset);
> -               if (ret) {
> -                       dev_err(&pdev->dev, "reset err %d\n", ret);
> -                       goto error_disable_clk_sample;
> -               }
> -       }
> -
> -       /*
> -        * Sometimes the controller asserts the irq on boot for some reason,
> -        * make sure the controller is in a sane state before enabling irqs.
> -        */
> -       ret = sunxi_mmc_reset_host(host);
> +       ret = sunxi_mmc_enable(host);
>         if (ret)
> -               goto error_assert_reset;
> +               return ret;
>
>         host->irq = platform_get_irq(pdev, 0);
>         if (host->irq <= 0) {
>                 ret = -EINVAL;
> -               goto error_assert_reset;
> +               goto error_disable_mmc;
>         }
>
>         return devm_request_threaded_irq(&pdev->dev, host->irq, sunxi_mmc_irq,
>                         sunxi_mmc_handle_manual_stop, 0, "sunxi-mmc", host);
>
> -error_assert_reset:
> -       if (!IS_ERR(host->reset))
> -               reset_control_assert(host->reset);
> -error_disable_clk_sample:
> -       clk_disable_unprepare(host->clk_sample);
> -error_disable_clk_output:
> -       clk_disable_unprepare(host->clk_output);
> -error_disable_clk_mmc:
> -       clk_disable_unprepare(host->clk_mmc);
> -error_disable_clk_ahb:
> -       clk_disable_unprepare(host->clk_ahb);
> +error_disable_mmc:
> +       sunxi_mmc_disable(host);
>         return ret;
>  }
>
> @@ -1308,6 +1338,7 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
>         }
>
>         host = mmc_priv(mmc);
> +       host->dev = &pdev->dev;
>         host->mmc = mmc;
>         spin_lock_init(&host->lock);
>
> @@ -1388,16 +1419,7 @@ static int sunxi_mmc_remove(struct platform_device *pdev)
>
>         mmc_remove_host(mmc);
>         disable_irq(host->irq);
> -       sunxi_mmc_reset_host(host);
> -
> -       if (!IS_ERR(host->reset))
> -               reset_control_assert(host->reset);
> -
> -       clk_disable_unprepare(host->clk_sample);
> -       clk_disable_unprepare(host->clk_output);
> -       clk_disable_unprepare(host->clk_mmc);
> -       clk_disable_unprepare(host->clk_ahb);
> -
> +       sunxi_mmc_disable(host);
>         dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
>         mmc_free_host(mmc);
>
> --
> git-series 0.9.1
