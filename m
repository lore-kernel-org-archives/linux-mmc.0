From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH 1/2] mmc: sdhci-of-arasan: add phy support for
 sdhci-of-arasan
Date: Mon, 19 Oct 2015 08:51:17 +0800
Message-ID: <56243E85.2040202@rock-chips.com>
References: <1441961698-10516-1-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKFpwgZSkE+TNehZ1Un=5CfjoEtfvELfrS6t-ZHZPscy3Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <CAPDyKFpwgZSkE+TNehZ1Un=5CfjoEtfvELfrS6t-ZHZPscy3Yg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, S?ren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 2015/10/16 20:35, Ulf Hansson wrote:
> On 11 September 2015 at 10:54, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
>> This patch adds Generic PHY access for sdhci-of-arasan. Driver
>> can get PHY handler from dt-binding, and power-on/init the PHY.
>> Also we add pm ops for PHY here if CONFIG_PM_SLEEP is enabled.
>>
>> Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>> ---
>>
>>   drivers/mmc/host/sdhci-of-arasan.c | 90 ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 90 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
>> index 621c3f4..fdd71c7 100644
>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>> @@ -21,6 +21,7 @@
>>
>>   #include <linux/module.h>
>>   #include <linux/of_device.h>
>> +#include <linux/phy/phy.h>
>>   #include "sdhci-pltfm.h"
>>
>>   #define SDHCI_ARASAN_CLK_CTRL_OFFSET   0x2c
>> @@ -35,6 +36,7 @@
>>    */
>>   struct sdhci_arasan_data {
>>          struct clk      *clk_ahb;
>> +       struct phy      *phy;
>>   };
>>
>>   static unsigned int sdhci_arasan_get_timeout_clock(struct sdhci_host *host)
>> @@ -67,6 +69,62 @@ static struct sdhci_pltfm_data sdhci_arasan_pdata = {
>>
>>   #ifdef CONFIG_PM_SLEEP
>>   /**
>> +  * sdhci_arasan_suspend_phy - Suspend phy method for the driver
>> +  * @phy:        Handler of phy structure
>> +  * Returns 0 on success and error value on error
>> +  *
>> +  * Put the phy in a deactive state.
>> +  */
>> +static int sdhci_arasan_suspend_phy(struct phy *phy)
>> +{
>> +       int ret;
>> +
>> +       ret = phy_exit(phy);
>> +       if (ret < 0)
>> +               goto err_phy_exit;
>
> This odd to me. First you do phy_exit() then phy_power_off(). It seems
> like it should be in the opposite order.
>

yep, there is no need to use phy_exit/init for suspend/resume.
I will do it.

> Moreover I wonder why phy_exit() is needed, I expected that to be
> called at ->remove() only!?
>
>> +
>> +       ret = phy_power_off(phy);
>> +       if (ret < 0)
>> +               goto err_phy_pwr_off;
>> +
>> +       return 0;
>> +
>> +err_phy_pwr_off:
>> +       phy_power_on(phy);
>> +err_phy_exit:
>> +       phy_init(phy);
>> +       return ret;
>> +}
>> +
>> +/**
>> +  * sdhci_arasan_resume_phy - Resume phy method for the driver
>> +  * @phy:        Handler of phy structure
>> +  * Returns 0 on success and error value on error
>> +  *
>> +  * Put the phy in a active state.
>> +  */
>> +static int sdhci_arasan_resume_phy(struct phy *phy)
>> +{
>> +       int ret;
>> +
>> +       ret = phy_power_on(phy);
>> +       if (ret < 0)
>> +               goto err_phy_pwr_on;
>> +
>> +       ret = phy_init(phy);
>> +       if (ret < 0)
>> +               goto err_phy_init;
>> +
>
> Similar comment as above.
>
>> +       return 0;
>> +
>> +err_phy_init:
>> +       phy_exit(phy);
>> +err_phy_pwr_on:
>> +       phy_power_off(phy);
>> +       return ret;
>> +}
>> +
>> +/**
>>    * sdhci_arasan_suspend - Suspend method for the driver
>>    * @dev:       Address of the device structure
>>    * Returns 0 on success and error value on error
>> @@ -88,6 +146,12 @@ static int sdhci_arasan_suspend(struct device *dev)
>>          clk_disable(pltfm_host->clk);
>>          clk_disable(sdhci_arasan->clk_ahb);
>>
>> +       if (sdhci_arasan->phy) {
>> +               ret = sdhci_arasan_suspend_phy(sdhci_arasan->phy);
>> +               if (ret < 0)
>> +                       return ret;
>> +       }
>
> This means you will suspend the phy after you have disabled the
> clocks. Of course I can't tell whether that okay, but it doesn't
> follow the same sequence as in ->probe(). To me that indicates that
> either probe or suspend/resume could be broken.
>

phy has a seperate clk for itself, and it's controlled by phy driver. 
So, there is no any relationship between controller's clk and phy's clk. 
We disable or enable phy's clk internally in 
phy_int/exit/power_off/power_on.

Of course if it makes odd to you, I would put suspend_phy before 
clk_disable.  :)

>> +
>>          return 0;
>>   }
>>
>> @@ -119,6 +183,12 @@ static int sdhci_arasan_resume(struct device *dev)
>>                  return ret;
>>          }
>>
>> +       if (sdhci_arasan->phy) {
>> +               ret = sdhci_arasan_resume_phy(sdhci_arasan->phy);
>> +               if (ret < 0)
>> +                       return ret;
>> +       }
>> +
>>          return sdhci_resume_host(host);
>>   }
>>   #endif /* ! CONFIG_PM_SLEEP */
>> @@ -163,6 +233,26 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>>                  goto clk_dis_ahb;
>>          }
>>
>> +       sdhci_arasan->phy = devm_phy_get(&pdev->dev, "phy_arasan");
>> +       if (!IS_ERR(sdhci_arasan->phy)) {
>
> I understand the phy is optional, but you still need to handle the
> EPROBE_DEFER case.
>
> Perhaps you should also use devm_phy_optional_get() instead!?

I already changed it in version-2 [1]. :)
phy is mandatory for sdhci-arasan,5.1.

[1]: https://patchwork.kernel.org/patch/7173251/

>
>> +               ret = phy_power_on(sdhci_arasan->phy);
>
> This looks a bit weird. Shouldn't you do phy_init() prior phy_power_on()?
>
> Similar comment applies to phy_exit() and phy_power_off().

Both are okay. It depends how the phy-driver implement the four 
interfaces. From my case, power_on for arasan's phy driver firstly 
enable phy's clk and open power-domain, then programme phy internal 
registers to activate phy. Without enabling phy's clk and power-domain, 
we cannot do phy_init since phy can't be accessed by CPU.

But here, I think you are right. It does look a bit weird.
I think the better way is to remove phy_power_on here, and let 
phy-driver do power_on in phy_init internally. Similarly in the remove call.


How about?

>
>> +               if (ret < 0) {
>> +                       dev_err(&pdev->dev, "phy_power_on err.\n");
>> +                       phy_power_off(sdhci_arasan->phy);
>> +                       goto clk_dis_ahb;
>> +               }
>> +
>> +               ret = phy_init(sdhci_arasan->phy);
>> +               if (ret < 0) {
>> +                       dev_err(&pdev->dev, "phy_init err.\n");
>> +                       phy_exit(sdhci_arasan->phy);
>> +                       phy_power_off(sdhci_arasan->phy);
>> +                       goto clk_dis_ahb;
>> +               }
>> +       } else {
>
> This else isn't needed. When you are about to access the phy you can
> check the cookie of it by "!IS_ERR(sdhci_arasan->phy)".
>

similarly, I had removed it in v2.

>> +               sdhci_arasan->phy = NULL;
>> +       }
>> +
>>          host = sdhci_pltfm_init(pdev, &sdhci_arasan_pdata, 0);
>>          if (IS_ERR(host)) {
>>                  ret = PTR_ERR(host);
>> --
>> 2.3.7
>>
>>
>
> Kind regards
> Uffe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>


-- 
Best Regards
Shawn Lin
