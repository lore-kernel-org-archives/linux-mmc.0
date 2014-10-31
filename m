From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: add support for the other bit of sdio
 interrupt
Date: Fri, 31 Oct 2014 10:14:37 +0900
Message-ID: <5452E27D.5060707@samsung.com>
References: <1414635679-12565-1-git-send-email-addy.ke@rock-chips.com>
 <1414666240-16782-1-git-send-email-addy.ke@rock-chips.com>
 <54521AA9.2030700@samsung.com> <5452DBD7.4090908@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:59938 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161430AbaJaBOl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Oct 2014 21:14:41 -0400
In-reply-to: <5452DBD7.4090908@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: addy ke <addy.ke@rock-chips.com>, jh80.chung@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rdunlap@infradead.org, tgih.jun@samsung.com, chris@printf.net, ulf.hansson@linaro.org, dinguyen@altera.com, heiko@sntech.de, olof@lixom.net, dianders@chromium.org, sonnyrao@chromium.org
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, zhenfu.fang@rock-chips.com, cf@rock-chips.com, lintao@rock-chips.com, chenfen@rock-chips.com, zyf@rock-chips.com, xjq@rock-chips.com, huangtao@rock-chips.com, zyw@rock-chips.com, yzq@rock-chips.com, hj@rock-chips.com, kever.yang@rock-chips.com, zhangqing@rock-chips.com, hl@rock-chips.com

Hi,

On 10/31/2014 09:46 AM, addy ke wrote:
> Hi, Jaehoon
> 
> On 2014/10/30 19:02, Jaehoon Chung wrote:
>> Hi, Addy.
>>
>> This patch is conflicted..Could you rebase on latest Ulf's tree?
> I have not found ulf's tree in git.kernel.org.
> I can't 'git clone git://git.kernel.org/pub/scm/linux/kernel/git/ulf/xxx.git'.
> So my patch is based on kernel-3.18.
> I will send patch v2 for this.
> Would you please give me a git url for it?

http://git.linaro.org/git/people/ulf.hansson/mmc.git
I'm checking with next branch.

Best Regards,
Jaehoon Chung

> Thank you.
> 
>>
>> Best Regards,
>> Jaehoon Chung
>>
>> On 10/30/2014 07:50 PM, Addy Ke wrote:
>>> The bit of sdio interrupt is 16 in designware implementation,
>>> but it is 24 in RK3288. This patch add sdio_id0 for the number
>>> of slot0 in the SDIO interrupt registers, which can be set in
>>> platform DT table, such as:
>>> - rockchip,sdio-interrupt-slot0 = <8>;
>>>
>>> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
>>> ---
>>>  drivers/mmc/host/dw_mmc-rockchip.c | 13 +++++++++++++
>>>  drivers/mmc/host/dw_mmc.c          | 12 +++++++-----
>>>  drivers/mmc/host/dw_mmc.h          |  2 ++
>>>  include/linux/mmc/dw_mmc.h         |  3 +++
>>>  4 files changed, 25 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
>>> index f0c2cb1..54655e7 100644
>>> --- a/drivers/mmc/host/dw_mmc-rockchip.c
>>> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
>>> @@ -65,6 +65,18 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>>>  	}
>>>  }
>>>  
>>> +static int dw_mci_rk3288_parse_dt(struct dw_mci *host)
>>> +{
>>> +	struct device_node *np = host->dev->of_node;
>>> +	int sdio_id0;
>>> +
>>> +	if (!of_property_read_u32(np, "rockchip,sdio-interrupt-slot0",
>>> +				  &sdio_id0))
>>> +		host->sdio_id0 = sdio_id0;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>  static const struct dw_mci_drv_data rk2928_drv_data = {
>>>  	.prepare_command        = dw_mci_rockchip_prepare_command,
>>>  };
>>> @@ -73,6 +85,7 @@ static const struct dw_mci_drv_data rk3288_drv_data = {
>>>  	.prepare_command        = dw_mci_rockchip_prepare_command,
>>>  	.set_ios		= dw_mci_rk3288_set_ios,
>>>  	.setup_clock    = dw_mci_rk3288_setup_clock,
>>> +	.parse_dt	= dw_mci_rk3288_parse_dt,
>>>  };
>>>  
>>>  static const struct of_device_id dw_mci_rockchip_match[] = {
>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>> index 69f0cc6..2ea7467 100644
>>> --- a/drivers/mmc/host/dw_mmc.c
>>> +++ b/drivers/mmc/host/dw_mmc.c
>>> @@ -819,7 +819,7 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
>>>  
>>>  		/* enable clock; only low power if no SDIO */
>>>  		clk_en_a = SDMMC_CLKEN_ENABLE << slot->id;
>>> -		if (!(mci_readl(host, INTMASK) & SDMMC_INT_SDIO(slot->id)))
>>> +		if (!(mci_readl(host, INTMASK) & SDMMC_INT_SDIO(slot->sdio_id)))
>>>  			clk_en_a |= SDMMC_CLKEN_LOW_PWR << slot->id;
>>>  		mci_writel(host, CLKENA, clk_en_a);
>>>  
>>> @@ -1180,10 +1180,10 @@ static void dw_mci_enable_sdio_irq(struct mmc_host *mmc, int enb)
>>>  		dw_mci_disable_low_power(slot);
>>>  
>>>  		mci_writel(host, INTMASK,
>>> -			   (int_mask | SDMMC_INT_SDIO(slot->id)));
>>> +			   (int_mask | SDMMC_INT_SDIO(slot->sdio_id)));
>>>  	} else {
>>>  		mci_writel(host, INTMASK,
>>> -			   (int_mask & ~SDMMC_INT_SDIO(slot->id)));
>>> +			   (int_mask & ~SDMMC_INT_SDIO(slot->sdio_id)));
>>>  	}
>>>  }
>>>  
>>> @@ -2035,8 +2035,9 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>>>  		/* Handle SDIO Interrupts */
>>>  		for (i = 0; i < host->num_slots; i++) {
>>>  			struct dw_mci_slot *slot = host->slot[i];
>>> -			if (pending & SDMMC_INT_SDIO(i)) {
>>> -				mci_writel(host, RINTSTS, SDMMC_INT_SDIO(i));
>>> +			if (pending & SDMMC_INT_SDIO(slot->sdio_id)) {
>>> +				mci_writel(host, RINTSTS,
>>> +					   SDMMC_INT_SDIO(slot->sdio_id));
>>>  				mmc_signal_sdio_irq(slot->mmc);
>>>  			}
>>>  		}
>>> @@ -2206,6 +2207,7 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>>>  
>>>  	slot = mmc_priv(mmc);
>>>  	slot->id = id;
>>> +	slot->sdio_id = host->sdio_id0 + id;
>>>  	slot->mmc = mmc;
>>>  	slot->host = host;
>>>  	host->slot[id] = slot;
>>> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
>>> index 01b99e8..3e966a9 100644
>>> --- a/drivers/mmc/host/dw_mmc.h
>>> +++ b/drivers/mmc/host/dw_mmc.h
>>> @@ -214,6 +214,7 @@ extern int dw_mci_resume(struct dw_mci *host);
>>>   *	with CONFIG_MMC_CLKGATE.
>>>   * @flags: Random state bits associated with the slot.
>>>   * @id: Number of this slot.
>>> + * @sdio_id: Number of this slot in the SDIO interrupt registers.
>>>   * @last_detect_state: Most recently observed card detect state.
>>>   */
>>>  struct dw_mci_slot {
>>> @@ -234,6 +235,7 @@ struct dw_mci_slot {
>>>  #define DW_MMC_CARD_PRESENT	0
>>>  #define DW_MMC_CARD_NEED_INIT	1
>>>  	int			id;
>>> +	int			sdio_id;
>>>  	int			last_detect_state;
>>>  };
>>>  
>>> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
>>> index 0013669..4c0d3f2 100644
>>> --- a/include/linux/mmc/dw_mmc.h
>>> +++ b/include/linux/mmc/dw_mmc.h
>>> @@ -96,6 +96,7 @@ struct mmc_data;
>>>   * @quirks: Set of quirks that apply to specific versions of the IP.
>>>   * @irq_flags: The flags to be passed to request_irq.
>>>   * @irq: The irq value to be passed to request_irq.
>>> + * @sdio_id0: Number of slot0 in the SDIO interrupt registers.
>>>   *
>>>   * Locking
>>>   * =======
>>> @@ -193,6 +194,8 @@ struct dw_mci {
>>>  	bool			vqmmc_enabled;
>>>  	unsigned long		irq_flags; /* IRQ flags */
>>>  	int			irq;
>>> +
>>> +	int			sdio_id0;
>>>  };
>>>  
>>>  /* DMA ops for Internal/External DMAC interface */
>>>
>>
>>
>>
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

