From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [RFC 4/4] mmc: sdhci-msm: Handle unexpected interrupt case on
 enabling legacy IRQs on CQE halt
Date: Sat, 2 Sep 2017 10:43:40 +0530
Message-ID: <9dce21e1-4693-6d44-8613-66d08e2136fa@codeaurora.org>
References: <1504098251-27739-1-git-send-email-riteshh@codeaurora.org>
 <1504098251-27739-5-git-send-email-riteshh@codeaurora.org>
 <3f31712a-56bf-24c1-7823-f33d7c7f665a@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3f31712a-56bf-24c1-7823-f33d7c7f665a@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, stummala@codeaurora.org, asutoshd@codeaurora.org
List-Id: linux-mmc@vger.kernel.org


On 8/31/2017 1:05 PM, Adrian Hunter wrote:
> On 30/08/17 16:04, Ritesh Harjani wrote:
>> There is a case when enabling the legacy IRQs and halting CQE is
>> resuling into a command response interrupt without any command in
>> progress. This patch handles such case here.
>>
>> Error signature without this patch:-
>> mmc0: Got command interrupt 0x00000001 even though no command operation
>> was in progress.
>>
>> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
> 
> Seems fine, but this is a necessary part of enabling i.e. put all the
> sdhci-msm changes into one patch.

Yes, sure.

> 
>> ---
>>   drivers/mmc/host/sdhci-msm.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>> index baa3409..8fdc2c0 100644
>> --- a/drivers/mmc/host/sdhci-msm.c
>> +++ b/drivers/mmc/host/sdhci-msm.c
>> @@ -1124,10 +1124,21 @@ void sdhci_msm_cqe_enable(struct mmc_host *mmc)
>>   void sdhci_msm_cqe_disable(struct mmc_host *mmc, bool recovery)
>>   {
>>   	struct sdhci_host *host = mmc_priv(mmc);
>> +	unsigned long flags;
>> +	u32 ctrl;
>>   
>>   	if (host->flags & SDHCI_USE_64_BIT_DMA)
>>   		host->desc_sz = 16;
>>   
>> +	spin_lock_irqsave(&host->lock, flags);
>> +
> 
> Could use a comment here.

Ok. Thanks.

> 
>> +	ctrl = sdhci_readl(host, SDHCI_INT_ENABLE);
>> +	ctrl |= SDHCI_INT_RESPONSE;
>> +	sdhci_writel(host,  ctrl, SDHCI_INT_ENABLE);
>> +	sdhci_writel(host, SDHCI_INT_RESPONSE, SDHCI_INT_STATUS);
>> +
>> +	spin_unlock_irqrestore(&host->lock, flags);
>> +
>>   	sdhci_cqe_disable(mmc, recovery);
>>   }
>>   
>>
> 

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, 
Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project.
