From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: Handle the Hardware Locked Write Error(HLE)
Date: Fri, 02 Aug 2013 14:48:37 +0900
Message-ID: <51FB4835.4030809@samsung.com>
References: <1375415444-23407-1-git-send-email-dinguyen@altera.com>
 <51FB3218.7040309@samsung.com> <51FB3F53.50301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:33323 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068Ab3HBFsh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Aug 2013 01:48:37 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MQW00BVE2S55JJ0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 02 Aug 2013 14:48:36 +0900 (KST)
In-reply-to: <51FB3F53.50301@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dinh Nguyen <dinh.linux@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, dinguyen@altera.com, linux-mmc@vger.kernel.org, Doug Anderson <dianders@chromium.org>, James Hogan <james.hogan@imgtec.com>, Seungwon Jeon <tgih.jun@samsung.com>, Chris Ball <cjb@laptop.org>

On 08/02/2013 02:10 PM, Dinh Nguyen wrote:
> Hi Jaehoon,
> 
> On 08/01/2013 11:14 PM, Jaehoon Chung wrote:
>> You can refer to Seungwon's patch.
>>
>> https://patchwork.kernel.org/patch/1814991/
> 
> Thanks alot for the referral. It appears that this exactly what I'm
> seeing on the SOCFPGA platform. The command buffer is already filled
> with a command when software sets the start_bit.
Right, HLE is triggered when the command buffer is filled fully.
Previously command is waiting for completing, ongoing next command..and next..
Then i found the HLE interrupt is triggered.

> 
> Wonder what happened to Senugwon's patch? I would think that the driver
> should at least clear the HLE interrupt when it is triggered?
I known that Seungwon's patch is just noticed the HLE interrupt.
We need to discuss how clear the HLE interrupt.
In my case, reset the fifo and resend the command that didn't complete.
if you have any other idea, let me share.

Best Regards,
Jaehoon Chung
> 
> Thanks,
> Dinh
>>
>> Best Regards,
>> Jaehoon Chung
>>
>> On 08/02/2013 12:50 PM, dinguyen@altera.com wrote:
>>> From: Dinh Nguyen <dinguyen@altera.com>
>>>
>>> The Handle the Hardware Locked Write Error(HLE) was getting triggered
>>> intermittently on the SOCFPGA platform. But since the driver did not
>>> have a mechanism to handle this interrupt, it was stuck in the ISR.
>>>
>>> Clear the HLE interrupt when it gets triggered.
>>>
>>> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
>>> Cc: Doug Anderson <dianders@chromium.org>
>>> Cc: Jaehoon Chung <jh80.chung@samsung.com>
>>> Cc: James Hogan <james.hogan@imgtec.com>
>>> Cc: Seungwon Jeon <tgih.jun@samsung.com>
>>> Cc: Chris Ball <cjb@laptop.org>
>>> ---
>>>  drivers/mmc/host/dw_mmc.c |    3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>> index ee5f167..ef30bec 100644
>>> --- a/drivers/mmc/host/dw_mmc.c
>>> +++ b/drivers/mmc/host/dw_mmc.c
>>> @@ -1664,6 +1664,9 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>>>  			queue_work(host->card_workqueue, &host->card_work);
>>>  		}
>>>  
>>> +		if (pending & SDMMC_INT_HLE)
>>> +			mci_writel(host, RINTSTS, SDMMC_INT_HLE);
>>> +
>>>  		/* Handle SDIO Interrupts */
>>>  		for (i = 0; i < host->num_slots; i++) {
>>>  			struct dw_mci_slot *slot = host->slot[i];
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

