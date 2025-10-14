Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713B51D7E4A;
	Tue, 14 Oct 2025 13:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760448674; cv=none; b=k8X2orvpbCMJOPJsjDTiYyJ0RSULj4rVIwX1uEG96kEGss3U2rXvLKyYqoo/rDT9lNVKfJONO+mtVvA9b5k777MFg4O/0lKV094nU5Le1O6pXayd94XfisOQvFB/hkTflEBcFVMVjTIqQgu5Ppu4e+j5w/hlRiLiezCu3N6W53g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760448674; c=relaxed/simple;
	bh=Pd+RXTNXqwtTl0Ps6q82IpRn8j9zy3XBl+4lbBTNB7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A8Tpuqy4FVCTCD/PT6/ESAj+BfjegSySWLaLE0OJbencUWZGE5GUL8hMAXEy0u0asvGGH6s9881zDrpNRGK/M6Bw8IcCXE2srZsCaeiNbYSOUGOPNkRuXyKvdAvAmguh1AlewIdhF59S2xjgetE/SEB9po6kJsJIDafdWdfvkCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9DFYFoD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9DFYFoD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911A2C4CEE7;
	Tue, 14 Oct 2025 13:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760448674;
	bh=Pd+RXTNXqwtTl0Ps6q82IpRn8j9zy3XBl+4lbBTNB7s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O9DFYFoDzF00egIpQI7+sSk2FaOh6iFX2u4d1w81THKSYCDMlTInjn5WZTb3aCldv
	 7arr+/E7J4eX7Uu8AWbwM0nxyXOgkJevOsTJKiWCZ+V7OIOcLwu5RgECoaguW8LiAG
	 +RlLGfZuXpk4E78YsTJNjo7bAg7CID27fVCXRUgEDiiKFwa3HVKTHNyEemp8bDB9Zu
	 oIj89hbDlH4kQvgw27eUqmRJyWO1my7H/j+Aw7wJ/IFtu2+8iLfcq6yWb1LB1kRBUR
	 lnfkuPsQBy4CS6xUQzz7TopKQKX9H0dsoyavdt18wZF2C1rCU17hoeEC4FGAER2+jJ
	 otPCpEeNcK/XA==
Message-ID: <ed5bcdca-9a6d-4144-acd7-1c1feeaadb0f@kernel.org>
Date: Tue, 14 Oct 2025 07:31:13 -0600
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: pxamci: Fix passing NULL to PTR_ERR() in
 pxamci_probe()
To: Dan Carpenter <dan.carpenter@linaro.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Rakuram Eswaran <rakuram.e96@gmail.com>, chenhuacai@kernel.org,
 david.hunter.linux@gmail.com, linux-kernel-mentees@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, lkp@intel.com,
 skhan@linuxfoundation.org, ulf.hansson@linaro.org, zhoubinbin@loongson.cn
References: <xxtrhbv5qm2crtvc5ejpgu5caadsmms3rfulmosjwq7lumrko3@5mlcpk24hymm>
 <20251012183804.15171-1-rakuram.e96@gmail.com>
 <6j7ix5yof7qmrp6cgxhqver7yimvmgj7dujqu4l7cnzbpjksfd@5sp7am47gigw>
 <8afff048-4fe1-440a-9739-e5a5ea43d6eb@kernel.org>
 <aO5BnwkNNyv_GOGS@stanley.mountain>
Content-Language: en-US
From: Khalid Aziz <khalid@kernel.org>
In-Reply-To: <aO5BnwkNNyv_GOGS@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/14/25 6:27 AM, Dan Carpenter wrote:
> On Mon, Oct 13, 2025 at 04:54:13PM -0600, Khalid Aziz wrote:
>>> @@ -703,20 +705,15 @@ static int pxamci_probe(struct platform_device *pdev)
>>>    	platform_set_drvdata(pdev, mmc);
>>> -	host->dma_chan_rx = dma_request_chan(dev, "rx");
>>> -	if (IS_ERR(host->dma_chan_rx)) {
>>> -		host->dma_chan_rx = NULL;
>>> +	host->dma_chan_rx = devm_dma_request_chan(dev, "rx");
>>> +	if (IS_ERR(host->dma_chan_rx))
>>>    		return dev_err_probe(dev, PTR_ERR(host->dma_chan_rx),
>>>    				     "unable to request rx dma channel\n");
>>> -	}
>>> -	host->dma_chan_tx = dma_request_chan(dev, "tx");
>>> -	if (IS_ERR(host->dma_chan_tx)) {
>>> -		dev_err(dev, "unable to request tx dma channel\n");
>>> -		ret = PTR_ERR(host->dma_chan_tx);
>>> -		host->dma_chan_tx = NULL;
>>> -		goto out;
>>> -	}
>>> +	host->dma_chan_tx = devm_dma_request_chan(dev, "tx");
>>> +	if (IS_ERR(host->dma_chan_tx))
>>> +		return dev_err_probe(dev, PTR_ERR(host->dma_chan_tx),
>>> +				     "unable to request tx dma channel\n");
>>
>> We should still release DMA rx channel before returning here.
>>
>>>    	if (host->pdata) {
>>>    		host->detect_delay_ms = host->pdata->detect_delay_ms;
>>> @@ -724,25 +721,21 @@ static int pxamci_probe(struct platform_device *pdev)
>>>    		host->power = devm_gpiod_get_optional(dev, "power", GPIOD_OUT_LOW);
>>>    		if (IS_ERR(host->power)) {
>>>    			ret = PTR_ERR(host->power);
>>> -			dev_err(dev, "Failed requesting gpio_power\n");
>>> -			goto out;
>>> +			return dev_err_probe(dev, ret, "Failed requesting gpio_power\n");
>>
>> Don't we need to release DMA Rx and Tx channels before we return from here?
>>
>>>    		}
>>>    		/* FIXME: should we pass detection delay to debounce? */
>>>    		ret = mmc_gpiod_request_cd(mmc, "cd", 0, false, 0);
>>> -		if (ret && ret != -ENOENT) {
>>> -			dev_err(dev, "Failed requesting gpio_cd\n");
>>> -			goto out;
>>> -		}
>>> +		if (ret && ret != -ENOENT)
>>> +			return dev_err_probe(dev, ret, "Failed requesting gpio_cd\n");
>>
>> Same here
>>
>>>    		if (!host->pdata->gpio_card_ro_invert)
>>>    			mmc->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
>>>    		ret = mmc_gpiod_request_ro(mmc, "wp", 0, 0);
>>> -		if (ret && ret != -ENOENT) {
>>> -			dev_err(dev, "Failed requesting gpio_ro\n");
>>> -			goto out;
>>> -		}
>>> +		if (ret && ret != -ENOENT)
>>> +			return dev_err_probe(dev, ret, "Failed requesting gpio_ro\n");
>>
>> and here.
>>
>> Looking at Documentation/driver-api/driver-model/devres.rst,
>> dma_request_chan() is not devres managed interface and thus will not be
>> released automatically. Do you agree?
>>
> 
> The patch changes dma_request_chan() to devm_dma_request_chan().
> 

Ah, yes. It does. That works then.

Thanks,
Khalid

> regards,
> dan carpenter
> 

