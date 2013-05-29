From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: Re: [PATCH] mmc: sh_mobile_sdhi: fix error return code in sh_mobile_sdhi_probe()
Date: Wed, 29 May 2013 15:15:43 +0800
Message-ID: <CAPgLHd-Qv5fdoxd6HmO8LbDpLZAxYP8e8x4FqAutg_8T4-DRtg@mail.gmail.com>
References: <CAPgLHd_dwxRp8Ug7=05=3gTTa9bPME5tb-Mq1aqRFXZSrgqFGg@mail.gmail.com>
	<Pine.LNX.4.64.1305290841080.14157@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f51.google.com ([209.85.214.51]:55600 "EHLO
	mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759493Ab3E2HPp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 May 2013 03:15:45 -0400
Received: by mail-bk0-f51.google.com with SMTP id ji1so2563627bkc.38
        for <linux-mmc@vger.kernel.org>; Wed, 29 May 2013 00:15:43 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1305290841080.14157@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: g.liakhovetski@gmx.de
Cc: ian@mnementh.co.uk, cjb@laptop.org, grant.likely@linaro.org, rob.herring@calxeda.com, yongjun_wei@trendmicro.com.cn, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

Hi

On 05/29/2013 02:58 PM, Guennadi Liakhovetski wrote:
> Hi
>
> On Tue, 28 May 2013, Wei Yongjun wrote:
>
>> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>>
>> Fix to return a negative error code instead of 0 when we cannot get
>> IRQ source by platform_get_irq(), as done elsewhere in this function.
>>
>> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> Thanks for the patch. Do you think the following version would be even a 
> bit simpler?
>
> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index fe90853..76661b6 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -255,18 +255,17 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
>  	if (multiplexed_isr) {
>  		while (1) {
>  			irq = platform_get_irq(pdev, i);
> -			if (irq < 0)
> -				break;
> +			/* There must be at least one IRQ source */
> +			if (irq < 0) {
> +				ret = irq;
> +				goto eirq;
> +			}
>  			i++;
>  			ret = devm_request_irq(&pdev->dev, irq, tmio_mmc_irq, 0,
>  					  dev_name(&pdev->dev), host);
>  			if (ret)
>  				goto eirq;
>  		}
> -
> -		/* There must be at least one IRQ source */
> -		if (!i)
> -			goto eirq;
>  	}
>  
>  	dev_info(&pdev->dev, "%s base at 0x%08lx clock rate %u MHz\n",

The orig code used while loop to get many irqs, but with your change,
we will leave the loop util platform_get_irq() or request_irq() fail
and nerver success. Do your means remove the while loop and this device
need only one irq?

>
> If you agree, maybe you could send a v2 of your patch in this form, I'll 
> ack it then.
>
> Thanks
> Guennadi
>
>> ---
>>  drivers/mmc/host/sh_mobile_sdhi.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
>> index cc4c872..a4316b3 100644
>> --- a/drivers/mmc/host/sh_mobile_sdhi.c
>> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
>> @@ -273,8 +273,10 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
>>  		}
>>  
>>  		/* There must be at least one IRQ source */
>> -		if (!i)
>> +		if (!i) {
>> +			ret = irq;
>>  			goto eirq;
>> +		}
>>  	}
>>  
>>  	dev_info(&pdev->dev, "%s base at 0x%08lx clock rate %u MHz\n",
>>
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
>
>


