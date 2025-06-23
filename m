Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C7C23A9AC;
	Mon, 23 Jun 2025 09:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750672628; cv=none; b=G8FjRXaOH1l0AmNZzn0lMZoLbBCgPSiVexlNl/UK5asZhw3nu2fGiM9NGxY7R3wfZ5C6ai0mIPUiP4BkPODDFlcVzR8RFnAzAvUkuS6eqlUPrR1bG2NVUV/snxNRYe6ggx1OaZKHGzPIWkUgs5fbqjzJOhdH4h7uWhJ50O46c1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750672628; c=relaxed/simple;
	bh=vgWm7jmOVVRzfgaQT6LeLtOXW+FZMqRHHMx2jmBo6ZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c1etLcBipYO76pNW9CNCZg9tZ5m2KDtShEDZOynjk1UpjdRKnNWOEFI9c5Ubcn0gfRWm2CK3z/xH4sHaJSX4D8GU1YhgWI9eGMaLCBcqtNlEqFxb6mgECR+tteQ9AVUxEtLNw/tDwHo9HjOo7Y3QMY43mfrvdYP/CmyEOHHf7OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kuQvgV4f; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kuQvgV4f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750672625;
	bh=vgWm7jmOVVRzfgaQT6LeLtOXW+FZMqRHHMx2jmBo6ZY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kuQvgV4f27X0GiIFF3oN6c1a29VlG0nyTqYg4HX+X5nM39c37k3yTYvkFscLNKWal
	 qZLN9xAVvAmFe/unOSmD+iIFfNwa5yluAxHKn714f60zmAG5NMr7i7viMNuvmk8Zsh
	 qKpGDDTIsXqIpInG49O3KyUJR04Y+XScPaJzj2RGk4/ciUvMQfcAv9tdHc7SS2/fsH
	 OQGG16DGVo+7CyqII2f0s1cdYhprjKKprUKfgv/eLkT/ZZUL2gadhL1mSwjqsH05To
	 civyUR9lW6+POo4xRngFh38QrSL14xbhHaJ32Rinti8bOmSSqhfzKOHwJjAUIDEzhE
	 V6YJnJvglbxUw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8AE2A17E0CF9;
	Mon, 23 Jun 2025 11:57:04 +0200 (CEST)
Message-ID: <64451537-86e1-4c5f-bbbd-c9164d0c2dd3@collabora.com>
Date: Mon, 23 Jun 2025 11:57:04 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] mmc: mtk-sd: use default PATCH_BIT register values
 for mt7620
To: Shiji Yang <yangshiji66@outlook.com>, linux-mmc@vger.kernel.org
Cc: Chaotian Jing <chaotian.jing@mediatek.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <OSBPR01MB16708176FE57F691359D0943BC7DA@OSBPR01MB1670.jpnprd01.prod.outlook.com>
 <OSBPR01MB1670CE92711CE9EF6601122EBC7DA@OSBPR01MB1670.jpnprd01.prod.outlook.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <OSBPR01MB1670CE92711CE9EF6601122EBC7DA@OSBPR01MB1670.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 19/06/25 07:35, Shiji Yang ha scritto:
> The register map definitions of these PATCH_BIT registers seem to be
> slightly different from other variants. Use their default values to
> respect the vendor SDK driver behaviors.
> 

Just read the values that do work from the registers on your board and on
the downstream kernel, after which, map the resulting value to the patch
bits that you can find here in this driver.

If there's any difference, add the relevant definitions.

Cheers,
Angelo

> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
> ---
>   drivers/mmc/host/mtk-sd.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 276d4e324..8933cd089 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1939,7 +1939,8 @@ static void msdc_init_hw(struct msdc_host *host)
>   	val |= FIELD_PREP(MSDC_CKGEN_MSDC_DLY_SEL, 1);
>   
>   	/* First MSDC_PATCH_BIT setup is done: pull the trigger! */
> -	writel(val, host->base + MSDC_PATCH_BIT);
> +	if (!host->dev_comp->mips_mt762x)
> +		writel(val, host->base + MSDC_PATCH_BIT);
>   
>   	/* Set wr data, crc status, cmd response turnaround period for UHS104 */
>   	pb1_val = FIELD_PREP(MSDC_PB1_WRDAT_CRC_TACNTR, 1);
> @@ -2002,8 +2003,10 @@ static void msdc_init_hw(struct msdc_host *host)
>   		pb2_val |= MSDC_PB2_SUPPORT_64G;
>   
>   	/* Patch Bit 1/2 setup is done: pull the trigger! */
> -	writel(pb1_val, host->base + MSDC_PATCH_BIT1);
> -	writel(pb2_val, host->base + MSDC_PATCH_BIT2);
> +	if (!host->dev_comp->mips_mt762x) {
> +		writel(pb1_val, host->base + MSDC_PATCH_BIT1);
> +		writel(pb2_val, host->base + MSDC_PATCH_BIT2);
> +	}
>   	sdr_set_bits(host->base + EMMC50_CFG0, EMMC50_CFG_CFCSTS_SEL);
>   
>   	if (host->dev_comp->data_tune) {


