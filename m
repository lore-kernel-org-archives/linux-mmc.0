Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2831CAA9C;
	Sun, 13 Jul 2025 08:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752396300; cv=none; b=ZZIfAeWyr1UcfsyqnoAh/CvUxuCo6kwkictlAAWvA9Hgk9tGHZNMBSa3rRdUOloqs8YoycclMq4uJu9jF34tlr7cLyN1ec+Mtx5wrwtQeqx9M+A0SOiyzaeJjkLfDMOheix8YpO9M7IU5t6zOCgMUYyv5WqSDBKTz45sF15Xb34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752396300; c=relaxed/simple;
	bh=ASPv/r6GXTBe7L2poja4xEnn6UOIN4wrVJugrHA0UqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MCqW5IUSESRraIMOc+17U6CNVF4BHfh+4DbRotCQwfepFUWEietCkRmLfdwcil/mDSU4HSak2iAEOcAX5+AXCjN3vPxAEJ/R/adc5zHSfn0oW4SN1hnYRoAIra7hu9AUCnVSa07IsOmHgZ6ilr+1HfATCygc14nTMS2ebHmBaLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iv5MbJuE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iv5MbJuE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571C5C4CEE3;
	Sun, 13 Jul 2025 08:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752396299;
	bh=ASPv/r6GXTBe7L2poja4xEnn6UOIN4wrVJugrHA0UqI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Iv5MbJuExz5JLFy9uM5Se5FuCNyvM/ELAA0NzzRwtcHq8fHNFcXXLjf4Joam1dp1o
	 mMZape1BlzE7vhjx/eDmdZLZcacV1urJKLIBFTjw0HNuIjCsVE1N3RbeQ8RtBdgDyq
	 zwwEDiLTUu6QMRZvHlF1Hmz0TDgyV8YO++jAJQPJNs9RWq2tbFMmN3JNgnScJpj/sg
	 3LmCJ3obCJz2KcPPEbmU7ujNCQFgrvzp/BRVdPII5Sfe3yrw0GdQ3pq3Q9X1CQ3Lzn
	 SvWBL7ZyYS23OyVVmKpNWxm3PTHOO6d3yibfsu5+9XL9Cjsju23Gxdj/P2WHpggrMQ
	 UA82Bspu43yGA==
Message-ID: <3a297f23-9b80-4623-ad58-85de85a5b8f7@kernel.org>
Date: Sun, 13 Jul 2025 10:44:47 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] mmc: sdhci-brcmstb: rpmb sharing by claiming host for
 TZOS
To: Kamal Dasu <kamal.dasu@broadcom.com>, andersson@kernel.org,
 baolin.wang@linux.alibaba.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, florian.fainelli@broadcom.com, ulf.hansson@linaro.org,
 adrian.hunter@intel.com
Cc: bcm-kernel-feedback-list@broadcom.com, linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 Kamal Dasu <kdasu@broadcom.com>
References: <20250711154221.928164-1-kamal.dasu@broadcom.com>
 <20250711154221.928164-6-kamal.dasu@broadcom.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250711154221.928164-6-kamal.dasu@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/07/2025 17:42, Kamal Dasu wrote:
> +
> +static int sdhci_brcmstb_sdio_share_init(struct platform_device *pdev)
> +{
> +	struct sdhci_host *host = dev_get_drvdata(&pdev->dev);
> +	struct device_node *np = pdev->dev.of_node;
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	struct brcmstb_sdio_share_info *si;
> +	void __iomem *sdio_sh_regs;
> +	int ret;
> +
> +	/* sdio_share block */
> +	sdio_sh_regs = devm_platform_ioremap_resource_byname(pdev, "share");
> +	if (IS_ERR(sdio_sh_regs))
> +		return 0;
> +
> +	si = devm_kcalloc(&pdev->dev, 1, sizeof(struct brcmstb_sdio_share_info),

sizeof(*)

> +			  GFP_KERNEL);
> +	if (!si)
> +		return -ENOMEM;
> +
> +	si->share_reg = sdio_sh_regs;
> +	ret = of_hwspin_lock_get_id(np, 0);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to get hwspinlock id %d\n", ret);

Uh? So you changed the ABI in the driver but not in the bindings? No,
this must be always synced. Look what your binding is saying. Is it
optional? Yes.

And why would you print errors anyway on deferred probe? Twice! One here
and warning in your probe.

> +		return ret;
> +	}
> +
> +	si->hwlock = devm_hwspin_lock_request_specific(&pdev->dev, ret);
> +	if (!si->hwlock) {
> +		dev_err(&pdev->dev, "failed to request hwspinlock\n");

Syntax is: return dev_err_probe

> +		return -ENXIO;
> +	}
> +
> +	si->irq_recv = platform_get_irq_byname_optional(pdev, "recv_ipi0");
> +	if (si->irq_recv < 0) {
> +		ret = si->irq_recv;
> +		dev_err(&pdev->dev, "recv_ipi0 IRQ not found\n");

Syntax is: return dev_err_probe

> +		return ret;
> +	}
> +
> +	ret = devm_request_irq(&pdev->dev, si->irq_recv,
> +			       sdhci_brcmstb_recv_ipi0_irq,
> +			       0, "mmc_recv_ipi0", host);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "mmc_recv_ipi0 IRQ request_irq failed\n");
> +		return ret;

return dev_err_probe

> +	}
> +
> +	si->ipis0_reg = devm_platform_ioremap_resource_byname(pdev, "flshr_ipis0");
> +	if (IS_ERR(si->ipis0_reg))
> +		return -ENXIO;
> +
> +	priv->si = si;
> +	si->host = host;
> +	init_waitqueue_head(&si->wq);
> +	/* acquire hwsem */
> +	sdhci_brcmstb_aquire_hwsem(si);
> +	si->claim_thread =
> +		kthread_run(sdhci_brcmstb_host_claim_thread, si,
> +			    "ksdshrthread/%s", mmc_hostname(host->mmc));
> +	if (IS_ERR(si->claim_thread)) {
> +		ret = PTR_ERR(si->claim_thread);
> +		dev_err(&pdev->dev, "failed to run claim thread\n");
> +		return -ENOEXEC;
> +	}
> +
> +	return 0;
> +}
> +
>  static u32 sdhci_brcmstb_cqhci_irq(struct sdhci_host *host, u32 intmask)
>  {
>  	int cmd_error = 0;
> @@ -482,8 +720,11 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>  		goto err;
>  
>  	pltfm_host->clk = clk;
> -	return res;
> +	res  = sdhci_brcmstb_sdio_share_init(pdev);

Only single space before '='

> +	if (res)
> +		dev_warn(&pdev->dev, "sdio share unavailable\n");

Why do you warn on completely optional hwlock? Drop, this should be
silent. You already print errors earlier and there is no point to print
error twice.

>  
> +	return 0;
>  err:
>  	sdhci_pltfm_free(pdev);
>  	clk_disable_unprepare(base_clk);


Best regards,
Krzysztof
