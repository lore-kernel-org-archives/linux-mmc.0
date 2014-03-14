From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: add the vqmmc regulator
Date: Fri, 14 Mar 2014 17:16:28 +0900
Message-ID: <5322BADC.7030707@samsung.com>
References: <5322AEAB.8010602@samsung.com>
 <CAPDyKFqf0D6CDJ-t=TztLv6Ocefq9sUZAWGOhUgPVya3uXtpkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:46885 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755373AbaCNIQY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Mar 2014 04:16:24 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N2F00C002ZAHUA0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 14 Mar 2014 17:16:22 +0900 (KST)
In-reply-to: <CAPDyKFqf0D6CDJ-t=TztLv6Ocefq9sUZAWGOhUgPVya3uXtpkw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>

Hi, Ulf.

On 03/14/2014 04:53 PM, Ulf Hansson wrote:
> On 14 March 2014 08:24, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Add the "vqmmc" regulator into dw_mmc.c
>>
>> This patch depend on below patches. ([PATCH v4 1/7] mmc: dw_mmc: use the mmc_of_parse() instead of local parser ~)
>>
>> https://patchwork.kernel.org/patch/3750681/
>> https://patchwork.kernel.org/patch/3750691/
>> https://patchwork.kernel.org/patch/3750711/
>> https://patchwork.kernel.org/patch/3750701/
>> https://patchwork.kernel.org/patch/3750721/
>> https://patchwork.kernel.org/patch/3750731/
>> https://patchwork.kernel.org/patch/3750741/
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> ---
>>  drivers/mmc/host/dw_mmc.c  |   34 ++++++++++++++++++++++++++++++++++
>>  include/linux/mmc/dw_mmc.h |    1 +
>>  2 files changed, 35 insertions(+)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 5e78748..9a33a6d 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -2393,6 +2393,24 @@ int dw_mci_probe(struct dw_mci *host)
>>                 }
>>         }
>>
>> +       host->vqmmc = devm_regulator_get_optional(host->dev, "vqmmc");
> 
> I recommend you to convert to use mmc_regulator_get_supply() API instead.
> 
>> +       if (IS_ERR(host->vqmmc)) {
>> +               ret = PTR_ERR(host->vqmmc);
>> +               if (ret == -EPROBE_DEFER)
>> +                       goto err_vqmmc;
>> +
>> +               dev_info(host->dev, "no vqmmc regulator found: %d\n", ret);
>> +               host->vqmmc = NULL;
>> +       } else {
>> +               ret = regulator_enable(host->vqmmc);
>> +               if (ret) {
>> +                       if (ret != -EPROBE_DEFER)
>> +                               dev_err(host->dev,
>> +                                       "regulator_enable fail: %d\n", ret);
>> +                       goto err_vqmmc;
>> +               }
>> +       }
>> +
> 
> Are there any specific reasons to why you don't want use the .set_ios
> callback to control this regulator?
There is no reason that don't use it. I will resend the patch after changing.
(We can use the mmc regulator framework.)

> 
> Is seems wrong to do it from the probe(). I also realize that the same
> applies for the already existing vmmc regulator.
You're right. Thanks for point out.

This patch cab be discarded.

Best Regards,
Jaehoon Chung
> 
>>         host->quirks = host->pdata->quirks;
>>
>>         spin_lock_init(&host->lock);
>> @@ -2536,6 +2554,9 @@ err_workqueue:
>>  err_dmaunmap:
>>         if (host->use_dma && host->dma_ops->exit)
>>                 host->dma_ops->exit(host);
>> +       if (host->vqmmc)
>> +               regulator_disable(host->vqmmc);
>> +err_vqmmc:
>>         if (host->vmmc)
>>                 regulator_disable(host->vmmc);
>>
>> @@ -2575,6 +2596,8 @@ void dw_mci_remove(struct dw_mci *host)
>>
>>         if (host->vmmc)
>>                 regulator_disable(host->vmmc);
>> +       if (host->vqmmc)
>> +               regulator_disable(host->vqmmc);
>>
>>         if (!IS_ERR(host->ciu_clk))
>>                 clk_disable_unprepare(host->ciu_clk);
>> @@ -2594,6 +2617,8 @@ int dw_mci_suspend(struct dw_mci *host)
>>  {
>>         if (host->vmmc)
>>                 regulator_disable(host->vmmc);
>> +       if (host->vqmmc)
>> +               regulator_disable(host->vqmmc);
>>
>>         return 0;
>>  }
>> @@ -2612,6 +2637,15 @@ int dw_mci_resume(struct dw_mci *host)
>>                 }
>>         }
>>
>> +       if (host->vqmmc) {
>> +               ret = regulator_enable(host->vqmmc);
>> +               if (ret) {
>> +                       dev_err(host->dev,
>> +                               "failed to enable regulator: %d\n", ret);
>> +                       return ret;
>> +               }
>> +       }
>> +
>>         if (!dw_mci_ctrl_all_reset(host)) {
>>                 ret = -ENODEV;
>>                 return ret;
>> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
>> index babaea9..8912d92 100644
>> --- a/include/linux/mmc/dw_mmc.h
>> +++ b/include/linux/mmc/dw_mmc.h
>> @@ -189,6 +189,7 @@ struct dw_mci {
>>         u32                     quirks;
>>
>>         struct regulator        *vmmc;  /* Power regulator */
>> +       struct regulator        *vqmmc; /* Signalling regulator */
>>         unsigned long           irq_flags; /* IRQ flags */
>>         int                     irq;
>>  };
>> --
>> 1.7.9.5
> 
> Kind regards
> Ulf Hansson
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

