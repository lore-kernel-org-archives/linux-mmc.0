From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/4] mmc: sdhci-s3c: use the sdhci-pltfm for Samsung-SoC
Date: Fri, 24 Feb 2012 19:12:21 +0900
Message-ID: <4F476285.7080806@samsung.com>
References: <4F39EB0A.5070708@samsung.com>
 <CAJuYYwSLgO1uNfPDC9HvX5ZjTrL+AzLDh9MJnZVV2=_AhMJwLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAJuYYwSLgO1uNfPDC9HvX5ZjTrL+AzLDh9MJnZVV2=_AhMJwLw@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-samsung-soc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, kgene kim <kgene.kim@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On 02/24/2012 06:53 PM, Thomas Abraham wrote:

> Dear Mr. Chung,
> 
> This has been in the todo list for a long time. Thanks for the patch.
> With the use of device tree and sdhci-pltfm driver, it should be
> possible to avoid dependency with platform code.

I'm working for using sdhci-pltfm. And in mmc-next tree, latest your patch is merged.
(using device-tree). So i rework this patch.
Right. this is the todo list. And need more discussion.
Main goal is to use the sdhci-pltfm.

> 
> There are few comments below.
> 
> On 14 February 2012 10:33, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> This patch is change to use the sdhci-pltfm.c
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  drivers/mmc/host/sdhci-s3c.c |  218 ++++++++++++++----------------------------
>>  1 files changed, 71 insertions(+), 147 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
>> index 1af756e..a651c1e 100644
>> --- a/drivers/mmc/host/sdhci-s3c.c
>> +++ b/drivers/mmc/host/sdhci-s3c.c
>> @@ -26,6 +26,7 @@
>>  #include <plat/sdhci.h>
>>  #include <plat/regs-sdhci.h>
>>
>> +#include "sdhci-pltfm.h"
>>  #include "sdhci.h"
>>
>>  #define MAX_BUS_CLK    (4)
>> @@ -41,9 +42,7 @@
>>  * @clk_bus: The clocks that are available for the SD/MMC bus clock.
>>  */
>>  struct sdhci_s3c {
>> -       struct sdhci_host       *host;
>>        struct platform_device  *pdev;
>> -       struct resource         *ioarea;
>>        struct s3c_sdhci_platdata *pdata;
>>        unsigned int            cur_clk;
> 
> Would it be possible to remove cur_clk and only use pltfm_host->clk ?

Good point, cur_clk can be removed.

> 
>>        int                     ext_cd_irq;
>> @@ -53,11 +52,6 @@ struct sdhci_s3c {
>>        struct clk              *clk_bus[MAX_BUS_CLK];
>>  };
>>
>> -static inline struct sdhci_s3c *to_s3c(struct sdhci_host *host)
>> -{
>> -       return sdhci_priv(host);
>> -}
>> -
>>  /**
>>  * get_curclk - convert ctrl2 register to clock source number
>>  * @ctrl2: Control2 register value.
>> @@ -72,7 +66,8 @@ static u32 get_curclk(u32 ctrl2)
>>
>>  static void sdhci_s3c_check_sclk(struct sdhci_host *host)
>>  {
>> -       struct sdhci_s3c *ourhost = to_s3c(host);
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       struct sdhci_s3c *ourhost = pltfm_host->priv;
>>        u32 tmp = readl(host->ioaddr + S3C_SDHCI_CONTROL2);
>>
>>        if (get_curclk(tmp) != ourhost->cur_clk) {
>> @@ -92,13 +87,13 @@ static void sdhci_s3c_check_sclk(struct sdhci_host *host)
>>  */
>>  static unsigned int sdhci_s3c_get_max_clk(struct sdhci_host *host)
>>  {
>> -       struct sdhci_s3c *ourhost = to_s3c(host);
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       struct sdhci_s3c *ourhost = pltfm_host->priv;
>>        struct clk *busclk;
>>        unsigned int rate, max;
>>        int clk;
>>
>>        /* note, a reset will reset the clock source */
>> -
>>        sdhci_s3c_check_sclk(host);
>>
>>        for (max = 0, clk = 0; clk < MAX_BUS_CLK; clk++) {
>> @@ -163,7 +158,8 @@ static unsigned int sdhci_s3c_consider_clock(struct sdhci_s3c *ourhost,
>>  */
>>  static void sdhci_s3c_set_clock(struct sdhci_host *host, unsigned int clock)
>>  {
>> -       struct sdhci_s3c *ourhost = to_s3c(host);
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       struct sdhci_s3c *ourhost = pltfm_host->priv;
>>        unsigned int best = UINT_MAX;
>>        unsigned int delta;
>>        int best_src = 0;
>> @@ -233,7 +229,8 @@ static void sdhci_s3c_set_clock(struct sdhci_host *host, unsigned int clock)
>>  */
>>  static unsigned int sdhci_s3c_get_min_clock(struct sdhci_host *host)
>>  {
>> -       struct sdhci_s3c *ourhost = to_s3c(host);
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       struct sdhci_s3c *ourhost = pltfm_host->priv;
>>        unsigned int delta, min = UINT_MAX;
>>        int src;
>>
>> @@ -251,27 +248,27 @@ static unsigned int sdhci_s3c_get_min_clock(struct sdhci_host *host)
>>  /* sdhci_cmu_get_max_clk - callback to get maximum clock frequency.*/
>>  static unsigned int sdhci_cmu_get_max_clock(struct sdhci_host *host)
>>  {
>> -       struct sdhci_s3c *ourhost = to_s3c(host);
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>
>> -       return clk_round_rate(ourhost->clk_bus[ourhost->cur_clk], UINT_MAX);
>> +       return clk_round_rate(pltfm_host->clk, UINT_MAX);
>>  }
>>
>>  /* sdhci_cmu_get_min_clock - callback to get minimal supported clock value. */
>>  static unsigned int sdhci_cmu_get_min_clock(struct sdhci_host *host)
>>  {
>> -       struct sdhci_s3c *ourhost = to_s3c(host);
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>
>>        /*
>>         * initial clock can be in the frequency range of
>>         * 100KHz-400KHz, so we set it as max value.
>>         */
>> -       return clk_round_rate(ourhost->clk_bus[ourhost->cur_clk], 400000);
>> +       return clk_round_rate(pltfm_host->clk, 400000);
>>  }
>>
>>  /* sdhci_cmu_set_clock - callback on clock change.*/
>>  static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned int clock)
>>  {
>> -       struct sdhci_s3c *ourhost = to_s3c(host);
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>
>>        /* don't bother if the clock is going off */
>>        if (clock == 0)
>> @@ -279,7 +276,7 @@ static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned int clock)
>>
>>        sdhci_s3c_set_clock(host, clock);
>>
>> -       clk_set_rate(ourhost->clk_bus[ourhost->cur_clk], clock);
>> +       clk_set_rate(pltfm_host->clk, clock);
>>
>>        host->clock = clock;
>>  }
>> @@ -382,52 +379,50 @@ static void sdhci_s3c_setup_card_detect_gpio(struct sdhci_s3c *sc)
>>        }
>>  }
>>
>> +static struct sdhci_pltfm_data sdhci_s3c_pdata = {
>> +       .quirks = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
>> +               SDHCI_QUIRK_NO_HISPD_BIT | SDHCI_QUIRK_NO_BUSY_IRQ |
>> +               SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 |
>> +               SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
>> +               SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
>> +               SDHCI_QUIRK_32BIT_DMA_ADDR | SDHCI_QUIRK_32BIT_DMA_SIZE,
>> +       .ops    = &sdhci_s3c_ops,
>> +};
>> +
>>  static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>>  {
>>        struct s3c_sdhci_platdata *pdata = pdev->dev.platform_data;
>>        struct device *dev = &pdev->dev;
>> +       struct sdhci_pltfm_host *pltfm_host;
>> +       struct sdhci_pltfm_data *pltfm_pdata = &sdhci_s3c_pdata;
>>        struct sdhci_host *host;
>>        struct sdhci_s3c *sc;
>> -       struct resource *res;
>> -       int ret, irq, ptr, clks;
>> -
>> -       if (!pdata) {
>> -               dev_err(dev, "no device data specified\n");
>> -               return -ENOENT;
>> -       }
>> +       int ret, ptr, clks;
>>
>> -       irq = platform_get_irq(pdev, 0);
>> -       if (irq < 0) {
>> -               dev_err(dev, "no irq specified\n");
>> -               return irq;
>> -       }
>> -
>> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -       if (!res) {
>> -               dev_err(dev, "no memory specified\n");
>> -               return -ENOENT;
>> -       }
>> -
>> -       host = sdhci_alloc_host(dev, sizeof(struct sdhci_s3c));
>> +       host = sdhci_pltfm_init(pdev, pltfm_pdata);
>>        if (IS_ERR(host)) {
>>                dev_err(dev, "sdhci_alloc_host() failed\n");
>>                return PTR_ERR(host);
>>        }
>>
>> -       sc = sdhci_priv(host);
>> +       sc = kzalloc(sizeof(struct sdhci_s3c), GFP_KERNEL);
>> +       if (!sc) {
>> +               ret = -ENOMEM;
>> +               goto err_alloc_host;
>> +       }
>> +
>> +       pltfm_host = sdhci_priv(host);
>> +       pltfm_host->priv = sc;
>>
>> -       sc->host = host;
>>        sc->pdev = pdev;
>> -       sc->pdata = pdata;
>> +       sc->pdata = pdev->dev.platform_data;
>>        sc->ext_cd_gpio = -1; /* invalid gpio number */
>>
>> -       platform_set_drvdata(pdev, host);
>> -
>>        sc->clk_io = clk_get(dev, "hsmmc");
>>        if (IS_ERR(sc->clk_io)) {
>>                dev_err(dev, "failed to get io clock\n");
>>                ret = PTR_ERR(sc->clk_io);
>> -               goto err_io_clk;
>> +               goto err_alloc_host;
>>        }
>>
>>        /* enable the local io clock and keep it running for the moment. */
>> @@ -439,9 +434,8 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>>
>>                snprintf(name, 14, "mmc_busclk.%d", ptr);
>>                clk = clk_get(dev, name);
>> -               if (IS_ERR(clk)) {
>> +               if (IS_ERR(clk))
>>                        continue;
>> -               }
>>
>>                clks++;
>>                sc->clk_bus[ptr] = clk;
>> @@ -450,7 +444,7 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>>                 * save current clock index to know which clock bus
>>                 * is used later in overriding functions.
>>                 */
>> -               sc->cur_clk = ptr;
>> +               pltfm_host->clk = clk;
> 
> The sc->cur_clk and pltfm_host->clk are being used interchangeably
> here. It would be better to use pltfm_host->clk and remove clk_clk
> member from driver private data.

Right.

> 
>>
>>                clk_enable(clk);
>>
>> @@ -464,53 +458,17 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>>                goto err_no_busclks;
>>        }
>>
>> -       sc->ioarea = request_mem_region(res->start, resource_size(res),
>> -                                       mmc_hostname(host->mmc));
>> -       if (!sc->ioarea) {
>> -               dev_err(dev, "failed to reserve register area\n");
>> -               ret = -ENXIO;
>> -               goto err_req_regs;
>> -       }
>> -
>> -       host->ioaddr = ioremap_nocache(res->start, resource_size(res));
>> -       if (!host->ioaddr) {
>> -               dev_err(dev, "failed to map registers\n");
>> -               ret = -ENXIO;
>> -               goto err_req_regs;
>> -       }
>> -
>>        /* Ensure we have minimal gpio selected CMD/CLK/Detect */
>> -       if (pdata->cfg_gpio)
>> -               pdata->cfg_gpio(pdev, pdata->max_width);
>> -
>> -       host->hw_name = "samsung-hsmmc";
>> -       host->ops = &sdhci_s3c_ops;
>> -       host->quirks = 0;
>> -       host->irq = irq;
>> -
>> -       /* Setup quirks for the controller */
>> -       host->quirks |= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC;
>> -       host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
>> +       if (sc->pdata->cfg_gpio)
>> +               sc->pdata->cfg_gpio(pdev, sc->pdata->max_width);
>>
>>  #ifndef CONFIG_MMC_SDHCI_S3C_DMA
>> -
>>        /* we currently see overruns on errors, so disable the SDMA
>>         * support as well. */
>>        host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
>>
>>  #endif /* CONFIG_MMC_SDHCI_S3C_DMA */
>>
>> -       /* It seems we do not get an DATA transfer complete on non-busy
>> -        * transfers, not sure if this is a problem with this specific
>> -        * SDHCI block, or a missing configuration that needs to be set. */
>> -       host->quirks |= SDHCI_QUIRK_NO_BUSY_IRQ;
>> -
>> -       /* This host supports the Auto CMD12 */
>> -       host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
>> -
>> -       /* Samsung SoCs need BROKEN_ADMA_ZEROLEN_DESC */
>> -       host->quirks |= SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC;
>> -
>>        if (pdata->cd_type == S3C_SDHCI_CD_NONE ||
>>            pdata->cd_type == S3C_SDHCI_CD_PERMANENT)
>>                host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
>> @@ -518,17 +476,14 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>>        if (pdata->cd_type == S3C_SDHCI_CD_PERMANENT)
>>                host->mmc->caps = MMC_CAP_NONREMOVABLE;
>>
>> +       /* It supports additional host capabilities if needed */
>>        if (pdata->host_caps)
>> -               host->mmc->caps |= pdata->host_caps;
>> -
>> -       if (pdata->pm_caps)
>> -               host->mmc->pm_caps |= pdata->pm_caps;
>> +               host->mmc->caps |= sc->pdata->host_caps;
>>
>> -       host->quirks |= (SDHCI_QUIRK_32BIT_DMA_ADDR |
>> -                        SDHCI_QUIRK_32BIT_DMA_SIZE);
>> +       host->mmc->caps2 |= MMC_CAP2_BROKEN_VOLTAGE;
>>
>> -       /* HSMMC on Samsung SoCs uses SDCLK as timeout clock */
>> -       host->quirks |= SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK;
>> +       if (pdata->pm_caps)
>> +               host->mmc->pm_caps |= sc->pdata->pm_caps;
>>
>>        /*
>>         * If controller does not have internal clock divider,
>> @@ -540,10 +495,6 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>>                sdhci_s3c_ops.get_max_clock = sdhci_cmu_get_max_clock;
>>        }
>>
>> -       /* It supports additional host capabilities if needed */
>> -       if (pdata->host_caps)
>> -               host->mmc->caps |= pdata->host_caps;
>> -
>>        ret = sdhci_add_host(host);
>>        if (ret) {
>>                dev_err(dev, "sdhci_add_host() failed\n");
>> @@ -561,24 +512,21 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>>
>>        return 0;
>>
>> - err_add_host:
>> -       release_resource(sc->ioarea);
>> -       kfree(sc->ioarea);
>> -
>> - err_req_regs:
>> +err_add_host:
>>        for (ptr = 0; ptr < MAX_BUS_CLK; ptr++) {
>>                if (sc->clk_bus[ptr]) {
>>                        clk_disable(sc->clk_bus[ptr]);
>>                        clk_put(sc->clk_bus[ptr]);
>>                }
>>        }
>> -
>> - err_no_busclks:
>> +err_no_busclks:
>>        clk_disable(sc->clk_io);
>>        clk_put(sc->clk_io);
>>
>> - err_io_clk:
>> -       sdhci_free_host(host);
>> +       kfree(sc);
>> +err_alloc_host:
>> +       sdhci_pltfm_free(pdev);
>> +       dev_err(&pdev->dev, "%s failed %d\n", __func__, ret);
>>
>>        return ret;
>>  }
>> @@ -587,8 +535,9 @@ static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
>>  {
>>        struct s3c_sdhci_platdata *pdata = pdev->dev.platform_data;
>>        struct sdhci_host *host =  platform_get_drvdata(pdev);
>> -       struct sdhci_s3c *sc = sdhci_priv(host);
>> -       int ptr;
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       struct sdhci_s3c *sc = pltfm_host->priv;
>> +       int ptr, ret;
>>
>>        if (pdata->cd_type == S3C_SDHCI_CD_EXTERNAL && pdata->ext_cd_cleanup)
>>                pdata->ext_cd_cleanup(&sdhci_s3c_notify_change);
>> @@ -599,9 +548,9 @@ static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
>>        if (gpio_is_valid(sc->ext_cd_gpio))
>>                gpio_free(sc->ext_cd_gpio);
>>
>> -       sdhci_remove_host(host, 1);
>> +       ret = sdhci_pltfm_unregister(pdev);
>>
>> -       for (ptr = 0; ptr < 3; ptr++) {
>> +       for (ptr = 0; ptr < MAX_BUS_CLK; ptr++) {
>>                if (sc->clk_bus[ptr]) {
>>                        clk_disable(sc->clk_bus[ptr]);
>>                        clk_put(sc->clk_bus[ptr]);
>> @@ -610,54 +559,29 @@ static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
>>        clk_disable(sc->clk_io);
>>        clk_put(sc->clk_io);
>>
>> -       iounmap(host->ioaddr);
>> -       release_resource(sc->ioarea);
>> -       kfree(sc->ioarea);
>> -
>> -       sdhci_free_host(host);
>> -       platform_set_drvdata(pdev, NULL);
>> -
>> -       return 0;
>> -}
>> -
>> -#ifdef CONFIG_PM
>> -
>> -static int sdhci_s3c_suspend(struct device *dev)
>> -{
>> -       struct sdhci_host *host = dev_get_drvdata(dev);
>> -
>> -       return sdhci_suspend_host(host);
>> -}
>> -
>> -static int sdhci_s3c_resume(struct device *dev)
>> -{
>> -       struct sdhci_host *host = dev_get_drvdata(dev);
>> -
>> -       return sdhci_resume_host(host);
>> +       return ret;
>>  }
>>
>> -static const struct dev_pm_ops sdhci_s3c_pmops = {
>> -       .suspend        = sdhci_s3c_suspend,
>> -       .resume         = sdhci_s3c_resume,
>> -};
>> -
>> -#define SDHCI_S3C_PMOPS (&sdhci_s3c_pmops)
>> -
>> -#else
>> -#define SDHCI_S3C_PMOPS NULL
>> -#endif
>> -
>>  static struct platform_driver sdhci_s3c_driver = {
>>        .probe          = sdhci_s3c_probe,
>>        .remove         = __devexit_p(sdhci_s3c_remove),
>>        .driver         = {
>>                .owner  = THIS_MODULE,
>>                .name   = "s3c-sdhci",
>> -               .pm     = SDHCI_S3C_PMOPS,
> 
> The SDHCI_PLTFM_PMOPS could be used here since the s3c specific ops
> have been removed.

Right...I will fix.

> 
>>        },
>>  };
>>
>> -module_platform_driver(sdhci_s3c_driver);
>> +static int __init sdhci_s3c_init(void)
>> +{
>> +       return platform_driver_register(&sdhci_s3c_driver);
>> +}
>> +module_init(sdhci_s3c_init);
>> +
>> +static void __exit sdhci_s3c_exit(void)
>> +{
>> +       platform_driver_unregister(&sdhci_s3c_driver);
>> +}
>> +module_exit(sdhci_s3c_exit);
> 
> Any reason to expand this into a boilerplate again?

It's my mis-understanding. there is no reason.

Best Regards,
Jaehoon Chung

> 
>>
>>  MODULE_DESCRIPTION("Samsung SDHCI (HSMMC) glue");
>>  MODULE_AUTHOR("Ben Dooks, <ben@simtec.co.uk>");
> 
> Thanks,
> Thomas.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
