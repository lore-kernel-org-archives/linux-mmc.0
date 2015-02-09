From: Addy <addy.ke@rock-chips.com>
Subject: Re: [PATCH] mmc: dw_mmc: fix bug that cause 'Timeout sending command'
Date: Mon, 09 Feb 2015 14:56:47 +0800
Message-ID: <54D85A2F.1090301@rock-chips.com>
References: <1423134801-23219-1-git-send-email-addy.ke@rock-chips.com> <CAPDyKFpxYcRu1s8jwtoV5SVCANwX90yEYxED+w45eVuwZJUGEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.130]:60814 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753238AbbBIG5G (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Feb 2015 01:57:06 -0500
In-Reply-To: <CAPDyKFpxYcRu1s8jwtoV5SVCANwX90yEYxED+w45eVuwZJUGEQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, =?UTF-8?B?UGF3ZcWCIE1vbGw=?= <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Randy Dunlap <rdunlap@infradead.org>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>, Dinh Nguyen <dinguyen@altera.com>, =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, Olof Johansson <olof@lixom.net>, Doug Anderson <dianders@chromium.org>, Sonny Rao <sonnyrao@chromium.org>, Alexandru Stan <amstan@chromium.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.inf>



On 2015.02.09 12:51, Ulf Hansson wrote:
> On 5 February 2015 at 12:13, Addy Ke <addy.ke@rock-chips.com> wrote:
>> Because of some uncertain factors, such as worse card or worse hardware,
>> DAT[3:0](the data lines) may be pulled down by card, and mmc controller
>> will be in busy state. This should not happend when mmc controller
>> send command to update card clocks. If this happends, mci_send_cmd will
>> be failed and we will get 'Timeout sending command', and then system will
>> be blocked. To avoid this, we need reset mmc controller.
>>
>> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
>
> Hi Addy,
>
> Should I consider $subject patch as a better option to the one below?
No:
This patch fix the bug, which can be found by script:
     cd /sys/bus/platform/drivers/dwmmc_rockchip
     for i in $(seq 1 10000); do
       echo "========================" $i
       echo ff0c0000.dwmmc > unbind
       sleep .5
       echo ff0c0000.dwmmc > bind
       sleep 2
     done

> [PATCH] mmc: dw_mmc: rockchip: Add DW_MCI_QUIRK_RETRY_DELAY
This patch is for tuning issue: we should delay until card go to idle 
state, when the previous command return error.
> https://lkml.org/lkml/2015/1/13/562
>
> Kind regards
> Uffe
>
>
>> ---
>>   drivers/mmc/host/dw_mmc.c | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 4d2e3c2..b1d6dfb 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -100,6 +100,7 @@ struct idmac_desc {
>>   };
>>   #endif /* CONFIG_MMC_DW_IDMAC */
>>
>> +static int dw_mci_card_busy(struct mmc_host *mmc);
>>   static bool dw_mci_reset(struct dw_mci *host);
>>   static bool dw_mci_ctrl_reset(struct dw_mci *host, u32 reset);
>>
>> @@ -888,6 +889,26 @@ static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg)
>>                  cmd, arg, cmd_status);
>>   }
>>
>> +static void dw_mci_wait_busy(struct dw_mci_slot *slot)
>> +{
>> +       struct dw_mci *host = slot->host;
>> +       unsigned long timeout = jiffies + msecs_to_jiffies(500);
>> +
>> +       while (time_before(jiffies, timeout)) {
>> +               if (!dw_mci_card_busy(slot->mmc))
>> +                       return;
>> +       }
>> +       dev_err(host->dev, "Data busy (status %#x)\n",
>> +               mci_readl(slot->host, STATUS));
>> +
>> +       /*
>> +        * Data busy, this should not happend when mmc controller send command
>> +        * to update card clocks in non-volt-switch state. If it happends, we
>> +        * should reset controller to avoid getting "Timeout sending command".
>> +        */
>> +       dw_mci_ctrl_reset(host, SDMMC_CTRL_ALL_RESET_FLAGS);
>> +}
>> +
>>   static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
>>   {
>>          struct dw_mci *host = slot->host;
>> @@ -899,6 +920,8 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
>>          /* We must continue to set bit 28 in CMD until the change is complete */
>>          if (host->state == STATE_WAITING_CMD11_DONE)
>>                  sdmmc_cmd_bits |= SDMMC_CMD_VOLT_SWITCH;
>> +       else
>> +               dw_mci_wait_busy(slot);
>>
>>          if (!clock) {
>>                  mci_writel(host, CLKENA, 0);
>> --
>> 1.8.3.2
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>


