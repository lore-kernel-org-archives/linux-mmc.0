From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2] mmc: sdhci-xenon: add set_power callback
Date: Tue, 29 Aug 2017 11:56:18 +0800
Message-ID: <1cfdff8b-6332-0893-f6bc-a556815dfd15@rock-chips.com>
References: <1503338529-21102-1-git-send-email-zjwu@marvell.com>
 <e37d8951-7e1b-8431-5593-5e693295987f@intel.com>
 <87val76624.fsf@free-electrons.com> <59A464BA.6030401@marvell.com>
 <043c4643-bbd1-6aaa-687b-5208f7c6b395@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:51473 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751209AbdH2D4Y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Aug 2017 23:56:24 -0400
In-Reply-To: <043c4643-bbd1-6aaa-687b-5208f7c6b395@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhoujie Wu <zjwu@marvell.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, ulf.hansson@linaro.org, shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org, zmxu@marvell.com, jszhang@marvell.com, nadavh@marvell.com, xigu@marvell.com, dingwei@marvell.com, kostap@marvell.com, hannah@marvell.com, hongd@marvell.com, dougj@marvell.com, ygao@marvell.com, liuw@marvell.com, thomas.petazzoni@free-electrons.com


On 2017/8/29 11:29, Shawn Lin wrote:
> On 2017/8/29 2:45, Zhoujie Wu wrote:
>> Hi Gregory,
>>
>> On 08/28/2017 08:54 AM, Gregory CLEMENT wrote:
>>> Hi,
>>>   On lun., août 28 2017, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>
>>>> On 21/08/17 21:02, Zhoujie Wu wrote:
>>>>> Xenon sdh controller requests proper SD bus voltage select
>>>>> bits programmed even with vmmc power supply. Any reserved
>>>>> value(100b-000b) programmed in this field will lead to controller
>>>>> ignore SD bus power bit and keep its value at zero.
>>>>> Add set_power callback to handle this.
>>>>>
>>>>> Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
>>>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>>> I tested this patch on the Armada 3720 DB board. And thanks to this 
>>> patch
>>> and by adding a vmmc regulator in the device tree I did not have anymore
>>> the issue UHS card not detected on warm reset.
>>>
>>> Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>>>
>>> Actually for me this should be a fix. Indeed if I try to use a vmmc
>>> regulator without this patch then the SD card does not work at all I
>>> only have the following messages:
>>>
>>> "mmc1: Timeout waiting for hardware cmd interrupt."
>> This patch with sd vmmc power supply(must be claimed as AON, or card 
>> detection can't work)enabled can solve the issue for warm reset. This 
>> patch is must for xenon controller once vmmc power supply enabled, 
>> since the HW will ignore any reserved value for sd bus voltage select 
>> field and ignore the pwr_en in this case.
>> But recently we met another issue after resume, it is similar as warm 
>> reset. When resume back, SD card(UHS) is re-initialized and it is 
>> recognized as HS again. It needs power-cycle before initialization to 
>> solve the resume issue. But vmmc is claimed as AON, it won't be shut 
> 
> This is a expected behaviour from the spec's POV. So you need a high
> level solution to solve it for all hosts. I just quickly cook a patch[1]
> for test, maybe it doesn't work at all but I guess it helps.:)
> 
> [1]: https://patchwork.kernel.org/patch/9926715/

Hmm.. sorry. update v2 for setting voltage to 1v8 for that case.

https://patchwork.kernel.org/patch/9926723/

> 
>> down in standby, so vmmc and this patch won't solve resume issue. I 
>> have no better idea to solve both warm reset and resume issue, I added 
>> a dedicated pwrseq for a3700 sd card, it will do power cycle during 
>> pre and post pwrseq, but keep power when power off the card.
>> Do you have any other better suggestion?
>>>
>>> Thanks,
>>>
>>> Gregory
>>>
>>>
>>>>> ---
>>>>> Updated according to Jisheng Zhang's comment.
>>>>>   drivers/mmc/host/sdhci-xenon.c | 19 +++++++++++++++++++
>>>>>   1 file changed, 19 insertions(+)
>>>>>
>>>>> diff --git a/drivers/mmc/host/sdhci-xenon.c 
>>>>> b/drivers/mmc/host/sdhci-xenon.c
>>>>> index edd4d915..a4be2fd 100644
>>>>> --- a/drivers/mmc/host/sdhci-xenon.c
>>>>> +++ b/drivers/mmc/host/sdhci-xenon.c
>>>>> @@ -210,8 +210,27 @@ static void xenon_set_uhs_signaling(struct 
>>>>> sdhci_host *host,
>>>>>       sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
>>>>>   }
>>>>> +static void xenon_set_power(struct sdhci_host *host, unsigned char 
>>>>> mode,
>>>>> +        unsigned short vdd)
>>>>> +{
>>>>> +    struct mmc_host *mmc = host->mmc;
>>>>> +    u8 pwr = host->pwr;
>>>>> +
>>>>> +    sdhci_set_power_noreg(host, mode, vdd);
>>>>> +
>>>>> +    if (host->pwr == pwr)
>>>>> +        return;
>>>>> +
>>>>> +    if (host->pwr == 0)
>>>>> +        vdd = 0;
>>>>> +
>>>>> +    if (!IS_ERR(mmc->supply.vmmc))
>>>>> +        mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
>>>>> +}
>>>>> +
>>>>>   static const struct sdhci_ops sdhci_xenon_ops = {
>>>>>       .set_clock        = sdhci_set_clock,
>>>>> +    .set_power        = xenon_set_power,
>>>>>       .set_bus_width        = sdhci_set_bus_width,
>>>>>       .reset            = xenon_reset,
>>>>>       .set_uhs_signaling    = xenon_set_uhs_signaling,
>>>>>
>>
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
> 
> 
> 

