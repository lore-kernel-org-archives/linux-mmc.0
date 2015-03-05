From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: omap_hsmmc: add hibernation support
Date: Thu, 5 Mar 2015 14:46:40 +0100
Message-ID: <CAPDyKFoTBXNtGe1R3Kw3q8O28FgwxnfqSF2BkOYZqNxk4EpRsQ@mail.gmail.com>
References: <1425036274-9017-1-git-send-email-grygorii.strashko@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1425036274-9017-1-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@linaro.org>
Cc: Chris Ball <chris@printf.net>, Felipe Balbi <balbi@ti.com>, Nishanth Menon <nm@ti.com>, sumit.semwal@linaro.org, NeilBrown <neilb@suse.de>, linux-mmc <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Russ Dill <Russ.Dill@ti.com>
List-Id: linux-mmc@vger.kernel.org

On 27 February 2015 at 12:24,  <grygorii.strashko@linaro.org> wrote:
> From: Russ Dill <Russ.Dill@ti.com>
>
> Setting a dev_pm_ops suspend/resume pair but not a set of
> hibernation functions means those pm functions will not be
> called upon hibernation.
> Fix this by using SET_SYSTEM_SLEEP_PM_OPS, which appropriately
> assigns the suspend and hibernation handlers and move
> omap_hsmmc_x callbacks under CONFIG_PM_SLEEP to avoid build warnings.
>
> Signed-off-by: Russ Dill <Russ.Dill@ti.com>
> [Grygorii.Strashko@linaro.org: rebased on top of K4.0]
> Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>

Applied, thanks!

Kind regards
Uffe


> ---
>
> original patch: https://github.com/russdill/linux/commit/2ea98def0717f0918426c2004122c63d52cff1b4
>
>  drivers/mmc/host/omap_hsmmc.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index f84cfb0..9cc1ea3 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2236,7 +2236,7 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> -#ifdef CONFIG_PM
> +#ifdef CONFIG_PM_SLEEP
>  static int omap_hsmmc_suspend(struct device *dev)
>  {
>         struct omap_hsmmc_host *host = dev_get_drvdata(dev);
> @@ -2292,10 +2292,6 @@ static int omap_hsmmc_resume(struct device *dev)
>         pm_runtime_put_autosuspend(host->dev);
>         return 0;
>  }
> -
> -#else
> -#define omap_hsmmc_suspend     NULL
> -#define omap_hsmmc_resume      NULL
>  #endif
>
>  static int omap_hsmmc_runtime_suspend(struct device *dev)
> @@ -2376,8 +2372,7 @@ static int omap_hsmmc_runtime_resume(struct device *dev)
>  }
>
>  static struct dev_pm_ops omap_hsmmc_dev_pm_ops = {
> -       .suspend        = omap_hsmmc_suspend,
> -       .resume         = omap_hsmmc_resume,
> +       SET_SYSTEM_SLEEP_PM_OPS(omap_hsmmc_suspend, omap_hsmmc_resume)
>         .runtime_suspend = omap_hsmmc_runtime_suspend,
>         .runtime_resume = omap_hsmmc_runtime_resume,
>  };
> --
> 1.9.1
>
