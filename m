From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2] mmc: dw-mmc: relocate the position called
 dw_mci_setup_bus()
Date: Mon, 29 Oct 2012 18:38:55 +0900
Message-ID: <508E4EAF.2060409@samsung.com>
References: <508E11E8.2040609@samsung.com>
 <009e01cdb5b4$fb55b010$f2011030$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:50635 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753Ab2J2Ji5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Oct 2012 05:38:57 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MCN002KJESTY6J0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 29 Oct 2012 18:38:56 +0900 (KST)
Received: from [10.90.51.55] by mmp2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0MCN00DQOESVTD70@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 29 Oct 2012 18:38:56 +0900 (KST)
In-reply-to: <009e01cdb5b4$fb55b010$f2011030$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: 'Jaehoon Chung' <jh80.chung@samsung.com>, 'linux-mmc' <linux-mmc@vger.kernel.org>, 'Chris Ball' <cjb@laptop.org>, 'Will Newton' <will.newton@imgtec.com>, 'James Hogan' <James.Hogan@imgtec.com>, 'Kyungmin Park' <kyungmin.park@samsung.com>

On 10/29/2012 06:08 PM, Seungwon Jeon wrote:
> Monday, October 29, 2012, Jaehoon Chung <jh80.chung@samsung.com>
>> After power-on, must be ensured at least 74~80 clocks before sending any first command.
>> To ensure, it's good that dw_mci_setup_bus() is located at dw_mci_set_ios
>> instead of __dw_mci_start_request()
> After power-up, host driver sets 'DW_MMC_CARD_NEED_INIT' flag, right?
> And then, this flag help to add SDMMC_CMD_INIT flag into CMD, when __dw_mci_start_request is executed.
> 74~80 clocks is ensured with SDMMC_CMD_INIT regardless location change, isn't it?
> I mentioned this part in previous mail. Could you check it?
According to eMMC spec, after power-on, need to wait for 74-clock before sending first command
You can see code that after mmc_set_ios(), waiting for mmc_delay(10) into mmc_power_up().
(You can read the comment at mmc_power_up(), Maybe mmc_delay(10) didn't ensure the 74-clock).

Best Regards,
Jaehoon Chung
> 
> Thanks,
> Seungwon Jeon
> 
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
>> ------
>> Changelog V2:
>> 	- Modified the commit-message.
>> ---
>>  drivers/mmc/host/dw_mmc.c |    6 +++---
>>  1 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 4b2bedc..de79093 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -682,9 +682,6 @@ static void __dw_mci_start_request(struct dw_mci *host,
>>  	if (host->pdata->select_slot)
>>  		host->pdata->select_slot(slot->id);
>>
>> -	/* Slot specific timing and width adjustment */
>> -	dw_mci_setup_bus(slot);
>> -
>>  	host->cur_slot = slot;
>>  	host->mrq = mrq;
>>
>> @@ -810,6 +807,9 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>  	if (slot->host->drv_data->set_ios)
>>  		slot->host->drv_data->set_ios(slot->host, ios);
>>
>> +	/* Slot specific timing and width adjustment */
>> +	dw_mci_setup_bus(slot);
>> +
>>  	switch (ios->power_mode) {
>>  	case MMC_POWER_UP:
>>  		set_bit(DW_MMC_CARD_NEED_INIT, &slot->flags);
>> --
>> 1.7.4.1
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

