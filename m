Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC96B155389;
	Tue,  7 Oct 2025 17:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759858988; cv=none; b=J/2IcF+ebjnGDdPIL8pI9F6mAa0danVnNbkRNbm5YyYYvy06HYcO3XLZBWvwJDUvFMjPTVrG80NF7y8mCJTbtRZBhb2xMFu7h6NdueaLFGe/KjeIyPIE3NL2lsWNByXxD63jwTchHgG2lKFCs0/JEjcKpJt7VnvBvqM+js9gFiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759858988; c=relaxed/simple;
	bh=1W7eD4LmjRgsHbhA7j5gZwdnLJtmeU4zAiC/DIZRRuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mehipkOAZORff3F/E2p25KtMItGaG04+TLLd7A09+4kV1iqZdh8wTQK/9mAx71xdrfLadDgxwKBAFqOMDXffPJ1FEBSUsa3h49PtDymGP/eDt3/rqEkCk8CvmcFVQIHCu3Kw4NUWjIgoaYes9QHB1ulba0Zr6jDsFx2yz55229Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9k5KcwT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9k5KcwT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2907CC4CEF1;
	Tue,  7 Oct 2025 17:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759858988;
	bh=1W7eD4LmjRgsHbhA7j5gZwdnLJtmeU4zAiC/DIZRRuI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E9k5KcwTEBVStmsUVgXKdljdj/YCqTGi0JJqywUZ/BCaOZ501ifGb0usru57FCmKm
	 ioje5xC0wMTi0w9ih4Xs5SWJJkDJAotqiKOJOq3t+hBVpmngo8X1Bc3Z/yXUWUsy+u
	 sZVWiG9n7TNidyjbtN2lUt/rrLC4OSLisez7sK3SLzfVx9HV0sgxnDrjOO5LIDhc4A
	 00w3L5haZnxzzTR6pf0cB7x0/7HelhGYqcRZ/XJshb/1+9A7GjgoaEVD/h+M6Vb+5G
	 XjIMwHsnBbyHX3Fal5NrNTYxmZMi0sgn0Kk46flyMjx75jgiLx03+RmpM4Zlwzf0HJ
	 ofXMiCRaHAXYw==
Message-ID: <a5a86f30-4e52-4694-a6e4-3b71d46c793b@kernel.org>
Date: Tue, 7 Oct 2025 11:43:07 -0600
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: pxamci: Fix passing NULL to PTR_ERR() in
 pxamci_probe()
To: Rakuram Eswaran <rakuram.e96@gmail.com>, ulf.hansson@linaro.org
Cc: zhoubinbin@loongson.cn, u.kleine-koenig@baylibre.com,
 chenhuacai@kernel.org, david.hunter.linux@gmail.com,
 skhan@linuxfoundation.org, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 kernel test robot <lkp@intel.com>, Dan Carpenter <dan.carpenter@linaro.org>
References: <20251007161948.12442-1-rakuram.e96@gmail.com>
Content-Language: en-US
From: Khalid Aziz <khalid@kernel.org>
In-Reply-To: <20251007161948.12442-1-rakuram.e96@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/7/25 10:17 AM, Rakuram Eswaran wrote:
> Smatch reported:
> drivers/mmc/host/pxamci.c:709 pxamci_probe() warn: passing zero to 'PTR_ERR'
> 
> Case 1:
> When dma_request_chan() fails, host->dma_chan_rx is an ERR_PTR(),
> but it is reset to NULL before using PTR_ERR(), resulting in PTR_ERR(0).
> This mistakenly returns 0 instead of the real error code.
> 
> Case 2:
> When devm_clk_get() fails, host->clk is an ERR_PTR() resulting in the similar
> issue like case 1.
> 
> Store the error code before nullifying the pointers in both the cases.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202510041841.pRlunIfl-lkp@intel.com/
> Fixes: 58c40f3faf742c ("mmc: pxamci: Use devm_mmc_alloc_host() helper")
> Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>
> ---
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
>   drivers/mmc/host/pxamci.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> index 26d03352af63..4fab693d3b32 100644
> --- a/drivers/mmc/host/pxamci.c
> +++ b/drivers/mmc/host/pxamci.c
> @@ -653,8 +653,9 @@ static int pxamci_probe(struct platform_device *pdev)
>   
>   	host->clk = devm_clk_get(dev, NULL);
>   	if (IS_ERR(host->clk)) {
> +		ret = PTR_ERR(host->clk);
>   		host->clk = NULL;
> -		return PTR_ERR(host->clk);
> +		return ret;
>   	}
>   
>   	host->clkrate = clk_get_rate(host->clk);
> @@ -705,8 +706,9 @@ static int pxamci_probe(struct platform_device *pdev)
>   
>   	host->dma_chan_rx = dma_request_chan(dev, "rx");
>   	if (IS_ERR(host->dma_chan_rx)) {
> +		ret = PTR_ERR(host->dma_chan_rx);
>   		host->dma_chan_rx = NULL;
> -		return dev_err_probe(dev, PTR_ERR(host->dma_chan_rx),
> +		return dev_err_probe(dev, ret,
>   				     "unable to request rx dma channel\n");
>   	}
>   

This looks good to me.

Reviewed-by: Khalid Aziz <khalid@kernel.org>

--
Khalid
