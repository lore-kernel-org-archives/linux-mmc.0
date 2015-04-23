From: "Rajendra Nayak" <rnayak@codeaurora.org>
Subject: Re: [RFC/RFT 4/6] mmc: sdhci-msm: convert driver to use runtime PM
 apis
Date: Thu, 23 Apr 2015 13:42:52 -0000
Message-ID: <f390840a65cdf503397b162f2f8f8133.squirrel@www.codeaurora.org>
References: <1429778744-13352-1-git-send-email-rnayak@codeaurora.org>
    <1429778744-13352-5-git-send-email-rnayak@codeaurora.org>
    <CAPDyKFpKPkKXutn-2OAC4r6Um254C2vQoF83SB4Dsk4MmZv=wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpKPkKXutn-2OAC4r6Um254C2vQoF83SB4Dsk4MmZv=wQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rajendra Nayak <rnayak@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org


> On 23 April 2015 at 10:45, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>> With platform support now in place to manage clocks from within runtime
>> PM
>> callbacks, get rid of all clock handling from the driver and convert the
>> driver to use runtime PM apis.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> Cc: <linux-mmc@vger.kernel.org>
>> ---
>>  drivers/mmc/host/sdhci-msm.c | 46
>> +++++++++++---------------------------------
>>  1 file changed, 11 insertions(+), 35 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>> index 4a09f76..3c62a77 100644
>> --- a/drivers/mmc/host/sdhci-msm.c
>> +++ b/drivers/mmc/host/sdhci-msm.c
>> @@ -19,6 +19,7 @@
>>  #include <linux/delay.h>
>>  #include <linux/mmc/mmc.h>
>>  #include <linux/slab.h>
>> +#include <linux/pm_runtime.h>
>>
>>  #include "sdhci-pltfm.h"
>>
>> @@ -56,8 +57,6 @@
>>  struct sdhci_msm_host {
>>         struct platform_device *pdev;
>>         void __iomem *core_mem; /* MSM SDCC mapped address */
>> -       struct clk *clk;        /* main SD/MMC bus clock */
>> -       struct clk *pclk;       /* SDHC peripheral bus clock */
>>         struct clk *bus_clk;    /* SDHC bus voter clock */
>>         struct mmc_host *mmc;
>>         struct sdhci_pltfm_data sdhci_msm_pdata;
>> @@ -469,29 +468,8 @@ static int sdhci_msm_probe(struct platform_device
>> *pdev)
>>                         goto pltfm_free;
>>         }
>>
>> -       /* Setup main peripheral bus clock */
>> -       msm_host->pclk = devm_clk_get(&pdev->dev, "iface");
>> -       if (IS_ERR(msm_host->pclk)) {
>> -               ret = PTR_ERR(msm_host->pclk);
>> -               dev_err(&pdev->dev, "Perpheral clk setup failed (%d)\n",
>> ret);
>> -               goto bus_clk_disable;
>> -       }
>> -
>> -       ret = clk_prepare_enable(msm_host->pclk);
>> -       if (ret)
>> -               goto bus_clk_disable;
>> -
>> -       /* Setup SDC MMC clock */
>> -       msm_host->clk = devm_clk_get(&pdev->dev, "core");
>> -       if (IS_ERR(msm_host->clk)) {
>> -               ret = PTR_ERR(msm_host->clk);
>> -               dev_err(&pdev->dev, "SDC MMC clk setup failed (%d)\n",
>> ret);
>> -               goto pclk_disable;
>> -       }
>> -
>> -       ret = clk_prepare_enable(msm_host->clk);
>> -       if (ret)
>> -               goto pclk_disable;
>> +       pm_runtime_enable(&pdev->dev);
>> +       pm_runtime_get_sync(&pdev->dev);
>>
>>         core_memres = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>>         msm_host->core_mem = devm_ioremap_resource(&pdev->dev,
>> core_memres);
>> @@ -499,7 +477,7 @@ static int sdhci_msm_probe(struct platform_device
>> *pdev)
>>         if (IS_ERR(msm_host->core_mem)) {
>>                 dev_err(&pdev->dev, "Failed to remap registers\n");
>>                 ret = PTR_ERR(msm_host->core_mem);
>> -               goto clk_disable;
>> +               goto err;
>>         }
>>
>>         /* Reset the core and Enable SDHC mode */
>> @@ -511,7 +489,7 @@ static int sdhci_msm_probe(struct platform_device
>> *pdev)
>>         if (readl(msm_host->core_mem + CORE_POWER) & CORE_SW_RST) {
>>                 dev_err(&pdev->dev, "Stuck in reset\n");
>>                 ret = -ETIMEDOUT;
>> -               goto clk_disable;
>> +               goto err;
>>         }
>>
>>         /* Set HC_MODE_EN bit in HC_MODE register */
>> @@ -545,15 +523,13 @@ static int sdhci_msm_probe(struct platform_device
>> *pdev)
>>
>>         ret = sdhci_add_host(host);
>>         if (ret)
>> -               goto clk_disable;
>> +               goto err;
>>
>>         return 0;
>>
>> -clk_disable:
>> -       clk_disable_unprepare(msm_host->clk);
>> -pclk_disable:
>> -       clk_disable_unprepare(msm_host->pclk);
>> -bus_clk_disable:
>> +err:
>> +       pm_runtime_put_sync(&pdev->dev);
>> +       pm_runtime_disable(&pdev->dev);
>>         if (!IS_ERR(msm_host->bus_clk))
>>                 clk_disable_unprepare(msm_host->bus_clk);
>>  pltfm_free:
>> @@ -571,8 +547,8 @@ static int sdhci_msm_remove(struct platform_device
>> *pdev)
>>
>>         sdhci_remove_host(host, dead);
>>         sdhci_pltfm_free(pdev);
>> -       clk_disable_unprepare(msm_host->clk);
>> -       clk_disable_unprepare(msm_host->pclk);
>> +       pm_runtime_put_sync(&pdev->dev);
>> +       pm_runtime_disable(&pdev->dev);
>>         if (!IS_ERR(msm_host->bus_clk))
>>                 clk_disable_unprepare(msm_host->bus_clk);
>>         return 0;
>> --
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
>> member
>> of Code Aurora Forum, hosted by The Linux Foundation
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> This all looks wrong. The driver will no longer work unless CONFIG_PM is
> set.

Right, I seem to have completely ignored the !CONFIG_PM case.
Will look at how to handle that.

>
> Kind regards
> Uffe
>


-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

