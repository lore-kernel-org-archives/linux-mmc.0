From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 1/5] mmc: dw-mmc: ensure that the card is not busy when
 changing clock
Date: Thu, 30 Aug 2012 11:25:55 +0900
Message-ID: <503ECF33.9060103@samsung.com>
References: <503C797D.4040404@samsung.com>
 <003501cd8584$a1cd8370$e5688a50$%jun@samsung.com>
 <503D7818.2040402@samsung.com>
 <001101cd864d$879dec50$96d9c4f0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:34939 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753638Ab2H3C0E (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Aug 2012 22:26:04 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M9J00HAVQPDZBI0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 30 Aug 2012 11:26:02 +0900 (KST)
Received: from [10.90.51.55] by mmp2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0M9J0022HQRDMP30@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 30 Aug 2012 11:26:02 +0900 (KST)
In-reply-to: <001101cd864d$879dec50$96d9c4f0$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: 'linux-mmc' <linux-mmc@vger.kernel.org>, 'Chris Ball' <cjb@laptop.org>, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Will Newton' <will.newton@imgtec.com>, 'Thomas Abraham' <thomas.abraham@linaro.org>

On 08/30/2012 10:19 AM, Seungwon Jeon wrote:
> On Tuesday, August 29, 2012, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> On 08/29/2012 10:21 AM, Seungwon Jeon wrote:
>>> On Tuesday, August 28, 2012, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>>> synopsys spec is mentioned. (7.1 Software/Hardware Restrictions)
>>>> "Before disabling clock, ensure that card is not busy due to any previous data command."
>>>>
>>>> At specific board, i found the problem that didn't inform ciu.
>>>> (It didn't produce always.)
>>>> At that time, i checked the status register whether card is busy or not.
>>>> (Start bit of CMD register is cleared, but card is busy.)
>>>> Current code didn't check the card status. Just check whether the start-bit cleared.
>>>> host regard that command is completed, will send the next command.
>>>> But next command didn't issue because Card is busy.
>>>> This patch can prevent this situation.
>>>>
>>>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>>>> ---
>>>>  drivers/mmc/host/dw_mmc.c |   27 +++++++++++++++++++++------
>>>>  drivers/mmc/host/dw_mmc.h |    1 +
>>>>  2 files changed, 22 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>>> index 36f98c0..e30d3ed 100644
>>>> --- a/drivers/mmc/host/dw_mmc.c
>>>> +++ b/drivers/mmc/host/dw_mmc.c
>>>> @@ -623,6 +623,24 @@ static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg)
>>>>  		cmd, arg, cmd_status);
>>>>  }
>>>>
>>>> +static void dw_mci_inform_ciu(struct dw_mci_slot *slot)
>>>> +{
>>>> +	struct dw_mci *host = slot->host;
>>>> +	unsigned long timeout = jiffies + msecs_to_jiffies(10);
>>> 10ms is from test?
>> It's tested...it's not exactly value..but never spent the time.
>>>
>>>> +	u32 ctrl, status;
>>>> +
>>>> +	do {
>>>> +		status = mci_readl(host, STATUS);
>>>> +		if (!(status & SDMMC_DATA_BUSY))
>>>> +			break;
>>>> +		ctrl = mci_readl(host, CTRL);
>>>> +		ctrl |= SDMMC_CTRL_RESET;
>>>> +		mci_writel(host, CTRL, ctrl);
>>>> +	} while (time_before(jiffies, timeout));
>>>> +
>>>> +	mci_send_cmd(slot, SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT, 0);
>>>> +}
>>>> +
>>>>  static void dw_mci_setup_bus(struct dw_mci_slot *slot)
>>>>  {
>>>>  	struct dw_mci *host = slot->host;
>>>> @@ -650,15 +668,13 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot)
>>> According to your quotation of manual("Before disabling clock, ...),
>>> Place of dw_mci_inform_ciu is proper here?
>> manual is mentioned "before the disabling clock". but i think no problem before send the command.
>>>
>>> 	dw_mci_inform_ciu(slot);
>>>
>>>           /* disable clock */
>>>          mci_writel(host, CLKENA, 0);
>>>          mci_writel(host, CLKSRC, 0);
>>>
>>>>  		mci_writel(host, CLKSRC, 0);
>>>>
>>>>  		/* inform CIU */
>>>> -		mci_send_cmd(slot,
>>>> -			     SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT, 0);
>>>> +		dw_mci_inform_ciu(slot);
>>>>
>>>>  		/* set clock to desired speed */
>>>>  		mci_writel(host, CLKDIV, div);
>>>>
>>>>  		/* inform CIU */
>>>> -		mci_send_cmd(slot,
>>>> -			     SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT, 0);
>>>> +		dw_mci_inform_ciu(slot);
>>> And then, since start to change clock sequence, there is no need to check busy-status.
>>> Just need to update clock with origin code.
>> Right, didn't check the busy-status. but there is also no reason that didn't need to check busy-status.
> Ok, I mentioned no check busy-status because host doesn't send command to card in the middle of host's clock update.
> If you have a opinion, please let me know.
OK, i will apply with your opinion.
Then resend the patch.

Best Regards,
Jaehoon Chung
> 
> Thanks,
> Seungwon Jeon
> 
>>>>
>>>>  		/* enable clock; only low power if no SDIO */
>>>>  		clk_en_a = SDMMC_CLKEN_ENABLE << slot->id;
>>>> @@ -667,8 +683,7 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot)
>>>>  		mci_writel(host, CLKENA, clk_en_a);
>>>>
>>>>  		/* inform CIU */
>>>> -		mci_send_cmd(slot,
>>>> -			     SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT, 0);
>>>> +		dw_mci_inform_ciu(slot);
>>> Same here.
>>>
>>> Thanks,
>>> Seungwon Jeon
>>>>
>>>>  		host->current_speed = slot->clock;
>>>>  	}
>>>> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
>>>> index 15c27e1..b6a1a78 100644
>>>> --- a/drivers/mmc/host/dw_mmc.h
>>>> +++ b/drivers/mmc/host/dw_mmc.h
>>>> @@ -127,6 +127,7 @@
>>>>  #define SDMMC_CMD_INDX(n)		((n) & 0x1F)
>>>>  /* Status register defines */
>>>>  #define SDMMC_GET_FCNT(x)		(((x)>>17) & 0x1FFF)
>>>> +#define SDMMC_DATA_BUSY			BIT(9)
>>>>  /* Internal DMAC interrupt defines */
>>>>  #define SDMMC_IDMAC_INT_AI		BIT(9)
>>>>  #define SDMMC_IDMAC_INT_NI		BIT(8)
>>>> --
>>>> 1.7.4.1
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

