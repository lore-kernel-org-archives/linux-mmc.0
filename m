From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mxcmmc: Handle return value of clk_prepare_enable
Date: Tue, 8 Aug 2017 12:38:46 +0200
Message-ID: <CAPDyKFqgMUHx+A24PrXd==DYc1bt76xk=bC24mLk4v5vY039tw@mail.gmail.com>
References: <97f19cf864fa688cbb92a06b90120f4faee04e7d.1502171736.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <97f19cf864fa688cbb92a06b90120f4faee04e7d.1502171736.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 8 August 2017 at 07:57, Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
> clk_prepare_enable() can fail here and we must check its return value.
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/mxcmmc.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index fb3ca82..c016820 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -1098,8 +1098,13 @@ static int mxcmci_probe(struct platform_device *pdev)
>                 goto out_free;
>         }
>
> -       clk_prepare_enable(host->clk_per);
> -       clk_prepare_enable(host->clk_ipg);
> +       ret = clk_prepare_enable(host->clk_per);
> +       if (ret)
> +               goto out_free;
> +
> +       ret = clk_prepare_enable(host->clk_ipg);
> +       if (ret)
> +               goto out_clk_per_put;
>
>         mxcmci_softreset(host);
>
> @@ -1168,8 +1173,9 @@ static int mxcmci_probe(struct platform_device *pdev)
>                 dma_release_channel(host->dma);
>
>  out_clk_put:
> -       clk_disable_unprepare(host->clk_per);
>         clk_disable_unprepare(host->clk_ipg);
> +out_clk_per_put:
> +       clk_disable_unprepare(host->clk_per);
>
>  out_free:
>         mmc_free_host(mmc);
> @@ -1212,10 +1218,17 @@ static int __maybe_unused mxcmci_resume(struct device *dev)
>  {
>         struct mmc_host *mmc = dev_get_drvdata(dev);
>         struct mxcmci_host *host = mmc_priv(mmc);
> +       int ret;
>
> -       clk_prepare_enable(host->clk_per);
> -       clk_prepare_enable(host->clk_ipg);
> -       return 0;
> +       ret = clk_prepare_enable(host->clk_per);
> +       if (ret)
> +               return ret;
> +
> +       ret = clk_prepare_enable(host->clk_ipg);
> +       if (ret)
> +               clk_disable_unprepare(host->clk_per);
> +
> +       return ret;
>  }
>
>  static SIMPLE_DEV_PM_OPS(mxcmci_pm_ops, mxcmci_suspend, mxcmci_resume);
> --
> 1.9.1
>
