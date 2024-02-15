Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A300F136642
	for <linux-mmc@vger.kernel.org>; Thu, 15 Feb 2024 16:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708015680; cv=none; b=figJI5cTb9myr6V6rQQadjwAoalz1Vw/pLF2H6rcEajHk4Wpc3EEc18nrzHm20Hi2MFIU107oN9nmJgvq1Ng9Qz2BnHh/zrmpqVHyMcFwF56Vg2LnPmC7lEXPOhZBotYOBEd47v1qpxtignQxpzy+5Rsz4GTx36EWdw1/4moahw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708015680; c=relaxed/simple;
	bh=m/RdHK9Tdl3LCEKGq0f3pdA7CmfEFBLBUKiED3OZtks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KV8Cg8+kiZIpTatB2CiHQWeLBwvLDBvolalh32HhkOXlh1aBifSFH/ng6DPgNe/caO6MjfuUL9W9e0QRGt7cD6sX3wERDOLtVabUj4b9+awm9aJp4xN2m59XQUmAQ7SdDBmXpi4IS7IXN53X05EzBvQ8R3Mm/JApvstiaTyASNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hpgjf2Dr; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hpgjf2Dr"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dcd9e34430cso1057776276.1
        for <linux-mmc@vger.kernel.org>; Thu, 15 Feb 2024 08:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708015677; x=1708620477; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MJXT4bkQbGQzTXV7k3G659qQ960IV+AKnK8ee7bJMnQ=;
        b=Hpgjf2Drf5AVcGTiQzvJdGgeW2gJXlm7pTLAhdb+MSus26i722JM7KeUld8V+HbElK
         2P/B06zz5RKsFxElUEKwHUPKtGcct3hsmmG+bQOHrUmqCuhj+SGNAcjL3MzLcTQiA6IO
         QQLELRVf0gTjUmxKN2j4nC6JVSNKUkUgWfovVT7ZZX8OloEVqK8j+7B7MMQpkknYLQhH
         0UwqCrWrZ5C6z32nG06Ak2UVVfEyqFlcI20IfxbW3Mo8KTkpCUm0OD4m3cKCo0zdo5Lz
         kT49UuD9rz1k1yPBpNLvTbVwBX6piS4v2hFIa2f20YGuzyUvD2dwCV581EgJl5bwuXi3
         3lcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708015677; x=1708620477;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MJXT4bkQbGQzTXV7k3G659qQ960IV+AKnK8ee7bJMnQ=;
        b=LTnVwcqopGw8yMIh0MHVlLBSraPKUu+hzYFXj/qqBavOHOnOcAWbDoNt51oF8zQpz1
         /EyDz8xSkZHIfX8aHMUd5PEewxUcltgDVBr6DjR/ebIa6wRDeRXFn0/VvN3UnOzMeK8U
         iy3l9njxaNqCjl1X86RUAdDiyAeE6C8plHVa5sR0bjiTUpclywbCaXLSxIxraGNEBA56
         nDXDEnH08WEikPZ6XC+vlfJ27SrU+hLV5FpkpnztojsPgagodstQKPAJplU8fHGEqqpa
         5hx5GQ5Uwq1Qm/ENIYgBXvmmC1bBxz/IVH8W8IKrFqpCxa5aiDEoS5c44rEYff1Za/NM
         tT0w==
X-Forwarded-Encrypted: i=1; AJvYcCVRP6TkSf8fFcWmZVfa64whqy/kK0IF0s7TS/2m3ZnG61wZfU2x6xP5lrV18N4lwZYzVhTEMxxxe3sQ4KLwPGFw2cxw+deoTv1u
X-Gm-Message-State: AOJu0Yyv/PlML+09sUjiWo2P3ewX1+2aUmkxDlhEcgPGc6hQcMs+zlHV
	tglnKLlzmxg7nRmbD9xX0Ji7da052VYAZaYFwHqm7F2SPvYZEDJn7n/UHFQNbIRkjZ03NY2zRxk
	8qe/NyU9neuwx7xbdNE62cKkeq80+7A6zDWDq/Q==
X-Google-Smtp-Source: AGHT+IFcEdDxkaV5gl2B0D9rLVsJb+rIMq80f4RxVLr6/cWjMSKXRFW8Ted8UPodyM0dXz2HXXSU8/DgM010QxOPGuc=
X-Received: by 2002:a81:b3c4:0:b0:602:c1e2:c6ee with SMTP id
 r187-20020a81b3c4000000b00602c1e2c6eemr2101425ywh.44.1708015677601; Thu, 15
 Feb 2024 08:47:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215-mmc_phase-v1-1-f27644ee13e4@outlook.com>
In-Reply-To: <20240215-mmc_phase-v1-1-f27644ee13e4@outlook.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 15 Feb 2024 17:47:22 +0100
Message-ID: <CAPDyKFo9NpKSuBnrcOseuD-jDA64CMyRxpH-OUoozOQDYHj1mQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: replace 1st argument to struct device * for mmc_of_parse_clk_phase()
To: forbidden405@outlook.com
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, Adrian Hunter <adrian.hunter@intel.com>, 
	Joel Stanley <joel@jms.id.au>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Feb 2024 at 12:03, Yang Xiwen via B4 Relay
<devnull+forbidden405.outlook.com@kernel.org> wrote:
>
> From: Yang Xiwen <forbidden405@outlook.com>
>
> Parsing dt usaully happens very early, sometimes even bofore struct
> mmc_host is allocated (e.g. dw_mci_probe() and dw_mci_parse_dt() in
> dw_mmc.c). Looking at the source of mmc_of_parse_clk_phase(), it's
> actually not mandatory to have a initialized mmc_host first, instead we
> can pass struct device * to it directly.
>
> Also fix the only current user (sdhci-of-aspeed.c).

Is there a problem? I don't see it, can please elaborate.

Kind regards
Uffe

>
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  drivers/mmc/core/host.c            | 4 +---
>  drivers/mmc/host/sdhci-of-aspeed.c | 2 +-
>  include/linux/mmc/host.h           | 2 +-
>  3 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index cf396e8f34e9..8b2844ac5dc5 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -234,10 +234,8 @@ static void mmc_of_parse_timing_phase(struct device *dev, const char *prop,
>  }
>
>  void
> -mmc_of_parse_clk_phase(struct mmc_host *host, struct mmc_clk_phase_map *map)
> +mmc_of_parse_clk_phase(struct device *dev, struct mmc_clk_phase_map *map)
>  {
> -       struct device *dev = host->parent;
> -
>         mmc_of_parse_timing_phase(dev, "clk-phase-legacy",
>                                   &map->phase[MMC_TIMING_LEGACY]);
>         mmc_of_parse_timing_phase(dev, "clk-phase-mmc-hs",
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> index 42d54532cabe..430c1f90037b 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -435,7 +435,7 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
>                 goto err_sdhci_add;
>
>         if (dev->phase_desc)
> -               mmc_of_parse_clk_phase(host->mmc, &dev->phase_map);
> +               mmc_of_parse_clk_phase(&pdev->dev, &dev->phase_map);
>
>         ret = sdhci_add_host(host);
>         if (ret)
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 2f445c651742..5894bf912f7b 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -539,7 +539,7 @@ struct mmc_host *devm_mmc_alloc_host(struct device *dev, int extra);
>  int mmc_add_host(struct mmc_host *);
>  void mmc_remove_host(struct mmc_host *);
>  void mmc_free_host(struct mmc_host *);
> -void mmc_of_parse_clk_phase(struct mmc_host *host,
> +void mmc_of_parse_clk_phase(struct device *dev,
>                             struct mmc_clk_phase_map *map);
>  int mmc_of_parse(struct mmc_host *host);
>  int mmc_of_parse_voltage(struct mmc_host *host, u32 *mask);
>
> ---
> base-commit: 9d64bf433c53cab2f48a3fff7a1f2a696bc5229a
> change-id: 20240215-mmc_phase-26e85511285d
>
> Best regards,
> --
> Yang Xiwen <forbidden405@outlook.com>
>
