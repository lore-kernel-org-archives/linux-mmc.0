Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F4335029D
	for <linux-mmc@vger.kernel.org>; Thu, 22 Jan 2026 18:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769105032; cv=pass; b=dQjgD1s4yesfwvwRXYcQfP7LwkU1Zd29SgdKQVsfex7w/1mZLWKe7zw5pCcfjr9gX13jaHTD0NVwKIWwKWTRi7D7U7pQih3uTnQY+ILaYgLOLuCqckXgKl10CQ99uhLI+yqOZcQ7kdLQKhB7baY8BbumwtHu7wvecHCKGrPb5l0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769105032; c=relaxed/simple;
	bh=lg67F5EASTP8ujz86YDcptbihxvlG0HTfIEH3CHivPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jJkd+uRTzP/atYg7nnIN071fsInk3jxn5JC+hpw2t/jjJ9w/+SNwGhnLK8MhEMBABU2ra0+8UvsiFEO1MXrsKlCmgYBJOqB1kkYUEJClTfOTdT9bG2XBo8a/zEYr6kSm5+4gbMSi6wfan1WlHktJkc7bQuhQXnBkuFxrdTNKCKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YD1VlxAr; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YD1VlxAr"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59b679cff1fso1196938e87.0
        for <linux-mmc@vger.kernel.org>; Thu, 22 Jan 2026 10:03:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769105020; cv=none;
        d=google.com; s=arc-20240605;
        b=QnBqv+ILz4hh/DTljVBAP/Rbp0UDcTD3feoYA1v7Yn0QmkGsRuDg3TscZgVUe7eQ0B
         nBGSbSvQFOeUn1+/Mr878yCisC8qy/m/g+/WVUohpiDr3iGBldZGtBnPTyTI/HfcHDvQ
         Tr3ihDqgftp+TR9xvhl3/Gdmnf35/M4MqRSyJLZx8qg5xMKRRZI6yLe9w14+AbnPO0qX
         o+rc4OiolhQWqdvxr13iKsNyFk1bAigC3pchHDVXjXl7mt3fhYOkWNfWfuYXslexNArE
         kgkmMUtSf92aXW7ei2IOXOjEF3rkVf3mfcIuBwv67cr62o5bquk7rp1ih++aQIqd/jJt
         l4Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5mz2FnMnRpzj4uk9OMh1RrV0uRLB2piBSSGRGN2i0Ak=;
        fh=OfS2mu/afSBGWKeUvM0S/gRVs3zc/uQlzXYCfD2EN+E=;
        b=Mq4iNxwtl6MniyYOWuHIGFXFK76ompziMnFSYJvnB3RX4YCj1NsniHuibcvbut7Is1
         wh4cgtXeU2XpmOnSNdmUa39OoMSrU6HCiPqEDSEU1Rd2rmarP8Fk21/FxRfxUv8b5YTB
         V2JTEb+ipCOLSjZrPKZyV+kj/1d37GBkfDW5k0dwkSNFY1mzjO4P1lbvk4teHR8Rl+BD
         IIv8m9wvMuWADfFIttODkkje9vSr2+7BjXIzEy8LJAdOqtrV+LYWeCs0eKvzHNuZ3VA4
         pPA6an3Q4iSnFx51tQDKZY3Rx7j2P82knaXMPbbhBYmDQEGa/HUTHuucyo6ZoZ2sOWgv
         WUKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769105020; x=1769709820; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5mz2FnMnRpzj4uk9OMh1RrV0uRLB2piBSSGRGN2i0Ak=;
        b=YD1VlxArliLpVHi9l0/bAi6YFzUT/5u8u0rI7S5NoFA95vauD+WczolgFr2S/fI6ug
         KI8fDn4RXd5tNBQtH+m53kYQjuaD0nE5gywhnb9m6WnXeu9IkrIbeTsf1tqDcuBmqTKo
         x40YMWAyDy9knSbkC2b8Iuxbz+ui6bXccWAcRZBcdlz9QCB0cVIGjLN7ENzjL37KLrkF
         bo9nP7jUbEDHsCxbezd0vdyQnFe5Rg9T5APiTTYMXIMXWlUvjIteZ75zd/7o0VSYs463
         m/NXsfgM/ZwryMxOP/T+hDl6lWi5dJ3ZsksVlj8UgoYq7EiSFyFj9CNs5P+yPzf7kx1D
         geUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769105020; x=1769709820;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mz2FnMnRpzj4uk9OMh1RrV0uRLB2piBSSGRGN2i0Ak=;
        b=i+xA0lC6vp1EASOC+AXbnh7pvlUOWm3289f3o0AWrXe6KNzTQ9I9OCFJK5XNYYGCE6
         0FY6uNRtYY7pPN6gHHtV1PT84AEqcgQUjVVNSOZYBDSB4VR2O0Zzk/IUhLGBs1aWvkvf
         P5jQsgZkO7E5f5u4hQHT1PZ5CeOqi6KXdxUJbgZoMKSoKjfVJ2xUXovkBcqQ0QyR+K42
         B1bbO+Ivg3nZGddGx+BKFcWhrEJiZNxjlXNY/ppW6OhcYVc7vSy/9thilZ299lNzd0Bl
         SgEDWL8XshOunCCQS2tjOEyXd1zJHno6PWDgzb3gZasxa7if1LHAbRiJeq93Vj4U5+xU
         pxTw==
X-Forwarded-Encrypted: i=1; AJvYcCWAqoJ0EKctAbX+l9u7GNVOptG3oHGnqVAkEC4mYaxny6imTK3IgGeNfYR3pbTz5hHRdhjRtnImKAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaujgBjJ9qqVER3vGGLdUhkhtOpCWkBF6970uAjAclWe+bvujX
	nyeR5fL5Em4zNSbgnPc2Mux4XBx5nW+oMIhykknRVj0T8wzyZEEhINteSX5zplQn2xciFqGJbCf
	liirl+mncGeFG1P3EoKUjB89UgMdshJnWqAKCTn/gKQ==
X-Gm-Gg: AZuq6aLG6RdHyrKIZIYB0PTVGvpNknQodB5W/kieA+IM/YmWzNGBDPYKRohB4JPeAJK
	iZ4lseQsbCzE6jFAbRhzP7QbLNSl88TSHKXFCs4qPTG9pUgzBLg/2v+Bji1FxPRbk3zl/QASdl4
	4pEfFf/c7Kz8aNuU/d8gWmltXz2Tr2IM473mCXvoi+Ns3cEppG0kLorMguj5WosSOg7smh+3p1V
	qwDMCe+nXkLLyThGm9ttJ6CVFn7xiojajwDdkDNqq+2l5jZITNGw8E0aUykmtHoQB6HVGlR
X-Received: by 2002:a05:6512:2249:b0:598:853e:72f9 with SMTP id
 2adb3069b0e04-59de4a26891mr43260e87.51.1769105019654; Thu, 22 Jan 2026
 10:03:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114122141.1529-1-hehuan1@eswincomputing.com>
In-Reply-To: <20260114122141.1529-1-hehuan1@eswincomputing.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 22 Jan 2026 19:03:03 +0100
X-Gm-Features: AZwV_QhN6zcjazh5TOmljIVp-TkoWRRwr61s14Eeb3HCUWqpilURl7yP9qvs5Z0
Message-ID: <CAPDyKFrkEZDuMbGpfxismcx=vJkSSK_XbtB762+sUFocupT63w@mail.gmail.com>
Subject: Re: [PATCH v1] mmc: sdhci-of-dwcmshc: fix init for AXI clock
To: hehuan1@eswincomputing.com
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ningyu@eswincomputing.com, 
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com, 
	xuxiang@eswincomputing.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Jan 2026 at 13:21, <hehuan1@eswincomputing.com> wrote:
>
> From: Huan He <hehuan1@eswincomputing.com>
>
> Accessing the High-Speed registers requires the AXI clock to be enabled.
>
> Signed-off-by: Huan He <hehuan1@eswincomputing.com>

Applied for fixes and by adding a fixes tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 51949cde0958..d795745987e3 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -1588,6 +1588,7 @@ static int eic7700_init(struct device *dev, struct sdhci_host *host, struct dwcm
>  {
>         u32 emmc_caps = MMC_CAP2_NO_SD | MMC_CAP2_NO_SDIO;
>         unsigned int val, hsp_int_status, hsp_pwr_ctrl;
> +       static const char * const clk_ids[] = {"axi"};
>         struct of_phandle_args args;
>         struct eic7700_priv *priv;
>         struct regmap *hsp_regmap;
> @@ -1605,6 +1606,11 @@ static int eic7700_init(struct device *dev, struct sdhci_host *host, struct dwcm
>                 return ret;
>         }
>
> +       ret = dwcmshc_get_enable_other_clks(mmc_dev(host->mmc), dwc_priv,
> +                                           ARRAY_SIZE(clk_ids), clk_ids);
> +       if (ret)
> +               return ret;
> +
>         ret = of_parse_phandle_with_fixed_args(dev->of_node, "eswin,hsp-sp-csr", 2, 0, &args);
>         if (ret) {
>                 dev_err(dev, "Fail to parse 'eswin,hsp-sp-csr' phandle (%d)\n", ret);
> --
> 2.25.1
>
