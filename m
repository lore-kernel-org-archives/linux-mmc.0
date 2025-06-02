Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687F72F42
	for <linux-mmc@vger.kernel.org>; Mon,  2 Jun 2025 16:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748880552; cv=none; b=Pg1Kr64ai/r9xb5Nzy5JLlSNBQGEfUdy4DBYtl4UnMg9lGujNOvVO6zWb1uii8BJNfypeRL97aS4lIW2Xr5K02XHlxra5rk1X9IdVsa3JsOEh42SBiXxUsbCPrkF9RqqcaAMN5zvT+liMBNlOp4uE4Hn7i79oEDH4JVbEuQZsmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748880552; c=relaxed/simple;
	bh=wZdRjUe8Fr7+jme6oIb5H0kyIBMDNUXnDbXAGBLNixc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZW3/e8hPaUa+iDsrDrIpAIKJzYCdM/hQKb4DM8BK+KtrVG2+m1v7TJ6i78C8tWTkrI3K/8z9jwFHPresnKOcWkzPXatEY5Jaql+FWGUVFCnvDb8HLIhhnucQR+JADomrXa5mWyMHtBf9gR4GXGumx3CTz/lcGnxBcAHEZ6/TG78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=G1VRHvk8; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="G1VRHvk8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1748880550; x=1780416550;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wZdRjUe8Fr7+jme6oIb5H0kyIBMDNUXnDbXAGBLNixc=;
  b=G1VRHvk8+xmoDxFqNj8a6EwTIedXAlxJw8MqOVYL/dhSkvHzoECUfZo3
   h1aFCZaRMrZxpeH+cms5EYG3xGBE/zxWp7E1nE0CIgiQj4Zfxe4Ho2FQ1
   N4ZIVHNIp+Qw982DgPGTn/YCXqM+DovNw7UtltaRw0fHyXUxC0j1tkgot
   5NIQzD/1vUo7QTqmQzcvvKYmY7hgKJBUSPTxccdOwnBvlqj2X299Z9oA4
   c6VUwGLDWWFY7Iy0B8hwhUNlOeE0qpshs6/ldaBoABgEBF25teYM6rxnt
   GBfkYYEHHRJpTr02Rlw0c7IfvpxBiw8NispdVDbWUUa6a+cKDPwa6Tyti
   Q==;
X-CSE-ConnectionGUID: Y9kQufQLRPq/Rr67heG40A==
X-CSE-MsgGUID: 6+kZSAaqTZSTdvbtR/44LQ==
X-IronPort-AV: E=Sophos;i="6.16,203,1744095600"; 
   d="scan'208";a="41870805"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jun 2025 09:09:08 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 2 Jun 2025 09:08:58 -0700
Received: from [10.159.227.122] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Mon, 2 Jun 2025 09:08:56 -0700
Message-ID: <59dd37bc-f138-4326-a8d6-197a4355bc1d@microchip.com>
Date: Mon, 2 Jun 2025 18:09:06 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/35] mmc: sdhci-of-at91: Drop the use of
 sdhci_pltfm_free()
To: Binbin Zhou <zhoubinbin@loongson.cn>, Binbin Zhou
	<zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, Ulf Hansson
	<ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
CC: Huacai Chen <chenhuacai@kernel.org>, <linux-mmc@vger.kernel.org>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Eugen Hristev
	<eugen.hristev@linaro.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>
References: <cover.1748515612.git.zhoubinbin@loongson.cn>
 <a1f998ecdae85cc3039cfa30096220d822b616fa.1748515612.git.zhoubinbin@loongson.cn>
Content-Language: en-US, fr
From: Aubin Constans <aubin.constans@microchip.com>
In-Reply-To: <a1f998ecdae85cc3039cfa30096220d822b616fa.1748515612.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hi Binbin,

Thank you for the change.

On 29/05/2025 15:00, Binbin Zhou wrote:
> Since the devm_mmc_alloc_host() helper is already in use,
> sdhci_pltfm_free() is no longer needed.
> 
> Cc: Aubin Constans <aubin.constans@microchip.com>
> Cc: Eugen Hristev <eugen.hristev@linaro.org>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>   drivers/mmc/host/sdhci-of-at91.c | 23 ++++++++---------------
>   1 file changed, 8 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index 97988ed37467..0b7d7db79139 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -337,28 +337,23 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>                          priv->mainck = NULL;
>                  } else {
>                          dev_err(&pdev->dev, "failed to get baseclk\n");
> -                       ret = PTR_ERR(priv->mainck);
> -                       goto sdhci_pltfm_free;
> +                       return PTR_ERR(priv->mainck);
>                  }
>          }

For consistency with the changes below, please use dev_err_probe() as well.
Doing so, you can remove the brackets in both if/else blocks. Or preserve these
brackets may you wish to keep the changes minimal.

Regards
Aubin

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
> @@ -438,8 +433,6 @@ static int sdhci_at91_probe(struct platform_device *pdev)
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

