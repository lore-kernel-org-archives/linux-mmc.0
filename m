From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] Revert "mmc: dw_mmc-rockchip: add runtime PM support"
Date: Thu, 29 Dec 2016 15:25:46 +0800
Message-ID: <7fb90b9e-75c3-0184-4f0a-d4113899b860@rock-chips.com>
References: <CGME20161228153516epcas2p253c6bc0371ab0df464573b63218795ef@epcas2p2.samsung.com>
 <1482939288-14950-1-git-send-email-ayaka@soulik.info>
 <e0cc8029-0155-4879-a643-ddc4239a55ab@samsung.com>
 <7e37b8ad-39d0-3a94-f75a-2166ae2caf10@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:60685 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751686AbcL2H0l (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Dec 2016 02:26:41 -0500
In-Reply-To: <7e37b8ad-39d0-3a94-f75a-2166ae2caf10@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Randy Li <ayaka@soulik.info>, linux-mmc@vger.kernel.org
Cc: shawn.lin@rock-chips.com, randy.li@rock-chips.com, ulf.hansson@linaro.org, heiko@sntech.de, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 2016/12/29 15:13, Jaehoon Chung wrote:
> On 12/29/2016 12:02 PM, Jaehoon Chung wrote:
>> Hi Randy,
>>
>> On 12/29/2016 12:34 AM, Randy Li wrote:
>>> This reverts commit f90142683f04bcb0729bf0df67a5e29562b725b9.
>>> It is reported that making RK3288 can't boot from eMMC/MMC.
>>
>> Could you explain in more detail?
>> As you mentioned, this patch is making that RK3288 can't boot..then why?
>> Good way should be that finds the main reason and fixes it.
>> Not just revert.
>
> To Shawn,
>
> Could you check this? If you have rk3288..
> If it's not working fine, it needs to revert this patch until finding the problem.
>

Hrmm.....as that patchset was tested based on rk3288 and rk3368, so I
need to know which board Randy are using now and could you share some
log?

I will have a look at it.


> Best Regards,
> Jaehoon Chung
>
>>
>> Best Regards,
>> Jaehoon Chung
>>
>>>
>>> Signed-off-by: Randy Li <ayaka@soulik.info>
>>> ---
>>>  drivers/mmc/host/dw_mmc-rockchip.c | 41 +++-----------------------------------
>>>  1 file changed, 3 insertions(+), 38 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
>>> index 9a46e46..3189234 100644
>>> --- a/drivers/mmc/host/dw_mmc-rockchip.c
>>> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
>>> @@ -14,7 +14,6 @@
>>>  #include <linux/mmc/dw_mmc.h>
>>>  #include <linux/of_address.h>
>>>  #include <linux/mmc/slot-gpio.h>
>>> -#include <linux/pm_runtime.h>
>>>  #include <linux/slab.h>
>>>
>>>  #include "dw_mmc.h"
>>> @@ -327,7 +326,6 @@ static int dw_mci_rockchip_probe(struct platform_device *pdev)
>>>  {
>>>  	const struct dw_mci_drv_data *drv_data;
>>>  	const struct of_device_id *match;
>>> -	int ret;
>>>
>>>  	if (!pdev->dev.of_node)
>>>  		return -ENODEV;
>>> @@ -335,49 +333,16 @@ static int dw_mci_rockchip_probe(struct platform_device *pdev)
>>>  	match = of_match_node(dw_mci_rockchip_match, pdev->dev.of_node);
>>>  	drv_data = match->data;
>>>
>>> -	pm_runtime_get_noresume(&pdev->dev);
>>> -	pm_runtime_set_active(&pdev->dev);
>>> -	pm_runtime_enable(&pdev->dev);
>>> -	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
>>> -	pm_runtime_use_autosuspend(&pdev->dev);
>>> -
>>> -	ret = dw_mci_pltfm_register(pdev, drv_data);
>>> -	if (ret) {
>>> -		pm_runtime_disable(&pdev->dev);
>>> -		pm_runtime_set_suspended(&pdev->dev);
>>> -		pm_runtime_put_noidle(&pdev->dev);
>>> -		return ret;
>>> -	}
>>> -
>>> -	pm_runtime_put_autosuspend(&pdev->dev);
>>> -
>>> -	return 0;
>>> +	return dw_mci_pltfm_register(pdev, drv_data);
>>>  }
>>>
>>> -static int dw_mci_rockchip_remove(struct platform_device *pdev)
>>> -{
>>> -	pm_runtime_get_sync(&pdev->dev);
>>> -	pm_runtime_disable(&pdev->dev);
>>> -	pm_runtime_put_noidle(&pdev->dev);
>>> -
>>> -	return dw_mci_pltfm_remove(pdev);
>>> -}
>>> -
>>> -static const struct dev_pm_ops dw_mci_rockchip_dev_pm_ops = {
>>> -	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
>>> -				pm_runtime_force_resume)
>>> -	SET_RUNTIME_PM_OPS(dw_mci_runtime_suspend,
>>> -			   dw_mci_runtime_resume,
>>> -			   NULL)
>>> -};
>>> -
>>>  static struct platform_driver dw_mci_rockchip_pltfm_driver = {
>>>  	.probe		= dw_mci_rockchip_probe,
>>> -	.remove		= dw_mci_rockchip_remove,
>>> +	.remove		= dw_mci_pltfm_remove,
>>>  	.driver		= {
>>>  		.name		= "dwmmc_rockchip",
>>>  		.of_match_table	= dw_mci_rockchip_match,
>>> -		.pm		= &dw_mci_rockchip_dev_pm_ops,
>>> +		.pm		= &dw_mci_pltfm_pmops,
>>>  	},
>>>  };
>>>
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> .
>>
>
>
>
>


-- 
Best Regards
Shawn Lin

