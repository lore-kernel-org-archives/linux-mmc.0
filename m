From: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] Revert "mmc: dw_mmc-rockchip: add runtime PM support"
Date: Thu, 29 Dec 2016 16:13:52 +0900
Message-ID: <7e37b8ad-39d0-3a94-f75a-2166ae2caf10@samsung.com>
References: <CGME20161228153516epcas2p253c6bc0371ab0df464573b63218795ef@epcas2p2.samsung.com>
 <1482939288-14950-1-git-send-email-ayaka@soulik.info>
 <e0cc8029-0155-4879-a643-ddc4239a55ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-reply-to: <e0cc8029-0155-4879-a643-ddc4239a55ab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Randy Li <ayaka-xPW3/0Ywev/iB9QmIjCX8w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, randy.li-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 12/29/2016 12:02 PM, Jaehoon Chung wrote:
> Hi Randy,
> 
> On 12/29/2016 12:34 AM, Randy Li wrote:
>> This reverts commit f90142683f04bcb0729bf0df67a5e29562b725b9.
>> It is reported that making RK3288 can't boot from eMMC/MMC.
> 
> Could you explain in more detail?
> As you mentioned, this patch is making that RK3288 can't boot..then why?
> Good way should be that finds the main reason and fixes it.
> Not just revert.

To Shawn,

Could you check this? If you have rk3288..
If it's not working fine, it needs to revert this patch until finding the problem.

Best Regards,
Jaehoon Chung

> 
> Best Regards,
> Jaehoon Chung
> 
>>
>> Signed-off-by: Randy Li <ayaka-xPW3/0Ywev/iB9QmIjCX8w@public.gmane.org>
>> ---
>>  drivers/mmc/host/dw_mmc-rockchip.c | 41 +++-----------------------------------
>>  1 file changed, 3 insertions(+), 38 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
>> index 9a46e46..3189234 100644
>> --- a/drivers/mmc/host/dw_mmc-rockchip.c
>> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
>> @@ -14,7 +14,6 @@
>>  #include <linux/mmc/dw_mmc.h>
>>  #include <linux/of_address.h>
>>  #include <linux/mmc/slot-gpio.h>
>> -#include <linux/pm_runtime.h>
>>  #include <linux/slab.h>
>>  
>>  #include "dw_mmc.h"
>> @@ -327,7 +326,6 @@ static int dw_mci_rockchip_probe(struct platform_device *pdev)
>>  {
>>  	const struct dw_mci_drv_data *drv_data;
>>  	const struct of_device_id *match;
>> -	int ret;
>>  
>>  	if (!pdev->dev.of_node)
>>  		return -ENODEV;
>> @@ -335,49 +333,16 @@ static int dw_mci_rockchip_probe(struct platform_device *pdev)
>>  	match = of_match_node(dw_mci_rockchip_match, pdev->dev.of_node);
>>  	drv_data = match->data;
>>  
>> -	pm_runtime_get_noresume(&pdev->dev);
>> -	pm_runtime_set_active(&pdev->dev);
>> -	pm_runtime_enable(&pdev->dev);
>> -	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
>> -	pm_runtime_use_autosuspend(&pdev->dev);
>> -
>> -	ret = dw_mci_pltfm_register(pdev, drv_data);
>> -	if (ret) {
>> -		pm_runtime_disable(&pdev->dev);
>> -		pm_runtime_set_suspended(&pdev->dev);
>> -		pm_runtime_put_noidle(&pdev->dev);
>> -		return ret;
>> -	}
>> -
>> -	pm_runtime_put_autosuspend(&pdev->dev);
>> -
>> -	return 0;
>> +	return dw_mci_pltfm_register(pdev, drv_data);
>>  }
>>  
>> -static int dw_mci_rockchip_remove(struct platform_device *pdev)
>> -{
>> -	pm_runtime_get_sync(&pdev->dev);
>> -	pm_runtime_disable(&pdev->dev);
>> -	pm_runtime_put_noidle(&pdev->dev);
>> -
>> -	return dw_mci_pltfm_remove(pdev);
>> -}
>> -
>> -static const struct dev_pm_ops dw_mci_rockchip_dev_pm_ops = {
>> -	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
>> -				pm_runtime_force_resume)
>> -	SET_RUNTIME_PM_OPS(dw_mci_runtime_suspend,
>> -			   dw_mci_runtime_resume,
>> -			   NULL)
>> -};
>> -
>>  static struct platform_driver dw_mci_rockchip_pltfm_driver = {
>>  	.probe		= dw_mci_rockchip_probe,
>> -	.remove		= dw_mci_rockchip_remove,
>> +	.remove		= dw_mci_pltfm_remove,
>>  	.driver		= {
>>  		.name		= "dwmmc_rockchip",
>>  		.of_match_table	= dw_mci_rockchip_match,
>> -		.pm		= &dw_mci_rockchip_dev_pm_ops,
>> +		.pm		= &dw_mci_pltfm_pmops,
>>  	},
>>  };
>>  
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> .
> 
