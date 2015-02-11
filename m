From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/2] mmc: dw_mmc: fix bug that cause 'Timeout sending command'
Date: Wed, 11 Feb 2015 04:52:46 +0100
Message-ID: <CAPDyKFoKvtjvWBEAt9c7jRKoHrZQT27_W6XTy9nTYhJVDjSEww@mail.gmail.com>
References: <1423134801-23219-1-git-send-email-addy.ke@rock-chips.com>
	<1423466726-20833-1-git-send-email-addy.ke@rock-chips.com>
	<1423466726-20833-2-git-send-email-addy.ke@rock-chips.com>
	<CAGOxZ51wgw9iXF3xX39vnB0M5ZPb+zHWoCtTvvKdyo9bSOCVgw@mail.gmail.com>
	<54DAC534.4020708@rock-chips.com>
	<CAPDyKFpgjCBnY=8Ca3ZQ0jmoE_7iwPOwwR5Cz3NiNrh+z0RWng@mail.gmail.com>
	<54DAD0A6.7060204@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:41856 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805AbbBKDwr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Feb 2015 22:52:47 -0500
Received: by mail-qg0-f46.google.com with SMTP id z107so907988qgd.5
        for <linux-mmc@vger.kernel.org>; Tue, 10 Feb 2015 19:52:46 -0800 (PST)
In-Reply-To: <54DAD0A6.7060204@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Addy <addy.ke@rock-chips.com>, Alim Akhtar <alim.akhtar@gmail.com>, Seungwon Jeon <tgih.jun@samsung.com>, Chris Ball <chris@printf.net>, Olof Johansson <olof@lixom.net>, Douglas Anderson <dianders@chromium.org>, Sonny Rao <sonnyrao@chromium.org>, Alexandru Stan <amstan@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 11 February 2015 at 04:46, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Dear, Ulf.
>
> On 02/11/2015 12:25 PM, Ulf Hansson wrote:
>> On 11 February 2015 at 03:57, Addy <addy.ke@rock-chips.com> wrote:
>>>
>>> On 2015/02/10 23:22, Alim Akhtar wrote:
>>>>
>>>> Hi Addy,
>>>>
>>>> On Mon, Feb 9, 2015 at 12:55 PM, Addy Ke <addy.ke@rock-chips.com> wrote:
>>>>>
>>>>> Because of some uncertain factors, such as worse card or worse hardware,
>>>>> DAT[3:0](the data lines) may be pulled down by card, and mmc controller
>>>>> will be in busy state. This should not happend when mmc controller
>>>>> send command to update card clocks. If this happends, mci_send_cmd will
>>>>> be failed and we will get 'Timeout sending command', and then system will
>>>>> be blocked. To avoid this, we need reset mmc controller.
>>>>>
>>>>> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
>>>>> ---
>>>>>   drivers/mmc/host/dw_mmc.c | 28 ++++++++++++++++++++++++++++
>>>>>   1 file changed, 28 insertions(+)
>>>>>
>>>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>>>> index 4d2e3c2..b0b57e3 100644
>>>>> --- a/drivers/mmc/host/dw_mmc.c
>>>>> +++ b/drivers/mmc/host/dw_mmc.c
>>>>> @@ -100,6 +100,7 @@ struct idmac_desc {
>>>>>   };
>>>>>   #endif /* CONFIG_MMC_DW_IDMAC */
>>>>>
>>>>> +static int dw_mci_card_busy(struct mmc_host *mmc);
>>>>>   static bool dw_mci_reset(struct dw_mci *host);
>>>>>   static bool dw_mci_ctrl_reset(struct dw_mci *host, u32 reset);
>>>>>
>>>>> @@ -888,6 +889,31 @@ static void mci_send_cmd(struct dw_mci_slot *slot,
>>>>> u32 cmd, u32 arg)
>>>>>                  cmd, arg, cmd_status);
>>>>>   }
>>>>>
>>>>> +static void dw_mci_wait_busy(struct dw_mci_slot *slot)
>>>>> +{
>>>>> +       struct dw_mci *host = slot->host;
>>>>> +       unsigned long timeout = jiffies + msecs_to_jiffies(500);
>>>>> +
>>>>
>>>> Why 500 msec?
>>>
>>> This timeout value is the same as  mci_send_cmd:
>>> static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg)
>>> {
>>>         struct dw_mci *host = slot->host;
>>>         unsigned long timeout = jiffies + msecs_to_jiffies(500);
>>>         ....
>>> }
>>>
>>> I have not clear that which is suitable.
>>> Do you have any suggestion on it?
>>>>
>>>>
>>>>> +       do {
>>>>> +               if (!dw_mci_card_busy(slot->mmc))
>>>>> +                       return;
>>>>> +               cpu_relax();
>>>>> +       } while (time_before(jiffies, timeout));
>>>>> +
>>>>> +       dev_err(host->dev, "Data busy (status %#x)\n",
>>>>> +               mci_readl(slot->host, STATUS));
>>>>> +
>>>>> +       /*
>>>>> +        * Data busy, this should not happend when mmc controller send
>>>>> command
>>>>> +        * to update card clocks in non-volt-switch state. If it
>>>>> happends, we
>>>>> +        * should reset controller to avoid getting "Timeout sending
>>>>> command".
>>>>> +        */
>>>>> +       dw_mci_ctrl_reset(host, SDMMC_CTRL_ALL_RESET_FLAGS);
>>>>> +
>>>>
>>>> Why you need to reset all blocks? may be CTRL_RESET is good enough here.
>>>
>>> I have tested on rk3288, if only reset ctroller, data busy bit will not be
>>> cleaned,and we will still get
>>>
>>> "Timeout sending command".
>>>
>>>>
>>>>> +       /* Fail to reset controller or still data busy, WARN_ON! */
>>>>> +       WARN_ON(dw_mci_card_busy(slot->mmc));
>>>>> +}
>>>>> +
>>>>>   static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool
>>>>> force_clkinit)
>>>>>   {
>>>>>          struct dw_mci *host = slot->host;
>>>>> @@ -899,6 +925,8 @@ static void dw_mci_setup_bus(struct dw_mci_slot
>>>>> *slot, bool force_clkinit)
>>>>>          /* We must continue to set bit 28 in CMD until the change is
>>>>> complete */
>>>>>          if (host->state == STATE_WAITING_CMD11_DONE)
>>>>>                  sdmmc_cmd_bits |= SDMMC_CMD_VOLT_SWITCH;
>>>>> +       else
>>>>> +               dw_mci_wait_busy(slot);
>>>>>
>>>> hmm...I would suggest you to call dw_mci_wait_busy() from inside
>>>> mci_send_cmd(), seems like dw_mmc hangs while sending update clock cmd
>>>> in multiple cases.see [1]
>>>>
>>>> [1]: http://permalink.gmane.org/gmane.linux.kernel.mmc/31140
>>>
>>> I think this patch is more reasonable.
>>> So I will resend patches based on this patch.
>>> thank you!
>>
>> Addy, Jaehoon,
>>
>> It would simply things if I could get pull requests for patches of
>> dw_mmc. It's currently a bit hard to keep track and follow the
>> progress all the time.
>> Anyone volunteering in helping out here? :-)
>
> If you are ok, i will do it..

Great! Much appreciated!

Don't hesitate to send several PR during a release cycle.

Kind regards
Uffe
