Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EBB1FBEAC;
	Tue, 27 May 2025 06:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748329129; cv=none; b=PO45xnB2fYANIf0yrqiqFKayF57KyU6Lkq7zFjtAWLTHS9DNFu8ZYD6w+OnPyG+aR7x0PLGDX7DFjztWPVytj2u2LNtQviD5oWVVsFBBJVrHiUN5Taoa1Dp2JBiqa4kmM2HKEtBYO0nZ/+2QhBhEx7KeNPrO5UAKD3x+OMr+EjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748329129; c=relaxed/simple;
	bh=+nmJhTqJFkRyprJewCSUIRAOqsTIpamR0GF6tmQGjrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iy8SYGyef56km3z6yta+vjKwfb3kXobFe7qwjegIW7uUloDS4/pQE79VvhA3CMwHW4Ir1mB0wlkYJddyUkddNhQrYBqEojC/29n26q8+MD3xqT4sIkPCCeezl5COG5d3NKOjGc5VSrU+490apz3VboUwmdda0VZElb2XmqG4Om8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.18.143])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 54030343086;
	Tue, 27 May 2025 06:58:46 +0000 (UTC)
Date: Tue, 27 May 2025 06:58:41 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] mmc: sdhci-of-k1: Fix error code in probe()
Message-ID: <20250527065841-GYB55693@gentoo>
References: <aDVTtQdXVtRhxOrb@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDVTtQdXVtRhxOrb@stanley.mountain>

Hi Dan,

On 08:55 Tue 27 May     , Dan Carpenter wrote:
> If spacemit_sdhci_get_clocks() fails, then propagate the error code.
> Don't return success.
> 
> Fixes: e5502d15b0f3 ("mmc: sdhci-of-k1: add support for SpacemiT K1 SoC")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/mmc/host/sdhci-of-k1.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
> index 6880d3e9ab62..2e5da7c5834c 100644
> --- a/drivers/mmc/host/sdhci-of-k1.c
> +++ b/drivers/mmc/host/sdhci-of-k1.c
> @@ -276,7 +276,8 @@ static int spacemit_sdhci_probe(struct platform_device *pdev)
>  
>  	host->mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
>  
> -	if (spacemit_sdhci_get_clocks(dev, pltfm_host))
> +	ret = spacemit_sdhci_get_clocks(dev, pltfm_host);
> +	if (ret)
>  		goto err_pltfm;
>  
>  	ret = sdhci_add_host(host);
> -- 
> 2.47.2
> 
Thanks for catching this..

Reviewed-by: Yixun Lan <dlan@gentoo.org>

-- 
Yixun Lan (dlan)
