From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 2/2] mmc: sdhci-of-aspeed: add inversion signal
 presence
Date: Fri, 15 Nov 2019 15:17:14 +0200
Message-ID: <5bd753c3-102b-d78c-c390-4f88ebb0e229@intel.com>
References: <20191114125435.27756-1-i.mikhaylov@yadro.com>
 <20191114125435.27756-3-i.mikhaylov@yadro.com>
 <fcb5f8b5-40b9-6497-b24d-0b73e2525949@intel.com>
 <b443738f5e2a3c7ba96b329a8347374f7f934483.camel@yadro.com>
 <d177ef37-643e-442d-d536-750e0bb5e86d@intel.com>
 <221381ebad0236625775bda5655fcd7c78455e6f.camel@yadro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <221381ebad0236625775bda5655fcd7c78455e6f.camel@yadro.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc: Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 15/11/19 2:56 PM, Ivan Mikhaylov wrote:
> On Fri, 2019-11-15 at 09:20 +0200, Adrian Hunter wrote:
>> On 14/11/19 7:19 PM, Ivan Mikhaylov wrote:
>>> On Thu, 2019-11-14 at 15:10 +0200, Adrian Hunter wrote:
>>> On 14/11/19 2:54 PM, Ivan Mikhaylov wrote:
>>>>> Change the default .get_cd callback. Add inverted signal card detection
>>>>> check.
>>>>>
>>>>> Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
>>>>>
>>>>> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c
>>>>> b/drivers/mmc/host/sdhci-of-
>>>>> aspeed.c
>>>>> index 8962f6664381..186559ee8fcc 100644
>>>>> --- a/drivers/mmc/host/sdhci-of-aspeed.c
>>>>> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
>>>>> @@ -143,6 +143,19 @@ static inline int
>>>>> aspeed_sdhci_calculate_slot(struct
>>>>> aspeed_sdhci *dev,
>>>>>  	return (delta / 0x100) - 1;
>>>>>  }
>>>>>  
>>>>> +static int aspeed_get_cd(struct mmc_host *mmc)
>>>>> +{
>>>>> +	struct sdhci_host *host = mmc_priv(mmc);
>>>>> +
>>>>> +	int present = !!(sdhci_readl(host, SDHCI_PRESENT_STATE)
>>>>> +			 & SDHCI_CARD_PRESENT);
>>>>> +
>>>>> +	if (mmc->caps2 & MMC_CAP2_CD_ACTIVE_HIGH)
>>>>> +		present = !present;
>>>>
>>>> Perhaps safer to flip the bit using CONFIG_MMC_SDHCI_IO_ACCESSORS and
>>>> ->readl() callback
>>
>>
>>> Sorry, don't quite understand what you're saying. You want to instantiate
>>> '.read_l' callback instead of '.get_cd' in sdhci_ops and substitute the real
>>> value?
>>>
>>> res = readl(base, reg);
>>> if (reg == SDHCI_PRESENT_STATE)
>>> 	if (mmc->caps2 & MMC_CAP2_CD_ACTIVE_HIGH)
>>> 		return !res;
>>
>> Presumably just flip the SDHCI_CARD_PRESENT bit i.e.
>>
>> 		return res ^ SDHCI_CARD_PRESENT;
>>
>>> return res;
>>>
>>> Something like this?
>>
>> Yes
>>
> 
> Don't you think it will bring a little overhead on any sdhci_readl plus

Register accesses are usually slow (~1us) compared with logic.  Of course,
I/O requests are even slower >100ms so it is unlikely that the overhead is
significant.

> sdhci_readl will not get the real value in case of inverted signal which seems
> is not right from communication fairness between hw and sw? I took that approach

One of the purposes of the accessors is to smooth over the difference
between the SDHCI standard and actual hardware.  Given that
SDHCI_PRESENT_STATE is also used in sdhci_set_card_detection() and
sdhci_irq(), it is surprising that changing only ->get_cd() works correctly.

> with .get_cd from variety of drivers in host/mmc but if you think it will be
> better and safer with .read_l - I'll do that way. 
> 
> Sorry for the link in subject, didn't notice that I put it in previous message
> somehow.
> 
> Thanks.
> 
> 
