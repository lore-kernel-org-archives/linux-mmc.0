From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [RFC 1/4] mmc: cqhci: Move CQHCI_ENABLE before setting
 TDLBA/TDLBAU
Date: Sat, 2 Sep 2017 10:39:16 +0530
Message-ID: <3e4520c3-dcf5-fadf-6a58-94964055a4f3@codeaurora.org>
References: <1504098251-27739-1-git-send-email-riteshh@codeaurora.org>
 <1504098251-27739-2-git-send-email-riteshh@codeaurora.org>
 <82b52d84-6eb1-9f97-5e0a-bea6d25ddbda@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <82b52d84-6eb1-9f97-5e0a-bea6d25ddbda@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, stummala@codeaurora.org, asutoshd@codeaurora.org
List-Id: linux-mmc@vger.kernel.org



On 8/31/2017 11:31 AM, Adrian Hunter wrote:
> On 30/08/17 16:04, Ritesh Harjani wrote:
>> Without this patch the CQHCI registers are getting reset
>> again.
>>
>> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
>> ---
>>   drivers/mmc/host/cqhci.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
>> index 8650a13..2a7351c 100644
>> --- a/drivers/mmc/host/cqhci.c
>> +++ b/drivers/mmc/host/cqhci.c
>> @@ -262,6 +262,9 @@ static void __cqhci_enable(struct cqhci_host *cq_host)
>>   
>>   	cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
>>   
>> +	cqcfg |= CQHCI_ENABLE;
>> +	cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
> That doesn't follow the flow in the specification B.6.1. Command Queuing
> Initialization Sequence.  Also in B.3.5 Task List, the spec. says "Changing
> the value of TDLBA is not allowed when command queue mode is enabled."
> 
> So you will need to add a quirk for this.

Sure. thanks.

> 
>> +
>>   	cqhci_writel(cq_host, lower_32_bits(cq_host->desc_dma_base),
>>   		     CQHCI_TDLBA);
>>   	cqhci_writel(cq_host, upper_32_bits(cq_host->desc_dma_base),
>> @@ -271,10 +274,6 @@ static void __cqhci_enable(struct cqhci_host *cq_host)
>>   
>>   	cqhci_set_irqs(cq_host, 0);
>>   
>> -	cqcfg |= CQHCI_ENABLE;
>> -
>> -	cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
>> -
>>   	mmc->cqe_on = true;
>>   
>>   	if (cq_host->ops->enable)
>>
> 

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, 
Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project.
