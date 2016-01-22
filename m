From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: remove the prepare_command hook
Date: Fri, 22 Jan 2016 10:27:15 +0900
Message-ID: <56A18573.1080405@samsung.com>
References: <1453341666-26703-1-git-send-email-jh80.chung@samsung.com>
 <56A0855F.308@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:59051 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234AbcAVB1R (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jan 2016 20:27:17 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O1B020QTYPGNO40@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 22 Jan 2016 10:27:16 +0900 (KST)
In-reply-to: <56A0855F.308@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org

Hi,

On 01/21/2016 04:14 PM, Shawn Lin wrote:
> On 2016/1/21 10:01, Jaehoon Chung wrote:
>> This patch removes the prepare_command hook from entire dw_mmc driver.
>> Now, almost all SoCs are using by default, except Exynos.
>> It seems that dwmmc controller is using unnecessary hook.
>> To know whether needs to set this bit or not,
>> add the DW_MMC_CARD_NO_USE_HOLD bit.
>>
>> If some SoCs need to disable this in future, just set the
>> DW_MMC_CARD_NO_USE_HOLD bit.
>> set_bit(DW_MMC_CARD_NO_USE_HOLD, &slot->flags),
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> 
> For dw_mmc-rockchip:
> Tested-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> For the full patch:
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks for testing and reviewing.
Applied this.

Best Regards,
Jaehoon Chung

> 
>> ---
>>   drivers/mmc/host/dw_mmc-exynos.c   | 31 ++++++++++---------------------
>>   drivers/mmc/host/dw_mmc-pltfm.c    | 19 ++-----------------
>>   drivers/mmc/host/dw_mmc-rockchip.c |  7 -------
>>   drivers/mmc/host/dw_mmc.c          |  5 ++---
>>   drivers/mmc/host/dw_mmc.h          |  3 +--
>>   5 files changed, 15 insertions(+), 50 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
>> index 3a7e835..8790f2a 100644
>> --- a/drivers/mmc/host/dw_mmc-exynos.c
>> +++ b/drivers/mmc/host/dw_mmc-exynos.c
>> @@ -145,6 +145,16 @@ static void dw_mci_exynos_set_clksel_timing(struct dw_mci *host, u32 timing)
>>           mci_writel(host, CLKSEL64, clksel);
>>       else
>>           mci_writel(host, CLKSEL, clksel);
>> +
>> +    /*
>> +     * Exynos4412 and Exynos5250 extends the use of CMD register with the
>> +     * use of bit 29 (which is reserved on standard MSHC controllers) for
>> +     * optionally bypassing the HOLD register for command and data. The
>> +     * HOLD register should be bypassed in case there is no phase shift
>> +     * applied on CMD/DATA that is sent to the card.
>> +     */
>> +    if (!SDMMC_CLKSEL_GET_DRV_WD3(clksel))
>> +        set_bit(DW_MMC_CARD_NO_USE_HOLD, &host->cur_slot->flags);
>>   }
>>
>>   #ifdef CONFIG_PM_SLEEP
>> @@ -202,26 +212,6 @@ static int dw_mci_exynos_resume_noirq(struct device *dev)
>>   #define dw_mci_exynos_resume_noirq    NULL
>>   #endif /* CONFIG_PM_SLEEP */
>>
>> -static void dw_mci_exynos_prepare_command(struct dw_mci *host, u32 *cmdr)
>> -{
>> -    struct dw_mci_exynos_priv_data *priv = host->priv;
>> -    /*
>> -     * Exynos4412 and Exynos5250 extends the use of CMD register with the
>> -     * use of bit 29 (which is reserved on standard MSHC controllers) for
>> -     * optionally bypassing the HOLD register for command and data. The
>> -     * HOLD register should be bypassed in case there is no phase shift
>> -     * applied on CMD/DATA that is sent to the card.
>> -     */
>> -    if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
>> -        priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU) {
>> -        if (SDMMC_CLKSEL_GET_DRV_WD3(mci_readl(host, CLKSEL64)))
>> -            *cmdr |= SDMMC_CMD_USE_HOLD_REG;
>> -     } else {
>> -        if (SDMMC_CLKSEL_GET_DRV_WD3(mci_readl(host, CLKSEL)))
>> -            *cmdr |= SDMMC_CMD_USE_HOLD_REG;
>> -    }
>> -}
>> -
>>   static void dw_mci_exynos_config_hs400(struct dw_mci *host, u32 timing)
>>   {
>>       struct dw_mci_exynos_priv_data *priv = host->priv;
>> @@ -500,7 +490,6 @@ static const struct dw_mci_drv_data exynos_drv_data = {
>>       .caps            = exynos_dwmmc_caps,
>>       .init            = dw_mci_exynos_priv_init,
>>       .setup_clock        = dw_mci_exynos_setup_clock,
>> -    .prepare_command    = dw_mci_exynos_prepare_command,
>>       .set_ios        = dw_mci_exynos_set_ios,
>>       .parse_dt        = dw_mci_exynos_parse_dt,
>>       .execute_tuning        = dw_mci_exynos_execute_tuning,
>> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
>> index 81bdeeb..c0bb0c7 100644
>> --- a/drivers/mmc/host/dw_mmc-pltfm.c
>> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
>> @@ -26,19 +26,6 @@
>>   #include "dw_mmc.h"
>>   #include "dw_mmc-pltfm.h"
>>
>> -static void dw_mci_pltfm_prepare_command(struct dw_mci *host, u32 *cmdr)
>> -{
>> -    *cmdr |= SDMMC_CMD_USE_HOLD_REG;
>> -}
>> -
>> -static const struct dw_mci_drv_data socfpga_drv_data = {
>> -    .prepare_command    = dw_mci_pltfm_prepare_command,
>> -};
>> -
>> -static const struct dw_mci_drv_data pistachio_drv_data = {
>> -    .prepare_command    = dw_mci_pltfm_prepare_command,
>> -};
>> -
>>   int dw_mci_pltfm_register(struct platform_device *pdev,
>>                 const struct dw_mci_drv_data *drv_data)
>>   {
>> @@ -94,10 +81,8 @@ EXPORT_SYMBOL_GPL(dw_mci_pltfm_pmops);
>>
>>   static const struct of_device_id dw_mci_pltfm_match[] = {
>>       { .compatible = "snps,dw-mshc", },
>> -    { .compatible = "altr,socfpga-dw-mshc",
>> -        .data = &socfpga_drv_data },
>> -    { .compatible = "img,pistachio-dw-mshc",
>> -        .data = &pistachio_drv_data },
>> +    { .compatible = "altr,socfpga-dw-mshc", },
>> +    { .compatible = "img,pistachio-dw-mshc", },
>>       {},
>>   };
>>   MODULE_DEVICE_TABLE(of, dw_mci_pltfm_match);
>> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
>> index d9c92f3..84e50f3 100644
>> --- a/drivers/mmc/host/dw_mmc-rockchip.c
>> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
>> @@ -26,11 +26,6 @@ struct dw_mci_rockchip_priv_data {
>>       int            default_sample_phase;
>>   };
>>
>> -static void dw_mci_rockchip_prepare_command(struct dw_mci *host, u32 *cmdr)
>> -{
>> -    *cmdr |= SDMMC_CMD_USE_HOLD_REG;
>> -}
>> -
>>   static int dw_mci_rk3288_setup_clock(struct dw_mci *host)
>>   {
>>       host->bus_hz /= RK3288_CLKGEN_DIV;
>> @@ -240,12 +235,10 @@ static int dw_mci_rockchip_init(struct dw_mci *host)
>>   }
>>
>>   static const struct dw_mci_drv_data rk2928_drv_data = {
>> -    .prepare_command        = dw_mci_rockchip_prepare_command,
>>       .init            = dw_mci_rockchip_init,
>>   };
>>
>>   static const struct dw_mci_drv_data rk3288_drv_data = {
>> -    .prepare_command        = dw_mci_rockchip_prepare_command,
>>       .set_ios        = dw_mci_rk3288_set_ios,
>>       .execute_tuning        = dw_mci_rk3288_execute_tuning,
>>       .parse_dt        = dw_mci_rk3288_parse_dt,
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index ffef24a..7238f66 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -234,7 +234,6 @@ static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
>>       struct mmc_data    *data;
>>       struct dw_mci_slot *slot = mmc_priv(mmc);
>>       struct dw_mci *host = slot->host;
>> -    const struct dw_mci_drv_data *drv_data = slot->host->drv_data;
>>       u32 cmdr;
>>
>>       cmd->error = -EINPROGRESS;
>> @@ -296,8 +295,8 @@ static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
>>               cmdr |= SDMMC_CMD_DAT_WR;
>>       }
>>
>> -    if (drv_data && drv_data->prepare_command)
>> -        drv_data->prepare_command(slot->host, &cmdr);
>> +    if (!test_bit(DW_MMC_CARD_NO_USE_HOLD, &slot->flags))
>> +        cmdr |= SDMMC_CMD_USE_HOLD_REG;
>>
>>       return cmdr;
>>   }
>> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
>> index a14b7fc..68d5da2 100644
>> --- a/drivers/mmc/host/dw_mmc.h
>> +++ b/drivers/mmc/host/dw_mmc.h
>> @@ -268,6 +268,7 @@ struct dw_mci_slot {
>>   #define DW_MMC_CARD_PRESENT    0
>>   #define DW_MMC_CARD_NEED_INIT    1
>>   #define DW_MMC_CARD_NO_LOW_PWR    2
>> +#define DW_MMC_CARD_NO_USE_HOLD 3
>>       int            id;
>>       int            sdio_id;
>>   };
>> @@ -277,7 +278,6 @@ struct dw_mci_slot {
>>    * @caps: mmc subsystem specified capabilities of the controller(s).
>>    * @init: early implementation specific initialization.
>>    * @setup_clock: implementation specific clock configuration.
>> - * @prepare_command: handle CMD register extensions.
>>    * @set_ios: handle bus specific extensions.
>>    * @parse_dt: parse implementation specific device tree properties.
>>    * @execute_tuning: implementation specific tuning procedure.
>> @@ -290,7 +290,6 @@ struct dw_mci_drv_data {
>>       unsigned long    *caps;
>>       int        (*init)(struct dw_mci *host);
>>       int        (*setup_clock)(struct dw_mci *host);
>> -    void        (*prepare_command)(struct dw_mci *host, u32 *cmdr);
>>       void        (*set_ios)(struct dw_mci *host, struct mmc_ios *ios);
>>       int        (*parse_dt)(struct dw_mci *host);
>>       int        (*execute_tuning)(struct dw_mci_slot *slot, u32 opcode);
>>
> 
> 

