Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422722D3EC5
	for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2025 09:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755767419; cv=none; b=b6biOBj25QCd2qw7c5RRnjVkGeLdkKw+6zVMMZX7Xvs3NKOG4+Gv6m1rphZvZOEzRUp9/sfdMXFJ6bRRKXa56guilZZubNOF3oFT4hPINK7i3i8HVHRv69Y84vzfENU7zQOLsfySiXYBR9k3na/lfJERyfxNCnOhEv0eF8R3Vbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755767419; c=relaxed/simple;
	bh=D82VoRC7SRWylLufDqwtIwGR8ekpdUz9FEgCnO2WFbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ocbCw2nGNi83yQz/li7+z8l66JFrp+yGFtLDzFw/0pMGVKrT76onN1JQlsMqSEtUrJMlKBKU6fFlWIg9s//3aQkF1d+F3u4Lvovdtho1d/jTZ6ZPLvFHxULPIoySdFUCwncficrcIPdmtaGCEHvWZwMNg1CfMa6ONs7qwGHg7iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CCurtE+I; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CCurtE+I"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-71d6083cc69so6167457b3.2
        for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2025 02:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755767417; x=1756372217; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q1lvOZzEeeYujPTiqMkU/SfYwhQqH+4WeDtoyp2UpLg=;
        b=CCurtE+IKk3lcEafwRYm4YRP382FLnrshMZnWAtk5oCwjKnLjcVG2KaDeAjiKSZPnA
         /P3G/vXxakZk0yIqxHW/T1G4UZlHaj3Hx5xus/3znvoxlFsFLZlbqg7qy3bIwrkHCMnu
         OdOCYQHcoVPFvqWuBDp6jiYM7yV8yAnBAXmSZ3lFeHFXeIpiZfCrP6kMaHagmomw//vK
         FpL79rJ2Rh3O9MC0yUx3MRmUBqcC7n5fGTudZxzlyy6uhuR8g/bCWogiWYE8YcPC7ze1
         a+MkE+m5VroGgXhcXT3Gi3hZ7na1nG+XVZIjDkNOtoQRloQa/2gyS23X7M/4SOXbTDKq
         dDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755767417; x=1756372217;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q1lvOZzEeeYujPTiqMkU/SfYwhQqH+4WeDtoyp2UpLg=;
        b=JCkMvQu15f1TVrn931oMn0dv1P8o4dhcTWe6Zl/c+3PphZbnvLeHfCPQbYWF2sZe/K
         Ru7VJlNxO3M+bBfCajqlIbE7imOf6drwWdIkZoMKFbA7/dtoZpit3d8/RDUaT3ZWPUpJ
         oMASsDsjJ7IcCu6oluQDqTiNQkwGrDFLjCpFjD2rW+tRy1pjGjiTaaCFytRCkFiFqbqo
         iZuVNVtVeJHXG/GEqVcfzYN/+Ns2YPgUd1KL2VggaommXzZYKzAWlTcNxSo9dfNpg9nP
         nJylWmWQxC3e3/qeDjY53iAjdQrg/TrF4m+kp0CQGD/iq8liQPkxaVBWmwFeiHyhObru
         Lz6w==
X-Forwarded-Encrypted: i=1; AJvYcCX6rR4o9gk/hM/EDrzHsheclcLU3nfJwVGdOmtXmVBPkKCRlOBoYgRP8hh9is7x0VmzQ3JtzqG+C28=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj7uH69REKFvU5PEt6RjYEj/Wer8Sg91ctGWzvi2JsbXuj3602
	D1HBaSWf2dyG6eN3ouqzKR9J5GaHM6UQTaP3u5EMLH7OsVQvgYoVx8eHh0gzOBNCydyaouKpMu6
	pF+03XVOePCq9GuOAfWOnVh/iUGrzW2uoOy5CiAD0dmHM9VkehWzu
X-Gm-Gg: ASbGnctIPVyEEKgfoWh30amb369757q4yT1ma4HxMk7Eenm4daiAmFn8vVt3cgpv7Jo
	EbQYrTgIBaNY/izsgtH6GlTSa+si0nDXNaVkAp1Rb3OJPiVRYuYZhqBM2gUoENlNlGv+t/IkKpZ
	WmAEV/awHUushnLxhoAN2DYJteozZF+Tk5AX18LYwjGqg7dfKR5G9vM1Iri2iD6bQwoqoLsr5Pj
	H+1UwZo
X-Google-Smtp-Source: AGHT+IE3XPrdY1rmSoGIfTQNp7AUzGanhZ4zCUcabEi/3a6ztGvU4JGCxFLz/vEHwGrmJU6OeC1mGQpm8phPeetSBnQ=
X-Received: by 2002:a05:690c:4b90:b0:71d:5782:9d4c with SMTP id
 00721157ae682-71fc898b54emr19133007b3.28.1755767416917; Thu, 21 Aug 2025
 02:10:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820193047.4064142-1-jm@ti.com>
In-Reply-To: <20250820193047.4064142-1-jm@ti.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 21 Aug 2025 11:09:40 +0200
X-Gm-Features: Ac12FXz4cH776JgD7usSy98yaTqfXnx9d_ZVcbURZjgYhcQZQ3WKM_XhUMd5FsQ
Message-ID: <CAPDyKFqvf6CJfm52F0_wJj8xxCKDv18b1T+i8zm2rsdBiAqUJg@mail.gmail.com>
Subject: Re: [PATCH v5] mmc: sdhci_am654: Disable HS400 for AM62P SR1.0 and SR1.1
To: Judith Mendez <jm@ti.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Davis <afd@ti.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Aug 2025 at 21:30, Judith Mendez <jm@ti.com> wrote:
>
> This adds SDHCI_AM654_QUIRK_DISABLE_HS400 quirk which shall be used
> to disable HS400 support. AM62P SR1.0 and SR1.1 do not support HS400
> due to errata i2458 [0] so disable HS400 for these SoC revisions.
>
> [0] https://www.ti.com/lit/er/sprz574a/sprz574a.pdf
> Fixes: 37f28165518f ("arm64: dts: ti: k3-am62p: Add ITAP/OTAP values for MMC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Judith Mendez <jm@ti.com>
> Reviewed-by: Andrew Davis <afd@ti.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for fixes, thanks!

Kind regards
Uffe

> ---
> This patch was separated from [1] since it will be merged to
> different trees anyways.
>
> Links:
> v4: https://lore.kernel.org/linux-mmc/20250819152854.3117844-1-jm@ti.com/
> v3: https://lore.kernel.org/linux-mmc/20250818203310.3066985-1-jm@ti.com/
> v2: [1] https://lore.kernel.org/linux-mmc/20250807225138.1228333-1-jm@ti.com
>
> Changes since v4:
> - Add fixes tag and cc stable as per Ulf's review comment in v4
> ---
>  drivers/mmc/host/sdhci_am654.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 8a099508b939..ffc45930c240 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -155,6 +155,7 @@ struct sdhci_am654_data {
>
>  #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
>  #define SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA BIT(1)
> +#define SDHCI_AM654_QUIRK_DISABLE_HS400 BIT(2)
>  };
>
>  struct window {
> @@ -764,6 +765,7 @@ static int sdhci_am654_init(struct sdhci_host *host)
>  {
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
> +       struct device *dev = mmc_dev(host->mmc);
>         u32 ctl_cfg_2 = 0;
>         u32 mask;
>         u32 val;
> @@ -819,6 +821,12 @@ static int sdhci_am654_init(struct sdhci_host *host)
>         if (ret)
>                 goto err_cleanup_host;
>
> +       if (sdhci_am654->quirks & SDHCI_AM654_QUIRK_DISABLE_HS400 &&
> +           host->mmc->caps2 & (MMC_CAP2_HS400 | MMC_CAP2_HS400_ES)) {
> +               dev_info(dev, "HS400 mode not supported on this silicon revision, disabling it\n");
> +               host->mmc->caps2 &= ~(MMC_CAP2_HS400 | MMC_CAP2_HS400_ES);
> +       }
> +
>         ret = __sdhci_add_host(host);
>         if (ret)
>                 goto err_cleanup_host;
> @@ -882,6 +890,12 @@ static int sdhci_am654_get_of_property(struct platform_device *pdev,
>         return 0;
>  }
>
> +static const struct soc_device_attribute sdhci_am654_descope_hs400[] = {
> +       { .family = "AM62PX", .revision = "SR1.0" },
> +       { .family = "AM62PX", .revision = "SR1.1" },
> +       { /* sentinel */ }
> +};
> +
>  static const struct of_device_id sdhci_am654_of_match[] = {
>         {
>                 .compatible = "ti,am654-sdhci-5.1",
> @@ -969,6 +983,10 @@ static int sdhci_am654_probe(struct platform_device *pdev)
>         if (ret)
>                 return dev_err_probe(dev, ret, "parsing dt failed\n");
>
> +       soc = soc_device_match(sdhci_am654_descope_hs400);
> +       if (soc)
> +               sdhci_am654->quirks |= SDHCI_AM654_QUIRK_DISABLE_HS400;
> +
>         host->mmc_host_ops.start_signal_voltage_switch = sdhci_am654_start_signal_voltage_switch;
>         host->mmc_host_ops.execute_tuning = sdhci_am654_execute_tuning;
>
> --
> 2.49.0
>
