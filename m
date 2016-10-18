From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2 0/9] Init runtime PM support for dw_mmc
Date: Tue, 18 Oct 2016 09:04:34 +0800
Message-ID: <d56e8605-1b8d-9791-a742-af1f2fad4995@rock-chips.com>
References: <CGME20161012024453epcas1p1bdc2c6bd18d864b5535bd2b067b491af@epcas1p1.samsung.com>
 <1476240643-5701-1-git-send-email-shawn.lin@rock-chips.com>
 <488999ee-acf5-47bd-3ebd-707899224749@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:55608 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933462AbcJRBEw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Oct 2016 21:04:52 -0400
In-Reply-To: <488999ee-acf5-47bd-3ebd-707899224749@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org, Doug Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org

Hi Jaehoon,

On 2016/10/18 8:24, Jaehoon Chung wrote:
> Hi Shawn,
>
> On 10/12/2016 11:50 AM, Shawn Lin wrote:
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
> I have tested with my boards..it's working fine..I will apply on this if there is no special issue.

Great to hear this. The test for this patchset have been running for a
while on my rk3288/3368 boards and it seems no failures were found
until now.

Thanks!

>
> Thanks!
>
> Best Regards,
> Jaehoon Chung
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
>
>
>


-- 
Best Regards
Shawn Lin

