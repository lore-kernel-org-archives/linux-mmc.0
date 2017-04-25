From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/2] mmc: arasan: adapt to runtime pm
Date: Tue, 25 Apr 2017 13:52:36 +0300
Message-ID: <c3f89850-ae62-bed2-4750-159f4d4126b7@intel.com>
References: <1492667088-20866-1-git-send-email-shubhrajyoti.datta@xilinx.com>
 <77e3c31a-69df-a71e-47d8-da0e3924c4aa@intel.com>
 <CAKfKVtHUB2Q6hVzf_byepPbdQdQJRep5D7cWTR2-q0cN_SP8ig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:63135 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164978AbdDYK6V (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 25 Apr 2017 06:58:21 -0400
In-Reply-To: <CAKfKVtHUB2Q6hVzf_byepPbdQdQJRep5D7cWTR2-q0cN_SP8ig@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, Michal Simek <michal.simek@xilinx.com>

On 25/04/17 13:50, Shubhrajyoti Datta wrote:
> Hi Adrian,
> 
> Thanks for the review.
> 
> On Tue, Apr 25, 2017 at 3:47 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 20/04/17 08:44, Shubhrajyoti Datta wrote:
>>> Currently the clock are enabled at probe and released at driver
>>> removal. This moves to enable before mmc read/ write and disables
>>> after it.
>>>
>>> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
>>> ---
>>>  drivers/mmc/host/sdhci-of-arasan.c | 50 ++++++++++++++++++++++++++++++++++++--
>>>  1 file changed, 48 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
>>> index 1cfd7f9..812e75a 100644
>>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>>> @@ -24,6 +24,7 @@
>>>  #include <linux/module.h>
>>>  #include <linux/of_device.h>
>>>  #include <linux/phy/phy.h>
>>> +#include <linux/pm_runtime.h>
>>>  #include <linux/regmap.h>
>>>  #include "sdhci-pltfm.h"
>>>  #include <linux/of.h>
>>> @@ -373,10 +374,44 @@ static int sdhci_arasan_resume(struct device *dev)
>>>
>>>       return sdhci_resume_host(host);
>>>  }
>>> +
>>
>> Runtime PM is under CONFIG_PM not CONFIG_PM_SLEEP
> 
> Will fix.
> 
>>
>>> +static int sdhci_arasan_runtime_suspend(struct device *dev)
>>> +{
>>> +     struct platform_device *pdev = to_platform_device(dev);
>>> +     struct sdhci_host *host = platform_get_drvdata(pdev);
>>> +     struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>> +     struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
>>> +     int ret;
>>> +
>>> +     ret = sdhci_runtime_suspend_host(host);
>>
>> Other drivers now have:
> Can you point me to an example.
> 
>>
>>         if (host->tuning_mode != SDHCI_TUNING_MODE_3)
>>                 mmc_retune_needed(host->mmc);
>>
>> If you don't need re-tuning, maybe add a comment so we know.
> 
> I  didnt  I  understood this one.
> I am calling sdhci_runtime_suspend_host  which has.
> 
> 2907
> 2908 int sdhci_runtime_suspend_host(struct sdhci_host *host)
> 2909 {
> 2910         unsigned long flags;
> 2911
> 2912         mmc_retune_timer_stop(host->mmc);
> 2913         if (host->tuning_mode != SDHCI_TUNING_MODE_3)
> 2914                 mmc_retune_needed(host->mmc);
> 
> 
> Am I missing something

It has changed recently, so you need to look at the 'next' branch of Ulf's
mmc tree:

	git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git

>>
>>> +
>>> +     clk_disable_unprepare(pltfm_host->clk);
>>> +     clk_disable_unprepare(sdhci_arasan->clk_ahb);
>>> +
>>> +     return ret;
> 

