From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci-msm: Add sdhci_reset() implementation
Date: Thu, 1 Dec 2016 20:08:32 +0200
Message-ID: <7f35faac-7c04-8024-3111-9d4742ad2154@linaro.org>
References: <20161128173920.25334-1-georgi.djakov@linaro.org>
 <27e95224-ff32-954d-443a-2310c1225ca0@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35410 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752008AbcLASIj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Dec 2016 13:08:39 -0500
Received: by mail-wm0-f52.google.com with SMTP id a197so306981837wmd.0
        for <linux-mmc@vger.kernel.org>; Thu, 01 Dec 2016 10:08:38 -0800 (PST)
In-Reply-To: <27e95224-ff32-954d-443a-2310c1225ca0@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org

On 11/29/2016 05:40 AM, Ritesh Harjani wrote:
> Hi Georgi,
>
> On 11/28/2016 11:09 PM, Georgi Djakov wrote:
>> On apq8016, apq8084 and apq8074 platforms, writing to the software
>> reset register triggers the "power irq". We need to ack and handle
>> the irq, otherwise the following message appears:
>>
>> mmc0: Reset 0x1 never completed.
>> sdhci: =========== REGISTER DUMP (mmc0)===========
>> sdhci: Sys addr: 0x00000000 | Version:  0x00002e02
>> sdhci: Blk size: 0x00004000 | Blk cnt:  0x00000000
>> sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
>> sdhci: Present:  0x01f80000 | Host ctl: 0x00000000
>> sdhci: Power:    0x00000000 | Blk gap:  0x00000000
>> sdhci: Wake-up:  0x00000000 | Clock:    0x00000003
>> sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
>> sdhci: Int enab: 0x00000000 | Sig enab: 0x00000000
>> sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
>> sdhci: Caps:     0x322dc8b2 | Caps_1:   0x00008007
>> sdhci: Cmd:      0x00000000 | Max curr: 0x00000000
>> sdhci: Host ctl2: 0x00000000
>> sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x0000000000000000
>> sdhci: ===========================================
>>
>> Fix it by implementing the custom sdhci_reset() function,
>> which performs the software reset and then handles the irq.
>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>
>> Changes since v1: (https://lkml.org/lkml/2016/11/22/411)
>>  * Perform the software reset by just writing to the SDHCI_SOFTWARE_RESET
>>    register and then check for the irq.
> I am still not sure about this change. Below change will trigger the
> IRQ, once this call is completed (say on a single core system) -since
> this is called while holding spin_lock_irqsave.
>
> But you will be end up calling sdhci_msm_voltage_switch twice,
> which to me does not seems correct.
> 1. 1st time you are directly calling it in sdhci_msm_reset.
> 2. 2nd time will be called from within pwr_irq to handle the same case.

Yes, that would be the behavior. This function actually is not doing
anything much than to check irq status and ack it. Testing the patch
on a few different platforms does not show any side effects, however i
could not be 100% sure as i have limited information about the hardware.

Thanks,
Georgi

>
> Please let me know your thoughts on this ?
>
> Regards
> Ritesh
>
>>
>>  drivers/mmc/host/sdhci-msm.c | 29 ++++++++++++++++++++++++++++-
>>  1 file changed, 28 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>> index 32879b845b75..157ae07f9309 100644
>> --- a/drivers/mmc/host/sdhci-msm.c
>> +++ b/drivers/mmc/host/sdhci-msm.c
>> @@ -1019,6 +1019,33 @@ static void sdhci_msm_set_clock(struct
>> sdhci_host *host, unsigned int clock)
>>      __sdhci_msm_set_clock(host, clock);
>>  }
>>
>> +void sdhci_msm_reset(struct sdhci_host *host, u8 mask)
>> +{
>> +    unsigned long timeout = 100;
>> +
>> +    sdhci_writeb(host, mask, SDHCI_SOFTWARE_RESET);
>> +
>> +    if (mask & SDHCI_RESET_ALL) {
>> +        host->clock = 0;
>> +
>> +        /*
>> +         * SDHCI_RESET_ALL triggers the PWR IRQ and we need
>> +         * to handle it here.
>> +         */
>> +        sdhci_msm_voltage_switch(host);
>> +    }
>> +
>> +    while (sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask) {
>> +        if (timeout == 0) {
>> +            pr_err("%s: Reset 0x%x never completed.\n",
>> +                   mmc_hostname(host->mmc), (int)mask);
>> +            return;
>> +        }
>> +        timeout--;
>> +        mdelay(1);
>> +    }
>> +}
>> +
>>  static const struct of_device_id sdhci_msm_dt_match[] = {
>>      { .compatible = "qcom,sdhci-msm-v4" },
>>      {},
>> @@ -1028,7 +1055,7 @@ MODULE_DEVICE_TABLE(of, sdhci_msm_dt_match);
>>
>>  static const struct sdhci_ops sdhci_msm_ops = {
>>      .platform_execute_tuning = sdhci_msm_execute_tuning,
>> -    .reset = sdhci_reset,
>> +    .reset = sdhci_msm_reset,
>>      .set_clock = sdhci_msm_set_clock,
>>      .get_min_clock = sdhci_msm_get_min_clock,
>>      .get_max_clock = sdhci_msm_get_max_clock,
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
