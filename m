From: Dinh Nguyen <dinh.linux@gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Handle the Hardware Locked Write Error(HLE)
Date: Fri, 02 Aug 2013 00:10:43 -0500
Message-ID: <51FB3F53.50301@gmail.com>
References: <1375415444-23407-1-git-send-email-dinguyen@altera.com> <51FB3218.7040309@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:52019 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753982Ab3HBFKs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Aug 2013 01:10:48 -0400
Received: by mail-oa0-f44.google.com with SMTP id l20so491651oag.3
        for <linux-mmc@vger.kernel.org>; Thu, 01 Aug 2013 22:10:48 -0700 (PDT)
In-Reply-To: <51FB3218.7040309@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: dinguyen@altera.com, linux-mmc@vger.kernel.org, Doug Anderson <dianders@chromium.org>, James Hogan <james.hogan@imgtec.com>, Seungwon Jeon <tgih.jun@samsung.com>, Chris Ball <cjb@laptop.org>

Hi Jaehoon,

On 08/01/2013 11:14 PM, Jaehoon Chung wrote:
> You can refer to Seungwon's patch.
> 
> https://patchwork.kernel.org/patch/1814991/

Thanks alot for the referral. It appears that this exactly what I'm
seeing on the SOCFPGA platform. The command buffer is already filled
with a command when software sets the start_bit.

Wonder what happened to Senugwon's patch? I would think that the driver
should at least clear the HLE interrupt when it is triggered?

Thanks,
Dinh
> 
> Best Regards,
> Jaehoon Chung
> 
> On 08/02/2013 12:50 PM, dinguyen@altera.com wrote:
>> From: Dinh Nguyen <dinguyen@altera.com>
>>
>> The Handle the Hardware Locked Write Error(HLE) was getting triggered
>> intermittently on the SOCFPGA platform. But since the driver did not
>> have a mechanism to handle this interrupt, it was stuck in the ISR.
>>
>> Clear the HLE interrupt when it gets triggered.
>>
>> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
>> Cc: Doug Anderson <dianders@chromium.org>
>> Cc: Jaehoon Chung <jh80.chung@samsung.com>
>> Cc: James Hogan <james.hogan@imgtec.com>
>> Cc: Seungwon Jeon <tgih.jun@samsung.com>
>> Cc: Chris Ball <cjb@laptop.org>
>> ---
>>  drivers/mmc/host/dw_mmc.c |    3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index ee5f167..ef30bec 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -1664,6 +1664,9 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>>  			queue_work(host->card_workqueue, &host->card_work);
>>  		}
>>  
>> +		if (pending & SDMMC_INT_HLE)
>> +			mci_writel(host, RINTSTS, SDMMC_INT_HLE);
>> +
>>  		/* Handle SDIO Interrupts */
>>  		for (i = 0; i < host->num_slots; i++) {
>>  			struct dw_mci_slot *slot = host->slot[i];
>>
> 
