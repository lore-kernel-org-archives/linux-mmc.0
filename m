From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH] mmc: dwmmc: Add quirk for broken Hardware Config
Date: Tue, 17 Jul 2012 15:38:51 +0530
Message-ID: <CAGxe1ZG+hvX7DA8N12KNBKDcY+Yjp4R4NZ02P7x1AfG3abQkPg@mail.gmail.com>
References: <1342428302-10707-1-git-send-email-girish.shivananjappa@linaro.org>
	<5005184E.6000807@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <5005184E.6000807@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, will.newton@imgtec.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org, shashidharh@vayavyalabs.com, thomas.abraham@linaro.org
List-Id: linux-mmc@vger.kernel.org

On 17 July 2012 13:16, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi Girish,
>
> On 07/16/2012 05:45 PM, Girish K S wrote:
>> In some Soc'S that integrate Designware mmc host controllers, the
>> HCON register is broken. The hardware configuration is not
>> updated. One specific usecase is the IDMAC. In Exysons5 SoC
>> there exist a internal DMA, but the HCON register's DMA_INTERFACE
>> field is not set to indicate its existance.
>>
>> This quirk can be used in such case to force the existance broken
>> HCON field.
>>
>> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
>> ---
>>  drivers/mmc/host/dw_mmc-pltfm.c |    5 +++++
>>  drivers/mmc/host/dw_mmc.c       |   11 ++++++++++-
>>  drivers/mmc/host/dw_mmc.h       |    1 +
>>  include/linux/mmc/host.h        |    1 +
>>  4 files changed, 17 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
>> index 900f412..24ea485 100644
>> --- a/drivers/mmc/host/dw_mmc-pltfm.c
>> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
>> @@ -35,9 +35,14 @@ static unsigned long exynos5250_dwmmc_caps[4] = {
>>       MMC_CAP_CMD23,
>>  };
>>
>> +static unsigned long exynos5250_dwmmc_caps2[1] = {
>> +     MMC_CAP2_CONFIG_BROKEN,
>> +};
>> +
>>  static struct dw_mci_drv_data exynos5250_drv_data = {
>>       .ctrl_type      = DW_MCI_TYPE_EXYNOS5250,
>>       .caps           = exynos5250_dwmmc_caps,
>> +     .caps2          = exynos5250_dwmmc_caps2,
>>  };
>>
>>  static const struct of_device_id dw_mci_pltfm_match[] = {
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 1a59a92..030224c 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -431,7 +431,13 @@ static int dw_mci_idmac_init(struct dw_mci *host)
>>       /* Check if Hardware Configuration Register has support for DMA */
>>       dma_support = (mci_readl(host, HCON) >> 16) & 0x3;
>>
>> -     if (!dma_support || dma_support > 2) {
>> +     /*
>> +      * In Some of the Soc's the HCON Register is broken. Even though the
>> +      * Soc's has a internal DMA the HCON register's DMA field doesnt
>> +      * show it. So additional quirk is added for such Soc's
>> +      */
>> +     if ((!dma_support || dma_support > 2) &&
>> +             !((u32)host->drv_data->caps2 & MMC_CAP2_CONFIG_BROKEN)) {
> Just caps2? if use the device tree, need to get ctrl_id?
did you mean host->drv_data->caps2[ctrl_id].
Sorry my mistake i ll change it
> It didn't work..
>>               dev_err(&host->dev,
>>                       "Host Controller does not support IDMA Tx.\n");
>>               host->dma_ops = NULL;
>> @@ -1957,6 +1963,9 @@ static int __init dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>>       if (host->pdata->caps2)
>>               mmc->caps2 = host->pdata->caps2;
>>
>> +     if (host->drv_data->caps2)
>> +             mmc->caps2 |= host->drv_data->caps2[ctrl_id];
>> +
>>       if (host->pdata->get_bus_wd) {
>>               if (host->pdata->get_bus_wd(slot->id) >= 4)
>>                       mmc->caps |= MMC_CAP_4_BIT_DATA;
>> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
>> index 6c17282..8c4810a 100644
>> --- a/drivers/mmc/host/dw_mmc.h
>> +++ b/drivers/mmc/host/dw_mmc.h
>> @@ -203,6 +203,7 @@ extern int dw_mci_resume(struct dw_mci *host);
>>  struct dw_mci_drv_data {
>>       unsigned long           ctrl_type;
>>       unsigned long           *caps;
>> +     unsigned long           *caps2;
>>  };
>>
>>  #endif /* _DW_MMC_H_ */
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> index 65c64ee..ab5c7f9 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -261,6 +261,7 @@ struct mmc_host {
>>  #define MMC_CAP2_HC_ERASE_SZ (1 << 9)        /* High-capacity erase size */
>>  #define MMC_CAP2_CD_ACTIVE_HIGH      (1 << 10)       /* Card-detect signal active high */
>>  #define MMC_CAP2_RO_ACTIVE_HIGH      (1 << 11)       /* Write-protect signal active high */
>> +#define MMC_CAP2_CONFIG_BROKEN       (1 << 12)       /* Broken Config Register */
>>
>>       mmc_pm_flag_t           pm_caps;        /* supported pm features */
>>       unsigned int        power_notify_type;
>>
>
>
