From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 0/9] Init runtime PM support for dw_mmc
Date: Tue, 18 Oct 2016 19:45:35 +0900
Message-ID: <17f821c0-46d3-76e7-06dd-fbb415de37eb@samsung.com>
References: <1476240643-5701-1-git-send-email-shawn.lin@rock-chips.com>
 <CGME20161018085101epcas1p323c180baf3a9c34b97bc9fb4a9581c46@epcas1p3.samsung.com>
 <CAPDyKFopNgWh=+0RNFwJc+aaFPXGuJMAac5rPtfOawvLwSbN+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:36226 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753461AbcJRKpi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Oct 2016 06:45:38 -0400
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OF800GEXOJVLX60@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 18 Oct 2016 19:45:36 +0900 (KST)
In-reply-to: <CAPDyKFopNgWh=+0RNFwJc+aaFPXGuJMAac5rPtfOawvLwSbN+g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Doug Anderson <dianders@chromium.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Heiko Stuebner <heiko@sntech.de>

On 10/18/2016 05:46 PM, Ulf Hansson wrote:
> + Heiko
> 
> On 12 October 2016 at 04:50, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>
>> Hi Jaehoon and Ulf,
>>
>>    This patch is gonna support runtime PM for dw_mmc.
>> It could support to disable ciu_clk by default and disable
>> biu_clk if the devices are non-removeable, or removeable
>> with gpio-base card detect.
>>
>>    Then I remove the system PM since the runtime PM actually
>> does the same thing as it. So I help migrate the dw_mmc variant
>> drivers to use runtime PM pairs and pm_runtime_force_*. Note
>> that I only enable runtime PM for dw_mmc-rockchip as I will
>> leave the decision to the owners of the corresponding drivers.
>> I just tested it on my RK3288 platform with linux-next to make
>> the runtime PM and system PM work fine for my emmc, sd card and
>> sdio. But I don't have hardware to help test other variant drivers.
>> But in theory it should work fine as I mentioned that the runtime
>> PM does the same thing as system PM except for disabling ciu_clk
>> aggressively which should not be related to the variant hosts.
>>
>>    As you could see that I just extend the slot-gpio a bit, so the
>> ideal way is Ulf could pick them up with Jaehoon's ack. :)
> 
> The mmc core change looks fine to me, so I will wait for a pull
> request from Jaehoon.
> 
>>
>>
>> Changes in v2:
>> - use struct device as argument for runtime callback
>> - use dw_mci_runtime_* directly
>> - use dw_mci_runtime_* directly
>> - minor fix since I change the argument for dw_mci_runtime_*
>> - use dw_mci_runtime_* directly
>> - use dw_mci_runtime_* directly
>>
>> Shawn Lin (9):
>>   mmc: dw_mmc: add runtime PM callback
>>   mmc: dw_mmc-rockchip: add runtime PM support
>>   mmc: core: expose the capability of gpio card detect
>>   mmc: dw_mmc: disable biu clk if possible
>>   mmc: dw_mmc-k3: deploy runtime PM facilities
>>   mmc: dw_mmc-exynos: deploy runtime PM facilities
>>   mmc: dw_mmc-pci: deploy runtime PM facilities
>>   mmc: dw_mmc-pltfm: deploy runtime PM facilities
>>   mmc: dw_mmc: remove system PM callback
>>
>>  drivers/mmc/core/slot-gpio.c       |  8 +++++++
>>  drivers/mmc/host/dw_mmc-exynos.c   | 24 +++++++++-----------
>>  drivers/mmc/host/dw_mmc-k3.c       | 39 ++++++++------------------------
>>  drivers/mmc/host/dw_mmc-pci.c      | 29 ++++++++----------------
>>  drivers/mmc/host/dw_mmc-pltfm.c    | 28 +++++++----------------
>>  drivers/mmc/host/dw_mmc-rockchip.c | 42 +++++++++++++++++++++++++++++++---
>>  drivers/mmc/host/dw_mmc.c          | 46 +++++++++++++++++++++++++-------------
>>  drivers/mmc/host/dw_mmc.h          |  6 ++---
>>  include/linux/mmc/slot-gpio.h      |  1 +
>>  9 files changed, 117 insertions(+), 106 deletions(-)
>>
> 
> Overall these changes looks good to me, so I am ready to accept the PR
> from Jaehoon!!
> 

Yes..I will apply on my repository..i'm testing on dwmmc-testing branch..
Actually, i found the some blocking issue but it's not relevant to these patches.
after checking the stress test until today..(eMMC/SD/SDIO)..I will do.

Entire patches looks good to me..thanks for Shawn's effort! :)

> 
> Although, highly related to this patchset, I am worried that there is
> a misunderstanding on how MMC_PM_KEEP_POWER (DT binding
> "keep-power-in-suspend") is being used for dw_mmc. Perhaps I am wrong,
> but I would appreciate if you could elaborate a bit for my
> understanding.
> 
> First, this cap is solely intended to be used for controllers which
> may have SDIO cards attached, as it indicates those cards may be
> configured to be powered on while the system enters suspend state. By
> looking at some DTS files, for example
> arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts which uses it
> for an eMMC slot, this is clearly being abused.

Right..it doesn't need to uses "keep-power-in-suspend" for eMMC/SD.

> 
> Anyway, the wrong DT configurations might not be a big deal, as in
> dw_mci_resume(), it's not the capabilities bit that is checked but the
> corresponding "pm_flag". This flag is set via calling
> sdio_set_host_pm_flags(), but as that doesn't happen for an eMMC card
> we should be fine, right!?
> 
> Now, what also do puzzles me, is exactly that piece of code in
> dw_mci_resume() that is being executed *when* the pm_flag contains
> MMC_PM_KEEP_POWER:
> if (slot->mmc->pm_flags & MMC_PM_KEEP_POWER) {
>      dw_mci_set_ios(slot->mmc, &slot->mmc->ios);
>      dw_mci_setup_bus(slot, true);
> }

There is no place to set this in dw_mmc controller..Maybe it should be located in other vendor driver.
Almost all cards that used SDIO might be WiFi..Of course..there might be other cards.
e.g) In exnyos, use the sdio as WiFi card(broadcom chipset) then broadcom driver also used..
When broadcom driver initialized or suspending time, it should be set to this flag..
As i mentioned..it's not normal case.

> 
> So, in the system resume path, the above do makes sense as you need to
> restore the registers etc for the dw_mmc controller to enable it to
> operate the SDIO card. Such as bus width, clocks, etc.
> 
> Although, I would expect something similar would be needed in the new
> runtime resume path as well. And in particular also for eMMC/SD cards,
> as you need to restore the dw_mmc registers to be able to operate the
> card again. Don't you?

Need to check :)

> 
> So in the end, perhaps you should *always* call dw_mci_set_ios() and
> dw_mci_setup_bus() in dw_mci_resume() instead of conditionally check
> for MMC_PM_KEEP_POWER? Or maybe only a subset of those functions?

It's reasonable..but it also needs to check on real case and stress test.

Best Regards,
Jaehoon Chung

> 
> Kind regards
> Uffe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 

