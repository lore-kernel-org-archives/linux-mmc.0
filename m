Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F48622DA06
	for <linux-mmc@vger.kernel.org>; Thu, 29 May 2025 15:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748532226; cv=none; b=eIUSmVHDSAF60mzoTUltsw/hUj290LpIRH58nUxM1eOMa9fqiySVepgZ9eV+2VlM3lgvDly2t8TxNmzD2edxDBUlMfotS4anOfUydcuD1QOf90mebLdrDwGYeF2onoXpR4d9bzLKEk71qo3AYTLNWmUzScpkKF9yrioHYUetVJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748532226; c=relaxed/simple;
	bh=nPhvSZzHK+QvDxlR8MMTNIEtJF2U6PNCLmdMiz1boPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0bJ3TCwUflYHnF/nzK5/WmEGAoT9GhbgwtgBaQYKizlvepE2UMch4HDVW1Tiq8hia3UzlLcj808huUwKxyUEzUzGOkwLv5NUAqKfyZWqUn7lCAigFzif2EpnCBsv15sf2KzyPzaJFHj8W67y9/3RY2sLDGD/Osq9Gdg0wdtt+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.147.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 06FA1343169;
	Thu, 29 May 2025 15:23:43 +0000 (UTC)
Date: Thu, 29 May 2025 15:23:38 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Huacai Chen <chenhuacai@kernel.org>, linux-mmc@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: [PATCH v2 22/35] mmc: sdhci-of-k1: Drop the use of
 sdhci_pltfm_free()
Message-ID: <20250529152338-GYC64143@gentoo>
References: <cover.1748515612.git.zhoubinbin@loongson.cn>
 <84cc84004d0bdbb2ee1c68dbea4b23eeefe8845b.1748515612.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84cc84004d0bdbb2ee1c68dbea4b23eeefe8845b.1748515612.git.zhoubinbin@loongson.cn>

On 21:00 Thu 29 May     , Binbin Zhou wrote:
> Since the devm_mmc_alloc_host() helper is already in use,
> sdhci_pltfm_free() is no longer needed.
> 
> Cc: Yixun Lan <dlan@gentoo.org>
> Cc: linux-riscv@lists.infradead.org
> Cc: spacemit@lists.linux.dev
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>

Reviewed-by: Yixun Lan <dlan@gentoo.org>

> ---
>  drivers/mmc/host/sdhci-of-k1.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
> index 6880d3e9ab62..026dc79af292 100644
> --- a/drivers/mmc/host/sdhci-of-k1.c
> +++ b/drivers/mmc/host/sdhci-of-k1.c
> @@ -286,7 +286,6 @@ static int spacemit_sdhci_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_pltfm:
> -	sdhci_pltfm_free(pdev);
>  	return ret;
>  }
>  
> -- 
> 2.47.1
> 

-- 
Yixun Lan (dlan)
