From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v3 2/3] mmc: sdhci-of-arasan: add phy support for
 sdhci-of-arasan
Date: Wed, 21 Oct 2015 14:34:06 +0800
Message-ID: <562731DE.90303@rock-chips.com>
References: <1445324718-31407-1-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKFpFM5K1cyd-WbD2mOmz-=tTVfE9x+ZHYGsnfNvxxodViA@mail.gmail.com>
 <56269126.1070807@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:56060 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150AbbJUGeR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Oct 2015 02:34:17 -0400
In-Reply-To: <56269126.1070807@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, Michal Simek <michal.simek@xilinx.com>, =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 2015/10/21 3:08, Kishon Vijay Abraham I wrote:
> Hi,
>
> On Tuesday 20 October 2015 02:09 PM, Ulf Hansson wrote:
>> + Kishon
>>
>> On 20 October 2015 at 09:05, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>> This patch adds Generic PHY access for sdhci-of-arasan. Driver
>>> can get PHY handler from dt-binding, and power-on/init the PHY.
>>> Also we add pm ops for PHY here if CONFIG_PM_SLEEP is enabled.
>>> Currently, it's just mandatory for arasan,sdhci-5.1.
>>>
>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>>
>>> Serise-changes: 3
>>> - remove phy_init/exit for suspend/resume
>>> - adjust phy_int/power_on seq to make code more reasonable
>>> - simplify suspend/resume_phy
>>>
>>> Serise-changes: 2
>>> - Keep phy as a mandatory requirement for arasan,sdhci-5.1
>>>
>>> ---
>>>
>>> Changes in v2: None
>>>
>>>   drivers/mmc/host/sdhci-of-arasan.c | 87 ++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 87 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
>>> index 75379cb..85bd0f9d 100644
>>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>>> @@ -21,6 +21,7 @@
>>>
>>>   #include <linux/module.h>
>>>   #include <linux/of_device.h>
>>> +#include <linux/phy/phy.h>
>>>   #include "sdhci-pltfm.h"
>>>
>>>   #define SDHCI_ARASAN_CLK_CTRL_OFFSET   0x2c
>>> @@ -35,6 +36,7 @@
>>>    */
>>>   struct sdhci_arasan_data {
>>>          struct clk      *clk_ahb;
>>> +       struct phy      *phy;
>>>   };
>>>
>>>   static unsigned int sdhci_arasan_get_timeout_clock(struct sdhci_host *host)
>>> @@ -70,6 +72,42 @@ static struct sdhci_pltfm_data sdhci_arasan_pdata = {
>>>
>>>   #ifdef CONFIG_PM_SLEEP
>>>   /**
>>> +  * sdhci_arasan_suspend_phy - Suspend phy method for the driver
>>> +  * @phy:        Handler of phy structure
>>> +  * Returns 0 on success and error value on error
>>> +  *
>>> +  * Put the phy in a deactive state.
>>> +  */
>>> +static int sdhci_arasan_suspend_phy(struct phy *phy)
>>> +{
>>> +       int ret = 0;
>>> +
>>> +       ret = phy_power_off(phy);
>>> +       if (ret)
>>
>> This is an odd error handling, should you really do phy_power_on()?
>
> right, if phy_power_off fails, it means the phy is still powered on.
> This will also get reference counting wrong in the phy core.
>
> Also phy_power_off can be invoked directly instead of having a separate
> function to invoke it.

Thanks for comments, Kisho. Then I will remove these two wrappers and 
call phy_power_off/on directly.

>>
>>> +               phy_power_on(phy);
>>> +
>>> +       return ret;
>>> +}
>>> +
>>> +/**
>>> +  * sdhci_arasan_resume_phy - Resume phy method for the driver
>>> +  * @phy:        Handler of phy structure
>>> +  * Returns 0 on success and error value on error
>>> +  *
>>> +  * Put the phy in a active state.
>>> +  */
>>> +static int sdhci_arasan_resume_phy(struct phy *phy)
>>> +{
>>> +       int ret = 0;
>>> +
>>> +       ret = phy_power_on(phy);
>>> +       if (ret)
>>
>> Similar comment as above.
>
> use phy_power_on directly.
>>
>>> +               phy_power_off(phy);
>>> +
>>> +       return ret;
>>> +}
>>> +
>>> +/**
>>>    * sdhci_arasan_suspend - Suspend method for the driver
>>>    * @dev:       Address of the device structure
>>>    * Returns 0 on success and error value on error
>>> @@ -88,6 +126,15 @@ static int sdhci_arasan_suspend(struct device *dev)
>>>          if (ret)
>>>                  return ret;
>>>
>>> +       if (!IS_ERR(sdhci_arasan->phy)) {
>
> you can make this an optional PHY and then you don't have to check error
> every time you use PHY API's.
>>> +               ret = sdhci_arasan_suspend_phy(sdhci_arasan->phy);
>>> +               if (ret) {
>>> +                       dev_err(dev, "Cannot suspend phy.\n");
>>> +                       sdhci_resume_host(host);
>>
>> This is an odd error handling, why do sdhci_resume_host()?
>
> right, this will result in multiple power_on's to be invoked.
>>
>>> +                       return ret;
>>> +               }
>>> +       }
>>> +
>>>          clk_disable(pltfm_host->clk);
>>>          clk_disable(sdhci_arasan->clk_ahb);
>>>
>>> @@ -122,6 +169,16 @@ static int sdhci_arasan_resume(struct device *dev)
>>>                  return ret;
>>>          }
>>>
>>> +       if (!IS_ERR(sdhci_arasan->phy)) {
>
> same here.
>>> +               ret = sdhci_arasan_resume_phy(sdhci_arasan->phy);
>>> +               if (ret) {
>>> +                       dev_err(dev, "Cannot resume phy.\n");
>>> +                       clk_disable(sdhci_arasan->clk_ahb);
>>> +                       clk_disable(pltfm_host->clk);
>>> +                       return ret;
>>
>> The error handling is starting to be a bit complex in
>> sdhci_arasan_resume(), perhaps it's time to add some labels to make
>> the code more readable?
>>
>>> +               }
>>> +       }
>>> +
>>>          return sdhci_resume_host(host);
>>>   }
>>>   #endif /* ! CONFIG_PM_SLEEP */
>>> @@ -166,6 +223,33 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>>>                  goto clk_dis_ahb;
>>>          }
>>>
>>> +       sdhci_arasan->phy = NULL;
>>
>> NULL isn't an error. You probably want something like:
>> sdhci_arasan->phy = ERR_PTR(-ENODEV);
>>
>> Although, I just realize that the phy API works a bit differently than
>> other APIs. More precisely, instead of returning an error while you
>> provide a NULL pointer to the APIs, it will treat it as a NOOP and
>> return a non-error code (at least according to the documentation). I
>> don't know why the phy API is different, but to me I prefer to use the
>> regular kernel style and thus, please adopt to my suggestion above.
>
> So with optional PHY's, the phy core API will return NULL, if it's not
> able to get the PHY (i.e if the ERR is ENODEV). So there don't have to
> be error checking in the driver before invoking PHY APIs.
>>
>>> +       if (of_device_is_compatible(pdev->dev.of_node,
>>> +                                   "arasan,sdhci-5.1")) {
>>> +               sdhci_arasan->phy = devm_phy_get(&pdev->dev,
>>> +                                                "phy_arasan");
>
> oh.. so it's not an optional PHY. I think then initializing phy to NULL
> above is okay IMO.

yes, it's mandatory in the case.

>
> Thanks
> Kishon
>
>
>


-- 
Best Regards
Shawn Lin

