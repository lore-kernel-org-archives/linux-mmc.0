From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 1/4] mmc: dw_mmc: fix the transmission handling in IDMAC
Date: Wed, 23 May 2012 16:18:08 +0900
Message-ID: <4FBC8F30.20400@samsung.com>
References: <006801cd37cf$7ca2e2a0$75e8a7e0$%jun@samsung.com>
 <4FBC6512.8070400@samsung.com>
 <009c01cd38ad$084b1b50$18e151f0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:22302 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753917Ab2EWHS5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 May 2012 03:18:57 -0400
Received: from epcpsbgm1.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M4G005L9SBJY3A0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 23 May 2012 16:18:56 +0900 (KST)
Received: from [165.213.219.108] by mmp2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0M4G00C2HSBJ8G70@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 23 May 2012 16:18:56 +0900 (KST)
In-reply-to: <009c01cd38ad$084b1b50$18e151f0$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, 'Will Newton' <will.newton@imgtec.com>, 'James Hogan' <james.hogan@imgtec.com>, hyeonsu.kim@samsung.com

Hi Seungwon Jeon,

This patch looks good to me..also.

I think good that should be added
Signed-off-by : Hyeonsu Kim <hyeonsu.kim@samsung.com>

Anyway, you reminded this patch.
Thanks :)

Best Regards,
Jaehoon Chung

On 05/23/2012 03:26 PM, Seungwon Jeon wrote:

> Hi, Jaehoon Chung,
> 
> We have missed Hyeonsu's patch?
> I checked the your link page and found the similarity of patch now.
> How can we do?
> Anyway, it'd need to be applied.
> 
> Thanks,
> Seungwon Jeon
> Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Hi Seungwon,
>>
>> This patch is already sent from Hyeonsu Kim,
>> Plz check the below patch.
>> Add Hyeonsu to CC'd
>>
>> http://comments.gmane.org/gmane.linux.kernel.mmc/12870
>>
>> Best Regards,
>> Jaehoon Chung
>>
>> On 05/22/2012 01:00 PM, Seungwon Jeon wrote:
>>
>>> DTO interrupt can be later than transmit interrupt(IDMAC)
>>> in case of write. Current handling of idmac interrupt sets
>>> EVENT_DATA_COMPLETE as well as EVENT_XFER_COMPLETE regardless
>>> DTO rising. This makes the current request be finished in tasklet
>>> and permits the next request even though current data transfer
>>> is still in progress. As a result, sequence is broken and lock-up
>>> happens. Setting EVENT_DATA_COMPLETE is not proper after IDMAC
>>> interrupt. It should be taken after DTO interrupt is generated.
>>>
>>> Reported-by: Dmitry Shmidt <dimitrysh@android.com>
>>> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>>> ---
>>>  drivers/mmc/host/dw_mmc.c |    1 -
>>>  1 files changed, 0 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>> index 9bbf45f..b46faf0 100644
>>> --- a/drivers/mmc/host/dw_mmc.c
>>> +++ b/drivers/mmc/host/dw_mmc.c
>>> @@ -1623,7 +1623,6 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>>>  	if (pending & (SDMMC_IDMAC_INT_TI | SDMMC_IDMAC_INT_RI)) {
>>>  		mci_writel(host, IDSTS, SDMMC_IDMAC_INT_TI | SDMMC_IDMAC_INT_RI);
>>>  		mci_writel(host, IDSTS, SDMMC_IDMAC_INT_NI);
>>> -		set_bit(EVENT_DATA_COMPLETE, &host->pending_events);
>>>  		host->dma_ops->complete(host);
>>>  	}
>>>  #endif
>>
>>
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


