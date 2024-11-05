Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCC941C69;
	Tue,  5 Nov 2024 06:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730788194; cv=none; b=buHD5Y6Xh5DqNBTRP/C5tX5Nau3klFqJSZ2Oqm/e2grD3EpOQWczAlLtkVMhUTh7tLBg/IGto/aA7zKzDCaFgGdncAut6KkYsk8DNW49hSSizZz0pF5Kds/o2u7x6wUHjXOYwq03TTz9cdI10radFi78nVgN718FjvFAMiczFUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730788194; c=relaxed/simple;
	bh=6DEYIIrf9rnJY37cFJ6bjpvI+y1KGnq1lzv188Z3PrQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=KuJf3jFYhWY0zgh/RJS3w6Z10zv1ULcUTWO4pC7/PXDu7wFNZrCqSwnzWNXFxx8mufzqGGmEv4Z4GWLpmYve0xT3r8kyu5TktmAbWboA1pCuJkfy02GradHO0S7q3Uepzn9hWsRgWxY0ciqO/Fe9MRNb1a5xVD93JwUDhkUA7y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=pxeH1phe; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="pxeH1phe"
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1730788190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RSfZmloa5ktLj5m2satJeJFjZZCI/khmEGOs0heit4E=;
	b=pxeH1pheOQFO9IM4gwFWvB08/Pm/bh3299YWAbgeriWmT03jXKkL0l6UoF4H0KJNDGqcEt
	2qFSavAgbdfOySL1PlPtKAny1u2Kx30iZpS1rM6FXytqu0r6we/O/Ncjec7nosgzTDKaqe
	lxl09XU2iE+EQES14V7CPqY+Q4mi4u5x6wlqBkxCUtK43/j9bbxE4syPt5Y33F/Z0Tz+na
	HvIG7GPMFiZ5ouSwo/Iiv5gEEFU9dPBgV1rkWi1ZC1XU8vpMYAPEHLSYUVTfDfsqYjXpgM
	6EH4BnoOSCKm1Up5urHE9/X3F2Toxe7dDsycOe5Em9y12azIm6gGuwXvRCZUsA==
Date: Tue, 05 Nov 2024 07:29:50 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter
 <adrian.hunter@intel.com>, Haibo Chen <haibo.chen@nxp.com>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, s32@nxp.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] mmc: Use of_property_present() for non-boolean properties
In-Reply-To: <20241104190707.275758-1-robh@kernel.org>
References: <20241104190707.275758-1-robh@kernel.org>
Message-ID: <e737fdb7766495ec95fdf42d23c68736@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Rob,

On 2024-11-04 20:07, Rob Herring (Arm) wrote:
> The use of of_property_read_bool() for non-boolean properties is
> deprecated in favor of of_property_present() when testing for property
> presence.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Looking good to me, thanks for the patch!  See also a small nitpick 
below.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
>  drivers/mmc/host/mxcmmc.c          | 6 +++---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index 1edf65291354..dcb1a7336029 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -1048,9 +1048,9 @@ static int mxcmci_probe(struct platform_device 
> *pdev)
> 
>  	if (pdata)
>  		dat3_card_detect = pdata->dat3_card_detect;
> -	else if (mmc_card_is_removable(mmc)
> -			&& !of_property_read_bool(pdev->dev.of_node, "cd-gpios"))
> -		dat3_card_detect = true;
> +	else
> +		dat3_card_detect = mmc_card_is_removable(mmc) &&
> +			!of_property_present(pdev->dev.of_node, "cd-gpios");

There's enough space in the allowed 100 columns to align "mmc_card_..."
and "!of_property_..." by indenting the latter further a bit.

> 
>  	ret = mmc_regulator_get_supply(mmc);
>  	if (ret)
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
> b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 8f0bc6dca2b0..cda1872769e0 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1629,7 +1629,7 @@ sdhci_esdhc_imx_probe_dt(struct platform_device 
> *pdev,
>  	 * Retrieveing and requesting the actual WP GPIO will happen
>  	 * in the call to mmc_of_parse().
>  	 */
> -	if (of_property_read_bool(np, "wp-gpios"))
> +	if (of_property_present(np, "wp-gpios"))
>  		boarddata->wp_type = ESDHC_WP_GPIO;
> 
>  	of_property_read_u32(np, "fsl,tuning-step", &boarddata->tuning_step);
