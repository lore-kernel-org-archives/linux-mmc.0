From: ayaka <ayaka-xPW3/0Ywev/iB9QmIjCX8w@public.gmane.org>
Subject: Re: [PATCH] Revert "mmc: dw_mmc-rockchip: add runtime PM support"
Date: Thu, 29 Dec 2016 20:55:21 +0800
Message-ID: <6ccade72-ae20-2ffa-1504-2536b9f03adf@soulik.info>
References: <CGME20161228153516epcas2p253c6bc0371ab0df464573b63218795ef@epcas2p2.samsung.com>
 <1482939288-14950-1-git-send-email-ayaka@soulik.info>
 <e0cc8029-0155-4879-a643-ddc4239a55ab@samsung.com>
 <7e37b8ad-39d0-3a94-f75a-2166ae2caf10@samsung.com>
 <7fb90b9e-75c3-0184-4f0a-d4113899b860@rock-chips.com>
 <04b667d9-2591-51ff-e024-047bbb6e17c3@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <04b667d9-2591-51ff-e024-047bbb6e17c3-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Randy Li <randy.li-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

[    5.849733] rk_gmac-dwmac ff290000.ethernet (unnamed net_device) 
(uninitialized): Enable RX Mitigation via HW Watchdog Timer
[    5.944512] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 
50000000Hz, actual 50000000HZ div = 0)
[    5.958249] mmc1: new ultra high speed DDR50 SDIO card at address 0001
[    6.294548] dwmmc_rockchip ff0f0000.dwmmc: Successfully tuned phase 
to 177
[    6.301591] mmc2: new HS200 MMC card at address 0001
[    6.306758] mmc_host mmc0: Bus speed (slot 0) = 300000Hz (slot req 
300000Hz, actual 300000HZ div = 0)
[    6.316830] mmcblk2: mmc2:0001 AGND3R 14.6 GiB
[    6.321881] mmcblk2boot0: mmc2:0001 AGND3R partition 1 4.00 MiB
[    6.328331] mmcblk2boot1: mmc2:0001 AGND3R partition 2 4.00 MiB
[    6.334792] mmcblk2rpmb: mmc2:0001 AGND3R partition 3 4.00 MiB
[    6.344295]  mmcblk2: p1 p2 p3 p4 p5 p6 p7
[    6.469892] mmc_host mmc0: Bus speed (slot 0) = 200000Hz (slot req 
200000Hz, actual 200000HZ div = 0)
[    6.621888] mmc_host mmc0: Bus speed (slot 0) = 187500Hz (slot req 
100000Hz, actual 93750HZ div = 1)
[    6.917883] libphy: stmmac: probed
[    6.921319] rk_gmac-dwmac ff290000.ethernet eth0: PHY ID 001cc915 at 
0 IRQ POLL (stmmac-0:00) active
[    6.930476] rk_gmac-dwmac ff290000.ethernet eth0: PHY ID 001cc915 at 
2 IRQ POLL (stmmac-0:02)
[    6.939757] input: gpio-keys as /devices/platform/gpio-keys/input/input0
[    6.946937] rtc-hym8563 0-0051: no valid clock/calendar values available
[    6.953694] rtc-hym8563 0-0051: hctosys: unable to read the hardware 
clock
[    6.961262] vcc_sd: disabling
[    6.964275] dovdd_1v8: disabling
[    6.967527] dvdd_1v2: disabling
[    6.971006] vdd10_lcd: disabling
[    6.974701] vcc18_lcd: disabling
[    6.978467] ttyS2 - failed to request DMA
[    7.101883] mmc_host mmc0: Bus speed (slot 0) = 400000Hz (slot req 
400000Hz, actual 400000HZ div = 0)
[    7.253874] mmc_host mmc0: Bus speed (slot 0) = 300000Hz (slot req 
300000Hz, actual 300000HZ div = 0)
[    7.405883] mmc_host mmc0: Bus speed (slot 0) = 200000Hz (slot req 
200000Hz, actual 200000HZ div = 0)
[    7.557885] mmc_host mmc0: Bus speed (slot 0) = 187500Hz (slot req 
100000Hz, actual 93750HZ div = 1)
[    8.037872] mmc_host mmc0: Bus speed (slot 0) = 400000Hz (slot req 
400000Hz, actual 400000HZ div = 0)
[    8.189877] mmc_host mmc0: Bus speed (slot 0) = 300000Hz (slot req 
300000Hz, actual 300000HZ div = 0)
[    8.341881] mmc_host mmc0: Bus speed (slot 0) = 200000Hz (slot req 
200000Hz, actual 200000HZ div = 0)
[    8.493884] mmc_host mmc0: Bus speed (slot 0) = 187500Hz (slot req 
100000Hz, actual 93750HZ div = 1)
[    8.973871] mmc_host mmc0: Bus speed (slot 0) = 400000Hz (slot req 
400000Hz, actual 400000HZ div = 0)
[    9.125876] mmc_host mmc0: Bus speed (slot 0) = 300000Hz (slot req 
300000Hz, actual 300000HZ div = 0)
[    9.277884] mmc_host mmc0: Bus speed (slot 0) = 200000Hz (slot req 
200000Hz, actual 200000HZ div = 0)
[    9.429882] mmc_host mmc0: Bus speed (slot 0) = 187500Hz (slot req 
100000Hz, actual 93750HZ div = 1)

looping here

If I revert that patch, there are still lots of Bus speed messages, but 
finally would enter into system.


On 12/29/2016 06:25 PM, Randy Li wrote:
>
>
> On 12/29/2016 03:25 PM, Shawn Lin wrote:
>> On 2016/12/29 15:13, Jaehoon Chung wrote:
>>> On 12/29/2016 12:02 PM, Jaehoon Chung wrote:
>>>> Hi Randy,
>>>>
>>>> On 12/29/2016 12:34 AM, Randy Li wrote:
>>>>> This reverts commit f90142683f04bcb0729bf0df67a5e29562b725b9.
>>>>> It is reported that making RK3288 can't boot from eMMC/MMC.
>>>>
>>>> Could you explain in more detail?
>>>> As you mentioned, this patch is making that RK3288 can't boot..then 
>>>> why?
>>>> Good way should be that finds the main reason and fixes it.
>>>> Not just revert.
>>>
>>> To Shawn,
>>>
>>> Could you check this? If you have rk3288..
>>> If it's not working fine, it needs to revert this patch until finding
>>> the problem.
>>>
>>
>> Hrmm.....as that patchset was tested based on rk3288 and rk3368, so I
>> need to know which board Randy are using now and could you share some
> Sorry, XZY has asked me about this in the morning and I answer him 
> that I would give a feedback at home, so I didn't notice this mail.
> The board is Firefly reload. but the reporter told me that Firefly 
> release also have the same problem.
>> log?
>>
>> I will have a look at it.
>>
>>
>>> Best Regards,
>>> Jaehoon Chung
>>>
>>>>
>>>> Best Regards,
>>>> Jaehoon Chung
>>>>
>>>>>
>>>>> Signed-off-by: Randy Li <ayaka-xPW3/0Ywev/iB9QmIjCX8w@public.gmane.org>
>>>>> ---
>>>>>  drivers/mmc/host/dw_mmc-rockchip.c | 41
>>>>> +++-----------------------------------
>>>>>  1 file changed, 3 insertions(+), 38 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c
>>>>> b/drivers/mmc/host/dw_mmc-rockchip.c
>>>>> index 9a46e46..3189234 100644
>>>>> --- a/drivers/mmc/host/dw_mmc-rockchip.c
>>>>> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
>>>>> @@ -14,7 +14,6 @@
>>>>>  #include <linux/mmc/dw_mmc.h>
>>>>>  #include <linux/of_address.h>
>>>>>  #include <linux/mmc/slot-gpio.h>
>>>>> -#include <linux/pm_runtime.h>
>>>>>  #include <linux/slab.h>
>>>>>
>>>>>  #include "dw_mmc.h"
>>>>> @@ -327,7 +326,6 @@ static int dw_mci_rockchip_probe(struct
>>>>> platform_device *pdev)
>>>>>  {
>>>>>      const struct dw_mci_drv_data *drv_data;
>>>>>      const struct of_device_id *match;
>>>>> -    int ret;
>>>>>
>>>>>      if (!pdev->dev.of_node)
>>>>>          return -ENODEV;
>>>>> @@ -335,49 +333,16 @@ static int dw_mci_rockchip_probe(struct
>>>>> platform_device *pdev)
>>>>>      match = of_match_node(dw_mci_rockchip_match, pdev->dev.of_node);
>>>>>      drv_data = match->data;
>>>>>
>>>>> -    pm_runtime_get_noresume(&pdev->dev);
>>>>> -    pm_runtime_set_active(&pdev->dev);
>>>>> -    pm_runtime_enable(&pdev->dev);
>>>>> -    pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
>>>>> -    pm_runtime_use_autosuspend(&pdev->dev);
>>>>> -
>>>>> -    ret = dw_mci_pltfm_register(pdev, drv_data);
>>>>> -    if (ret) {
>>>>> -        pm_runtime_disable(&pdev->dev);
>>>>> -        pm_runtime_set_suspended(&pdev->dev);
>>>>> -        pm_runtime_put_noidle(&pdev->dev);
>>>>> -        return ret;
>>>>> -    }
>>>>> -
>>>>> -    pm_runtime_put_autosuspend(&pdev->dev);
>>>>> -
>>>>> -    return 0;
>>>>> +    return dw_mci_pltfm_register(pdev, drv_data);
>>>>>  }
>>>>>
>>>>> -static int dw_mci_rockchip_remove(struct platform_device *pdev)
>>>>> -{
>>>>> -    pm_runtime_get_sync(&pdev->dev);
>>>>> -    pm_runtime_disable(&pdev->dev);
>>>>> -    pm_runtime_put_noidle(&pdev->dev);
>>>>> -
>>>>> -    return dw_mci_pltfm_remove(pdev);
>>>>> -}
>>>>> -
>>>>> -static const struct dev_pm_ops dw_mci_rockchip_dev_pm_ops = {
>>>>> -    SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
>>>>> -                pm_runtime_force_resume)
>>>>> -    SET_RUNTIME_PM_OPS(dw_mci_runtime_suspend,
>>>>> -               dw_mci_runtime_resume,
>>>>> -               NULL)
>>>>> -};
>>>>> -
>>>>>  static struct platform_driver dw_mci_rockchip_pltfm_driver = {
>>>>>      .probe        = dw_mci_rockchip_probe,
>>>>> -    .remove        = dw_mci_rockchip_remove,
>>>>> +    .remove        = dw_mci_pltfm_remove,
>>>>>      .driver        = {
>>>>>          .name        = "dwmmc_rockchip",
>>>>>          .of_match_table    = dw_mci_rockchip_match,
>>>>> -        .pm        = &dw_mci_rockchip_dev_pm_ops,
>>>>> +        .pm        = &dw_mci_pltfm_pmops,
>>>>>      },
>>>>>  };
>>>>>
>>>>>
>>>>
>>>> -- 
>>>> To unsubscribe from this list: send the line "unsubscribe 
>>>> linux-mmc" in
>>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>>>
>>>> .
>>>>
>>>
>>>
>>>
>>>
>>
>>
>
