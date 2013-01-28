From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: fix to refer NULL pointer
Date: Mon, 28 Jan 2013 11:14:08 +0900
Message-ID: <5105DEF0.5000507@samsung.com>
References: <1359177589-13868-1-git-send-email-jy0922.shim@samsung.com>
 <Pine.LNX.4.64.1301270906270.5137@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:43619 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247Ab3A1COa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 27 Jan 2013 21:14:30 -0500
In-reply-to: <Pine.LNX.4.64.1301270906270.5137@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>, cjb@laptop.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 01/27/2013 05:10 PM, Guennadi Liakhovetski wrote:
> On Sat, 26 Jan 2013, Joonyoung Shim wrote:
> 
>> Check whether host->sdio_irq_thread is NULL before wake_up_process() is
>> called about host->sdio_irq_thread.
> 
> Actually, mmc_signal_sdio_irq() shouldn't be called if SDIO IRQ isn't 
> used...
Right, But I think that need to check whether the host->sdio_irq_thread is assigned or not.

Best Regards,
Jaehoon Chung
> 
> Thanks
> Guennadi
> 
>>
>> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
>> ---
>> Currently the kernel panic to refer NULL pointer about
>> host->sdio_irq_thread are occuring at the trats board using Samsung
>> SDHCI driver.
>>
>>  include/linux/mmc/host.h |    3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> index 61a10c1..2950fea 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -372,7 +372,8 @@ static inline void mmc_signal_sdio_irq(struct mmc_host *host)
>>  {
>>  	host->ops->enable_sdio_irq(host, 0);
>>  	host->sdio_irq_pending = true;
>> -	wake_up_process(host->sdio_irq_thread);
>> +	if (host->sdio_irq_thread)
>> +		wake_up_process(host->sdio_irq_thread);
>>  }
>>  
>>  #ifdef CONFIG_REGULATOR
>> -- 
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

