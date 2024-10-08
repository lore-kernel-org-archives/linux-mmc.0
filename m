Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6101E1051
	for <linux-mmc@vger.kernel.org>; Tue,  8 Oct 2024 14:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398229; cv=none; b=hf5r0m57vnIQnrrIOl1TbTL9RSt9ZSshr2TN5lHwsa4aZE9X2rzq5+3p4AhkDfD8JfzaXSAarFQGHM83TtXBbApsgLuixA6SGLOTIPDXC7GPntO1X6mkU7CurpewM9XWfi3fmvAb9iWOJ2V0duHeQpZYeUYCKfnKq0nM7f1t+ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398229; c=relaxed/simple;
	bh=kyM/JRlJCLo4W49Smlxc/JwSIAqOTvuozLByqTwxaG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ndl4p1s/FsSdiCbiQHm5/aApVH9vU7U18G14bsPX71bzex4ea+AJfNlAwVyPE2nCcgdmQmGQ5iuYQF0XFkLj1qW7i9mG+khLK71UYg/8FT5rHCyTxdcSp7z0jRc1S6unExH35H9v1JeuyusFy1jIg0MUoS3hT4DO+qxee9bs7vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lSfOYXVw; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lSfOYXVw"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e25d6342837so4886861276.1
        for <linux-mmc@vger.kernel.org>; Tue, 08 Oct 2024 07:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728398226; x=1729003026; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/xpen/BJpwgN+MKlULirmUW54U9GXkeLllHPkt3HyE8=;
        b=lSfOYXVw2AwmAKqxOI16Rwv0T+47aFx/bNz1Rs2rAOIz7fJW8dvUnEaqZHhh9jHinb
         6C28bYL2aBwPuGp1MYjG/945U7MOn7rLep38pcg9yMNTqL9xuWzhxaVcTQTCRUXsHvMf
         nCl86gKVYUHsWjgSY+IEV9R2CTVQed4Tm4GwRvosvipwbc8gpKerJU/BT3Iose3aQfVV
         qzMln43NZMfj9Lxmxxdj6DPwK/43kR9SdRTsWdyR1pQwrwwUeGZaUb9dCEzV6m1MSm0q
         /E51msykMbgrLSXwOBV1uf7YAP1fLK3Vd9R83LUvCCRTvaKRAD/Unoixev8VtzXmr99h
         LrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728398226; x=1729003026;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/xpen/BJpwgN+MKlULirmUW54U9GXkeLllHPkt3HyE8=;
        b=vuppBz5B3FlNVCnSrTZ8xtSeb54mXgE2AR9ni6wKDbyq8c66kNJefD16oC34Xay6Yh
         gu6Vmv+yyJZA2DXXb1wtpjFRH07oVPAN28Mns7wIwWMLhSnIbLBrhEHJ/oMVcUrVrAfV
         WLusaz45oABCRjdRm8AoLRnxPrPlV3v9ITQ8m5/dbf1rVmxUZDbw+kxnJdN1qgaRRBpD
         D18kqUY7Y+zsUBRoF3NXtXfYgYZ3ONE7GnhRlzEsLbiNGLubbkQ1bG7ekx190uXFOuyw
         Lb8LPUJhkmW3hztMU4+4LHYC25ldCkSnThYoOlddNP0OYuZVE2Kxfqvj3S0EKY1fY4uA
         121w==
X-Gm-Message-State: AOJu0YzefArayPLnBKQovGossWowV40tVbJbblOpwsDLxJREcqRX3ipA
	TDptlPEi9xYL7rPxz6X76UhD9tE1+n6EvroY6rhlxGhjz70EEScDRCMnHDuovplHgP9xmc+b1ps
	+vsrR0uPAaq3XfEI5qse/Yq3HZKvls9ExQf/6FmQ3BIgv2zny
X-Google-Smtp-Source: AGHT+IF9ODQnY5yJxbWyaEGlykwD+FifHjsCzMbU/X+WxJFqLNAbtSmGi+UrYG40gTrPHGL/iQ3e5McTYKpxApJ41tc=
X-Received: by 2002:a05:6902:2601:b0:e21:505c:3e9c with SMTP id
 3f1490d57ef6-e28936c762dmr12450019276.10.1728398226536; Tue, 08 Oct 2024
 07:37:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007114918.52066-1-brgl@bgdev.pl> <20241007114918.52066-2-brgl@bgdev.pl>
In-Reply-To: <20241007114918.52066-2-brgl@bgdev.pl>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 8 Oct 2024 16:36:26 +0200
Message-ID: <CAPDyKFqThmrHB76ermV9vRX8PsgWxKiKo7XUpLQzeBcoqvMHqA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: davinci: use generic device_get_match_data()
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Oct 2024 at 13:49, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> There's no reason for this driver to use the OF-specific variant so
> switch to using the generic device_get_match_data() helper instead.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/davinci_mmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index fe7712532e84..cde4c4339ab7 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -21,9 +21,9 @@
>  #include <linux/mmc/mmc.h>
>  #include <linux/mmc/slot-gpio.h>
>  #include <linux/module.h>
> -#include <linux/of.h>
>  #include <linux/platform_data/mmc-davinci.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>
>  /*
>   * Register Definitions
> @@ -1228,7 +1228,7 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
>
>         host->mmc_input_clk = clk_get_rate(host->clk);
>
> -       pdev->id_entry = of_device_get_match_data(&pdev->dev);
> +       pdev->id_entry = device_get_match_data(&pdev->dev);
>         if (pdev->id_entry) {
>                 ret = mmc_of_parse(mmc);
>                 if (ret) {
> --
> 2.43.0
>
