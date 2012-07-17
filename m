From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH] mmc: dwmmc: Add quirk for broken Hardware Config
Date: Tue, 17 Jul 2012 16:07:49 +0530
Message-ID: <CAGxe1ZE7F_V3-qiGrNV0nd_aUyD+P3jSZoJO7=L4FzbYKpstzQ@mail.gmail.com>
References: <1342428302-10707-1-git-send-email-girish.shivananjappa@linaro.org>
	<5005184E.6000807@samsung.com>
	<CAGxe1ZGdADbDbJHV+=knDxtO4PxsNVq6A4jc1oCx8SDc_mDHQw@mail.gmail.com>
	<50053500.6030409@samsung.com>
	<CAGxe1ZE9Yk66A_eKeegJMQPuqSS63Ur+9NoiBXzYXNc1dEz-_Q@mail.gmail.com>
	<50053AAC.5050507@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:55701 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753425Ab2GQKhv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Jul 2012 06:37:51 -0400
Received: by qadb17 with SMTP id b17so2134022qad.19
        for <linux-mmc@vger.kernel.org>; Tue, 17 Jul 2012 03:37:50 -0700 (PDT)
In-Reply-To: <50053AAC.5050507@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, will.newton@imgtec.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org, shashidharh@vayavyalabs.com, thomas.abraham@linaro.org

On 17 July 2012 15:43, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi Girish..
>
> i tested with your patch and applied the device tree patch.
> But i found the didn't compare with the MMC_CAP2_CONFIG_BROKEN.
>
> I think that host->drv_data->caps2 just denote address.
> So if running the your code,
> Maybe it's compared like "0xc02a6e54 & 0x00001000".
> Is it wrong?
i got your point
Thanks for pointing it.
>
> Best Regards,
> Jaehoon Chung
>
> On 07/17/2012 06:54 PM, Girish K S wrote:
>> On 17 July 2012 15:18, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>> On 07/17/2012 06:17 PM, Girish K S wrote:
>>>> On 17 July 2012 13:16, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>>>> Hi Girish,
>>>>>
>>>>> On 07/16/2012 05:45 PM, Girish K S wrote:
>>>>>> In some Soc'S that integrate Designware mmc host controllers, the
>>>>>> HCON register is broken. The hardware configuration is not
>>>>>> updated. One specific usecase is the IDMAC. In Exysons5 SoC
>>>>>> there exist a internal DMA, but the HCON register's DMA_INTERFACE
>>>>>> field is not set to indicate its existance.
>>>>>>
>>>>>> This quirk can be used in such case to force the existance broken
>>>>>> HCON field.
>>>>>>
>>>>>> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
>>>>>> ---
>>>>>>  drivers/mmc/host/dw_mmc-pltfm.c |    5 +++++
>>>>>>  drivers/mmc/host/dw_mmc.c       |   11 ++++++++++-
>>>>>>  drivers/mmc/host/dw_mmc.h       |    1 +
>>>>>>  include/linux/mmc/host.h        |    1 +
>>>>>>  4 files changed, 17 insertions(+), 1 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
>>>>>> index 900f412..24ea485 100644
>>>>>> --- a/drivers/mmc/host/dw_mmc-pltfm.c
>>>>>> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
>>>>>> @@ -35,9 +35,14 @@ static unsigned long exynos5250_dwmmc_caps[4] = {
>>>>>>       MMC_CAP_CMD23,
>>>>>>  };
>>>>>>
>>>>>> +static unsigned long exynos5250_dwmmc_caps2[1] = {
>>>>>> +     MMC_CAP2_CONFIG_BROKEN,
>>>>>> +};
>>>>>> +
>>>>>>  static struct dw_mci_drv_data exynos5250_drv_data = {
>>>>>>       .ctrl_type      = DW_MCI_TYPE_EXYNOS5250,
>>>>>>       .caps           = exynos5250_dwmmc_caps,
>>>>>> +     .caps2          = exynos5250_dwmmc_caps2,
>>>>>>  };
>>>>>>
>>>>>>  static const struct of_device_id dw_mci_pltfm_match[] = {
>>>>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>>>>> index 1a59a92..030224c 100644
>>>>>> --- a/drivers/mmc/host/dw_mmc.c
>>>>>> +++ b/drivers/mmc/host/dw_mmc.c
>>>>>> @@ -431,7 +431,13 @@ static int dw_mci_idmac_init(struct dw_mci *host)
>>>>>>       /* Check if Hardware Configuration Register has support for DMA */
>>>>>>       dma_support = (mci_readl(host, HCON) >> 16) & 0x3;
>>>>>>
>>>>>> -     if (!dma_support || dma_support > 2) {
>>>>>> +     /*
>>>>>> +      * In Some of the Soc's the HCON Register is broken. Even though the
>>>>>> +      * Soc's has a internal DMA the HCON register's DMA field doesnt
>>>>>> +      * show it. So additional quirk is added for such Soc's
>>>>>> +      */
>>>>>> +     if ((!dma_support || dma_support > 2) &&
>>>>>> +             !((u32)host->drv_data->caps2 & MMC_CAP2_CONFIG_BROKEN)) {
>>>>> Just caps2? if use the device tree, need to get ctrl_id?
>>>> but i found one thing. I have initialized only one channel. are you
>>>> mentioning to initialize all 4 channels of exynos5
>>> You're defined "unsigned long *caps2"..host->drv_data->caps2?? what's value?
>>
>> .caps2          = exynos5250_dwmmc_caps2
>> and
>> static unsigned long exynos5250_dwmmc_caps2[1] = {
>>    MMC_CAP2_CONFIG_BROKEN,
>> };
>> hope i answered it
>>>>> It didn't work..
>>>>>>               dev_err(&host->dev,
>>>>>>                       "Host Controller does not support IDMA Tx.\n");
>>>>>>               host->dma_ops = NULL;
>>>>>> @@ -1957,6 +1963,9 @@ static int __init dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>>>>>>       if (host->pdata->caps2)
>>>>>>               mmc->caps2 = host->pdata->caps2;
>>>>>>
>>>>>> +     if (host->drv_data->caps2)
>>>>>> +             mmc->caps2 |= host->drv_data->caps2[ctrl_id];
>>>>>> +
>>>>>>       if (host->pdata->get_bus_wd) {
>>>>>>               if (host->pdata->get_bus_wd(slot->id) >= 4)
>>>>>>                       mmc->caps |= MMC_CAP_4_BIT_DATA;
>>>>>> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
>>>>>> index 6c17282..8c4810a 100644
>>>>>> --- a/drivers/mmc/host/dw_mmc.h
>>>>>> +++ b/drivers/mmc/host/dw_mmc.h
>>>>>> @@ -203,6 +203,7 @@ extern int dw_mci_resume(struct dw_mci *host);
>>>>>>  struct dw_mci_drv_data {
>>>>>>       unsigned long           ctrl_type;
>>>>>>       unsigned long           *caps;
>>>>>> +     unsigned long           *caps2;
>>>>>>  };
>>>>>>
>>>>>>  #endif /* _DW_MMC_H_ */
>>>>>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>>>>>> index 65c64ee..ab5c7f9 100644
>>>>>> --- a/include/linux/mmc/host.h
>>>>>> +++ b/include/linux/mmc/host.h
>>>>>> @@ -261,6 +261,7 @@ struct mmc_host {
>>>>>>  #define MMC_CAP2_HC_ERASE_SZ (1 << 9)        /* High-capacity erase size */
>>>>>>  #define MMC_CAP2_CD_ACTIVE_HIGH      (1 << 10)       /* Card-detect signal active high */
>>>>>>  #define MMC_CAP2_RO_ACTIVE_HIGH      (1 << 11)       /* Write-protect signal active high */
>>>>>> +#define MMC_CAP2_CONFIG_BROKEN       (1 << 12)       /* Broken Config Register */
>>>>>>
>>>>>>       mmc_pm_flag_t           pm_caps;        /* supported pm features */
>>>>>>       unsigned int        power_notify_type;
>>>>>>
>>>>>
>>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
