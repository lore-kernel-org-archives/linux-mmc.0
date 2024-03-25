Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CE613B7BC
	for <linux-mmc@vger.kernel.org>; Mon, 25 Mar 2024 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372778; cv=none; b=HX0H7+8k4NllVVstGmO8Xp65+WvBCEaSFXqirPLGnBN4e4b1Ue1bn9cNUpnQckn0Ty5UHui6undIL4paCKB4VV7PfDS6SecbgXBDzs/nkJxHoPjN3hq3lKOvUih2C3ajaVsBYu7OGeLZlWN1QUrP9dMjxJbyC9D2nMxWckx1d5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372778; c=relaxed/simple;
	bh=d6CmeaRPtDfAafVHQJdPQOuU2Zhm/5dS96jiCyZA9+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iM8mNa1wEK4hCDkkcnd0HRHBQJlZfuqU3TYAukqu901fCcKk4VlZXP5wpqXir2G5CHrPwrc0YDk5Ag7mWLaCtiLcRISWFQmBbz1fu0mDKy+B00uOz2Cwm7Es91WogaP7I1/h1ZAUcQHWDGGxmEF3eNd9dIMRLAcueCfAB2eo5jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sn/DIG2l; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sn/DIG2l"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dccb1421bdeso3795486276.1
        for <linux-mmc@vger.kernel.org>; Mon, 25 Mar 2024 06:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711372776; x=1711977576; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fT3MwGhMSQjWwd4oFtTdyz27PE3Zek9X7Wj5Tr9LaAI=;
        b=Sn/DIG2lLNhL7/pyEI667ZEvu7ZD87BaQbzGVRUSU5XiJI9wolb8pD0JAJ3I1k7eoX
         iHeBz0/iPl5fv6sKOGiOYVvX2UFOxQZzdipTll9pFmRV75TUfcpTkUBshw9sNop6vRSV
         gmecNV9ibzGH9U7BI4RRPUoQw+HZ9GIp7t3tdYQ+cOxqovlh4zkEC8f8xxbzSHgHIMrU
         78NTmqDaWgJBf43OOYNc7Le9/7NLmod2VFXRdyhS++PM8FHRxEfn7XSitbj4Oo/xnWKR
         gjgPEpwqqQ2CL71No57aSzJ0YEt8KXTaNJLyEj6tOwDfC1DZ8mLCOJASSzjU1Xsn/3h3
         jEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711372776; x=1711977576;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fT3MwGhMSQjWwd4oFtTdyz27PE3Zek9X7Wj5Tr9LaAI=;
        b=uI/jTXX1oz8wD9/r3sEXMgLxqllZiUx4oMj0zjuvPKjfIWF9O9ON84FsKgJy+NPoKW
         jiwvtZ0sLS5cQM6Hu+YadHzmCn8st0iVOD54/Kufc+UEaPgx007JCfpSEO7aXKTKHmdH
         gq/Rppnevg6L2K8sXCkQ/b91ThdBWmwToF/aTnfWJYxPJ2Zly9ePEmKBC8xNIwyMupB0
         6T0YkrAhZLydGrQTjLIEw749ITzD3VzwjzKnmcrLnd+RerTbPTUj1U63xmmlF1BNWtpK
         AV3Excf+WWz6X/N1SkARPs9L2weKviP75KHcyEWB+/uINs5Jq1jUKVPEKf/tyv8JUSz5
         buEw==
X-Forwarded-Encrypted: i=1; AJvYcCUlBD5pN5b61phUNqt892finhRpKkO8dZiHg19bFKMDVAKLram4xg231iYBwjBAZK9fr33Xuv1UzcXwL5IGcA5DQ+ZEsnSnZYYm
X-Gm-Message-State: AOJu0YzGgTSkifCqbzgLIn4UlBUq/aX3hePHeFZNQnJTdNPL7rywqF1U
	ARkyK4L/HGBa8H5/7onMYllI3SPD37TlD0Gl+fnZ/mtHBwenGLqSiaWAx5nKwzSy4Y2ATU9sZM3
	+X2vEzGkRzrH0iv8NwY6i1G0AKkx0kml9B4fkTw==
X-Google-Smtp-Source: AGHT+IGop6/PziXzCUHyTzYVdpvfKrK2/d+Evvn7C0ucdixP/Ox6Bjp4p3x8N/Ob7pmc2czLNFvZwPfs0rT/HDH5swQ=
X-Received: by 2002:a25:aea0:0:b0:dda:c5ca:c21b with SMTP id
 b32-20020a25aea0000000b00ddac5cac21bmr3876267ybj.37.1711372776266; Mon, 25
 Mar 2024 06:19:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b9155963ffb12d18375002bf9ac9a3f98b727fc8.1710854108.git.limings@nvidia.com>
In-Reply-To: <b9155963ffb12d18375002bf9ac9a3f98b727fc8.1710854108.git.limings@nvidia.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 25 Mar 2024 14:19:00 +0100
Message-ID: <CAPDyKFrFA2vMbP6Nxt9egxK8-Mk9Td9+Cz73tNEF8mQpQJ_DPA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] sdhci-of-dwcmshc: disable PM runtime in dwcmshc_remove()
To: Liming Sun <limings@nvidia.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, David Thompson <davthompson@nvidia.com>, 
	Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Mar 2024 at 17:16, Liming Sun <limings@nvidia.com> wrote:
>
> This commit disables PM runtime in dwcmshc_remove() to avoid the
> error message below when reloading the sdhci-of-dwcmshc.ko
>
>   sdhci-dwcmshc MLNXBF30:00: Unbalanced pm_runtime_enable!
>
> Fixes: 48fe8fadbe5e ("mmc: sdhci-of-dwcmshc: Add runtime PM operations")
> Reviewed-by: David Thompson <davthompson@nvidia.com>
> Signed-off-by: Liming Sun <limings@nvidia.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index ab4b964d4058..1d8f5a76096a 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -999,6 +999,17 @@ static int dwcmshc_probe(struct platform_device *pdev)
>         return err;
>  }
>
> +static void dwcmshc_disable_card_clk(struct sdhci_host *host)
> +{
> +       u16 ctrl;
> +
> +       ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +       if (ctrl & SDHCI_CLOCK_CARD_EN) {
> +               ctrl &= ~SDHCI_CLOCK_CARD_EN;
> +               sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
> +       }
> +}
> +
>  static void dwcmshc_remove(struct platform_device *pdev)
>  {
>         struct sdhci_host *host = platform_get_drvdata(pdev);
> @@ -1006,8 +1017,14 @@ static void dwcmshc_remove(struct platform_device *pdev)
>         struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
>         struct rk35xx_priv *rk_priv = priv->priv;
>
> +       pm_runtime_get_sync(&pdev->dev);
> +       pm_runtime_disable(&pdev->dev);
> +       pm_runtime_put_noidle(&pdev->dev);
> +
>         sdhci_remove_host(host, 0);
>
> +       dwcmshc_disable_card_clk(host);
> +
>         clk_disable_unprepare(pltfm_host->clk);
>         clk_disable_unprepare(priv->bus_clk);
>         if (rk_priv)
> @@ -1099,17 +1116,6 @@ static void dwcmshc_enable_card_clk(struct sdhci_host *host)
>         }
>  }
>
> -static void dwcmshc_disable_card_clk(struct sdhci_host *host)
> -{
> -       u16 ctrl;
> -
> -       ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> -       if (ctrl & SDHCI_CLOCK_CARD_EN) {
> -               ctrl &= ~SDHCI_CLOCK_CARD_EN;
> -               sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
> -       }
> -}
> -
>  static int dwcmshc_runtime_suspend(struct device *dev)
>  {
>         struct sdhci_host *host = dev_get_drvdata(dev);
> --
> 2.30.1
>
