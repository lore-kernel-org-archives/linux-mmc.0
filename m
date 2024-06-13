Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40DA9449;
	Thu, 13 Jun 2024 13:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284632; cv=none; b=GINDdsXRjBbeqmrmLM1qGVzBLWZORJCAlnH5i+Ym8FqfJjn+hBEV73Zz/7+UiiqCWb7TnoXrhpAFzn8FZ3wbBUdojydDF0jIyM7yO5YS1yhQZ3dRNbJTYHrpVbP4uCAGULEzMcnwOGwxIHUodVFp3aV52YDuN5Nn/AZMNOhmRws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284632; c=relaxed/simple;
	bh=JfrHfE5+wnDYBc2X9VtRgknSQ9saw1R3/iTpUCH9BvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZvMEJMAJEognwFOcCPO6IWiiyKQWivVdSvur9wKR0C+9V8IdPIcruxwyQXqHoY9+wAHGPN38f2VNNsQbixxAe32z4mAsTE5b2ujIlP5a1qgexjV1WL5dNVq7ErFwV4pTdbbbtrHH5eMJxFUiT5Kp9cotNQTG1uSoJiZsTrFGbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FN/YXXTf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FN/YXXTf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4AEEC2BBFC;
	Thu, 13 Jun 2024 13:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718284632;
	bh=JfrHfE5+wnDYBc2X9VtRgknSQ9saw1R3/iTpUCH9BvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FN/YXXTfFlj5TBAZkWQYn5iGGeI1YxwT+7U2UH1v2gP0eiqakofHTI/1ITWPmE0/h
	 e0hXtLxzPQhuQGHtC2TBz4TOVtIg1tbM/NxZ7TiV4WnfocY4rknXbE5OK+hWFeoKHp
	 odyJol4pNo4rwKy9RX9KAc0Li2dLqE8fkUY0rbO22djo5QxhZUYiGh4gzJl6XkhwGm
	 TjbwBiRIlV+UO/9OH/uRXNJsdiAzUjPQ3z3NijkbC9EEj/B8KlEvvY82XFw/bmGh0d
	 oylavdJe4YlgsLLjapFSASlDcQc9R5eb95TjZNYO1IIbF8Ueytu+p9jziy/EUxHlp/
	 XRG4SnanyDiAA==
Date: Thu, 13 Jun 2024 21:03:20 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Haylen Chu <heylenay@outlook.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: Use inverted-wp quirk for CV18xx
 and SG200x SoCs
Message-ID: <Zmrt-dcPR_ZXlYH-@xhacker>
References: <SEYPR01MB42219753E4388009470D958DD7FC2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SEYPR01MB42219753E4388009470D958DD7FC2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>

On Fri, May 31, 2024 at 02:13:47PM +0000, Haylen Chu wrote:
> MMC controller integrated in Sophgo CV18xx and SG200x SoCs has an
> inverted write-protect flag, causing SDCards misdetected as read-only.
> So set SDHCI_QURIK_INVERTED_WRITE_PROTECT to make write protection work
> correctly.

No, I would rather set cd-inverted property in dts.
> 
> Fixes: 017199c2849c ("mmc: sdhci-of-dwcmshc: Add support for Sophgo CV1800B and SG2002")
> Signed-off-by: Haylen Chu <heylenay@outlook.com>
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 39edf04fedcf..62b7f28de54f 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -962,7 +962,8 @@ static const struct sdhci_pltfm_data sdhci_dwcmshc_th1520_pdata = {
>  
>  static const struct sdhci_pltfm_data sdhci_dwcmshc_cv18xx_pdata = {
>  	.ops = &sdhci_dwcmshc_cv18xx_ops,
> -	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> +	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +		  SDHCI_QUIRK_INVERTED_WRITE_PROTECT,
>  	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>  };
>  
> -- 
> 2.45.1
> 
