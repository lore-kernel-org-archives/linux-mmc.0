Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9740235C15
	for <linux-mmc@vger.kernel.org>; Mon, 17 Mar 2025 10:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208723; cv=none; b=clfKki9uqx+k1b7/JXHQdbZRDAVZd3XTelmf8OR9sfxav0/Vd2QBycEJuzhPm1TmnG+vqaGwnajHf4poTkxPvP8JdEkRV265XjWe1p49rtTy7wjvVeGsPTc1rf770k/PdzbifZNGpWhwkuBXFtlLsnB/ZJ4DgKNcVnsPcLsO+tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208723; c=relaxed/simple;
	bh=sVFBQhrcAWlKClBKcDG2mFfwLfjULiYni95nXG0ePBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Boo0czbGvM/WEJsesQAYuhRSJxp5QFbHTkWUVOGhOV5yowsnKoNKKxm5vF53Cmd+wA9P+HBybDsR9GocfAy+UZSv7pVD/Xi1l995JvJ6XLR59UYh49CmPjLlXSPMM2ZD6BFFqEpGpgCQW4NBMN1CE1tTZR/jtgsHyiKRhuxAoZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D66pzehu; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D66pzehu"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6f6ae4846c7so41808347b3.1
        for <linux-mmc@vger.kernel.org>; Mon, 17 Mar 2025 03:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742208721; x=1742813521; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lr2110cYvl7za6wMxgJOpzLaRT8Ay8EQwITnfCfbHks=;
        b=D66pzehu7JjmisGcpM+PY/lt7nkC8+5BWDRvHzgojKASojlVMPp6/n/lEFo00Uo5LA
         e3CHUMiorFtneyLasmIzP3+Q3qgruehLFG25K1WcAioU4IikVcFrBwSkHlWfzEkCZRvf
         qvcISQEO5s12xvHcNTNFHdi8+uoRtwGGDOgSTM9M37m5eMg7hDU/HtIKIOC555msoI8W
         kDxO7YqWAztr1TC5GviuxT0n+iYyNdHcay86vKxj6WBX8m6jI3iAFePLr4U2C5Kc9RM3
         Z8lhSVcCfRVW4dmwHhWkOMX4lZC9p3UH2+7W6PHBNW6xt4epaDp7gNAIg4qkPwnWZtiM
         9g+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742208721; x=1742813521;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lr2110cYvl7za6wMxgJOpzLaRT8Ay8EQwITnfCfbHks=;
        b=Ybj+9jh5DbR3iEWvaBEMdZR8n6Ab2FBp0xMRii3tDwk1pSeI8NUzf2Qw8CeQHt3vbX
         tRuSttDeGaqeO/WBybuTdm8QXi8PzlsnDLBajx+UbmGCgh/i7bakRfJv4vJQVa8qOyLj
         Nfz9GWuOJoyCpYaCgJotW6ko/WfyjuTNmxUeEXkQ3DoVAGN3yFWwaHcz5j535YAkQpVp
         qfk9ylhtFoGGhrmFsB54zNM9k2Q4EQlUyJkH7QRq5xA/2MtclfhYMkgN79kH+r98560q
         2WvIlwSPzo3kAoJbuuPAYqoTYqcaNDWrm2K3XrbQlGCy/FG2sysLKan5fHShp09ZN5P/
         25+A==
X-Forwarded-Encrypted: i=1; AJvYcCVOz+Bt44GaNSQe1IDwgJ/K1usq63AQx4f+l2BXcCol41IUNVpeGMemjo6sz8v6kOd3gkK5T+OZrjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtgAaVVe+YfUs07vbfXx1RrIZfOKnntySSv613mKuMZpvC5V9f
	9tXtlQCyU/ec/WwFlE1IW+D5RGUMpx/wNgxEN9Du5GeAsd4Nm6VWc/j2YQkDciq2I4WUM0Ufoc3
	RrHZWzs7iyednFATUJ9zDyBt6UCCA0ZX9VfPdXw==
X-Gm-Gg: ASbGncuXczaVyMQdNCE06d8+yinpXBh+HMbUqh4Pe7bJZtchLCBKKWxo7unwuYV60uZ
	pK2lgPfjbxpPoZMoGQw5lK2Xz+ugb9XLxhQXSGda38lDld6Xmp6jZHvQHz7hU1w7/zXEZ+Wvcmf
	z374C42fCKL2+L9a1j7ACcPrr8O/w=
X-Google-Smtp-Source: AGHT+IFf7X3movNjHtqdVTvAfIHVx7pgogDuutwiMoW5qPqhCnfU9dayLqxs4JjWyA9VJmoQdVD/1A6kQ2keCggN8U8=
X-Received: by 2002:a05:690c:46c6:b0:6ff:26eb:fadd with SMTP id
 00721157ae682-6ff46074375mr148199567b3.26.1742208720778; Mon, 17 Mar 2025
 03:52:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dc39e555-8ef7-4a39-9253-65bcf3e50c01@stanley.mountain>
In-Reply-To: <dc39e555-8ef7-4a39-9253-65bcf3e50c01@stanley.mountain>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 17 Mar 2025 11:51:25 +0100
X-Gm-Features: AQ5f1JpqClchOclXJ-ISZPJXO2_ekcieYheM6YIoLWy4nEFQ2I-b44apFo7Ppjc
Message-ID: <CAPDyKFpO0a+hg0HrgXm0yv0p5JwMrD3aMN43boM73JP-EMpDWw@mail.gmail.com>
Subject: Re: [PATCH next] mmc: renesas_sdhi: fix error code in renesas_sdhi_probe()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Mar 2025 at 11:11, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> If devm_regulator_register() fails then propagate the error code.  Don't
> return success.
>
> Fixes: fae80a99dc03 ("mmc: renesas_sdhi: Add support for RZ/G3E SoC")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/renesas_sdhi_core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index 396fa2816a15..fa6526be3638 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -1178,6 +1178,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
>                 of_node_put(rcfg.of_node);
>                 if (IS_ERR(rdev)) {
>                         dev_err(dev, "regulator register failed err=%ld", PTR_ERR(rdev));
> +                       ret = PTR_ERR(rdev);
>                         goto efree;
>                 }
>                 priv->rdev = rdev;
> --
> 2.47.2
>
