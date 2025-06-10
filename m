Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D492728AAE5
	for <linux-mmc@vger.kernel.org>; Tue, 10 Jun 2025 09:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749548097; cv=none; b=G+y6feDudg49BxBdSileMCbai93/BlPxM00pgqTm8XvjQ0SJgUP4qqGCJYOi7vsAHeej8okoIHsmQrdZCGuKIs6G3/2yrnnMMg8+2XSd8xGWklffY5DcZ7Vs+NAfIporERE8VnbjwRWtWYiOmjbH4jgTQJ04i9PqYl91+wD5PGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749548097; c=relaxed/simple;
	bh=0IZ1eZx2nMnSFcLIF6cpjhL009mvAnI0of+WnVOljHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZnlWFOFtCIyy+9dfGFJjdwqqzE8FtS0qOzeKP67kIN20IfiTqDwvp/iSdL+/iPGYEnr7ReAw+FMzcL5QaNRgcLW4MulDbDYxiapakQglvVlgsMflQV4sxWaVnPjH98ZMbVohun0kJr0NgEWR3Ax8XC/fyiril+3IuQSHrUNwE3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=szQ7c0zu; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="szQ7c0zu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1749548096; x=1781084096;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0IZ1eZx2nMnSFcLIF6cpjhL009mvAnI0of+WnVOljHg=;
  b=szQ7c0zuH+VZrjTN1nBLwmu2Q/LHoquZsRxNB77YagaZcHwYP8JybV66
   8JILeIFDZiCdTyTtKs6AEoy7y0Ll0ynfejqhkh38MXp3hsqY9x8Wqgjg0
   DET2E8W2NU8ZKaUE60oxYPEGYnu9xdvU9MRCgZesf++EJxlwpar3Bjwdy
   iiITnUcGhjH4x8a/BCZA2BUmmk8wa1UGfuQM5X8A2QrQXUCmFITYdVnxh
   tQo3oPh/d9QcCV34XzVu/Ovjef4lji3Wv/uMWYZORABEOFs4uip4zkhqJ
   Hka66Sokrg0zuZa/Jq++BApRf+XLerGwcmte5RoRGPu7T9H4ZKRMoQuKe
   Q==;
X-CSE-ConnectionGUID: lkdJUlpCTPeJ8f2ohtktxA==
X-CSE-MsgGUID: j/OCxOplRl+GkyLx3171nA==
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="42615774"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jun 2025 02:34:55 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 10 Jun 2025 02:34:24 -0700
Received: from [10.159.227.108] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Tue, 10 Jun 2025 02:34:22 -0700
Message-ID: <94b36ca8-84e5-49ee-9a4c-169681bb282d@microchip.com>
Date: Tue, 10 Jun 2025 11:34:34 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/35] mmc: sdhci-of-at91: Drop the use of
 sdhci_pltfm_free()
To: Binbin Zhou <zhoubinbin@loongson.cn>, Binbin Zhou
	<zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, Ulf Hansson
	<ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
CC: Huacai Chen <chenhuacai@kernel.org>, <linux-mmc@vger.kernel.org>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Eugen Hristev
	<eugen.hristev@linaro.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>
References: <cover.1749127796.git.zhoubinbin@loongson.cn>
 <d64ed0f849277760d5b9ce04cfff1cd02ad43d19.1749127796.git.zhoubinbin@loongson.cn>
Content-Language: en-US, fr
From: Aubin Constans <aubin.constans@microchip.com>
In-Reply-To: <d64ed0f849277760d5b9ce04cfff1cd02ad43d19.1749127796.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 07/06/2025 09:38, Binbin Zhou wrote:
> Since the devm_mmc_alloc_host() helper is already in use,
> sdhci_pltfm_free() is no longer needed.
> 
> Cc: Aubin Constans <aubin.constans@microchip.com>
> Cc: Eugen Hristev <eugen.hristev@linaro.org>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>

Acked-by: Aubin Constans <aubin.constans@microchip.com>

> ---
>   drivers/mmc/host/sdhci-of-at91.c | 30 +++++++++++-------------------
>   1 file changed, 11 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index 97988ed37467..be80a457cd49 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -333,32 +333,26 @@ static int sdhci_at91_probe(struct platform_device *pdev)
> 
>          priv->mainck = devm_clk_get(&pdev->dev, "baseclk");
>          if (IS_ERR(priv->mainck)) {
> -               if (soc_data->baseclk_is_generated_internally) {
> +               if (soc_data->baseclk_is_generated_internally)
>                          priv->mainck = NULL;
> -               } else {
> -                       dev_err(&pdev->dev, "failed to get baseclk\n");
> -                       ret = PTR_ERR(priv->mainck);
> -                       goto sdhci_pltfm_free;
> -               }
> +               else
> +                       return dev_err_probe(&pdev->dev, PTR_ERR(priv->mainck),
> +                                            "failed to get baseclk\n");
>          }
> 
>          priv->hclock = devm_clk_get(&pdev->dev, "hclock");
> -       if (IS_ERR(priv->hclock)) {
> -               dev_err(&pdev->dev, "failed to get hclock\n");
> -               ret = PTR_ERR(priv->hclock);
> -               goto sdhci_pltfm_free;
> -       }
> +       if (IS_ERR(priv->hclock))
> +               return dev_err_probe(&pdev->dev, PTR_ERR(priv->hclock),
> +                                    "failed to get hclock\n");
> 
>          priv->gck = devm_clk_get(&pdev->dev, "multclk");
> -       if (IS_ERR(priv->gck)) {
> -               dev_err(&pdev->dev, "failed to get multclk\n");
> -               ret = PTR_ERR(priv->gck);
> -               goto sdhci_pltfm_free;
> -       }
> +       if (IS_ERR(priv->gck))
> +               return dev_err_probe(&pdev->dev, PTR_ERR(priv->gck),
> +                                    "failed to get multclk\n");
> 
>          ret = sdhci_at91_set_clks_presets(&pdev->dev);
>          if (ret)
> -               goto sdhci_pltfm_free;
> +               return ret;
> 
>          priv->restore_needed = false;
> 
> @@ -438,8 +432,6 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>          clk_disable_unprepare(priv->gck);
>          clk_disable_unprepare(priv->mainck);
>          clk_disable_unprepare(priv->hclock);
> -sdhci_pltfm_free:
> -       sdhci_pltfm_free(pdev);
>          return ret;
>   }
> 
> --
> 2.47.1
> 

