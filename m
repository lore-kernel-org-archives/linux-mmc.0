Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2764D1F4187
	for <linux-mmc@vger.kernel.org>; Mon, 26 May 2025 10:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748253885; cv=none; b=dMh1u9v0xLRh2q/3ryO4jG3Xpb3X0fSo3ACbxAKnXIlhx7Knibxb+iXMyUCemobv7kcWLiXNsl/aBVTD3HmoFgO8YkwI0P9OzPHWPWuJHFHP6MLIXUoe78WFh7XvC8fWDx/2aC49BIa/9pDZoVXbEHjAhNOP5TeYuv50wUKD+FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748253885; c=relaxed/simple;
	bh=ec8uspt4ncriXx6kL8YZ0OGhFSLMb29Sj7o0PRhfb4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqeKphx2AjoHvIsY2mm0hrZnTjnInbJoStHkumYzTWgTmBR2NFpSdRHqlRC9Uy4Zmx9KeVM+DHaI8mcWSSGBK/mztZzqt6pwmLG6V311beeiCVXf7KB310XWlgEsp+gvek8VZUVFiWfiid5OYojRbQAkga9U5JjTIgRgwTB5Ypk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.18.143])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id DBB9D34306C;
	Mon, 26 May 2025 10:04:42 +0000 (UTC)
Date: Mon, 26 May 2025 10:04:33 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Huacai Chen <chenhuacai@kernel.org>, linux-mmc@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: [PATCH 22/34] mmc: sdhci-of-k1: Drop the use of
 sdhci_pltfm_free()
Message-ID: <20250526100433-GYA52596@gentoo>
References: <cover.1747792905.git.zhoubinbin@loongson.cn>
 <a0906b1172c9452f700d97ff72484fda3023fbae.1747792905.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0906b1172c9452f700d97ff72484fda3023fbae.1747792905.git.zhoubinbin@loongson.cn>

hi Binbin,

On 14:06 Mon 26 May     , Binbin Zhou wrote:
> Since the devm_mmc_alloc_host() helper is already in
> use, sdhci_pltfm_free() is no longer needed.
> 
> Cc: Yixun Lan <dlan@gentoo.org>
> Cc: linux-riscv@lists.infradead.org
> Cc: spacemit@lists.linux.dev
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  drivers/mmc/host/sdhci-of-k1.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
> index 6880d3e9ab62..40c1929f2de2 100644
> --- a/drivers/mmc/host/sdhci-of-k1.c
> +++ b/drivers/mmc/host/sdhci-of-k1.c
> @@ -262,7 +262,7 @@ static int spacemit_sdhci_probe(struct platform_device *pdev)
>  
>  	ret = mmc_of_parse(host->mmc);
>  	if (ret)
> -		goto err_pltfm;
> +		return ret;
>  
>  	sdhci_get_of_property(pdev);
>  
> @@ -276,18 +276,11 @@ static int spacemit_sdhci_probe(struct platform_device *pdev)
>  
>  	host->mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
>  
> -	if (spacemit_sdhci_get_clocks(dev, pltfm_host))
> -		goto err_pltfm;
> -
> -	ret = sdhci_add_host(host);
> +	ret = spacemit_sdhci_get_clocks(dev, pltfm_host);
>  	if (ret)
> -		goto err_pltfm;
> -
> -	return 0;
> +		return ret;
>  
> -err_pltfm:
> -	sdhci_pltfm_free(pdev);
> -	return ret;
> +	return sdhci_add_host(host);
>  }
>  

although this patch looks good, but can you preserve the goto scheme?
we might add other error handlings as implement SD/SDIO in the future
(it also keeps the change minimal and easy to review)
 
-- 
Yixun Lan (dlan)
