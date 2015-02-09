From: addy ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH] mmc: dw_mmc: fix bug that cause 'Timeout sending command'
Date: Mon, 09 Feb 2015 17:17:52 +0800
Message-ID: <54D87B40.4000000@rock-chips.com>
References: <1423134801-23219-1-git-send-email-addy.ke@rock-chips.com> <CAPDyKFpxYcRu1s8jwtoV5SVCANwX90yEYxED+w45eVuwZJUGEQ@mail.gmail.com> <54D85A2F.1090301@rock-chips.com> <54D85C15.8010007@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54D85C15.8010007-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org, dinguyen-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, amstan-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, zhenfu.fang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org, lintao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, chenfen-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zyf-TNX95d0MmH7DzftRWevZcw@public.gmane.org, xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org, yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org, kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org



On 2015/2/9 15:04, Jaehoon Chung wrote:
> On 02/09/2015 03:56 PM, Addy wrote:
>>
>>
>> On 2015.02.09 12:51, Ulf Hansson wrote:
>>> On 5 February 2015 at 12:13, Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
>>>> Because of some uncertain factors, such as worse card or worse hardware,
>>>> DAT[3:0](the data lines) may be pulled down by card, and mmc controller
>>>> will be in busy state. This should not happend when mmc controller
>>>> send command to update card clocks. If this happends, mci_send_cmd will
>>>> be failed and we will get 'Timeout sending command', and then system will
>>>> be blocked. To avoid this, we need reset mmc controller.
> 
> I know that it needs to check whether card is busy or not, before clock-off.
> This patch seems to related with it. right?

Yes, it is.

> 
> Best Regards,
> Jaehoon Chung
> 
>>>>
>>>> Signed-off-by: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>>>
>>> Hi Addy,
>>>
>>> Should I consider $subject patch as a better option to the one below?
>> No:
>> This patch fix the bug, which can be found by script:
>>     cd /sys/bus/platform/drivers/dwmmc_rockchip
>>     for i in $(seq 1 10000); do
>>       echo "========================" $i
>>       echo ff0c0000.dwmmc > unbind
>>       sleep .5
>>       echo ff0c0000.dwmmc > bind
>>       sleep 2
>>     done
>>
>>> [PATCH] mmc: dw_mmc: rockchip: Add DW_MCI_QUIRK_RETRY_DELAY
>> This patch is for tuning issue: we should delay until card go to idle state, when the previous command return error.
>>> https://lkml.org/lkml/2015/1/13/562
>>>
>>> Kind regards
>>> Uffe
>>>
>>>
>>>> ---
>>>>   drivers/mmc/host/dw_mmc.c | 23 +++++++++++++++++++++++
>>>>   1 file changed, 23 insertions(+)
>>>>
>>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>>> index 4d2e3c2..b1d6dfb 100644
>>>> --- a/drivers/mmc/host/dw_mmc.c
>>>> +++ b/drivers/mmc/host/dw_mmc.c
>>>> @@ -100,6 +100,7 @@ struct idmac_desc {
>>>>   };
>>>>   #endif /* CONFIG_MMC_DW_IDMAC */
>>>>
>>>> +static int dw_mci_card_busy(struct mmc_host *mmc);
>>>>   static bool dw_mci_reset(struct dw_mci *host);
>>>>   static bool dw_mci_ctrl_reset(struct dw_mci *host, u32 reset);
>>>>
>>>> @@ -888,6 +889,26 @@ static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg)
>>>>                  cmd, arg, cmd_status);
>>>>   }
>>>>
>>>> +static void dw_mci_wait_busy(struct dw_mci_slot *slot)
>>>> +{
>>>> +       struct dw_mci *host = slot->host;
>>>> +       unsigned long timeout = jiffies + msecs_to_jiffies(500);
>>>> +
>>>> +       while (time_before(jiffies, timeout)) {
>>>> +               if (!dw_mci_card_busy(slot->mmc))
>>>> +                       return;
>>>> +       }
>>>> +       dev_err(host->dev, "Data busy (status %#x)\n",
>>>> +               mci_readl(slot->host, STATUS));
>>>> +
>>>> +       /*
>>>> +        * Data busy, this should not happend when mmc controller send command
>>>> +        * to update card clocks in non-volt-switch state. If it happends, we
>>>> +        * should reset controller to avoid getting "Timeout sending command".
>>>> +        */
>>>> +       dw_mci_ctrl_reset(host, SDMMC_CTRL_ALL_RESET_FLAGS);
>>>> +}
>>>> +
>>>>   static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
>>>>   {
>>>>          struct dw_mci *host = slot->host;
>>>> @@ -899,6 +920,8 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
>>>>          /* We must continue to set bit 28 in CMD until the change is complete */
>>>>          if (host->state == STATE_WAITING_CMD11_DONE)
>>>>                  sdmmc_cmd_bits |= SDMMC_CMD_VOLT_SWITCH;
>>>> +       else
>>>> +               dw_mci_wait_busy(slot);
>>>>
>>>>          if (!clock) {
>>>>                  mci_writel(host, CLKENA, 0);
>>>> -- 
>>>> 1.8.3.2
>>>>
>>>>
>>>> -- 
>>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>
>>
>>
> 
> 
> 
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
