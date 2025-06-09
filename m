Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87AF25CC56
	for <linux-mmc@vger.kernel.org>; Mon,  9 Jun 2025 14:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749479152; cv=none; b=VmH+I36LcqtnmlIv0YBQwrctQcPILKGo1YDkAwKVr9n0aBG5+M2eboLhZdZwnA5Uy+/rsoBpvJOENpWBXxf3+KvI3lGAIIdWr1UBTW7kiwl50pij2qFBD+Oes2HQwpIi+EEq0qh4i3oJ0bjBbQuGjbNYr4hp6Mms60h/cV2PhZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749479152; c=relaxed/simple;
	bh=tpgFqrLkSn1DVjpGW60JOm0C0+VLH7tHHY59kM5bL/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m3zVrKNTG9D53iz6Tm/2m/DbMsbGhyUr8GSnckNCEOA9y8mSnNf3fH0bSEdKW/ADgdIdgz4/89pT2amq50Whp8uTgewe3HLpBLusOQc3WxBGZQjEy0WahSamfNZK0Cwr8p9HHtDWinB6VIq6xh6/4bWZYjFDSJ17Mpx/OaGkyGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AVeiup7S; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AVeiup7S"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e7569ccf04cso3562311276.0
        for <linux-mmc@vger.kernel.org>; Mon, 09 Jun 2025 07:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749479150; x=1750083950; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/DHcPIW+FNlaQudxh/1xCvJS+KJ4L+7fwYUL5LAEe78=;
        b=AVeiup7SMc5rGeff8WBHr25QSzFULA4reLpqGP9vvcJx0uas+s8tPcLx9zk5JCr9mZ
         fqHTN0LDYxZFPRKr9SgEqQsKUFTdxOXsAQ9b5SEAsUrAfw/g1ZQhLSqjLTWVlnpVeOdP
         u5aNFLsUtUtkqY4Sw2g41IaWtbHnOo3Ry07YhAtmgRwsGdUNEPXao26Ki1iNFMCD2xZk
         8mJ0BUxg0tXFUciK17rHRtf8rDV5moBcza+7UlOMMU3KZFfhWunkEixvirixOpLpNGvs
         Yyd4a1TUnqbZzJSzoAsBTcFXCFZ3Q+678snQ1DqVAW4o5GRmEC0V6rL39SP6ZmD8tTai
         rZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749479150; x=1750083950;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/DHcPIW+FNlaQudxh/1xCvJS+KJ4L+7fwYUL5LAEe78=;
        b=B5mATBxZLpj3swMh3CeC4TQ5t0jSzIZRO2wYQYlAYFdv5zhPiH7B4rjssUrInPFJBG
         vvEeCalECNFe8kyZxOBMzszPfQDJr2gMUjo3MTemQYe3oTEbFx84K4qxiMQ3kDjHhsHv
         bLp0fnd9Jtb3YNGWYo/ZZ0KkXkN+/bu/A/EH2Ux2XNSCt65bPb++zB7pVa5RhYf6/yJ7
         sOZZPBu8tc7CNFzMVqZwETuleXL2VXObH9vP/0WPJuCvA+JdSoqRhZ9wgCy1HlXyUC4O
         FpEEiDSORj5htlgIGpxYP785zMmnEpjOKY0YOLs/VQozI6z/d+XzTIN5mtf23NXNBc7S
         d4SQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8VJ85fNVFIOWoCqLxWYJCYePipNUmRNIBIWK86sI7hpVulJsYPcPE95gjWpHLSmCfM1z5jB1SzD8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+bdnKsJsxAWIuJf81MAXsf20mrpFGQmnpyU0KIvYLO9VQag9H
	E/A0Z0n+gSA+afRtNb/zSxm/nOPQz498W700KvRHMVulJsONM4i/gXlpj05hOdOEg3OxyNSm7Uk
	2DFd8sqE4Zl6VKh+gcHlZWjnOccjoBOg+e49xVwLMXQ==
X-Gm-Gg: ASbGnct5mBYUSbgdj0YUJKLjb2BbSDa3Fi4jFlv/KiTpxi5kFHscoxzVAvJVLJR2cAK
	1p3G4fOv57cY8Dw3JlbuZxdPC+XGNtiaDd1uolv1L/IVkb2ILLyn2hnRJzs69LCElcduWYVyax4
	mj5/Zc7y3PmwA29mRp037SXSFoOgL8zj+VFQ==
X-Google-Smtp-Source: AGHT+IH/Pnd5J+NF0FnDZghYVyvpxu7EjsURZfHbZf+7AxkvSsyWy0aeXxECpBSIWdWQ+pB3LafvHHvF9PpdbwIrqGk=
X-Received: by 2002:a05:6902:2686:b0:e81:cfde:3d46 with SMTP id
 3f1490d57ef6-e81cfde4149mr9130040276.16.1749479149876; Mon, 09 Jun 2025
 07:25:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aDVTtQdXVtRhxOrb@stanley.mountain>
In-Reply-To: <aDVTtQdXVtRhxOrb@stanley.mountain>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 9 Jun 2025 16:25:12 +0200
X-Gm-Features: AX0GCFvaiXF4lOm-GilksSFMvid8SMz438Y_wsOtUwqxJmS3jsDnPCnS_PeSI8Q
Message-ID: <CAPDyKFqMmOUsEWjE7X2oj0Nuc+FU6g_0p=+JCQ8xgGXJXNN-0g@mail.gmail.com>
Subject: Re: [PATCH next] mmc: sdhci-of-k1: Fix error code in probe()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Yixun Lan <dlan@gentoo.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 May 2025 at 07:55, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> If spacemit_sdhci_get_clocks() fails, then propagate the error code.
> Don't return success.
>
> Fixes: e5502d15b0f3 ("mmc: sdhci-of-k1: add support for SpacemiT K1 SoC")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-k1.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
> index 6880d3e9ab62..2e5da7c5834c 100644
> --- a/drivers/mmc/host/sdhci-of-k1.c
> +++ b/drivers/mmc/host/sdhci-of-k1.c
> @@ -276,7 +276,8 @@ static int spacemit_sdhci_probe(struct platform_device *pdev)
>
>         host->mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
>
> -       if (spacemit_sdhci_get_clocks(dev, pltfm_host))
> +       ret = spacemit_sdhci_get_clocks(dev, pltfm_host);
> +       if (ret)
>                 goto err_pltfm;
>
>         ret = sdhci_add_host(host);
> --
> 2.47.2
>
