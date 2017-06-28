From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [RFC PATCH 0/2] mmc: sdhci: Add
 SDHCI_QUIRK2_BROKEN_SDMA_BOUNDARY_BUFFER
Date: Wed, 28 Jun 2017 19:16:16 +0100
Message-ID: <799ab3c1-ef36-0137-0064-63823c1598d3@linaro.org>
References: <20170628133504.17422-1-srinivas.kandagatla@linaro.org>
 <552ef0ba-91d5-ab9c-d55c-ac008608a689@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <552ef0ba-91d5-ab9c-d55c-ac008608a689@codeaurora.org>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org



On 28/06/17 18:21, Ritesh Harjani wrote:
> Hi Srinivas,
> 
> On 6/28/2017 7:05 PM, srinivas.kandagatla@linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> This patchset adds quirk to support cards which have issues when sdma
>> boundary buffer bits are programmed in Block Size Register (0x04)
>> when using ADMA.
> 
> Thanks for pointing out the reason of failure without this patch.
> Earlier I could not find the reason.
> 
> Previous discussion link :-
> https://patchwork.kernel.org/patch/9200579/

I did see this patch, only issue I had is making it default.

> 
> 
>>
>> First patch adds quirk and second one uses that quirk in msm sdhci 
>> driver.
> 
> Not sure if quirk will be the right way to go about this, or whether we 
> should make this functionality default since ADMA does not
> uses this (as per spec) ?
> Since other systems should not break (as Adrian was mentioning in the 
> discussion link above).
> 
That was the only reason to add this as quirk, so that other drivers 
would work as it previously.

Also, this seems to be a issue with only qcom controller, so quirk makes 
more sense for me.

> Adrian/Ulf will know better on this.
> 

--srini
>>
>> Tested on DB410c with WLAN SDIO card.
>>
>> thanks,
>> srini
>>
>> Srinivas Kandagatla (2):
>>    mmc: sdhci: add quirk SDHCI_QUIRK2_BROKEN_SDMA_BOUNDARY_BUFFER
>>    mmc: sdhci-msm: enable SDHCI_QUIRK2_BROKEN_SDMA_BOUNDARY_BUFFER
>>
>>   drivers/mmc/host/sdhci-msm.c |  3 ++-
>>   drivers/mmc/host/sdhci.c     | 24 ++++++++++++++++++------
>>   drivers/mmc/host/sdhci.h     |  2 ++
>>   3 files changed, 22 insertions(+), 7 deletions(-)
>>
> 
