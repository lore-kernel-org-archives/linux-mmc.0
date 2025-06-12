Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27711D61A3
	for <linux-mmc@vger.kernel.org>; Thu, 12 Jun 2025 12:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749732384; cv=none; b=ptA5aP7g6hPyGxrFn1yWMMNbGraSUtY+4OtJ3sYzuiVkFwkjFi7N8pG1qRQgcsP15uobqdEVTCIW78FDSUnOnXfXd7wGeziu2GqRHAMr6LvCjqsLrPrBIB1gk5YWZj93eGp+31aYeT4THeRcSHQRpYNkJ2mo5hdJ+CN31uzmXwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749732384; c=relaxed/simple;
	bh=97j73T9Sbla0tnqlB3E5XmhBEqlORedb53lMYLfkxJs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhpXK2C7IZR+DruYjdpzX8LGXPnay3SbaIp2oTaEleVNDFr8V1i8IR/ms3Wve0wj6aTu69rl7qlTACG9JFfU9tjWMZfekNepB/MXEQuO4oefv3EnXPjGIUNE1om4Jcxpurq41vCnKJDwwT5HMa31eeD9BZiX0uJO2rD6u/05RnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=cGiRjN1g; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="cGiRjN1g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1749732382; x=1781268382;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=97j73T9Sbla0tnqlB3E5XmhBEqlORedb53lMYLfkxJs=;
  b=cGiRjN1g+N7GmvFxpeIxedaFBdw1rdvlNoVmja7DuQD6q2x0EAqU1tzx
   bt7Z9fjbkPhehhY4s9XwPO9CSLFbY40ggApANvuTAgJJZdZrUns/YhnHR
   18fMUrgXwU0m2Pdjmub42ngCSdhdRIf0IeAB5ISmRk1HUVq+Tuzwseuoj
   5vahVWjzDx/VahuY3fQ0yfu2bBlo0qnZx91QMqUnT9SIQSYz138MIFT0B
   0bul3wLwyLxo0yHq9MBqS8/7wUgS7VmqTzqrnxG3YAzQvAoAkLZPxY/0D
   Q3DkVT+uSxne2dmzRg4tKBN14GmZ6XZJEsh2gm9zQkIslw+y4vPZx2Cro
   A==;
X-CSE-ConnectionGUID: QZmQPDBXT3+K9rgIp2U0Gg==
X-CSE-MsgGUID: xbSRJD2mRRmZEiXTLMxfAw==
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="47704927"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jun 2025 05:46:15 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 12 Jun 2025 05:45:52 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Thu, 12 Jun 2025 05:45:51 -0700
Date: Thu, 12 Jun 2025 12:45:50 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>
CC: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen
	<chenhuacai@loongson.cn>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter
	<adrian.hunter@intel.com>, Huacai Chen <chenhuacai@kernel.org>,
	<linux-mmc@vger.kernel.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Steen Hegelund <Steen.Hegelund@microchip.com>
Subject: Re: [PATCH v3 24/35] mmc: sdhci-of-sparx5: Drop the use of
 sdhci_pltfm_free()
Message-ID: <20250612124550.f66djfkm2tf6ljgs@DEN-DL-M70577>
References: <cover.1749127796.git.zhoubinbin@loongson.cn>
 <67b5e9076056da66d9fc8951fafd4f48ddd3ca25.1749127796.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <67b5e9076056da66d9fc8951fafd4f48ddd3ca25.1749127796.git.zhoubinbin@loongson.cn>

> Since the devm_mmc_alloc_host() helper is already in use,
> sdhci_pltfm_free() is no longer needed.

Acked-by: Daniel Machon <daniel.machon@microchip.com>

> 
> Cc: Steen Hegelund <Steen.Hegelund@microchip.com>
> Cc: Daniel Machon <daniel.machon@microchip.com>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  drivers/mmc/host/sdhci-of-sparx5.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-sparx5.c b/drivers/mmc/host/sdhci-of-sparx5.c
> index d2aa684e786f..b3db1e2c4c0e 100644
> --- a/drivers/mmc/host/sdhci-of-sparx5.c
> +++ b/drivers/mmc/host/sdhci-of-sparx5.c
> @@ -185,11 +185,9 @@ static int sdhci_sparx5_probe(struct platform_device *pdev)
>         sdhci_sparx5->host = host;
> 
>         pltfm_host->clk = devm_clk_get_enabled(&pdev->dev, "core");
> -       if (IS_ERR(pltfm_host->clk)) {
> -               ret = PTR_ERR(pltfm_host->clk);
> -               dev_err(&pdev->dev, "failed to get and enable core clk: %d\n", ret);
> -               goto free_pltfm;
> -       }
> +       if (IS_ERR(pltfm_host->clk))
> +               return dev_err_probe(&pdev->dev, PTR_ERR(pltfm_host->clk),
> +                                    "failed to get and enable core clk\n");
> 
>         if (!of_property_read_u32(np, "microchip,clock-delay", &value) &&
>             (value > 0 && value <= MSHC_DLY_CC_MAX))
> @@ -199,14 +197,12 @@ static int sdhci_sparx5_probe(struct platform_device *pdev)
> 
>         ret = mmc_of_parse(host->mmc);
>         if (ret)
> -               goto free_pltfm;
> +               return ret;
> 
>         sdhci_sparx5->cpu_ctrl = syscon_regmap_lookup_by_compatible(syscon);
> -       if (IS_ERR(sdhci_sparx5->cpu_ctrl)) {
> -               dev_err(&pdev->dev, "No CPU syscon regmap !\n");
> -               ret = PTR_ERR(sdhci_sparx5->cpu_ctrl);
> -               goto free_pltfm;
> -       }
> +       if (IS_ERR(sdhci_sparx5->cpu_ctrl))
> +               return dev_err_probe(&pdev->dev, PTR_ERR(sdhci_sparx5->cpu_ctrl),
> +                                    "No CPU syscon regmap !\n");
> 
>         if (sdhci_sparx5->delay_clock >= 0)
>                 sparx5_set_delay(host, sdhci_sparx5->delay_clock);
> @@ -222,7 +218,7 @@ static int sdhci_sparx5_probe(struct platform_device *pdev)
> 
>         ret = sdhci_add_host(host);
>         if (ret)
> -               goto free_pltfm;
> +               return ret;
> 
>         /* Set AXI bus master to use un-cached access (for DMA) */
>         if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA) &&
> @@ -235,10 +231,6 @@ static int sdhci_sparx5_probe(struct platform_device *pdev)
>                  mmc_hostname(host->mmc), sdhci_readl(host, MSHC2_TYPE));
> 
>         return ret;
> -
> -free_pltfm:
> -       sdhci_pltfm_free(pdev);
> -       return ret;
>  }
> 
>  static const struct of_device_id sdhci_sparx5_of_match[] = {
> --
> 2.47.1
> 
