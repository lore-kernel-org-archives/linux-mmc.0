From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v7] mmc: support BKOPS feature for eMMC
Date: Mon, 12 Mar 2012 09:01:49 +0900
Message-ID: <4F5D3CED.5010003@samsung.com>
References: <4F190E26.4040909@samsung.com>
 <c498ff8b542c601db641988c35ae120c.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:19288 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754342Ab2CLABv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 11 Mar 2012 20:01:51 -0400
Received: from epcpsbgm1.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0M0Q00DULW30ZC40@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 12 Mar 2012 09:01:50 +0900 (KST)
Received: from [165.213.219.108] by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0M0Q00GD6W31HU30@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 12 Mar 2012 09:01:50 +0900 (KST)
In-reply-to: <c498ff8b542c601db641988c35ae120c.squirrel@www.codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Konstantin Dorfman <kdorfman@codeaurora.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Per FORLIN <per.forlin@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "svenkatr@ti.com" <svenkatr@ti.com>

On 03/12/2012 01:06 AM, Konstantin Dorfman wrote:

> Hello Jaehoon,
> 
> On Fri, January 20, 2012 8:48 am, Jaehoon Chung wrote:
> ...
>> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
>> index 4d41fa9..109d0f0 100644
>> --- a/drivers/mmc/core/mmc_ops.c
>> +++ b/drivers/mmc/core/mmc_ops.c
>> @@ -392,13 +392,22 @@ int mmc_switch(struct mmc_card *card, u8 set, u8
>> index, u8 value,
>>  		  (index << 16) |
>>  		  (value << 8) |
>>  		  set;
>> -	cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
>> +	cmd.flags = MMC_CMD_AC;
>> +	if (index == EXT_CSD_BKOPS_START &&
>> +	    card->ext_csd.raw_bkops_status < EXT_CSD_BKOPS_LEVEL_2)
>> +		cmd.flags |= MMC_RSP_SPI_R1 | MMC_RSP_R1;
>> +	else
>> +		cmd.flags |= MMC_RSP_SPI_R1B | MMC_RSP_R1B;
> 
> It is not good to use conditional on 'index', because this function
> (mmc_switch)
> is generic and in case you want functionality like here "in some cases cmd
>  should not wait for PROG_DONE" it is better to use different approach:
> 
> 1. Use internal function with additional parameter wait_for_prog_done:
> 
> int __mmc_switch(struct mmc_card *card, u8 set, u8 index,
>                  unsigned int timeout_ms, u8 wait_for_prog_done)
> {
> ...
>     if(wait_for_prog_done)
>       cmd.flags |= MMC_RSP_SPI_R1B | MMC_RSP_R1B;
>     else
>       cmd.flags |= MMC_RSP_SPI_R1 | MMC_RSP_R1;
> ...
> }
> 
> 2. implement mmc_switch through __mmc_switch()
>    int mmc_switch(struct mmc_card *card, u8 set, u8 index,
>                                    unsigned int timeout_ms)
>    {
>      return __mmc_switch(card, set, index, timeout_ms, 0);
>    }
> 3. when you need to start bkops, use: __mmc_switch(card, set, index,
> timeout_ms, 1);
> 
> Does it make sense?
> 

Hi Konstantin.

Your opinion is right. i will fix them.
Thanks for comments.

Best Regards,
Jaehoon Chung

