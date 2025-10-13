Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F211FCF7C;
	Mon, 13 Oct 2025 22:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760396055; cv=none; b=CjzkRhTj/3ecM3wYieVAezOGguu/q2zPpfiYCvNTLlbOSxf8QYMRSOdd47jX+UuKItzyYBdUvPJRtLsacoB/n2t9VBz419IiILEm4p6DJp6VubGK3G7/WJCX4gR+suxPTFh5Zaj3TM60bKczpjkOzMMcW8wcuAy1DXjk6nyGIKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760396055; c=relaxed/simple;
	bh=JAsqAOWugkDCSeK4R312V+ZOCV7tNTROXYMNfW3N0tI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VkQsMs2teBmeHKb0HoOCT7cRyLQjAjY4h0yZlCnQqonH1wdPeKcYKWi6Rsl/mYzPbTdpuQdQH0On+ENqSVuQBxkR9ctBt9W6/97mjcI0Pq3manXpo+9lz1Hf/2QlAefDT91fJxGLjOkys8JWpgWjd/QAVkf/LMYEwnv3vErJm7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BlAmPDy/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BlAmPDy/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B98DC4CEE7;
	Mon, 13 Oct 2025 22:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760396054;
	bh=JAsqAOWugkDCSeK4R312V+ZOCV7tNTROXYMNfW3N0tI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BlAmPDy/JjsiiKyhyY7taFMkVPkn2W06zVaqvzr7BcoRHMSRMagYrkwVfsZW8UJ5X
	 eS4oCFi5qj3TYrWIs8VdeqpJE6PA3GnMuXIWqzCSl2gj/w/FcfXMgthmbtaLpVA9x0
	 j9YzGA3RoCzyqMA2aDAZCyPa5zPsXt6z84yBHs/TUOTnmP7xBNjS0X4OER/wuRzPUn
	 7G8f+3+nnGZunqYG3T6aH7ewc2q3sjKcdVIUStAZh1jW6hjZMMO+col3S/QMfzLtcF
	 yN/8JifzulW+yvO+o0Zc35EvNxoNk3UZ0ro0iS8RagvQ8Hbl1UOvXOxfgGS/+TpjGm
	 pIvO1TTFoW6Pw==
Message-ID: <8afff048-4fe1-440a-9739-e5a5ea43d6eb@kernel.org>
Date: Mon, 13 Oct 2025 16:54:13 -0600
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: pxamci: Fix passing NULL to PTR_ERR() in
 pxamci_probe()
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Rakuram Eswaran <rakuram.e96@gmail.com>
Cc: chenhuacai@kernel.org, dan.carpenter@linaro.org,
 david.hunter.linux@gmail.com, linux-kernel-mentees@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, lkp@intel.com,
 skhan@linuxfoundation.org, ulf.hansson@linaro.org, zhoubinbin@loongson.cn
References: <xxtrhbv5qm2crtvc5ejpgu5caadsmms3rfulmosjwq7lumrko3@5mlcpk24hymm>
 <20251012183804.15171-1-rakuram.e96@gmail.com>
 <6j7ix5yof7qmrp6cgxhqver7yimvmgj7dujqu4l7cnzbpjksfd@5sp7am47gigw>
Content-Language: en-US
From: Khalid Aziz <khalid@kernel.org>
In-Reply-To: <6j7ix5yof7qmrp6cgxhqver7yimvmgj7dujqu4l7cnzbpjksfd@5sp7am47gigw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/13/25 2:45 AM, Uwe Kleine-König wrote:
> Hello Rakuram,
> 
> On Mon, Oct 13, 2025 at 12:07:52AM +0530, Rakuram Eswaran wrote:
>>>>
>>>> I do not see the need for this code change. "if (host->dma_chan_tx)" will
>>>> skip "dma_release_channel(host->dma_chan_tx)" since dma_chan_tx is already
>>>> NULL. This code change does not add anything.
>>>
>>> Yes, stand alone this change doesn't make sense, but if we want to drop
>>>
>>>          host->dma_chan_tx = NULL
>>>
>>> in the error path above, this change is needed. Maybe then even
>>>
>>>          if (host->dma_chan_rx)
>>>
>>> and
>>>
>>>          if (host->dma_chan_rx)
>>>
>>> can be dropped.
>>
>> Hello Uwe,
>>
>> I had one quick follow-up before sending v2.
>>
>> Regarding the devm_clk_get() error path —
>> you mentioned that setting host->clk = NULL; is redundant since host is
>> devm-managed and the function returns immediately afterward.
>>
>>> I am not sure that sounds right. Looking at the code for
>>> __devm_clk_get(), if devres_alloc() fails, it returns -ENOMEM. If any of
>>> the other steps after a successful devres_alloc() fail, code goes
>>> through possibly clk_put() if needed and then devres_free(). So the
>>> resources are already freed at this point before the return to
>>> pxamci_probe(). The only thing left to do is to set host->clk to NULL
>>> since it would be set to an error pointer at this point.
>>
>> Khalid pointed out that when __devm_clk_get() fails after allocating a
>> devres entry, the internal cleanup (clk_put() + devres_free()) ensures
>> resources are released, but host->clk would still hold an ERR_PTR()
>> value at that point.
>>
>> His suggestion was that setting it to NULL might be a harmless defensive
>> step to avoid any accidental later dereference.
> 
> Why is NULL better than an error pointer? (Spoiler: It isn't.)
> 
>> For now, I have dropped the redundant NULL assignment from
>> host->dma_chan_rx = NULL and directly returning the ERR_PTR instead of
>> storing in a return variable.
>>
>> Below I have appended proposed changes for v2.
>>
>> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
>> index 26d03352af63..eb46a4861dbe 100644
>> --- a/drivers/mmc/host/pxamci.c
>> +++ b/drivers/mmc/host/pxamci.c
>> @@ -653,8 +653,9 @@ static int pxamci_probe(struct platform_device *pdev)
>>   
>>   	host->clk = devm_clk_get(dev, NULL);
>>   	if (IS_ERR(host->clk)) {
>> +		ret = PTR_ERR(host->clk);
>>   		host->clk = NULL;
>> -		return PTR_ERR(host->clk);
>> +		return ret;
>>   	}
>>   
>>   	host->clkrate = clk_get_rate(host->clk);
>> @@ -705,7 +706,6 @@ static int pxamci_probe(struct platform_device *pdev)
>>   
>>   	host->dma_chan_rx = dma_request_chan(dev, "rx");
>>   	if (IS_ERR(host->dma_chan_rx)) {
>> -		host->dma_chan_rx = NULL;
>>   		return dev_err_probe(dev, PTR_ERR(host->dma_chan_rx),
>>   				     "unable to request rx dma channel\n");
>>   	}
>>
>> Would you prefer that I:
>>
>> 1. Remove the host->clk = NULL; assignment for consistency (as you initially
>> suggested), or
>>
>> 2. Keep it in v2 for defensive clarity, as Khalid reasoned?
>>
>> I just wanted to confirm your preference before resending, to keep v2 aligned.
> 
> Note that in the end it's not me who decides, but Ulf (= mmc
> maintainer).
> 
> If you ask me however, I'd say the right thing to do there is like the
> following:
> 
> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> index 26d03352af63..ce896b3f697b 100644
> --- a/drivers/mmc/host/pxamci.c
> +++ b/drivers/mmc/host/pxamci.c
> @@ -652,11 +652,13 @@ static int pxamci_probe(struct platform_device *pdev)
>   	host->clkrt = CLKRT_OFF;
>   
>   	host->clk = devm_clk_get(dev, NULL);
> -	if (IS_ERR(host->clk)) {
> -		host->clk = NULL;
> -		return PTR_ERR(host->clk);
> -	}
> +	if (IS_ERR(host->clk))
> +		return dev_err_probe(dev, PTR_ERR(host->clk), "Failed to aquire clock\n");

Hi Uwe,

I agree using dev_err_probe() is better since it leads to better logging 
and troubleshooting.

>   
> +	/*
> +	 * XXX: Note that the return value of clk_get_rate() is only valid if
> +	 * the clock is enabled.
> +	 */
>   	host->clkrate = clk_get_rate(host->clk);
>   
>   	/*
> @@ -703,20 +705,15 @@ static int pxamci_probe(struct platform_device *pdev)
>   
>   	platform_set_drvdata(pdev, mmc);
>   
> -	host->dma_chan_rx = dma_request_chan(dev, "rx");
> -	if (IS_ERR(host->dma_chan_rx)) {
> -		host->dma_chan_rx = NULL;
> +	host->dma_chan_rx = devm_dma_request_chan(dev, "rx");
> +	if (IS_ERR(host->dma_chan_rx))
>   		return dev_err_probe(dev, PTR_ERR(host->dma_chan_rx),
>   				     "unable to request rx dma channel\n");
> -	}
>   
> -	host->dma_chan_tx = dma_request_chan(dev, "tx");
> -	if (IS_ERR(host->dma_chan_tx)) {
> -		dev_err(dev, "unable to request tx dma channel\n");
> -		ret = PTR_ERR(host->dma_chan_tx);
> -		host->dma_chan_tx = NULL;
> -		goto out;
> -	}
> +	host->dma_chan_tx = devm_dma_request_chan(dev, "tx");
> +	if (IS_ERR(host->dma_chan_tx))
> +		return dev_err_probe(dev, PTR_ERR(host->dma_chan_tx),
> +				     "unable to request tx dma channel\n");

We should still release DMA rx channel before returning here.

>   
>   	if (host->pdata) {
>   		host->detect_delay_ms = host->pdata->detect_delay_ms;
> @@ -724,25 +721,21 @@ static int pxamci_probe(struct platform_device *pdev)
>   		host->power = devm_gpiod_get_optional(dev, "power", GPIOD_OUT_LOW);
>   		if (IS_ERR(host->power)) {
>   			ret = PTR_ERR(host->power);
> -			dev_err(dev, "Failed requesting gpio_power\n");
> -			goto out;
> +			return dev_err_probe(dev, ret, "Failed requesting gpio_power\n");

Don't we need to release DMA Rx and Tx channels before we return from here?

>   		}
>   
>   		/* FIXME: should we pass detection delay to debounce? */
>   		ret = mmc_gpiod_request_cd(mmc, "cd", 0, false, 0);
> -		if (ret && ret != -ENOENT) {
> -			dev_err(dev, "Failed requesting gpio_cd\n");
> -			goto out;
> -		}
> +		if (ret && ret != -ENOENT)
> +			return dev_err_probe(dev, ret, "Failed requesting gpio_cd\n");

Same here

>   
>   		if (!host->pdata->gpio_card_ro_invert)
>   			mmc->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
>   
>   		ret = mmc_gpiod_request_ro(mmc, "wp", 0, 0);
> -		if (ret && ret != -ENOENT) {
> -			dev_err(dev, "Failed requesting gpio_ro\n");
> -			goto out;
> -		}
> +		if (ret && ret != -ENOENT)
> +			return dev_err_probe(dev, ret, "Failed requesting gpio_ro\n");

and here.

Looking at Documentation/driver-api/driver-model/devres.rst, 
dma_request_chan() is not devres managed interface and thus will not be 
released automatically. Do you agree?

--
Khalid

> +
>   		if (!ret)
>   			host->use_ro_gpio = true;
>   
> @@ -759,16 +752,8 @@ static int pxamci_probe(struct platform_device *pdev)
>   	if (ret) {
>   		if (host->pdata && host->pdata->exit)
>   			host->pdata->exit(dev, mmc);
> -		goto out;
>   	}
>   
> -	return 0;
> -
> -out:
> -	if (host->dma_chan_rx)
> -		dma_release_channel(host->dma_chan_rx);
> -	if (host->dma_chan_tx)
> -		dma_release_channel(host->dma_chan_tx);
>   	return ret;
>   }
>   
> Best regards
> Uwe

