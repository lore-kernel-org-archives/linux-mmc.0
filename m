From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 2/2] mmc: host: s3cmci: allow probing from device tree
Date: Thu, 29 Dec 2016 12:40:29 +0100
Message-ID: <CAPDyKFof0xx0VyAs+jOy0Qe6UDe0DRYTpda0X_seWP+8ao4Ytw@mail.gmail.com>
References: <1481289284-19919-1-git-send-email-sergio.prado@e-labworks.com>
 <1481289284-19919-3-git-send-email-sergio.prado@e-labworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1481289284-19919-3-git-send-email-sergio.prado@e-labworks.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sergio Prado <sergio.prado@e-labworks.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Ben Dooks <ben-linux@fluff.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 9 December 2016 at 14:14, Sergio Prado <sergio.prado@e-labworks.com> wrote:
> Allows configuring Samsung S3C24XX MMC/SD/SDIO controller using a device
> tree.
>
> Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
> ---
>  drivers/mmc/host/s3cmci.c | 155 +++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 131 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
> index 932a4b1fed33..bfeb90e8ffee 100644
> --- a/drivers/mmc/host/s3cmci.c
> +++ b/drivers/mmc/host/s3cmci.c
> @@ -23,6 +23,9 @@
>  #include <linux/gpio.h>
>  #include <linux/irq.h>
>  #include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_gpio.h>
>
>  #include <plat/gpio-cfg.h>
>  #include <mach/dma.h>
> @@ -127,6 +130,22 @@ enum dbg_channels {
>         dbg_conf  = (1 << 8),
>  };
>
> +struct s3cmci_drv_data {
> +       int is2440;

This doesn't say much.

Please use a more descriptive variable name and rename the struct to
perhaps "variant_data", because I guess that is what this is?

> +};
> +
> +static const struct s3cmci_drv_data s3c2410_s3cmci_drv_data = {
> +       .is2440 = 0,
> +};
> +
> +static const struct s3cmci_drv_data s3c2412_s3cmci_drv_data = {
> +       .is2440 = 1,
> +};
> +
> +static const struct s3cmci_drv_data s3c2440_s3cmci_drv_data = {
> +       .is2440 = 1,
> +};
> +
>  static const int dbgmap_err   = dbg_fail;
>  static const int dbgmap_info  = dbg_info | dbg_conf;
>  static const int dbgmap_debug = dbg_err | dbg_debug;
> @@ -1241,8 +1260,9 @@ static void s3cmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>         case MMC_POWER_ON:
>         case MMC_POWER_UP:
>                 /* Configure GPE5...GPE10 pins in SD mode */
> -               s3c_gpio_cfgall_range(S3C2410_GPE(5), 6, S3C_GPIO_SFN(2),
> -                                     S3C_GPIO_PULL_NONE);
> +               if (!host->pdev->dev.of_node)
> +                       s3c_gpio_cfgall_range(S3C2410_GPE(5), 6, S3C_GPIO_SFN(2),
> +                                             S3C_GPIO_PULL_NONE);
>
>                 if (host->pdata->set_power)
>                         host->pdata->set_power(ios->power_mode, ios->vdd);
> @@ -1254,7 +1274,8 @@ static void s3cmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>
>         case MMC_POWER_OFF:
>         default:
> -               gpio_direction_output(S3C2410_GPE(5), 0);
> +               if (!host->pdev->dev.of_node)
> +                       gpio_direction_output(S3C2410_GPE(5), 0);
>
>                 if (host->is2440)
>                         mci_con |= S3C2440_SDICON_SDRESET;
> @@ -1544,21 +1565,12 @@ static inline void s3cmci_debugfs_remove(struct s3cmci_host *host) { }
>
>  #endif /* CONFIG_DEBUG_FS */
>
> -static int s3cmci_probe(struct platform_device *pdev)
> +static int s3cmci_probe_pdata(struct s3cmci_host *host)
>  {
> -       struct s3cmci_host *host;
> -       struct mmc_host *mmc;
> -       int ret;
> -       int is2440;
> -       int i;
> +       struct platform_device *pdev = host->pdev;
> +       int i, ret;
>
> -       is2440 = platform_get_device_id(pdev)->driver_data;
> -
> -       mmc = mmc_alloc_host(sizeof(struct s3cmci_host), &pdev->dev);
> -       if (!mmc) {
> -               ret = -ENOMEM;
> -               goto probe_out;
> -       }
> +       host->is2440 = platform_get_device_id(pdev)->driver_data;
>
>         for (i = S3C2410_GPE(5); i <= S3C2410_GPE(10); i++) {
>                 ret = gpio_request(i, dev_name(&pdev->dev));
> @@ -1568,14 +1580,90 @@ static int s3cmci_probe(struct platform_device *pdev)
>                         for (i--; i >= S3C2410_GPE(5); i--)
>                                 gpio_free(i);
>
> -                       goto probe_free_host;
> +                       return ret;
>                 }
>         }
>
> +       return 0;
> +}
> +
> +static int s3cmci_probe_dt(struct s3cmci_host *host)
> +{
> +       struct platform_device *pdev = host->pdev;
> +       struct s3c24xx_mci_pdata *pdata;
> +       const struct s3cmci_drv_data *drvdata;
> +       struct mmc_host *mmc = host->mmc;
> +       int gpio, ret;
> +
> +       drvdata = of_device_get_match_data(&pdev->dev);
> +       if (!drvdata)
> +               return -ENODEV;
> +
> +       host->is2440 = drvdata->is2440;

Instead of copying only the member, perhaps assign a host->variant
pointer to the drvdata instead, as that allows to extend the
information for the variant to cover more things than only "is2440",
while going forward.

In other words:

host->variant = of_device_get_match_data(&pdev->dev);

> +
> +       ret = mmc_of_parse(mmc);
> +       if (ret)
> +               return ret;
> +
> +       pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> +       if (!pdata)
> +               return -ENOMEM;
> +
> +       pdata->ocr_avail = mmc->ocr_avail;
> +
> +       if (mmc->caps2 & MMC_CAP2_NO_WRITE_PROTECT)
> +               pdata->no_wprotect = 1;
> +
> +       if (mmc->caps & MMC_CAP_NEEDS_POLL)
> +               pdata->no_detect = 1;
> +
> +       if (mmc->caps2 & MMC_CAP2_RO_ACTIVE_HIGH)
> +               pdata->wprotect_invert = 1;
> +
> +       if (mmc->caps2 & MMC_CAP2_CD_ACTIVE_HIGH)
> +               pdata->detect_invert = 1;
> +
> +       gpio = of_get_named_gpio(pdev->dev.of_node, "cd-gpios", 0);

This should already be covered via mmc_of_parse().

> +       if (gpio_is_valid(gpio)) {
> +               pdata->gpio_detect = gpio;
> +               gpio_free(gpio);
> +       }
> +
> +       gpio = of_get_named_gpio(pdev->dev.of_node, "wp-gpios", 0);

This should already be covered via mmc_of_parse().

> +       if (gpio_is_valid(gpio)) {
> +               pdata->gpio_wprotect = gpio;
> +               gpio_free(gpio);
> +       }
> +
> +       pdev->dev.platform_data = pdata;
> +
> +       return 0;
> +}
> +
> +static int s3cmci_probe(struct platform_device *pdev)
> +{
> +       struct s3cmci_host *host;
> +       struct mmc_host *mmc;
> +       int ret;
> +       int i;
> +
> +       mmc = mmc_alloc_host(sizeof(struct s3cmci_host), &pdev->dev);
> +       if (!mmc) {
> +               ret = -ENOMEM;
> +               goto probe_out;
> +       }
> +
>         host = mmc_priv(mmc);
>         host->mmc       = mmc;
>         host->pdev      = pdev;
> -       host->is2440    = is2440;
> +
> +       if (pdev->dev.of_node)
> +               ret = s3cmci_probe_dt(host);
> +       else
> +               ret = s3cmci_probe_pdata(host);
> +
> +       if (ret)
> +               goto probe_free_host;
>
>         host->pdata = pdev->dev.platform_data;
>         if (!host->pdata) {
> @@ -1586,7 +1674,7 @@ static int s3cmci_probe(struct platform_device *pdev)
>         spin_lock_init(&host->complete_lock);
>         tasklet_init(&host->pio_tasklet, pio_tasklet, (unsigned long) host);
>
> -       if (is2440) {
> +       if (host->is2440) {
>                 host->sdiimsk   = S3C2440_SDIIMSK;
>                 host->sdidata   = S3C2440_SDIDATA;
>                 host->clk_div   = 1;
> @@ -1789,8 +1877,9 @@ static int s3cmci_probe(struct platform_device *pdev)
>         release_mem_region(host->mem->start, resource_size(host->mem));
>
>   probe_free_gpio:
> -       for (i = S3C2410_GPE(5); i <= S3C2410_GPE(10); i++)
> -               gpio_free(i);
> +       if (!pdev->dev.of_node)
> +               for (i = S3C2410_GPE(5); i <= S3C2410_GPE(10); i++)
> +                       gpio_free(i);
>
>   probe_free_host:
>         mmc_free_host(mmc);
> @@ -1837,9 +1926,9 @@ static int s3cmci_remove(struct platform_device *pdev)
>         if (!pd->no_detect)
>                 gpio_free(pd->gpio_detect);
>
> -       for (i = S3C2410_GPE(5); i <= S3C2410_GPE(10); i++)
> -               gpio_free(i);
> -
> +       if (!pdev->dev.of_node)
> +               for (i = S3C2410_GPE(5); i <= S3C2410_GPE(10); i++)
> +                       gpio_free(i);
>
>         iounmap(host->base);
>         release_mem_region(host->mem->start, resource_size(host->mem));
> @@ -1848,6 +1937,23 @@ static int s3cmci_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> +static const struct of_device_id s3cmci_dt_match[] = {
> +       {
> +               .compatible = "samsung,s3c2410-sdi",
> +               .data = &s3c2410_s3cmci_drv_data,
> +       },
> +       {
> +               .compatible = "samsung,s3c2412-sdi",
> +               .data = &s3c2412_s3cmci_drv_data,
> +       },
> +       {
> +               .compatible = "samsung,s3c2440-sdi",
> +               .data = &s3c2440_s3cmci_drv_data,
> +       },
> +       { /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, sdhci_s3c_dt_match);
> +
>  static const struct platform_device_id s3cmci_driver_ids[] = {
>         {
>                 .name   = "s3c2410-sdi",
> @@ -1867,6 +1973,7 @@ static int s3cmci_remove(struct platform_device *pdev)
>  static struct platform_driver s3cmci_driver = {
>         .driver = {
>                 .name   = "s3c-sdi",
> +               .of_match_table = s3cmci_dt_match,
>         },
>         .id_table       = s3cmci_driver_ids,
>         .probe          = s3cmci_probe,
> --
> 1.9.1
>

Kind regards
Uffe
