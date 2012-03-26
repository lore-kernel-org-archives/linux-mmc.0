From: Yusuke Goda <yusuke.goda.sx@renesas.com>
Subject: Re: [PATCH 2/2] mmc: sh_mmcif: mmc->f_max should be half of the bus
 clock
Date: Mon, 26 Mar 2012 14:45:30 +0900
Message-ID: <4F70027A.9020203@renesas.com>
References: <1332320549-28584-1-git-send-email-horms@verge.net.au>
 <1332320549-28584-3-git-send-email-horms@verge.net.au>
 <Pine.LNX.4.64.1203241904150.19427@axis700.grange>
 <20120325223033.GA6860@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:46132 "EHLO
	relmlor2.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752699Ab2CZFpl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Mar 2012 01:45:41 -0400
Received: from relmlir1.idc.renesas.com ([10.200.68.151])
 by relmlor2.idc.renesas.com ( SJSMS)
 with ESMTP id <0M1H00E3F9BZ2T60@relmlor2.idc.renesas.com> for
 linux-mmc@vger.kernel.org; Mon, 26 Mar 2012 14:45:35 +0900 (JST)
Received: from relmlac1.idc.renesas.com ([10.200.69.21])
 by relmlir1.idc.renesas.com (SJSMS)
 with ESMTP id <0M1H0007U9BZNHG0@relmlir1.idc.renesas.com> for
 linux-mmc@vger.kernel.org; Mon, 26 Mar 2012 14:45:35 +0900 (JST)
In-reply-to: <20120325223033.GA6860@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Cao Minh Hiep <hiepcm@gmail.com>

Hi Simon-san, Guennadi-san

(2012/03/26 7:30), Simon Horman wrote:
> On Sat, Mar 24, 2012 at 07:06:31PM +0100, Guennadi Liakhovetski wrote:
>> On Wed, 21 Mar 2012, Simon Horman wrote:
>>
>>> mmc->f_max should be half of the bus clock.
>>> And now that mmc->f_max is not equal to the bus clock the
>>> latter should be used directly to calculate mmc->f_min.
>>
>> The patch seems correct as it stands, however, looking at it - does anyone 
>> understands why that "close to 400kHz" comment and such a complicated 
>> calculation? Shouldn't it be just host->clk / 512 always? Maybe this 
>> should be a separate patch, so, for this one
>>
>> Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> Hi Guennadi,
> 
> that code seems to date back to the original driver submission
> made by Goda-san. I have CCed him as perhaps he recalls why
> the code is like it is.
I thought to get closer to 400kHz if possible.
Probably even host->clk / 512 does not have any problem.

cheers,
Goda

>>> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>>> Tested-by: Cao Minh Hiep <hiepcm@gmail.com>
>>> Signed-off-by: Simon Horman <horms@verge.net.au>
>>> ---
>>>  drivers/mmc/host/sh_mmcif.c |   12 ++++++------
>>>  1 files changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
>>> index 5014bc4..1410baa 100644
>>> --- a/drivers/mmc/host/sh_mmcif.c
>>> +++ b/drivers/mmc/host/sh_mmcif.c
>>> @@ -1297,14 +1297,14 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
>>>  	spin_lock_init(&host->lock);
>>>  
>>>  	mmc->ops = &sh_mmcif_ops;
>>> -	mmc->f_max = host->clk;
>>> +	mmc->f_max = host->clk / 2;
>>>  	/* close to 400KHz */
>>> -	if (mmc->f_max < 51200000)
>>> -		mmc->f_min = mmc->f_max / 128;
>>> -	else if (mmc->f_max < 102400000)
>>> -		mmc->f_min = mmc->f_max / 256;
>>> +	if (host->clk < 51200000)
>>> +		mmc->f_min = host->clk / 128;
>>> +	else if (host->clk < 102400000)
>>> +		mmc->f_min = host->clk / 256;
>>>  	else
>>> -		mmc->f_min = mmc->f_max / 512;
>>> +		mmc->f_min = host->clk / 512;
>>>  	if (pd->ocr)
>>>  		mmc->ocr_avail = pd->ocr;
>>>  	mmc->caps = MMC_CAP_MMC_HIGHSPEED;
>>> -- 
>>> 1.7.6.3
>>>
>>
>> ---
>> Guennadi Liakhovetski, Ph.D.
>> Freelance Open-Source Software Developer
>> http://www.open-technology.de/
>>
> 
> 

-- 
EC No.

