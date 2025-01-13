Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B9120AF65
	for <linux-mmc@vger.kernel.org>; Mon, 13 Jan 2025 15:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782689; cv=none; b=YYo8OlwMj+M1NGACicy/KaSPFagQ8sKTJJur8RxgEtMw+mfTq8btZEQPQ8lsR26OtgUWd+Lo17QKJDgWTEGCHNSliBBW+oQsOMc7sIKtAvicOqYCGoanCNAmabhlpex0vXYwBtDXbEzuuCmw7i+nx+EqGr8iOP4mqr+wWJQyqOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782689; c=relaxed/simple;
	bh=t5aGDeDkhDjdPsBEVbQa6kOKRE9FBMzviOvU0BiaKlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7kzGMLhlifRVqncY1czZ0xDv0RSpHh2RlVkoV1DSu6JqA2ZPFuGMuAqLwUzxkz1OTD4M1+83aHfsqyQ3jyr6JM2pRpSKrYnnXV8pYjSgoJhJ3LAVEyInUQspAGfuXerlSSKeI7KAOlVqjdabciaJhr/xczlxibrkii45Y+DZ0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P0uAJgQs; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P0uAJgQs"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e53537d8feeso6439810276.0
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jan 2025 07:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736782686; x=1737387486; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SnKSFb3Y9ow+CgCanBPx1AwoeWaeOZbKgIOnxt+p0Qg=;
        b=P0uAJgQs07UzuG03g2ZwR3NL4gkftgOnqPC/jXDNqpc8fEX74ZMCgCpyl2pYVKZNXm
         E1E6MOwnI5SRvQdZ6z5Zn/rP8kY+VjYJaVIqYeQsG4ZSUbVK8ldQG+6Pnx53SCalbRh2
         Fb9dXOqeVr3u/OwOhN7e/kbLSRregsGxVeH6X+LfxU6jX33AYeDbZvpTGEO2u+hp4ffH
         1GTygJHkhSiBPxA+DVOKb8xC4XSjeKQ1/AHg94Q76K+zr+nTJF3F0bcB9khugsG1vH7x
         eebqAxTjExFMVTcu/bMu+ztYUI0klhwXiJKq8GynARRDaR/ubilplo0NfJ/YG0dMfSCu
         9pkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736782686; x=1737387486;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SnKSFb3Y9ow+CgCanBPx1AwoeWaeOZbKgIOnxt+p0Qg=;
        b=mSFCC32VWrWkmJbbDUtIg9eYyPHUrW6gbbIlNL3ZbKdeBSBNYUdImD3+Oz8bsyQgXy
         aHz4Zcm3vXTyJ4/kY5EPXCPm3KMZM8j75Q9osKPH5gP9+GfIKtx3vLeVbqc+gEAgIxUG
         NxwoMxZXJsWVUt4SLjZ36zGBsVtmHLeWJM2dZHEajdDavirzsZUGnFFz7xAAVi5LMPAB
         DvvJWla2csf/pFCMsM1doF6dBQ4zh0MVFN9AfgBDPa0YBp/Fs/v1QntX2foNYtArpLV9
         RtNXfWwxdoq368YDLGw/r+16K09MS0q0SLgK/Lxlk9NkI+tPXV8MUFRdQ3NbSAkTFFaB
         GCVA==
X-Forwarded-Encrypted: i=1; AJvYcCWGK1FEX1I7wmBMeFgbp9q/LAjLqMR35+I5jgJdseIGhadtGAM/PQy4n++mHY8HsC65v9Z+NU/piI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlxwlo8ZWRQtKdCApL0pCj3npzBdSU3n2N5zMgN6nzZcJo8r2+
	vdxwP0ogUwwVlWzewx5mnTjUWTneH95wfoAvqogiAbWTqWOZaY9bbrZuo+atkacULgQmT8bBRqp
	zL4pJwrG/k5ecKAuuen2yP8cEnIbw4izC2JCJ/csnGHE3Ol2h
X-Gm-Gg: ASbGncuJMSLzliLW7LFQlcMJlxxyk2DkaAesT9yWtzLiR++Plhi5/A2aS0mHyx+p2D0
	Qe9QzaWtb8H2XyCFoVaTCCCZowlUZV7L9wSa2XAw=
X-Google-Smtp-Source: AGHT+IFzI7fjLfeNrG8tJ88C1xJxsZ90hwKqg0Xa0t2lNDfHQMUjCSgBBrki+pBaO05OeJh5stsYw42zHdabArpX1Fg=
X-Received: by 2002:a05:690c:6b0a:b0:6b0:70fc:f6e4 with SMTP id
 00721157ae682-6f531220bb6mr174035417b3.15.1736782686567; Mon, 13 Jan 2025
 07:38:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111185410.183896-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250111185410.183896-1-krzysztof.kozlowski@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 13 Jan 2025 16:37:30 +0100
X-Gm-Features: AbW1kvZacI5dQg6e-Wq_Q5DiwXDgxjveWK1j77AoMioWOQqxOhSbO0A5tr4c3K4
Message-ID: <CAPDyKFqya3XCkfMjmUtupNJiV0w2bDdpgcPNfZpJcqEuBv1r4A@mail.gmail.com>
Subject: Re: [PATCH] mmc: hi3798mv200: Use syscon_regmap_lookup_by_phandle_args
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 11 Jan 2025 at 19:54, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Use syscon_regmap_lookup_by_phandle_args() which is a wrapper over
> syscon_regmap_lookup_by_phandle() combined with getting the syscon
> argument.  Except simpler code this annotates within one line that given
> phandle has arguments, so grepping for code would be easier.
>
> There is also no real benefit in printing errors on missing syscon
> argument, because this is done just too late: runtime check on
> static/build-time data.  Dtschema and Devicetree bindings offer the
> static/build-time check for this already.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc-hi3798mv200.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-hi3798mv200.c b/drivers/mmc/host/dw_mmc-hi3798mv200.c
> index cce174b5249b..5791a975a944 100644
> --- a/drivers/mmc/host/dw_mmc-hi3798mv200.c
> +++ b/drivers/mmc/host/dw_mmc-hi3798mv200.c
> @@ -181,7 +181,6 @@ static int dw_mci_hi3798mv200_init(struct dw_mci *host)
>  {
>         struct dw_mci_hi3798mv200_priv *priv;
>         struct device_node *np = host->dev->of_node;
> -       int ret;
>
>         priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
>         if (!priv)
> @@ -199,15 +198,12 @@ static int dw_mci_hi3798mv200_init(struct dw_mci *host)
>                 return dev_err_probe(host->dev, PTR_ERR(priv->drive_clk),
>                                      "failed to get enabled ciu-drive clock\n");
>
> -       priv->crg_reg = syscon_regmap_lookup_by_phandle(np, "hisilicon,sap-dll-reg");
> +       priv->crg_reg = syscon_regmap_lookup_by_phandle_args(np, "hisilicon,sap-dll-reg",
> +                                                            1, &priv->sap_dll_offset);
>         if (IS_ERR(priv->crg_reg))
>                 return dev_err_probe(host->dev, PTR_ERR(priv->crg_reg),
>                                      "failed to get CRG reg\n");
>
> -       ret = of_property_read_u32_index(np, "hisilicon,sap-dll-reg", 1, &priv->sap_dll_offset);
> -       if (ret)
> -               return dev_err_probe(host->dev, ret, "failed to get sample DLL register offset\n");
> -
>         host->priv = priv;
>         return 0;
>  }
> --
> 2.43.0
>
