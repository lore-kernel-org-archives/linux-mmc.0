Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF1A2874E1;
	Tue, 14 Oct 2025 19:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760470323; cv=none; b=Bb9Gem+JfzLUBNXv+j/KIiAjcfcdrVYlKVpt+31a5kQ0Pvm/tzazKt6J9qPcCblAecnrVESIdtmfEBTvMs9zUxNLeZdX0w4aM/K5tK1zBanYf5SQrw/kXhhLnwMc86es+fuCXkq+9FdE2RvpIOqYIST6xGmZakGOPILlXmsc29M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760470323; c=relaxed/simple;
	bh=X1XYILS4PYawHLwWQb6dY8gYVnKbbRtl5rUw+yvMvcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F2jy0NVycREoSJj18ctD9iTv4DfzgloQDS4vZrejQYntQyD96ibNG26fVGbS9hAix7ijWaFIKbzNReRJWyaTHeEpR1VAkNPWI4vjV+LTqA828Spf5w+p07LrEEo2zD2IVvyGr9pIbxKfKbOKN7Jg224l2W0USlSbl68DM7cOcOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCpA/e8I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCpA/e8I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A10C4CEF9;
	Tue, 14 Oct 2025 19:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760470323;
	bh=X1XYILS4PYawHLwWQb6dY8gYVnKbbRtl5rUw+yvMvcI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LCpA/e8IfQcXZrCtmPpmkDVgugz9ns/LpbYH29kpFdma3eTBZv54uz0ZJ27lqYJ0k
	 vsygBYRg662v9jVwelASkkkmK5IGr654MM1qA2PssDmldzmK0LHbS9qdIKxTh/FLQI
	 3dbxGzu8gxCMtp0RSBMfkPXIIwF5MU2LsgLJKi5n6sFbDyXM6NlP2wSuUa5dMl98mU
	 UruIk32ihN6/krwwOGYV6CLDbzMyE03J9CDnZT1Lu3uMvALMOpIW9DIgT4pwkpEEmZ
	 ZF1fjcnnoKOt+Q4GyuC9E5XaVu1mmu1k2U4xj4ckcsaaryvPytfw15NpVpn0BPIhVo
	 A3M6ds98zRC2A==
Message-ID: <a7a9d9aa-4ed4-494c-a7da-c47c84ff677c@kernel.org>
Date: Tue, 14 Oct 2025 13:32:02 -0600
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: pxamci: Simplify pxamci_probe() error handling
 using devm APIs
To: Rakuram Eswaran <rakuram.e96@gmail.com>, ulf.hansson@linaro.org
Cc: u.kleine-koenig@baylibre.com, chenhuacai@kernel.org,
 david.hunter.linux@gmail.com, skhan@linuxfoundation.org,
 zhoubinbin@loongson.cn, linux-kernel-mentees@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 kernel test robot <lkp@intel.com>, Dan Carpenter <dan.carpenter@linaro.org>
References: <20251014184657.111144-1-rakuram.e96@gmail.com>
Content-Language: en-US
From: Khalid Aziz <khalid@kernel.org>
In-Reply-To: <20251014184657.111144-1-rakuram.e96@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/14/25 12:46 PM, Rakuram Eswaran wrote:
> This patch refactors pxamci_probe() to use devm-managed resource
> allocation (e.g. devm_dma_request_chan()) and dev_err_probe() for
> improved readability and automatic cleanup on probe failure.
> 
> This eliminates redundant NULL assignments and manual release logic.
> 
> This issue was originally reported by Smatch:
> drivers/mmc/host/pxamci.c:709 pxamci_probe() warn: passing zero to 'PTR_ERR'
> 
> The warning occurred because a pointer was set to NULL before using
> PTR_ERR(), leading to PTR_ERR(0) and an incorrect 0 return value.
> This refactor eliminates that condition while improving overall
> error handling robustness.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202510041841.pRlunIfl-lkp@intel.com/
> Fixes: 58c40f3faf742c ("mmc: pxamci: Use devm_mmc_alloc_host() helper")
> Suggested-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>
> ---
> 
> Changes since v1:
> Following Uwe Kleine-König’s suggestion:
> - Replaced dma_request_chan() with devm_dma_request_chan() to make DMA
>    channel allocation devm-managed and avoid manual release paths.
> - Used dev_err_probe() for improved error reporting and consistent
>    probe failure handling.
> - Removed redundant NULL assignments and obsolete goto-based cleanup logic.
> - Updated commit message to better describe the intent of the change.
> 
> Testing note:
> I do not have access to appropriate hardware for runtime testing.
> Any help verifying on actual hardware would be appreciated.
> 
> Build and Analysis:
> This patch was compiled against the configuration file reported by
> 0day CI in the above link (config: s390-randconfig-r071-20251004) using
> `s390x-linux-gnu-gcc (Ubuntu 14.2.0-19ubuntu2) 14.2.0`.
> 
> Static analysis was performed with Smatch to ensure the reported warning
> no longer reproduces after applying this fix.
> 
> Command used for verification:
>    ARCH=s390 CROSS_COMPILE=s390x-linux-gnu- \
>    ~/project/smatch/smatch_scripts/kchecker ./drivers/mmc/host/pxamci.c
> 
>   drivers/mmc/host/pxamci.c | 57 +++++++++++++++------------------------
>   1 file changed, 21 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> index 26d03352af63..d03388f64934 100644
> --- a/drivers/mmc/host/pxamci.c
> +++ b/drivers/mmc/host/pxamci.c
> @@ -652,11 +652,14 @@ static int pxamci_probe(struct platform_device *pdev)
>   	host->clkrt = CLKRT_OFF;
>   
>   	host->clk = devm_clk_get(dev, NULL);
> -	if (IS_ERR(host->clk)) {
> -		host->clk = NULL;
> -		return PTR_ERR(host->clk);
> -	}
> +	if (IS_ERR(host->clk))
> +		return dev_err_probe(dev, PTR_ERR(host->clk),
> +				     "Failed to acquire clock\n");
>   
> +	/*
> +	 * Note that the return value of clk_get_rate() is only valid
> +	 * if the clock is enabled.
> +	 */
>   	host->clkrate = clk_get_rate(host->clk);
>   
>   	/*
> @@ -703,46 +706,36 @@ static int pxamci_probe(struct platform_device *pdev)
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
>   
>   	if (host->pdata) {
>   		host->detect_delay_ms = host->pdata->detect_delay_ms;
>   
>   		host->power = devm_gpiod_get_optional(dev, "power", GPIOD_OUT_LOW);
> -		if (IS_ERR(host->power)) {
> -			ret = PTR_ERR(host->power);
> -			dev_err(dev, "Failed requesting gpio_power\n");
> -			goto out;
> -		}
> +		if (IS_ERR(host->power))
> +			return dev_err_probe(dev, PTR_ERR(host->power),
> +						"Failed requesting gpio_power\n");
>   
>   		/* FIXME: should we pass detection delay to debounce? */
>   		ret = mmc_gpiod_request_cd(mmc, "cd", 0, false, 0);
> -		if (ret && ret != -ENOENT) {
> -			dev_err(dev, "Failed requesting gpio_cd\n");
> -			goto out;
> -		}
> +		if (ret && ret != -ENOENT)
> +			return dev_err_probe(dev, ret, "Failed requesting gpio_cd\n");
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

This looks good now.

Reviewed-by: Khalid Aziz <khalid@kernel.org>

--
Khalid
