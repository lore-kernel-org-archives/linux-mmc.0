Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C05E33DECB;
	Tue, 28 Oct 2025 15:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666634; cv=none; b=hucX2iMaQAVpS5Usr/GWzElAUq3GUmVGHq5OVUw1HvqARiH/iycq8exDI8Ny0LkKoB27I0WyJqW0wzBW6EAdlQgvVzlV8qf/goG+oiPyTxLtxjrsayRKqfwwKn+56GJiW3fHlYUtnjSudZneuHjFASry/CoBAQYbhyRdnW2bJjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666634; c=relaxed/simple;
	bh=xSCOkg4ucLk3x8OtuE7FGP9DNFzTsgpO2iRYEJXYRms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vsj7FRb2tNbHIG14b2gthGoGzYCC4xAhVmsM+fyHxJYc1BWA21fXdsZ/SZcLfw6paWHForoDqxd1sIC+T/5Atk9urXe3tZYi9I1O0mQ3vIODqpotuYoDNNOunNbP+pPirPWo06NZdfdUhhly0XkqKi0WasqziHx5Tq2ciOnj5Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pwfg2R3n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pwfg2R3n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31A6C4CEE7;
	Tue, 28 Oct 2025 15:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761666634;
	bh=xSCOkg4ucLk3x8OtuE7FGP9DNFzTsgpO2iRYEJXYRms=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Pwfg2R3n++bXY1DZvM+kkfq5xwFjt8aVZK7q7KwhGhd1rfJevN/MsxVeMQsG4Yz+t
	 4KqwORGNDrIlCeus0j5iTYsXD3/9jDIAVcE9h3xn1uZo5nbAS2C4xt8/DDlZD4UGlQ
	 tQRmzuLs0q8De5YxhPuQSMUeH9SeX+6m1mSPg1hs1QcToW39YyPbeOpkjt3kM6nRDv
	 Yz1sgBnb25CoXQ+cfysoBLqbcLYH8xShGJC4Z/xIUIo5TBt/nYSBR9G+jmWyH9G4f6
	 OH6O4fCLuAlotkOakXyLeh7tIUfAo5Hfe35zcMc8lsp8QpNWSHpxIsene+BPWfZn/J
	 JDz+YnRSt2pEA==
Message-ID: <d9478ebe-ff55-41fa-a3be-711061e988bb@kernel.org>
Date: Tue, 28 Oct 2025 09:50:33 -0600
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mmc: pxamci: Simplify pxamci_probe() error handling
 using devm APIs
To: Rakuram Eswaran <rakuram.e96@gmail.com>, ulf.hansson@linaro.org,
 u.kleine-koenig@baylibre.com
Cc: chenhuacai@kernel.org, dan.carpenter@linaro.org,
 david.hunter.linux@gmail.com, zhoubinbin@loongson.cn,
 linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, lkp@intel.com, skhan@linuxfoundation.org
References: <20251023145432.164696-1-rakuram.e96@gmail.com>
From: Khalid Aziz <khalid@kernel.org>
Content-Language: en-US
In-Reply-To: <20251023145432.164696-1-rakuram.e96@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/23/25 8:54 AM, Rakuram Eswaran wrote:
> This patch refactors pxamci_probe() to use devm-managed resource
> allocation (e.g. devm_dma_request_chan) and dev_err_probe() for
> improved readability and automatic cleanup on probe failure.
> 
> It also removes redundant NULL assignments and manual resource release
> logic from pxamci_probe(), and eliminates the corresponding release
> calls from pxamci_remove().
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202510041841.pRlunIfl-lkp@intel.com/
> Fixes: 58c40f3faf742c ("mmc: pxamci: Use devm_mmc_alloc_host() helper")
> Suggested-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>
> ---

This looks good to me now.

Reviewed-by: Khalid Aziz <khalid@kernel.org>

--
Khalid

> 
> Changes since v2:
> - Dropped redundant dma_release_channel() calls from pxamci_remove() as
>    devm_dma_request_chan() automatically handles resource cleanup.
> - Added link to v2 for reference:
>    https://lore.kernel.org/linux-mmc/20251014184657.111144-1-rakuram.e96@gmail.com/
> 
> Changes since v1:
> Following Uwe Kleine-König’s suggestion:
> - Replaced dma_request_chan() with devm_dma_request_chan() to make DMA
>    channel allocation devm-managed and avoid manual release paths.
> - Adopted dev_err_probe() for improved error reporting and consistent
>    probe failure handling.
> - Removed redundant NULL assignments and obsolete goto-based cleanup logic.
> - Updated commit message to better describe the intent of the change.
> - Added link to v1 for reference:
>    https://lore.kernel.org/linux-mmc/20251007161948.12442-1-rakuram.e96@gmail.com/
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
>   drivers/mmc/host/pxamci.c | 56 +++++++++++++--------------------------
>   1 file changed, 18 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> index 26d03352af63..b5ea058ed467 100644
> --- a/drivers/mmc/host/pxamci.c
> +++ b/drivers/mmc/host/pxamci.c
> @@ -652,10 +652,9 @@ static int pxamci_probe(struct platform_device *pdev)
>   	host->clkrt = CLKRT_OFF;
>   
>   	host->clk = devm_clk_get(dev, NULL);
> -	if (IS_ERR(host->clk)) {
> -		host->clk = NULL;
> -		return PTR_ERR(host->clk);
> -	}
> +	if (IS_ERR(host->clk))
> +		return dev_err_probe(dev, PTR_ERR(host->clk),
> +					"Failed to acquire clock\n");
>   
>   	host->clkrate = clk_get_rate(host->clk);
>   
> @@ -703,46 +702,37 @@ static int pxamci_probe(struct platform_device *pdev)
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
> +
> +	host->dma_chan_tx = devm_dma_request_chan(dev, "tx");
> +	if (IS_ERR(host->dma_chan_tx))
> +		return dev_err_probe(dev, PTR_ERR(host->dma_chan_tx),
> +					"unable to request tx dma channel\n");
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
> @@ -759,16 +749,8 @@ static int pxamci_probe(struct platform_device *pdev)
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
> @@ -791,8 +773,6 @@ static void pxamci_remove(struct platform_device *pdev)
>   
>   		dmaengine_terminate_all(host->dma_chan_rx);
>   		dmaengine_terminate_all(host->dma_chan_tx);
> -		dma_release_channel(host->dma_chan_rx);
> -		dma_release_channel(host->dma_chan_tx);
>   	}
>   }
>   

