From: Zhoujie Wu <zjwu@marvell.com>
Subject: Re: [PATCH] mmc: sdhci: ignore 3.3v voltage switch if ios.vdd is
 0
Date: Wed, 2 Aug 2017 15:33:06 -0700
Message-ID: <59825322.3030805@marvell.com>
References: <1501631901-1304-1-git-send-email-zjwu@marvell.com>
 <877eymbeuf.fsf@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:39558 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751062AbdHBWdL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Aug 2017 18:33:11 -0400
In-Reply-To: <877eymbeuf.fsf@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>, ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org, zmxu@marvell.com, jszhang@marvell.com, nadavh@marvell.com, xigu@marvell.com, dingwei@marvell.com, kostap@marvell.com, hannah@marvell.com, hongd@marvell.com, dougj@marvell.com, ygao@marvell.com, liuw@marvell.com, thomas.petazzoni@free-electrons.com

Hi Gregory,
Thanks for your response.

On 08/02/2017 12:36 AM, Gregory CLEMENT wrote:
> Hi Zhoujie, Adrian and Ulf,
>   
>   On mar., août 01 2017, Zhoujie Wu <zjwu@marvell.com> wrote:
>
>> One issue was found on a removable high speed sd card with
>> runtime pm enabled.
>> When SD card is unplugged, it keep printing "Switching to 3.3V
>> signalling voltage failed".
>> And found below sequence triggers the error.
>>
>> mmc_rescan
>> 	-> mmc_sd_detect
>> 		-> mmc_power_off  -- mmc->ios.vdd is update to 0.
>> 	-> mmc_claim_host
>> 		-> sdhci_runtime_resume_host
>> 			-> sdhci_start_signal_voltage_switch
>> 				-> mmc_regulator_set_vqmmc
>> 					-> mmc_ocrbitnum_to_vdd
>>
>> When mmc_ocrbitnum_to_vdd is called, the mmc->ios.vdd is 0, so it
>> always return -EINVAL. The signal switch will always fail and
>> print out warning.
>>
>> Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
>> ---
>> Hi Ulf,
>> 	Not sure if this is the best way to fix it. Please help to
>> suggest. Thanks.
> I don't know if there is a link, but I observed that when the kernel
> boot with an UHS SD Card plugged (and after a warm reset) then the bus
> speed is only "High Speed". Whereas if I plugged it while the kernel is
> running the "Ultra " speed is detected.
>
> I observed that with the sdhci-xenon driver, but I don't have any other
> UHS capable controller available to compare it and to know if it is
> something at sdhci level or at xenon level.

I observed the same behavior as you. I added some logs and I found the 
difference comes from when init card mmc_sd_get_cid got different ocr 
response from SD card.

When boot up board with sd card plugged, SD card ocr response didn't set 
S18A bit(bit24 of rocr), so driver won't switch to uhs mode.

[    4.162597] ocr = 41200000

[    4.236465] rocr = c0ff8000

If I unplugged the card and plugged it again, this time SD ocr response 
set S18A bit(bit24 of rocr), then driver will switch to uhs mode after that.

[   33.817272] ocr = 41200000

[   33.920454] rocr = c1ff8000

Currently I have no idea why SD card response different in these two 
cases. I will check more details later.

>
> Thanks,
>
> Gregory
>
>>   drivers/mmc/host/sdhci.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index ecd0d43..011ebbe 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1878,7 +1878,7 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>>   		ctrl &= ~SDHCI_CTRL_VDD_180;
>>   		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
>>   
>> -		if (!IS_ERR(mmc->supply.vqmmc)) {
>> +		if ((!IS_ERR(mmc->supply.vqmmc)) && mmc->ios.vdd) {
>>   			ret = mmc_regulator_set_vqmmc(mmc, ios);
>>   			if (ret) {
>>   				pr_warn("%s: Switching to 3.3V signalling voltage failed\n",
>> -- 
>> 1.9.1
>>

