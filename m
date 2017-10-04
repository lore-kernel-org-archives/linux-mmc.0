From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/7] mmc: sdhci-s3c: Fix driver data for Exynos4 SoCs
Date: Wed, 4 Oct 2017 10:59:30 +0200
Message-ID: <CAPDyKFqU0AUX8HB9yS3guikwLJuwza27SuO6rE+Cn_5ikZgbxA@mail.gmail.com>
References: <CGME20171004063835eucas1p1082954a0113f374f11ff364cf4b95408@eucas1p1.samsung.com>
 <20171004063828.22068-1-m.szyprowski@samsung.com> <20171004063828.22068-4-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20171004063828.22068-4-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On 4 October 2017 at 08:38, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> Support for non-dt based initialization for Exynos SoCs has been removed,
> so there is no need to keep driver IDs for this case. While touching this,
> replace odd conditional code for instantiating driver data for Exynos4
> SoCs with a simple reference and move that driver data under CONFIG_OF.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-s3c.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index d328fcf284d1..cda83ccb2702 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -761,32 +761,24 @@ static const struct dev_pm_ops sdhci_s3c_pmops = {
>                            NULL)
>  };
>
> -#if defined(CONFIG_CPU_EXYNOS4210) || defined(CONFIG_SOC_EXYNOS4212)
> -static struct sdhci_s3c_drv_data exynos4_sdhci_drv_data = {
> -       .no_divider = true,
> -};
> -#define EXYNOS4_SDHCI_DRV_DATA ((kernel_ulong_t)&exynos4_sdhci_drv_data)
> -#else
> -#define EXYNOS4_SDHCI_DRV_DATA ((kernel_ulong_t)NULL)
> -#endif
> -
>  static const struct platform_device_id sdhci_s3c_driver_ids[] = {
>         {
>                 .name           = "s3c-sdhci",
>                 .driver_data    = (kernel_ulong_t)NULL,
> -       }, {
> -               .name           = "exynos4-sdhci",
> -               .driver_data    = EXYNOS4_SDHCI_DRV_DATA,
>         },
>         { }
>  };
>  MODULE_DEVICE_TABLE(platform, sdhci_s3c_driver_ids);
>
>  #ifdef CONFIG_OF
> +static struct sdhci_s3c_drv_data exynos4_sdhci_drv_data = {
> +       .no_divider = true,
> +};
> +
>  static const struct of_device_id sdhci_s3c_dt_match[] = {
>         { .compatible = "samsung,s3c6410-sdhci", },
>         { .compatible = "samsung,exynos4210-sdhci",
> -               .data = (void *)EXYNOS4_SDHCI_DRV_DATA },
> +               .data = &exynos4_sdhci_drv_data },
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_s3c_dt_match);
> --
> 2.14.2
>
