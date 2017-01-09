From: Ziyuan <xzy.xu@rock-chips.com>
Subject: Re: [PATCH v4] mmc: dw_mmc: force setup bus if active slots exist
Date: Mon, 9 Jan 2017 11:39:17 +0800
Message-ID: <587305E5.30003@rock-chips.com>
References: <1483601012-18241-1-git-send-email-xzy.xu@rock-chips.com>
 <49544a65-9b3c-c56a-e5f7-89c5fa6e6cd0@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.133]:50239 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933629AbdAIDjZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 8 Jan 2017 22:39:25 -0500
In-Reply-To: <49544a65-9b3c-c56a-e5f7-89c5fa6e6cd0@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, ulf.hansson@linaro.org, jh80.chung@samsung.com
Cc: randy.li@rock-chips.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org



On 01/05/2017 03:34 PM, Shawn Lin wrote:
> On 2017/1/5 15:23, Ziyuan Xu wrote:
>> It's necessary to setup bus if any slots are present.
>> - update clock after ctrl reset
>> - if the host has genpd node, we can guarantee the clock is available
>> before starting request. Otherwies, the clock register is reset once
>> power off the pd, and host can't output the active clock during
>> communication.
>>
>> fixes: e9ed8835e990 ("mmc: dw_mmc: add runtime PM callback")
>> Reported-by: Randy Li <randy.li@rock-chips.com>
>> Signed-off-by: Ziyuan Xu <xzy.xu@rock-chips.com>
>>
>> ---
>> Hi guys,
>>
>> I found a similar issue on rk3399 platform, which has a genpd node for
>> SD card host. Power off-on pd will reset the registers to a default
>> value (ie. CLKENA), so that the host can't output the active clock
>> during communication.
>>
>
> Indeed, Caesar recently introduced all the genpd for rk3399 platform,
> so we need to restore them.
>
>> So we need to setup bus in rpm resume. It also wraps the update clock
>> behaviour which I did in V3.
>>
>> Thanks,
>> Ziyuan Xu
>>
>>
>> Changes in v4:
>> - update commit message
>> - fix SD host rpm resume can't work
>>
>> Changes in v3:
>> - only reset host with active slot.
>>
>> Changes in v2:
>> - update the commit message
>> - use dw_mci_reset instead of dw_mci_ctrl_reset
>>
>>  drivers/mmc/host/dw_mmc.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index b44306b..b6053b3 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -3354,10 +3354,10 @@ int dw_mci_runtime_resume(struct device *dev)
>>
>>          if (!slot)
>>              continue;
>> -        if (slot->mmc->pm_flags & MMC_PM_KEEP_POWER) {
>> +        if (slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
>>              dw_mci_set_ios(slot->mmc, &slot->mmc->ios);
>> -            dw_mci_setup_bus(slot, true);
>> -        }
>> +        /* Force setup bus to guarantee available clock output */
>> +        dw_mci_setup_bus(slot, true);
>
> So the spamming message about
>
> "Bus speed (slot %d) = %dHz (slot req %dHz, actual %dHZ div = %d)\n"
>
> will always be there, right? So you could append a new patch to shut
> up it as I think it's useless no matter for system pm or rpm to print
> it.  How about?

Fine, it's favourable with dev_vdbg if the dw_mmc rpm is enabled.
Hi Jaehoon,
What's your opinion? If you think this patch and shawn's advice are 
acceptable, I will send the v5 patch.

BR
Ziyuan Xu

>
>>      }
>>
>>      /* Now that slots are all setup, we can enable card detect */
>>
>
>


