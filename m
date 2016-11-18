From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: fix the error handling for dma operation
Date: Fri, 18 Nov 2016 16:15:42 +0900
Message-ID: <2e3f0ef1-0c82-7e14-0ae3-d61a60fe146f@samsung.com>
References: <20161117075347.9061-1-jh80.chung@samsung.com>
 <CGME20161117081315epcas5p11cfc5661a0c9b1c8543a0414b06d039d@epcas5p1.samsung.com>
 <75493dd3-f3c2-e7d7-0d21-01b430978cb6@rock-chips.com>
 <bbb9dcda-ead5-0a52-4c9a-3b5ff078ad45@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:49070 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751750AbcKRHPw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2016 02:15:52 -0500
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OGT0328STI6Y250@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 18 Nov 2016 16:15:42 +0900 (KST)
In-reply-to: <bbb9dcda-ead5-0a52-4c9a-3b5ff078ad45@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org

Hi Shawn,

On 11/17/2016 05:25 PM, Jaehoon Chung wrote:
> On 11/17/2016 05:08 PM, Shawn Lin wrote:
>> Hi Jaehoon,
>>
>> ÔÚ 2016/11/17 15:53, Jaehoon Chung Ð´µÀ:
>>> When OWN bit of dma descriptor is not cleared, then it returns -EINVAL.
>>> Then it has to fall back to PIO mode for current transfer.
>>>
>>> Host controller was already set to bits relevant to DMA operation.
>>> If needs to use the PIO mode, Host controller has to stop the DMA
>>> operation. (It's more stable than now.)
>>>
>>
>> It looks good to me, but
>>
>>> When it occurred error, it's not running any request.
>>>
>>> Fixes: 3b2a067b98b4 ("mmc: dw_mmc: avoid race condition of cpu and IDMAC")
>>>
>>
>> I think the real fixes tag should indicate the another commit,
>> 3fc7eaef44dbcbcd60 ("mmc: dw_mmc: Add external dma interface support")
> 
> You're right. 
> But my main problem is "checking OWN bit".  Thanks for noticing this commit. :)
> Some time..OWN bit is never released.. 

I think your the suggested commit is more correct than me.
After modifying fixes commit ID, then will apply. Thanks!

Best Regards,
Jaehoon Chung

> 
> Best Regards,
> Jaehoon Chung
> 
>>
>> otherwise,
>>
>> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
>>
>>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>>> ---
>>>  drivers/mmc/host/dw_mmc.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>> index 9341b18..080003b 100644
>>> --- a/drivers/mmc/host/dw_mmc.c
>>> +++ b/drivers/mmc/host/dw_mmc.c
>>> @@ -1058,6 +1058,7 @@ static int dw_mci_submit_data_dma(struct dw_mci *host, struct mmc_data *data)
>>>      spin_unlock_irqrestore(&host->irq_lock, irqflags);
>>>
>>>      if (host->dma_ops->start(host, sg_len)) {
>>> +        host->dma_ops->stop(host);
>>>          /* We can't do DMA, try PIO for this one */
>>>          dev_dbg(host->dev,
>>>              "%s: fall back to PIO mode for current transfer\n",
>>>
>>
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 

