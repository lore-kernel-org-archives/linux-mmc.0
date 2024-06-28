Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE523F519;
	Fri, 28 Jun 2024 07:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719559870; cv=none; b=jlzbFOqEqLhR78iCgmgHLhwfYCbxfXWqb3WrY+lQ8HrxKqXArD+di6I4j2MIypuDoOmsccDJ7AyYzEcsx7ZVf7U06EDlGV4gOG7IykTkl+SVvpdmPFMUUj/VbuV0f83GOeJxwQ87R+fJV55zasG6HAFAVLP99edym2tR+k91utM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719559870; c=relaxed/simple;
	bh=Nhu4vITwG68Td8Y4N60nUtMEr6DEXhwrVURy84rRJYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CUh49FG861jjip/TfH06m6aF30454es4WJgxN2pMznjDPCt5uAQW2p5UpPaUS9LPUAQWAlIPYoYRN7u/+1ZCfyLLmHMMHsny8a3TinY8779vSLTxhecXWJl72VngdxkoRv9JZ3KPEIERRP3mX65u/LTqc98CGnJxlph3ZV3uzmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXMSb6an; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXMSb6an"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9417C116B1;
	Fri, 28 Jun 2024 07:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719559869;
	bh=Nhu4vITwG68Td8Y4N60nUtMEr6DEXhwrVURy84rRJYE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VXMSb6anbJdRYHWSQ2jlfDNTT3aPmtmb9tZ3EPQjlT1crbdQriZqfQwMw4ZqoRFbT
	 gUR7rT2rTasorFKm5OjMiUIBZ3WLYWWkd//XnJ1vFuBHdnfWslNDPRM1vMNiDb/EXl
	 e8XhDzZkKNI+sAzb4ES1MCGZzNNvsuZyAZZS6hISiMzKqsHqF+jX5cyAjsXFg/T0yD
	 py5n3M9LwPhqYw58W8Rkx55K80FPdhyf10M8KuEYpuUipHTE86lfIsTQRnl0kYQ4T2
	 +kDfTaDoalRYcbTJLKRjX9GagTcKTts6l+icSmhE+JbLiSxe1HN/8xDRdRW8CxU+Pm
	 yNqBizhHiTqCg==
Message-ID: <0cc0aab1-f7bf-4a87-af5a-22cf842fbf80@kernel.org>
Date: Fri, 28 Jun 2024 09:31:01 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mmc: sdhci-of-ma35d1: Add Nuvoton MA35D1 SDHCI
 driver
To: Shan-Chun Hung <shanchun1218@gmail.com>, ulf.hansson@linaro.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 adrian.hunter@intel.com, p.zabel@pengutronix.de, pbrobinson@gmail.com,
 serghox@gmail.com, mcgrof@kernel.org,
 prabhakar.mahadev-lad.rj@bp.renesas.com, forbidden405@outlook.com,
 tmaimon77@gmail.com, andy.shevchenko@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com
References: <20240626094900.581552-1-shanchun1218@gmail.com>
 <20240626094900.581552-3-shanchun1218@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240626094900.581552-3-shanchun1218@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/06/2024 11:49, Shan-Chun Hung wrote:
> Add the SDHCI driver for the MA35D1 platform. It is based upon the
> SDHCI interface, but requires some extra initialization.
> 


> +static int ma35_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct sdhci_pltfm_host *pltfm_host;
> +	struct sdhci_host *host;
> +	struct ma35_priv *priv;
> +	int err;
> +	u32 extra, ctl;
> +
> +	host = sdhci_pltfm_init(pdev, &sdhci_ma35_pdata, sizeof(struct ma35_priv));
> +	if (IS_ERR(host))
> +		return PTR_ERR(host);
> +
> +	err = devm_add_action_or_reset(dev, ma35_sdhci_pltfm_free, pdev);
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to register sdhci_pltfm_free action\n");
> +
> +	/* Extra adma table cnt for cross 128M boundary handling. */
> +	extra = DIV_ROUND_UP_ULL(dma_get_required_mask(dev), SZ_128M);
> +	extra = min(extra, SDHCI_MAX_SEGS);
> +
> +	host->adma_table_cnt += extra;
> +	pltfm_host = sdhci_priv(host);
> +	priv = sdhci_pltfm_priv(pltfm_host);
> +
> +	pltfm_host->clk = devm_clk_get_optional_enabled(dev, NULL);
> +	if (IS_ERR(pltfm_host->clk))
> +		return dev_err_probe(dev, IS_ERR(pltfm_host->clk), "failed to get clk\n");

Ykes, you cannot return IS_ERR.

> +
> +	err = mmc_of_parse(host->mmc);
> +	if (err)
> +		return err;
> +
> +	priv->rst = devm_reset_control_get_exclusive(dev, NULL);
> +	if (IS_ERR(priv->rst))
> +		return dev_err_probe(dev, PTR_ERR(priv->rst), "failed to get reset control\n");
> +


Best regards,
Krzysztof

