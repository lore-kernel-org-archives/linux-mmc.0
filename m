Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B8B31CA72
	for <linux-mmc@vger.kernel.org>; Wed, 20 Aug 2025 16:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755706323; cv=none; b=BZNigbbLWWRKB4alL/gThzb1XvuNviZB4s9mrpunhIQBycqb+6yylAJAzUbXKdhXb50GvawtR6r09tH469Tdx99OZyDHf9GvTpIDqKymRJr5w/GTM+RsqJ/iw5llqOvB0avdyzB82z89x4kA34yQd0K0S4FbSBTyEhaxOoH3Qas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755706323; c=relaxed/simple;
	bh=N2MrP5BJEUs8REnU+Gj6bAFrxsuXD4Cgl44PMracfaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WyMqcEyYCCkGRPHOk5x9QLUxgchwUDNFfFK3RNpEbRnOcy06ovHVw+jbBbeudbw53F6tx/cvJT/lOBwvqaWAcgGmlUhXEWiRw182haIW4wllHmiawzY6WcCVmlYNx4UJfT/l+7xUXSO4FBMgo5iSxDWq0wCZP+YF+zOPreBs2Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pBwO9aQv; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pBwO9aQv"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71d60110772so63387b3.0
        for <linux-mmc@vger.kernel.org>; Wed, 20 Aug 2025 09:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755706320; x=1756311120; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKEj4OoFu5qxWiZKLT6PI6uf5xnbuxEXW6QnaXB6ZtI=;
        b=pBwO9aQvjDGnv7uIW7CNAsOd9ED/5VLvWSf4P5zS+AcQBIQ+QAdN5giHMZyFsZTLyo
         vZ/iXem/mCNhx02SHiZtLXYNSaHasyNyTvRc0ysJVjr3dOiY9CH6sEbSirP18ZRF+Mj1
         ZqlXl5nAEHB1RWimv0bYjPef12VjiQrAxmkW2KD5zVrySPi5+H9cn0JZnXGMsANf7RJf
         hZBB1Fbbg8qIGSLBgBSNU3a6CzG9MnXvpk7DqfLe0gJd0HefxggvQHzfrn8nuVjYsny7
         2vbbXwRRQOTmtxlcqaRyQpfD8BGUynE65bX1bUBYaCTAJAGml9vJpF7jHw55d1EI9QH4
         P4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755706320; x=1756311120;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZKEj4OoFu5qxWiZKLT6PI6uf5xnbuxEXW6QnaXB6ZtI=;
        b=fF+1asYoBIAxetdEvadFwDWhgJXs4JLXDeIxySuBT3J0WTt7GLarTzTFVAwZ8hEan0
         41DLMthOGrQqNI5BFYH361NNw4hFxAeBtzjURMq8Ffx1doXDcgvQ5GN+0XX6oa5NwX4s
         3U+dDTure9OsEZ4mW0Ok9anpby1bLdop/UTcVTZoYNpMIEMp/L6JCzqbdz4Nk5L7hJLB
         QsT4M34eOaf7rkr6y2K0bsTXu+tu9ySOjNP66azHU43VqEhe+jQRAKoV46x8D6R1cShY
         Ia3aYIxyY6geA3TSEShEARg7w5jgzPF6zWxBHKMP5QXXKqvb7C07hpYBkvG4XMNGxuZG
         MVhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwplqKX91L5pNxWCtoIPQ8VW75d6/x5ZBsRN1V6vDefstA5ImnZbgsZM87G9Sj0yGPEO6K3MtKyrk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyepfg3qXVxqQzihxI8P6RaBxLVd0CRdaPXI44noswiXA4Kql7/
	t8qFknBdvrR2oiX/6oRHXcu+7nkX6mzmUvR2GiiDumWuu5sBmwiI/lYtPtdJRoD4bVg8E4cKO/N
	uHHYmvfwGAECpcqRyupHM/TiwEyyqLHe0H4hyCRTIEg==
X-Gm-Gg: ASbGncuQ/rAgGUmY94WeCTDVxrOfBEx7N01RCamvXd1Geg6P9tVTM/h1UnalBGIhqdy
	0EkL98h9I8uakHF7l2jhV6A18tzbzfNmSV7Ne0FHnA8qSIkzWZJflDvy5mIY2CvPj+CrWnbSMfx
	XY+JLUw+UzENLka2FTMMBFla6o0Vn48OJCH6V3vLy/Iv20XEki9WOseDoHLVoX+P2i1o4KlcF0r
	zLwcebX
X-Google-Smtp-Source: AGHT+IFyGmPKSjD9LQZuyLeQ/TtIq9vh3tMfOnN/t8pZNM1B/noC7/Ya+OcZNQb3fDOmJP/tGcVjYZngksMRq3/mB94=
X-Received: by 2002:a05:690c:6109:b0:71f:b944:1012 with SMTP id
 00721157ae682-71fb9444b96mr27757007b3.45.1755706320050; Wed, 20 Aug 2025
 09:12:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819152854.3117844-1-jm@ti.com>
In-Reply-To: <20250819152854.3117844-1-jm@ti.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 20 Aug 2025 18:11:24 +0200
X-Gm-Features: Ac12FXzAJOFWwYq5VhPJAug_YKD03X7VQt06zhfNoBt5coG_TQ70POedXOcSHJQ
Message-ID: <CAPDyKFrZ7jLfAQ1N4_nXZndFvtvKeLqhK-9MjuHUoJA073Pdcg@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: sdhci_am654: Disable HS400 for AM62P SR1.0 and SR1.1
To: Judith Mendez <jm@ti.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Davis <afd@ti.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Aug 2025 at 17:28, Judith Mendez <jm@ti.com> wrote:
>
> This adds SDHCI_AM654_QUIRK_DISABLE_HS400 quirk which shall be used
> to disable HS400 support. AM62P SR1.0 and SR1.1 do not support HS400
> due to errata i2458 [0] so disable HS400 for these SoC revisions.
>
> [0] https://www.ti.com/lit/er/sprz574a/sprz574a.pdf
> Signed-off-by: Judith Mendez <jm@ti.com>
> Reviewed-by: Andrew Davis <afd@ti.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Can we add a fixes tag? And should this be tagged for stable too?

Kind regards
Uffe

> ---
> This patch was separated from [1] since it will be merged to
> different trees anyways.
>
> Links:
> v3: https://lore.kernel.org/linux-mmc/20250818203310.3066985-1-jm@ti.com/
> v2: [1] https://lore.kernel.org/linux-mmc/20250807225138.1228333-1-jm@ti.com
>
> Changes since v3:
> - Add Andrew's and Adrian's tags
> - Fix message to user as per Andrew's and Adrian's suggestion
>   in v3 to a less imperative tone
> - Fix commit message reference indexes
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
