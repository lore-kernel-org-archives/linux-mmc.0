From: Addy <addy.ke@rock-chips.com>
Subject: Re: [PATCH v2 1/2] mmc: dw_mmc: fix bug that cause 'Timeout sending
 command'
Date: Wed, 11 Feb 2015 11:07:14 +0800
Message-ID: <54DAC762.2050404@rock-chips.com>
References: <1423134801-23219-1-git-send-email-addy.ke@rock-chips.com> <1423466726-20833-1-git-send-email-addy.ke@rock-chips.com> <1423466726-20833-2-git-send-email-addy.ke@rock-chips.com> <54D88560.4050808@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <54D88560.4050808@samsung.com>
Sender: linux-doc-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rdunlap@infradead.org, tgih.jun@samsung.com, chris@printf.net, ulf.hansson@linaro.org, dinguyen@altera.com, heiko@sntech.de, olof@lixom.net, dianders@chromium.org, sonnyrao@chromium.org, amstan@chromium.org, djkurtz@chromium.org
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, zhenfu.fang@rock-chips.com, cf@rock-chips.com, lintao@rock-chips.com, chenfen@rock-chips.com, zyf@rock-chips.com, xjq@rock-chips.com, huangtao@rock-chips.com, zyw@rock-chips.com, yzq@rock-chips.com, hj@rock-chips.com, kever.yang@rock-chips.com, zhangqing@rock-chips.com, hl@rock-chips.com
List-Id: linux-mmc@vger.kernel.org


On 2015/02/09 18:01, Jaehoon Chung wrote:
> Hi, Addy.
>
> On 02/09/2015 04:25 PM, Addy Ke wrote:
>> Because of some uncertain factors, such as worse card or worse hardware,
>> DAT[3:0](the data lines) may be pulled down by card, and mmc controller
>> will be in busy state. This should not happend when mmc controller
>> send command to update card clocks. If this happends, mci_send_cmd will
>> be failed and we will get 'Timeout sending command', and then system will
>> be blocked. To avoid this, we need reset mmc controller.
>>
>> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
>> ---
>>   drivers/mmc/host/dw_mmc.c | 28 ++++++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 4d2e3c2..b0b57e3 100644
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
>> @@ -888,6 +889,31 @@ static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg)
>>   		cmd, arg, cmd_status);
>>   }
>>   
>> +static void dw_mci_wait_busy(struct dw_mci_slot *slot)
>> +{
>> +	struct dw_mci *host = slot->host;
>> +	unsigned long timeout = jiffies + msecs_to_jiffies(500);
>> +
>> +	do {
>> +		if (!dw_mci_card_busy(slot->mmc))
>> +			return;
>> +		cpu_relax();
>> +	} while (time_before(jiffies, timeout));
>> +
>> +	dev_err(host->dev, "Data busy (status %#x)\n",
>> +		mci_readl(slot->host, STATUS));
>> +
>> +	/*
>> +	 * Data busy, this should not happend when mmc controller send command
>> +	 * to update card clocks in non-volt-switch state. If it happends, we
>> +	 * should reset controller to avoid getting "Timeout sending command".
>> +	 */
>> +	dw_mci_ctrl_reset(host, SDMMC_CTRL_ALL_RESET_FLAGS);
> If reset is failed, then dw_mci_ctrl_reset should return "false".
>
> 	ret = dw_mci_ctrl_reset();
>
> 	WARN_ON(!ret || dw_mci_card_busy(slot->mmc));
>
> Is it right?
you are right, and I will update it in my next version patch. thank you.
>
> In my experiment, if reset is failed or card is busy, eMMC can't work anymore..right?
> I think this patch is reasonable to prevent blocking issue.
>
> Best Regards,
> Jaehoon Chung
>
>
>> +
>> +	/* Fail to reset controller or still data busy, WARN_ON! */
>> +	WARN_ON(dw_mci_card_busy(slot->mmc));
>> +}
>> +
>>   static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
>>   {
>>   	struct dw_mci *host = slot->host;
>> @@ -899,6 +925,8 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
>>   	/* We must continue to set bit 28 in CMD until the change is complete */
>>   	if (host->state == STATE_WAITING_CMD11_DONE)
>>   		sdmmc_cmd_bits |= SDMMC_CMD_VOLT_SWITCH;
>> +	else
>> +		dw_mci_wait_busy(slot);
>>   
>>   	if (!clock) {
>>   		mci_writel(host, CLKENA, 0);
>>
>
>
>


