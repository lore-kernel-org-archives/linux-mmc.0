From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v1 5/5] mmc: Kconfig: Enable CONFIG_MMC_SDHCI_IO_ACCESSORS
Date: Tue, 19 Sep 2017 08:44:26 +0300
Message-ID: <33605097-6881-50a3-4526-a2ac6448a60d@intel.com>
References: <1504097509-58983-1-git-send-email-vviswana@codeaurora.org>
 <1504097509-58983-6-git-send-email-vviswana@codeaurora.org>
 <f10addc2-5d67-3d0e-fb61-50d42f96125e@intel.com>
 <b2ea12b5-f502-097f-c9cf-aa9e7e6e18be@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <b2ea12b5-f502-097f-c9cf-aa9e7e6e18be@codeaurora.org>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: Vijay Viswanath <vviswana@codeaurora.org>, ulf.hansson@linaro.org, will.deacon@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, asutoshd@codeaurora.org, stummala@codeaurora.org, riteshh@codeaurora.org, subhashj@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

On 19/09/17 07:03, Vijay Viswanath wrote:
> 
> 
> On 9/14/2017 12:04 PM, Adrian Hunter wrote:
>> On 30/08/17 15:51, Vijay Viswanath wrote:
>>> Enable CONFIG_MMC_SDHCI_IO_ACCESSORS so that SDHC controller specific
>>> register read and write APIs, if registered, can be used.
>>
>> Missing signed-off
>>
>> Why don't you put this patch earlier in the patch set and then you don't
>> need all the ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS ?
>>
> 
> This will involve merging the current patches 3 & 4 into one (Some functions
> defined under ifdef in patch 3 are used only in patch 4). Will that be fine ?

Sure

> 
>>> ---
>>>   drivers/mmc/host/Kconfig | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>>> index 2db84dd..64a9298 100644
>>> --- a/drivers/mmc/host/Kconfig
>>> +++ b/drivers/mmc/host/Kconfig
>>> @@ -420,6 +420,7 @@ config MMC_SDHCI_MSM
>>>       tristate "Qualcomm SDHCI Controller Support"
>>>       depends on ARCH_QCOM || (ARM && COMPILE_TEST)
>>>       depends on MMC_SDHCI_PLTFM
>>> +    select CONFIG_MMC_SDHCI_IO_ACCESSORS
>>
>> CONFIG_MMC_SDHCI_IO_ACCESSORS -> MMC_SDHCI_IO_ACCESSORS
>>
>>>       help
>>>         This selects the Secure Digital Host Controller Interface (SDHCI)
>>>         support present in Qualcomm SOCs. The controller supports
>>>
>>
> 
