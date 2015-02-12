From: addy ke <addy.ke@rock-chips.com>
Subject: Re: [PATCH v2 1/2] mmc: dw_mmc: fix bug that cause 'Timeout sending
 command'
Date: Thu, 12 Feb 2015 10:28:11 +0800
Message-ID: <54DC0FBB.7010308@rock-chips.com>
References: <1423134801-23219-1-git-send-email-addy.ke@rock-chips.com> <1423466726-20833-1-git-send-email-addy.ke@rock-chips.com> <1423466726-20833-2-git-send-email-addy.ke@rock-chips.com> <CAGOxZ51wgw9iXF3xX39vnB0M5ZPb+zHWoCtTvvKdyo9bSOCVgw@mail.gmail.com> <54DAC534.4020708@rock-chips.com> <54DB43E2.70203@samsung.com> <CAGOxZ50CLM1Job+X45-CDF_23r9vsx0=jtMCu5cSoFk-+xzF=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.138]:47756 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457AbbBLC21 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Feb 2015 21:28:27 -0500
In-Reply-To: <CAGOxZ50CLM1Job+X45-CDF_23r9vsx0=jtMCu5cSoFk-+xzF=g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: alim.akhtar@gmail.com, a.hajda@samsung.com
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rdunlap@infradead.org, tgih.jun@samsung.com, jh80.chung@samsung.com, chris@printf.net, ulf.hansson@linaro.org, dinguyen@altera.com, heiko@sntech.de, olof@lixom.net, dianders@chromium.org, sonnyrao@chromium.org, amstan@chromium.org, djkurtz@chromium.org, huangtao@rock-chips.com, devicetree@vger.kernel.org, hl@rock-chips.com, linux-doc@vger.kernel.org, yzq@rock-chips.com, zyw@rock-chips.com, zhangqing@rock-chips.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, kever.yang@rock-chips.com

Hi Andrzej and Alim

On 2015/2/12 07:20, Alim Akhtar wrote:
> Hi Andrzej,
> 
> On Wed, Feb 11, 2015 at 5:28 PM, Andrzej Hajda <a.hajda@samsung.com> wrote:
>> Hi Alim,
>>
>> On 02/11/2015 03:57 AM, Addy wrote:
>>>
>>> On 2015/02/10 23:22, Alim Akhtar wrote:
>>>> Hi Addy,
>>>>
>>>> On Mon, Feb 9, 2015 at 12:55 PM, Addy Ke <addy.ke@rock-chips.com> wrote:
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
>>>>> @@ -888,6 +889,31 @@ static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg)
>>>>>                  cmd, arg, cmd_status);
>>>>>   }
>>>>>
>>>>> +static void dw_mci_wait_busy(struct dw_mci_slot *slot)
>>>>> +{
>>>>> +       struct dw_mci *host = slot->host;
>>>>> +       unsigned long timeout = jiffies + msecs_to_jiffies(500);
>>>>> +
>>>> Why 500 msec?
>>> This timeout value is the same as  mci_send_cmd:
>>> static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg)
>>> {
>>>          struct dw_mci *host = slot->host;
>>>          unsigned long timeout = jiffies + msecs_to_jiffies(500);
>>>          ....
>>> }
>>>
>>> I have not clear that which is suitable.
>>> Do you have any suggestion on it?
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
>>>>> +        * Data busy, this should not happend when mmc controller send command
>>>>> +        * to update card clocks in non-volt-switch state. If it happends, we
>>>>> +        * should reset controller to avoid getting "Timeout sending command".
>>>>> +        */
>>>>> +       dw_mci_ctrl_reset(host, SDMMC_CTRL_ALL_RESET_FLAGS);
>>>>> +
>>>> Why you need to reset all blocks? may be CTRL_RESET is good enough here.
>>> I have tested on rk3288, if only reset ctroller, data busy bit will not
>>> be cleaned,and we will still get
>>>
>>> "Timeout sending command".
>>>
>>>>
>>>>> +       /* Fail to reset controller or still data busy, WARN_ON! */
>>>>> +       WARN_ON(dw_mci_card_busy(slot->mmc));
>>>>> +}
>>>>> +
>>>>>   static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
>>>>>   {
>>>>>          struct dw_mci *host = slot->host;
>>>>> @@ -899,6 +925,8 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
>>>>>          /* We must continue to set bit 28 in CMD until the change is complete */
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
>>> I think this patch is more reasonable.
>>> So I will resend patches based on this patch.
>>> thank you!
>>
>> I have tested your patches instead [1] above and they do not solve my issue:
>> Board: odroid-xu3/exynos5422/dw_mmc_250a.
>> MMC card: absent, broken-cd quirk
>> SD card: present
>>
> I doubt $SUBJECT patch in current form can resolve you issue. I have
> already given comments on $subject patch.
> 
> Can you try out below patch (I have not tested yet) on top of $SUBJECT patch?
> 
> =======
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index b0b57e3..ea87844 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -101,6 +101,7 @@ struct idmac_desc {
>  #endif /* CONFIG_MMC_DW_IDMAC */
> 
>  static int dw_mci_card_busy(struct mmc_host *mmc);
> +static void dw_mci_wait_busy(struct dw_mci_slot *slot);
>  static bool dw_mci_reset(struct dw_mci *host);
>  static bool dw_mci_ctrl_reset(struct dw_mci *host, u32 reset);
> 
> @@ -874,16 +875,22 @@ static void mci_send_cmd(struct dw_mci_slot
> *slot, u32 cmd, u32 arg)
>         struct dw_mci *host = slot->host;
>         unsigned long timeout = jiffies + msecs_to_jiffies(500);
>         unsigned int cmd_status = 0;
> +       int re_try = 3; /* just random for now, 1 re-try should be ok */
> 
> -       mci_writel(host, CMDARG, arg);
> -       wmb();
> -       mci_writel(host, CMD, SDMMC_CMD_START | cmd);
> +       while(re_try--) {
> +               mci_writel(host, CMDARG, arg);
> +               wmb();
> +               mci_writel(host, CMD, SDMMC_CMD_START | cmd);
> 
> -       while (time_before(jiffies, timeout)) {
> -               cmd_status = mci_readl(host, CMD);
> -               if (!(cmd_status & SDMMC_CMD_START))
> -                       return;
> +               while (time_before(jiffies, timeout)) {
> +                       cmd_status = mci_readl(host, CMD);
> +                       if (!(cmd_status & SDMMC_CMD_START))
> +                               return;
> +               }
> +
> +               dw_mci_wait_busy(slot);
>         }
> +
>         dev_err(&slot->mmc->class_dev,
>                 "Timeout sending command (cmd %#x arg %#x status %#x)\n",
>                 cmd, arg, cmd_status);
> @@ -925,8 +932,6 @@ static void dw_mci_setup_bus(struct dw_mci_slot
> *slot, bool force_clkinit)
>         /* We must continue to set bit 28 in CMD until the change is complete */
>         if (host->state == STATE_WAITING_CMD11_DONE)
>                 sdmmc_cmd_bits |= SDMMC_CMD_VOLT_SWITCH;
> -       else
> -               dw_mci_wait_busy(slot);
> 
>         if (!clock) {
>                 mci_writel(host, CLKENA, 0);
> 
> ===== end ======
The reason why we are fail to send command is that we got data busy in
none-switch-volt state(host->state != STATE_WAITING_CMD11_DONE).
So:
if(host->state != STATE_WAITING_CMD11_DONE), we must wait until data not busy,
And if (host->state == STATE_WAITING_CMD11_DONE) we should not wait.

>> System hangs during boot after few minutes kernel spits:
>> [  242.188098] INFO: task kworker/u16:1:50 blocked for more than 120
>> seconds.
>> [  242.193524]       Not tainted
>> 3.19.0-next-20150210-00002-gf96831b-dirty #3834
>> [  242.200622] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>> disables this message.
>> [  242.208422] kworker/u16:1   D c04766ac     0    50      2 0x00000000
>> [  242.214756] Workqueue: kmmcd mmc_rescan
>> [  242.218553] [<c04766ac>] (__schedule) from [<c0476a58>]
>> (schedule+0x34/0x98)
>> [  242.225591] [<c0476a58>] (schedule) from [<c047a4dc>]
>> (schedule_timeout+0x110/0x164)
>> [  242.233302] [<c047a4dc>] (schedule_timeout) from [<c04774f0>]
>> (wait_for_common+0xb8/0x14c)
>> [  242.241539] [<c04774f0>] (wait_for_common) from [<c0362138>]
>> (mmc_wait_for_req+0x68/0x17c)
>> [  242.249861] [<c0362138>] (mmc_wait_for_req) from [<c03622cc>]
>> (mmc_wait_for_cmd+0x80/0xa0)
>> [  242.258002] [<c03622cc>] (mmc_wait_for_cmd) from [<c0367e50>]
>> (mmc_go_idle+0x78/0xf8)
>> [  242.265796] [<c0367e50>] (mmc_go_idle) from [<c0363e2c>]
>> (mmc_rescan+0x280/0x314)
>> [  242.273253] [<c0363e2c>] (mmc_rescan) from [<c0034764>]
>> (process_one_work+0x120/0x324)
>> [  242.281135] [<c0034764>] (process_one_work) from [<c00349cc>]
>> (worker_thread+0x30/0x42c)
>> [  242.289194] [<c00349cc>] (worker_thread) from [<c003926c>]
>> (kthread+0xd8/0xf4)
>> [  242.296389] [<c003926c>] (kthread) from [<c000e7c0>]
>> (ret_from_fork+0x14/0x34)
>>
>> Just for record, Exynos4412/dw_mmc_240a with the same configuration
>> (no MMC card, broken-cd) works OK without patches.
This is because mmc start command,but mmc_request_done() is't called.
I have ever found this issue.
I found that host does't get DTO interrupt when mmc send command to read data.
I have sent a patch for it, see:
https://patchwork.kernel.org/patch/5426531/

Would you please merge it and test again?
>>
>>
>> Regards
>> Andrzej
>>
>>>>
>>>>>          if (!clock) {
>>>>>                  mci_writel(host, CLKENA, 0);
>>>>> --
>>>>> 1.8.3.2
>>>>>
>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> linux-arm-kernel mailing list
>>>>> linux-arm-kernel@lists.infradead.org
>>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>>
>>>>
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-doc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
> 
> 
> 

