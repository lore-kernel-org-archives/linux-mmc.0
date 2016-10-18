From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2 0/9] Init runtime PM support for dw_mmc
Date: Tue, 18 Oct 2016 19:35:31 +0800
Message-ID: <5be33ac5-7b5e-4b53-67bf-1c38822832ea@rock-chips.com>
References: <1476240643-5701-1-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKFopNgWh=+0RNFwJc+aaFPXGuJMAac5rPtfOawvLwSbN+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:44116 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753095AbcJRLgI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Oct 2016 07:36:08 -0400
In-Reply-To: <CAPDyKFopNgWh=+0RNFwJc+aaFPXGuJMAac5rPtfOawvLwSbN+g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Doug Anderson <dianders@chromium.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Heiko Stuebner <heiko@sntech.de>

在 2016/10/18 16:46, Ulf Hansson 写道:
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

Indeed. In general, it should be copy-paste issues as folks maybe write
their dts referring to the exist dts there. So yes, I will do some 
cleanup work for them in prevent of further spread of abused code.

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
>
> So, in the system resume path, the above do makes sense as you need to
> restore the registers etc for the dw_mmc controller to enable it to
> operate the SDIO card. Such as bus width, clocks, etc.
>
> Although, I would expect something similar would be needed in the new
> runtime resume path as well. And in particular also for eMMC/SD cards,
> as you need to restore the dw_mmc registers to be able to operate the
> card again. Don't you?

yes, we do.

>
> So in the end, perhaps you should *always* call dw_mci_set_ios() and
> dw_mci_setup_bus() in dw_mci_resume() instead of conditionally check
> for MMC_PM_KEEP_POWER? Or maybe only a subset of those functions?
>

Thanks for noticing this.

Personally, I realize there is no need to check MMC_PM_KEEP_POWER but
it could be highly related to the cost of S-2-R, I guess. I just checked
sdhci and saw the similar cases you mentioned at the first glance.
Maybe I'm wrong but I need more time to investigate this issue later.

There are still some on-going cleanup work for dw_mmc listed on my TODO
list, including bugfix, legacy/redundant code etc.. So I will check this 
one either. Maybe Jaehoon could also do some stree test on enxyos
platforms. :)


> Kind regards
> Uffe
>
>
>


-- 
Best Regards
Shawn Lin

