From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 3/7] mmc: mediatek: Add PM support for MMC driver
Date: Tue, 5 May 2015 14:57:14 +0200
Message-ID: <CAPDyKFpC5XKOykCBp_JgcP7UAWoS-m5uFvb+QhqrNBwkZNJ6Ow@mail.gmail.com>
References: <1430214525-19198-1-git-send-email-chaotian.jing@mediatek.com>
	<1430214525-19198-4-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:34224 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423103AbbEEM5P (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 May 2015 08:57:15 -0400
Received: by qgfi89 with SMTP id i89so80356950qgf.1
        for <linux-mmc@vger.kernel.org>; Tue, 05 May 2015 05:57:14 -0700 (PDT)
In-Reply-To: <1430214525-19198-4-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Chris Ball <chris@printf.net>, Mark Rutland <mark.rutland@arm.com>, James Liao <jamesjj.liao@mediatek.com>, srv_heupstream <srv_heupstream@mediatek.com>, Arnd Bergmann <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Hongzhou Yang <hongzhou.yang@mediatek.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-mmc <linux-mmc@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>, "Joe.C" <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, =?UTF-8?B?QmluIFpoYW5nICjnq6Dmlowp?= <bin.zhang@mediatek.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek

On 28 April 2015 at 11:48, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> Add PM support for Mediatek MMC driver
>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  drivers/mmc/host/mtk-sd.c | 58 +++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 53 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 30e688d..79177d9 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -22,6 +22,7 @@
>  #include <linux/of_gpio.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/spinlock.h>
>
> @@ -215,6 +216,7 @@
>  #define MSDC_ASYNC_FLAG (0x1 << 1)
>  #define MSDC_MMAP_FLAG (0x1 << 2)
>
> +#define MTK_MMC_AUTOSUSPEND_DELAY      500

Most other mmc host drivers use 50ms, any reason to why this driver
wants a different value?

>  #define CMD_TIMEOUT         (HZ/10 * 5)        /* 100ms x5 */
>  #define DAT_TIMEOUT         (HZ    * 5)        /* 1000ms x5 */
>
> @@ -706,6 +708,9 @@ static void msdc_request_done(struct msdc_host *host, struct mmc_request *mrq)
>         if (mrq->data)
>                 msdc_unprepare_data(host, mrq);
>         mmc_request_done(host->mmc, mrq);
> +
> +       pm_runtime_mark_last_busy(host->dev);
> +       pm_runtime_put_autosuspend(host->dev);
>  }
>
>  /* returns true if command is fully handled; returns false otherwise */
> @@ -862,6 +867,8 @@ static void msdc_ops_request(struct mmc_host *mmc, struct mmc_request *mrq)
>                 WARN_ON(host->mrq);
>         spin_unlock_irqrestore(&host->lock, flags);
>
> +       pm_runtime_get_sync(host->dev);
> +
>         if (mrq->data)
>                 msdc_prepare_data(host, mrq);
>
> @@ -999,7 +1006,6 @@ static int msdc_ops_switch_volt(struct mmc_host *mmc, struct mmc_ios *ios)
>         int ret = 0;
>
>         if (!IS_ERR(mmc->supply.vqmmc)) {
> -

White space.

>                 if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
>                         min_uv = 3300000;
>                         max_uv = 3300000;
> @@ -1018,7 +1024,6 @@ static int msdc_ops_switch_volt(struct mmc_host *mmc, struct mmc_ios *ios)
>                                         ret, min_uv, max_uv);
>                 }
>         }
> -

White space.

>         return ret;
>  }
>
> @@ -1176,8 +1181,10 @@ static void msdc_ops_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>         int ret;
>         u32 ddr = 0;
>
> +       pm_runtime_get_sync(host->dev);
> +
>         if (ios->timing == MMC_TIMING_UHS_DDR50 ||
> -               ios->timing == MMC_TIMING_MMC_DDR52)
> +                       ios->timing == MMC_TIMING_MMC_DDR52)

White space.

>                 ddr = 1;
>
>         msdc_set_buswidth(host, ios->bus_width);
> @@ -1191,7 +1198,7 @@ static void msdc_ops_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>                                         ios->vdd);
>                         if (ret) {
>                                 dev_err(host->dev, "Failed to set vmmc power!\n");
> -                               return;
> +                               goto end;
>                         }
>                 }
>                 break;
> @@ -1227,6 +1234,10 @@ static void msdc_ops_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>
>         if (host->mclk != ios->clock || host->ddr != ddr)
>                 msdc_set_mclk(host, ddr, ios->clock);
> +
> +end:
> +       pm_runtime_mark_last_busy(host->dev);
> +       pm_runtime_put_autosuspend(host->dev);
>  }
>
>  static struct mmc_host_ops mt_msdc_ops = {
> @@ -1350,12 +1361,19 @@ static int msdc_drv_probe(struct platform_device *pdev)
>         if (ret)
>                 goto release;
>
> +       pm_runtime_set_active(host->dev);
> +       pm_runtime_set_autosuspend_delay(host->dev, MTK_MMC_AUTOSUSPEND_DELAY);
> +       pm_runtime_use_autosuspend(host->dev);
> +       pm_runtime_enable(host->dev);
>         ret = mmc_add_host(mmc);
> +
>         if (ret)
> -               goto release;
> +               goto end;
>
>         return 0;
>
> +end:
> +       pm_runtime_disable(host->dev);
>  release:
>         platform_set_drvdata(pdev, NULL);
>         msdc_deinit_hw(host);
> @@ -1368,6 +1386,7 @@ release_mem:
>                 dma_free_coherent(&pdev->dev,
>                         MAX_BD_NUM * sizeof(struct mt_bdma_desc),
>                         host->dma.bd, host->dma.bd_addr);
> +

White space.

>  host_free:
>         mmc_free_host(mmc);
>
> @@ -1382,10 +1401,14 @@ static int msdc_drv_remove(struct platform_device *pdev)
>         mmc = platform_get_drvdata(pdev);
>         host = mmc_priv(mmc);
>
> +       pm_runtime_get_sync(host->dev);
> +
>         platform_set_drvdata(pdev, NULL);
>         mmc_remove_host(host->mmc);
>         msdc_deinit_hw(host);
>
> +       pm_runtime_disable(host->dev);
> +       pm_runtime_put_noidle(host->dev);
>         dma_free_coherent(&pdev->dev,
>                         sizeof(struct mt_gpdma_desc),
>                         host->dma.gpd, host->dma.gpd_addr);
> @@ -1397,6 +1420,30 @@ static int msdc_drv_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> +#ifdef CONFIG_PM
> +static int msdc_runtime_suspend(struct device *dev)
> +{
> +       struct mmc_host *mmc = dev_get_drvdata(dev);
> +       struct msdc_host *host = mmc_priv(mmc);
> +
> +       msdc_gate_clock(host);

According to comments to patch2, I would think we should be able to
handle both the "hclk" and the "source" clock from the runtime PM
callbacks. Let's see.

It should anyway not affect this patch that much. Overall it looks good!

> +       return 0;
> +}
> +
> +static int msdc_runtime_resume(struct device *dev)
> +{
> +       struct mmc_host *mmc = dev_get_drvdata(dev);
> +       struct msdc_host *host = mmc_priv(mmc);
> +
> +       msdc_ungate_clock(host);
> +       return 0;
> +}
> +#endif
> +
> +static const struct dev_pm_ops msdc_dev_pm_ops = {
> +       SET_RUNTIME_PM_OPS(msdc_runtime_suspend, msdc_runtime_resume, NULL)
> +};
> +
>  static const struct of_device_id msdc_of_ids[] = {
>         {   .compatible = "mediatek,mt8135-mmc", },
>         {}
> @@ -1408,6 +1455,7 @@ static struct platform_driver mt_msdc_driver = {
>         .driver = {
>                 .name = "mtk-msdc",
>                 .of_match_table = msdc_of_ids,
> +               .pm = &msdc_dev_pm_ops,
>         },
>  };
>
> --
> 1.8.1.1.dirty
>

Kind regards
Uffe
