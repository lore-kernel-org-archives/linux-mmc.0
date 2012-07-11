From: Lauri Hintsala <lauri.hintsala@bluegiga.com>
Subject: Re: mmc: mxs: DEADLOCK
Date: Wed, 11 Jul 2012 09:08:26 +0300
Message-ID: <4FFD185A.8010501@bluegiga.com>
References: <4FFC367A.8020100@bluegiga.com> <20120711060607.GE14060@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bluegiga.fi ([194.100.31.45]:30640 "EHLO darkblue.bluegiga.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751869Ab2GKGI3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 11 Jul 2012 02:08:29 -0400
In-Reply-To: <20120711060607.GE14060@S2101-09.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Wolfram Sang <w.sang@pengutronix.de>, Koen Beel <koen.beel@barco.com>, Marek Vasut <marex@denx.de>, linux-mmc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Veli-Pekka Peltola <veli-pekka.peltola@bluegiga.com>

On 07/11/2012 09:06 AM, Shawn Guo wrote:
>> --- a/drivers/mmc/host/mxs-mmc.c
>> +++ b/drivers/mmc/host/mxs-mmc.c
>> @@ -278,11 +278,11 @@ static irqreturn_t mxs_mmc_irq_handler(int
>> irq, void *dev_id)
>>   	writel(stat & MXS_MMC_IRQ_BITS,
>>   	       host->base + HW_SSP_CTRL1(host) + STMP_OFFSET_REG_CLR);
>>
>> +	spin_unlock(&host->lock);
>> +
>>   	if ((stat & BM_SSP_CTRL1_SDIO_IRQ) && (stat & BM_SSP_CTRL1_SDIO_IRQ_EN))
>>   		mmc_signal_sdio_irq(host->mmc);
>>
>> -	spin_unlock(&host->lock);
>> -
>>   	if (stat & BM_SSP_CTRL1_RESP_TIMEOUT_IRQ)
>>   		cmd->error = -ETIMEDOUT;
>>   	else if (stat & BM_SSP_CTRL1_RESP_ERR_IRQ)
>>
>>
>> Is there any reason to keep mmc_signal_sdio_irq inside the spinlock?
>> mmc_signal_sdio_irq calls mxs_mmc_enable_sdio_irq and it tries to
>> acquire lock while it is already acquired.
>>
> The fix looks right to me.  You can have my ack when you send a patch
> for it.
>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>

OK, I'll send a patch. Thanks!

Lauri

