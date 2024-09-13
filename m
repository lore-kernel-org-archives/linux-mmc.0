Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C081D9323
	for <linux-mmc@vger.kernel.org>; Fri, 13 Sep 2024 12:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726229611; cv=none; b=NbVjnWNJyiLVdMF8llGFk3R+Jf/316+9Y85DbY3tyFJKezg409OCNYY0aXutBV4q9w4mB0HRM8i7qAqZCE7af06vcBlSzkhvwHZvF5x4+BSYVnA2sVdhOwUuyyv/rXR7GvwGobJQ61mByXmaymEc2Al8Od6rYupEgKDjd/OD53w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726229611; c=relaxed/simple;
	bh=WW7fLZZ8VgKohsiVkYZgDdgXl3w5a1PmghDLoJsRYXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQal2ldB0P+cS4KIIm6OHAoWwfZ/ZCF7ohWnWT7jY/8j1KY20Pk+bzNZIAcfBHlz4vtYeW7IbljRFA2xsQpVkI9NF7X5bEhM6ffrLVQBcBd4ah7BX4uf1Uxxo7SFAjG+ZxulkcjhLs1NicF6dSZw5tPz4b7y9ECSrmxa2ulaim4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H1hLH81i; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H1hLH81i"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e1a7f1597bbso1572257276.0
        for <linux-mmc@vger.kernel.org>; Fri, 13 Sep 2024 05:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726229609; x=1726834409; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TX9ih1ubYMKW2iVGMJX/IFiFekSGf836KE5EslMkk1U=;
        b=H1hLH81iyhRIRJyGESMHkbTHfd9eZRtzg9r/AuRiGLvu1JY2UzxjU27AepNkgMvR4g
         eutxcuc/HykSofbqL25BhwO/NcMaj0xRAhXCDZ0nsebTQRLRW91twdhCkWmD2xv3Jfur
         LQotK++WsHGyXFRRmdHXvawLDhmvFHH82PYZdyg+0Xj2WtAjYD/w+S1SHLel2Xipg/X/
         TpkS4tgwnifKpETI1fxtvj10Yvym01YN0bh8EM+5Pa80XD4v5hUH8AaQedfCEfAbpUzT
         cU2AX5Rp2GkeHTAz0eeBMrCgBsG/FxCiOkKjw/aiyhMDILtQeHgk/yKF/mTfH+Mvl6Uw
         B+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726229609; x=1726834409;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TX9ih1ubYMKW2iVGMJX/IFiFekSGf836KE5EslMkk1U=;
        b=U2pD0buFCFiQFXpF2DLA4IbE5e2NL/qzeUWY5D8+7gRZd4T7xVoNkC39s90F0LiWMy
         U8CWhhDM+ibHPh6uTKCvqR6IRQTKjsa7pOTSoh8ClRchk5Gvn7vPPb9T97xownu9JOSJ
         qy7hBm4evUADx1bay53D/bmoLI4W3J9b/kGjczlB0aAQIEgF7ELitS+yZ+VZ9uTqXXlS
         1/YJVJXPfsd35i0QYpLbG0VQ4GdU0qA5rwBhB8qYGMfeaob/sdMKI+6OQAzAAjoBvAIP
         mufvecy0gSbnMNGvh3xgGh2G33rFjxrxZHLdguoaOhjCuI0+Xe756TUh9UCZPADaU5bn
         gZvA==
X-Gm-Message-State: AOJu0YyHeeWurkSSAXilXHzXt1pr8KrxQ0JmNpi4mE4Mjbb4yHpxB2Fc
	1yOws16cmfrgpPITab3o+iiK3ZaTt17rz5pf7zFHYgfWt++b02aSsYYqgNsfe9hXsvidXVgFhci
	k584CgztYnV0xBU3com8jKrAqfIPf3oKMjJwPcg==
X-Google-Smtp-Source: AGHT+IHgDN2jdvDiw5yXIWHXJe2wI/6BK/3bUrx0vNc1IhCHnapZTBft52RHjxYmhEcK+zl1z3ewNSe+NEDA7nkf7cw=
X-Received: by 2002:a05:6902:dc1:b0:e1c:fbe6:b11a with SMTP id
 3f1490d57ef6-e1d79c15538mr10891169276.0.1726229609197; Fri, 13 Sep 2024
 05:13:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911090910.3060749-1-alexander.stein@ew.tq-group.com>
In-Reply-To: <20240911090910.3060749-1-alexander.stein@ew.tq-group.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 13 Sep 2024 14:12:53 +0200
Message-ID: <CAPDyKFo-8=UOH7ZLNDZ8+zLCLSW-f_-JvjUQFC26OtVpeT2oFA@mail.gmail.com>
Subject: Re: [PATCH 1/1] mmc: core: Use dev_err_probe for deferred regulators
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Sept 2024 at 11:09, Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> In case vmmc or vqmmc regulator is not available yet, use dev_err_probe
> in order to set a deferred probe reason. This is a helpful hint in
> /sys/kernel/debug/devices_deferred
>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/regulator.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/regulator.c b/drivers/mmc/core/regulator.c
> index 005247a49e51b..01747ab1024ec 100644
> --- a/drivers/mmc/core/regulator.c
> +++ b/drivers/mmc/core/regulator.c
> @@ -255,7 +255,9 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
>
>         if (IS_ERR(mmc->supply.vmmc)) {
>                 if (PTR_ERR(mmc->supply.vmmc) == -EPROBE_DEFER)
> -                       return -EPROBE_DEFER;
> +                       return dev_err_probe(dev, -EPROBE_DEFER,
> +                                            "vmmc regulator not available\n");
> +
>                 dev_dbg(dev, "No vmmc regulator found\n");
>         } else {
>                 ret = mmc_regulator_get_ocrmask(mmc->supply.vmmc);
> @@ -267,7 +269,9 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
>
>         if (IS_ERR(mmc->supply.vqmmc)) {
>                 if (PTR_ERR(mmc->supply.vqmmc) == -EPROBE_DEFER)
> -                       return -EPROBE_DEFER;
> +                       return dev_err_probe(dev, -EPROBE_DEFER,
> +                                            "vqmmc regulator not available\n");
> +
>                 dev_dbg(dev, "No vqmmc regulator found\n");
>         }
>
> --
> 2.34.1
>
