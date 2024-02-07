Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3440823C5
	for <linux-mmc@vger.kernel.org>; Wed,  7 Feb 2024 17:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707326641; cv=none; b=LRhyg78DwvjuJ7TQkp1iUHebhMAson3owgT7fD3L0PXRMs/G1fjzxW3F7MD20ukEfAh1ZfGG6y40qSbcdO33yExhGEy70wCxm9vSD+q1L9ANRq/v4POukzUzq+74MCAzUk5iuZnboKL9oUVBNPYLmNoJYuXMiqQ2toBrtXG9yok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707326641; c=relaxed/simple;
	bh=t+dNL8ajVst+djkWIBJwuyrhqa6AWnfWs+exL6JJTwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D+xHGdzCD2qLGU5DdbR0MD0YnmLDgQdU4rRo89Urw8lIJI87DiLBSAwq65MeY2BS0bs9Ni6j9pDykLshvp7Bxlc36+ohhda8y4yxpxXzYn3vjbUSLHAG1CW9SU5G5TFT9hVo5mumrBjivcMf4cW4mJl1p+GZRZtAP9stYVg4fQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SRS4/4Zx; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SRS4/4Zx"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-604a184703bso853577b3.3
        for <linux-mmc@vger.kernel.org>; Wed, 07 Feb 2024 09:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707326639; x=1707931439; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+0FKXmQhnpOuWx6P6CoEBm1fYjHsOnkUW1Pee1IpEOM=;
        b=SRS4/4Zxhow7s0fsWAVpXDDn2FJC/CYBgh0nCosmR4PTSZu1htmfgjEGtC9v9gHu8d
         gLDbczjKO1GyANtXR41gpy2jGef74/fJtuZrgb0MG9Gj530imwEYxFAjFDLXrmJaWqrb
         04Tn5x4PBzse1RyObG2+06nG6sHnzZ11Ps8aT0Y0J5nf4B57DZqWyPrcozFhXcaOx9yX
         /u93XS0XjPmzJuBs0WpowogLfeXN8pqoM0J/9WH6IM9zoLZbX9PuAulImGHG2ysaxgR/
         0Iw9zkUrhXS/D8SlrZZH6Kp27cNs8VrRtkDeELh94pHw9dLAbtbX6i2KrcQLdKZuXnpY
         o7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707326639; x=1707931439;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+0FKXmQhnpOuWx6P6CoEBm1fYjHsOnkUW1Pee1IpEOM=;
        b=LuPbK6VzyeKYzyyxeFeWdPMJlUXwlNqUW9pz3/VLmfNVln3sntvs83eZdrJcJSxY2o
         BpBARlbn2LKqFXLqsj80KwHBGOoShEX55bLOtl2EeOWA93DBZTbj4sVihbMn7FcRRzB0
         bIkQxiGg99FXjXUHi0Znr+rgTiBy2Ke92PW5jDY+BQqOCfcpzr8ojvHrHehF3sP6G0MJ
         VWXJS0W6SHESjNGYBqI+B1sliZSiCudCrnjsGSnfF2qvyYF10CIjFhw+FQ8JwnPeCRiD
         Y2iOKr5Ne91EgNNfKIzFZXCpVDnliICJ9AwNvjIsO/67CgsXucGUC3A405leBdaprO6z
         NTMA==
X-Gm-Message-State: AOJu0YwDeaqUF62cmw01sMjLErR/h/4rTMlnF6x7XSIUyo9ArWdr2h+v
	bE9ZeWeXt/Q8TDulUW/4e6075S0CXWujKwXcw7qzxW7Hz42bJ5OruMSHfkBuhdznMSvqxcg+p0c
	5MRPTzObYaokCHDYzxNl1Tl/OTUdtVMP3eEY9HA==
X-Google-Smtp-Source: AGHT+IGeCnmsxolePZ4ZnDhSAuANwHYjndNsJgU7gynZNwoZHY3zUbqi/DMbBIogisjXY6k5w+lV6vOHqBjo8OemdgQ=
X-Received: by 2002:a81:e901:0:b0:602:b7d3:9314 with SMTP id
 d1-20020a81e901000000b00602b7d39314mr6323538ywm.35.1707326638972; Wed, 07 Feb
 2024 09:23:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207170425.478558-1-enachman@marvell.com> <20240207170425.478558-2-enachman@marvell.com>
In-Reply-To: <20240207170425.478558-2-enachman@marvell.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 7 Feb 2024 18:23:22 +0100
Message-ID: <CAPDyKFqQ0bF3j3XQmTbEo-mzHXsH=2cvhTi1p1se1=rPmo90Wg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: xenon: fix PHY init clock stability
To: Elad Nachman <enachman@marvell.com>
Cc: huziji@marvell.com, adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Feb 2024 at 18:04, Elad Nachman <enachman@marvell.com> wrote:
>
> From: Elad Nachman <enachman@marvell.com>
>
> Each time SD/mmc phy is initialized, at times, in some of
> the attempts, phy fails to completes its initialization
> which results into timeout error. Per the HW spec, it is
> a pre-requisite to ensure a stable SD clock before a phy
> initialization is attempted.
>
> Signed-off-by: Elad Nachman <enachman@marvell.com>
> ---
>  drivers/mmc/host/sdhci-xenon-phy.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-xenon-phy.c
> index 8cf3a375de65..4e99197b62c3 100644
> --- a/drivers/mmc/host/sdhci-xenon-phy.c
> +++ b/drivers/mmc/host/sdhci-xenon-phy.c
> @@ -216,6 +216,24 @@ static int xenon_alloc_emmc_phy(struct sdhci_host *host)
>         return 0;
>  }
>
> +static int xenon_check_stability_internal_clk(struct sdhci_host *host)
> +{
> +       u32 reg;
> +       ktime_t timeout;
> +
> +       /* Wait max 20 ms */
> +       timeout = ktime_add_ms(ktime_get(), 20);
> +       while (!((reg = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
> +               & SDHCI_CLOCK_INT_STABLE)) {
> +               if (ktime_after(ktime_get(), timeout)) {
> +                       dev_err(mmc_dev(host->mmc), "phy_init: Internal clock never stabilized.\n");
> +                       return -ETIMEDOUT;
> +               }
> +               usleep_range(900, 1100);
> +       }
> +       return 0;

Please convert the above into readx_poll_timeout() or similar.

> +}
> +
>  /*
>   * eMMC 5.0/5.1 PHY init/re-init.
>   * eMMC PHY init should be executed after:
> @@ -232,6 +250,11 @@ static int xenon_emmc_phy_init(struct sdhci_host *host)
>         struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>         struct xenon_emmc_phy_regs *phy_regs = priv->emmc_phy_regs;
>
> +       int ret = xenon_check_stability_internal_clk(host);
> +
> +       if (ret)
> +               return ret;
> +
>         reg = sdhci_readl(host, phy_regs->timing_adj);
>         reg |= XENON_PHY_INITIALIZAION;
>         sdhci_writel(host, reg, phy_regs->timing_adj);

Kind regards
Uffe
