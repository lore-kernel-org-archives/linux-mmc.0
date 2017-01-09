From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v4] mmc: dw_mmc: force setup bus if active slots exist
Date: Mon, 9 Jan 2017 14:40:10 +0800
Message-ID: <ba42b6c0-067a-ea3d-8330-c2b6ee7a9c36@rock-chips.com>
References: <1483601012-18241-1-git-send-email-xzy.xu@rock-chips.com>
 <49544a65-9b3c-c56a-e5f7-89c5fa6e6cd0@rock-chips.com>
 <CGME20170109033926epcas4p3d4ad93f61a96f2c8d5ff5405bb3fc9cc@epcas4p3.samsung.com>
 <587305E5.30003@rock-chips.com>
 <7c41a01e-ded2-9c03-78d9-c0b75984bf20@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <7c41a01e-ded2-9c03-78d9-c0b75984bf20-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ziyuan <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, randy.li-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 2017/1/9 13:41, Jaehoon Chung wrote:
> On 01/09/2017 12:39 PM, Ziyuan wrote:
>>
>>
>> On 01/05/2017 03:34 PM, Shawn Lin wrote:
>>> On 2017/1/5 15:23, Ziyuan Xu wrote:
>>>> It's necessary to setup bus if any slots are present.
>>>> - update clock after ctrl reset
>>>> - if the host has genpd node, we can guarantee the clock is available
>>>> before starting request. Otherwies, the clock register is reset once
>>>> power off the pd, and host can't output the active clock during
>>>> communication.
>>>>
>>>> fixes: e9ed8835e990 ("mmc: dw_mmc: add runtime PM callback")
>>>> Reported-by: Randy Li <randy.li-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>>>> Signed-off-by: Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>>>>
>>>> ---
>>>> Hi guys,
>>>>
>>>> I found a similar issue on rk3399 platform, which has a genpd node for
>>>> SD card host. Power off-on pd will reset the registers to a default
>>>> value (ie. CLKENA), so that the host can't output the active clock
>>>> during communication.
>>>>
>>>
>>> Indeed, Caesar recently introduced all the genpd for rk3399 platform,
>>> so we need to restore them.
>>>
>>>> So we need to setup bus in rpm resume. It also wraps the update clock
>>>> behaviour which I did in V3.
>>>>
>>>> Thanks,
>>>> Ziyuan Xu
>>>>
>>>>
>>>> Changes in v4:
>>>> - update commit message
>>>> - fix SD host rpm resume can't work
>>>>
>>>> Changes in v3:
>>>> - only reset host with active slot.
>>>>
>>>> Changes in v2:
>>>> - update the commit message
>>>> - use dw_mci_reset instead of dw_mci_ctrl_reset
>>>>
>>>>  drivers/mmc/host/dw_mmc.c | 6 +++---
>>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>>> index b44306b..b6053b3 100644
>>>> --- a/drivers/mmc/host/dw_mmc.c
>>>> +++ b/drivers/mmc/host/dw_mmc.c
>>>> @@ -3354,10 +3354,10 @@ int dw_mci_runtime_resume(struct device *dev)
>>>>
>>>>          if (!slot)
>>>>              continue;
>>>> -        if (slot->mmc->pm_flags & MMC_PM_KEEP_POWER) {
>>>> +        if (slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
>>>>              dw_mci_set_ios(slot->mmc, &slot->mmc->ios);
>>>> -            dw_mci_setup_bus(slot, true);
>>>> -        }
>>>> +        /* Force setup bus to guarantee available clock output */
>>>> +        dw_mci_setup_bus(slot, true);
>>>
>>> So the spamming message about
>>>
>>> "Bus speed (slot %d) = %dHz (slot req %dHz, actual %dHZ div = %d)\n"
>>>
>>> will always be there, right? So you could append a new patch to shut
>>> up it as I think it's useless no matter for system pm or rpm to print
>>> it.  How about?
>>
>> Fine, it's favourable with dev_vdbg if the dw_mmc rpm is enabled.
>> Hi Jaehoon,
>> What's your opinion? If you think this patch and shawn's advice are acceptable, I will send the v5 patch.
>
> I don't agreed to use dev_vdbg()..but it needs not to display at everytime.
> Hmm..It needs to consider more..because we needs to see the clock value when it's initialized.
>

A very stright-forward way is to pass a flag to shut up the spamming
log when it's called from the PM context?

> Best Regards,
> Jaehoon Chung
>
>>
>> BR
>> Ziyuan Xu
>>
>>>
>>>>      }
>>>>
>>>>      /* Now that slots are all setup, we can enable card detect */
>>>>
>>>
>>>
>>
>>
>>
>>
>>
>
>
>
>


-- 
Best Regards
Shawn Lin
