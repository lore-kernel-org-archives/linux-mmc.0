From: Zhoujie Wu <zjwu@marvell.com>
Subject: Re: [EXT] Re: [PATCH v3] mmc: sdhci: wait 5ms after set 1.8V signal
 enable
Date: Mon, 18 Dec 2017 14:26:53 -0800
Message-ID: <5A3840AD.4060501@marvell.com>
References: <1513366136-20302-1-git-send-email-zjwu@marvell.com>
 <472f0d18-e529-2477-4809-079a5970a362@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:50716 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S936790AbdLRW1I (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Dec 2017 17:27:08 -0500
In-Reply-To: <472f0d18-e529-2477-4809-079a5970a362@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: nadavh@marvell.com, xigu@marvell.com, xswang@marvell.com, dingwei@marvell.com, kostap@marvell.com, hannah@marvell.com, hongd@marvell.com, dougj@marvell.com, ygao@marvell.com, liuw@marvell.com, gregory.clement@free-electrons.com, thomas.petazzoni@free-electrons.com



On 12/18/2017 05:19 AM, Adrian Hunter wrote:
> External Email
>
> ----------------------------------------------------------------------
> On 15/12/17 21:28, Zhoujie Wu wrote:
>> According to SD spec 3.00 3.6.1 signal voltage switch
>> procedure step 6~8,
>> (6) Set 1.8V Signal Enable in the Host Control 2 register.
>> (7) Wait 5ms. 1.8V voltage regulator shall be stable within this period.
>> (8) If 1.8V Signal Enable is cleared by Host Controller, go to step (12).
>>
>> Host should wait 5ms after set 1.8V signal enable bit in
>> Host Control 2 register and check if 1.8V is stable or not.
>>
>> But current code checks if this bit is cleared by controller
>> right after set it. On some platforms found the bit is not
>> cleared right away and host reports "1.8V regulator output
>> did not became stable" and 5ms delay can help.
> The check is for the bit set not cleared.
I will correct the comments.
>> Follow the spec and add 5ms delay to make sure the 1.8V Signal Enable
>> bit is cleared.
>>
>> Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
>> ---
>>   drivers/mmc/host/sdhci.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index e9290a3..fe5f208 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1933,6 +1933,9 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>>   		if (host->ops->voltage_switch)
>>   			host->ops->voltage_switch(host);
>>   
>> +		/* Wait for 5ms */
>> +		usleep_range(5000, 5500);
> We have managed without this delay for a while and I am reluctant to add
> delays that might anyway be specific to the controller.  What do you think
> about implementing ->voltage_switch() and putting the delay there?
Ok to me, will send out the updated version. Thanks.
>
>> +
>>   		/* 1.8V regulator output should be stable within 5 ms */
>>   		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>   		if (ctrl & SDHCI_CTRL_VDD_180)
>>

