Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2241212CD8B;
	Mon,  9 Dec 2024 10:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733739275; cv=none; b=q+nPP7HUh0EPrJgsg0S3d8BVKOewc/Xy8LEZrI+PtZSjqnbPqG4b9lukYuojEgeu4/cRPqevkOVwPv5PO/NESTyoV3IHpH+EKN8YC0YHqvN0jGTgrC15ewbwwQa+my4AaCsHbHC6f2OasJlNPTxvKGi6qC5e7TyCxFUjimzovWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733739275; c=relaxed/simple;
	bh=lQ9MP8Ja4PDcI0wl7iEL9FX90jRS27gE6Ne9YOuV3g0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bQp7B3JrfE8OY1ZbXB63Ib9C+l+GhkExlUDsIVrcpQW+xykD+5NGTrP0jKTjV0RaW4whlZSGQhmpudfdMpW9v4RTw8ISXWlXqyjYITVwTLS3GzUeCtWpkficJBvRLGvmChclyJXnAH1RhuqDfm2HwnaKe7ctsvJYdlzJudw4aFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=T1r0sUkG; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="T1r0sUkG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733739271;
	bh=lQ9MP8Ja4PDcI0wl7iEL9FX90jRS27gE6Ne9YOuV3g0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=T1r0sUkGZRd2lc5Mlyy2DRwXNuymY//gcxk3AXulq7z7CT9PVrp/LlzrrULZFfM4E
	 WibXSGX1ZnC+ELHuvSTPcTg4isnO9x9WLFxf3tN3rH0h9y1SpJ0vwdAOL1AzBiByRR
	 XGzh/BUCMWZ43v4+v5ehr/r/Azhfkns/848Sp9//WjwwVTOkeVYnUU2TBLxEk4Rcmv
	 Z7GTJDHLDY2nlR03xMyY2gef613SNP5KZmRq1Bj8eltN9e9IXPneEBPgJr9SM+pGsx
	 NWt5LGGZYTwk1/Q0Y5lLKFal0v6fsP8IT/WubJvs8IjhqyvylMD+T7pRL7uT4ab8N/
	 VcblphnyzIe+A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 73F1717E1522;
	Mon,  9 Dec 2024 11:14:30 +0100 (CET)
Message-ID: <6b4f98ab-5bfe-406d-a0d4-46d36ed10df7@collabora.com>
Date: Mon, 9 Dec 2024 11:14:29 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mmc: mtk-sd: Limit getting top_base to SoCs that
 require it
To: Chen-Yu Tsai <wenst@chromium.org>,
 Chaotian Jing <chaotian.jing@mediatek.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Wenbin Mei <wenbin.mei@mediatek.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, Frank Wunderlich <frank-w@public-files.de>,
 Andy-ld Lu <andy-ld.lu@mediatek.com>
References: <20241204092855.1365638-1-wenst@chromium.org>
 <20241204092855.1365638-3-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241204092855.1365638-3-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 04/12/24 10:28, Chen-Yu Tsai ha scritto:
> Currently the mtk-sd driver tries to get and map the second register
> base, named top_base in the code, regardless of whether the SoC model
> actually has it or not. This produces confusing big error messages on
> the platforms that don't need it:
> 
>      mtk-msdc 11260000.mmc: error -EINVAL: invalid resource (null)
> 
> Limit it to the platforms that actually require it, based on their
> device tree entries, and properly fail if it is missing. There is
> no MMC node in the MT6779 dts, so it's currently unknown if that
> platform needs it or not.
> 

No, it doesn't require it. The controller is (very) similar to the one
found on MT6795 :-)

> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Can you please remove that "I don't know about mt6779" mention, now that
you do know?

Btw,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/mmc/host/mtk-sd.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index e2c385853eef..1bb7044f4ca1 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -414,6 +414,7 @@ struct mtk_mmc_compatible {
>   	u8 clk_div_bits;
>   	bool recheck_sdio_irq;
>   	bool hs400_tune; /* only used for MT8173 */
> +	bool needs_top_base;
>   	u32 pad_tune_reg;
>   	bool async_fifo;
>   	bool data_tune;
> @@ -587,6 +588,7 @@ static const struct mtk_mmc_compatible mt7986_compat = {
>   	.clk_div_bits = 12,
>   	.recheck_sdio_irq = true,
>   	.hs400_tune = false,
> +	.needs_top_base = true,
>   	.pad_tune_reg = MSDC_PAD_TUNE0,
>   	.async_fifo = true,
>   	.data_tune = true,
> @@ -627,6 +629,7 @@ static const struct mtk_mmc_compatible mt8183_compat = {
>   	.clk_div_bits = 12,
>   	.recheck_sdio_irq = false,
>   	.hs400_tune = false,
> +	.needs_top_base = true,
>   	.pad_tune_reg = MSDC_PAD_TUNE0,
>   	.async_fifo = true,
>   	.data_tune = true,
> @@ -653,6 +656,7 @@ static const struct mtk_mmc_compatible mt8196_compat = {
>   	.clk_div_bits = 12,
>   	.recheck_sdio_irq = false,
>   	.hs400_tune = false,
> +	.needs_top_base = true,
>   	.pad_tune_reg = MSDC_PAD_TUNE0,
>   	.async_fifo = true,
>   	.data_tune = true,
> @@ -2887,9 +2891,13 @@ static int msdc_drv_probe(struct platform_device *pdev)
>   	if (IS_ERR(host->base))
>   		return PTR_ERR(host->base);
>   
> -	host->top_base = devm_platform_ioremap_resource(pdev, 1);
> -	if (IS_ERR(host->top_base))
> -		host->top_base = NULL;
> +	host->dev_comp = of_device_get_match_data(&pdev->dev);
> +
> +	if (host->dev_comp->needs_top_base) {
> +		host->top_base = devm_platform_ioremap_resource(pdev, 1);
> +		if (IS_ERR(host->top_base))
> +			return PTR_ERR(host->top_base);
> +	}
>   
>   	ret = mmc_regulator_get_supply(mmc);
>   	if (ret)
> @@ -2951,7 +2959,6 @@ static int msdc_drv_probe(struct platform_device *pdev)
>   	msdc_of_property_parse(pdev, host);
>   
>   	host->dev = &pdev->dev;
> -	host->dev_comp = of_device_get_match_data(&pdev->dev);
>   	host->src_clk_freq = clk_get_rate(host->src_clk);
>   	/* Set host parameters to mmc */
>   	mmc->ops = &mt_msdc_ops;


