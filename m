Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCC715B971;
	Thu,  9 Oct 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025188; cv=none; b=pNC+rGB8348/f79VxEFWHrwKYKyFzP7oNigx87az/Xsd+4ttaeYeS/W0G3FbYt7JqycCqk6dNX2kEbt009A3YS3kurHvwNHBN6tMMZokV96/xJ/Sr3qaanFTU8YqOn2qT3t++w8YOJ1nmffc1hHMKwRNbu50/XRiStBEuNba8Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025188; c=relaxed/simple;
	bh=DRY+bck72bFWLR+8BmkVmyrqTwQEZ9IGus6h3DbmY70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rWO8CDN4lwBXWZA7yZh0cFEYowqiLOcYxQfhuh3S0M9U6qBt7JEj79/0pyWhMibamwndSeMV14LHTfR9yv7Nwrg29OTEjB+CpzI4t7aqJ+z5dlKdWpGBZBQM7Wjo+W0ULo3vKYT8VvXBLoxPTQnWkHdpf1uY/h3MB+hC0bVxTpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjEEGCAG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjEEGCAG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0035DC4CEE7;
	Thu,  9 Oct 2025 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760025185;
	bh=DRY+bck72bFWLR+8BmkVmyrqTwQEZ9IGus6h3DbmY70=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BjEEGCAGZRON0a4Wm+u/hhGoiNOaEQShjNIjlCDnGApfHUC45F8bgxuSxFGJpN2Zd
	 ckV1qeJNWx88YogbwcIxTsMSd9/ezPXOdyQUDeJN5LeCemQtVTDOPuJUdT5J0dU8DK
	 LmB3JFqkNCkte2sabAjDe6Ir1O/GOMeoGUnJWuEWh/KrR/dnYNzHtRjNqvKYvMMN70
	 MIsT1ZkGty6U1nu+Zdiinl6Ij+3aWo+RFNXLYdkhSfgKFdYc4VtvzFaxJPJihUDIDY
	 07BVMJH5ePes63tAm8yqcUI5Im+yb1PgdSkSRqPPZQKpn3GugETSTVtUgLWJSGtfRs
	 LjIWhnEmIWRfg==
Message-ID: <c0eb8875-b7cf-421d-93d6-6195b13e6930@kernel.org>
Date: Thu, 9 Oct 2025 09:53:04 -0600
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
Cc: ulf.hansson@linaro.org, zhoubinbin@loongson.cn, chenhuacai@kernel.org,
 david.hunter.linux@gmail.com, skhan@linuxfoundation.org,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, kernel test robot <lkp@intel.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20251007161948.12442-1-rakuram.e96@gmail.com>
 <pe4sz3hamkxhahvwqzdq3p3q5u3yeqpdscl5rvvoo5gdfbbrl7@joiz2oj5y4so>
Content-Language: en-US
From: Khalid Aziz <khalid@kernel.org>
In-Reply-To: <pe4sz3hamkxhahvwqzdq3p3q5u3yeqpdscl5rvvoo5gdfbbrl7@joiz2oj5y4so>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/9/25 2:57 AM, Uwe Kleine-König wrote:
> On Tue, Oct 07, 2025 at 09:47:44PM +0530, Rakuram Eswaran wrote:
>> Smatch reported:
>> drivers/mmc/host/pxamci.c:709 pxamci_probe() warn: passing zero to 'PTR_ERR'
>>
>> Case 1:
>> When dma_request_chan() fails, host->dma_chan_rx is an ERR_PTR(),
>> but it is reset to NULL before using PTR_ERR(), resulting in PTR_ERR(0).
>> This mistakenly returns 0 instead of the real error code.
>>
>> Case 2:
>> When devm_clk_get() fails, host->clk is an ERR_PTR() resulting in the similar
>> issue like case 1.
>>
>> Store the error code before nullifying the pointers in both the cases.
> 
> Why is the pointer set to NULL at all? This is in both cases memory that
> is freed directly afterwards (as `host` is devm managed). So I'd claim

I am not sure that sounds right. Looking at the code for 
__devm_clk_get(), if devres_alloc() fails, it returns -ENOMEM. If any of 
the other steps after a successful devres_alloc() fail, code goes 
through possibly clk_put() if needed and then devres_free(). So the 
resources are already freed at this point before the return to 
pxamci_probe(). The only thing left to do is to set host->clk to NULL 
since it would be set to an error pointer at this point.

Am I missing something?

Thanks,
Khalid


> 
> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> index 26d03352af63..404f78198252 100644
> --- a/drivers/mmc/host/pxamci.c
> +++ b/drivers/mmc/host/pxamci.c
> @@ -652,10 +652,8 @@ static int pxamci_probe(struct platform_device *pdev)
>   	host->clkrt = CLKRT_OFF;
>   
>   	host->clk = devm_clk_get(dev, NULL);
> -	if (IS_ERR(host->clk)) {
> -		host->clk = NULL;
> +	if (IS_ERR(host->clk))
>   		return PTR_ERR(host->clk);
> -	}
>   
>   	host->clkrate = clk_get_rate(host->clk);
>   
> @@ -704,11 +702,9 @@ static int pxamci_probe(struct platform_device *pdev)
>   	platform_set_drvdata(pdev, mmc);
>   
>   	host->dma_chan_rx = dma_request_chan(dev, "rx");
> -	if (IS_ERR(host->dma_chan_rx)) {
> -		host->dma_chan_rx = NULL;
> +	if (IS_ERR(host->dma_chan_rx))
>   		return dev_err_probe(dev, PTR_ERR(host->dma_chan_rx),
>   				     "unable to request rx dma channel\n");
> -	}
>   
>   	host->dma_chan_tx = dma_request_chan(dev, "tx");
>   	if (IS_ERR(host->dma_chan_tx)) {
> 
> is a superior patch.
> 
> Best regards
> Uwe

