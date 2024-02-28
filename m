Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB141487D7
	for <linux-mmc@vger.kernel.org>; Wed, 28 Feb 2024 13:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125449; cv=none; b=pVjZYzQmGXZG47u6ZKiiANhCHOla7GZuQHhGloZgm20T7dsUDy95KYYMLu+XlSqO/VqU3aaDDXa/YZWaP5Y8b/5xN6PWSA2xdNbM8IPmMHEuJ+dQIEIvw9ORnRhsPxECqsK/9OIEQnUIJxXc46Mg2Ccc9PZrNlo1U0h7Ew+12Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125449; c=relaxed/simple;
	bh=gtYJD78+zk61wKaUFAjdhRUznoMop+FRi7xFVUcdo2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TWDsdMttPgaLkGVhh7/0eIHE4fU1kM/6nR3NbV3Gz2zsNSnNKHEZf+Qtwznx1r7p7WDNRM6m35dzNFmeTyZ54QlMzPG0g7Q5bESy5lHFNcusbYcx+vPv0UufQlmGefe+jGTrKmY7Mc8Ltc6VxZmvriz4eZvblbiztwO++8m/tys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O2Ds+7VX; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O2Ds+7VX"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c1a172e46bso2092598b6e.3
        for <linux-mmc@vger.kernel.org>; Wed, 28 Feb 2024 05:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709125447; x=1709730247; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k7qSr+E8IkDSOGsp4neJk0QYmDXRPfIuMj+PPH7uuhU=;
        b=O2Ds+7VXocLutQOlNqbMDecMXFOEPAl9AROKjkqvsRcO4s6ST/4Hblw4sgTObpg87L
         UH6ZqYwT4gdqgCwkMDOg5M/yRgVWDPbJZmtdBhRoa4R10TM50OxTxXl03Xubp2IjlcBU
         ejERcZyHRmrYIEfLWGAD212tTzxF4Eq3hK59A3Hyn1nsmmG5R/BfS7Nc28NYHYsGKXv1
         5HeefEGeihHgOs2F5IvYKi+LHyhHmPTpFJ1+lqo2JRWYltVa7clgm6iUIyUgYP+c1Z3Y
         Q1TCehYhdTabyxZYiKZYRSfXNurtZd1dErt2r2XiG7MXE9aNkeHmmATV9ec753pHg82o
         C/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709125447; x=1709730247;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k7qSr+E8IkDSOGsp4neJk0QYmDXRPfIuMj+PPH7uuhU=;
        b=ePcS+/emvQMx3sYAjDgUiFyHx6+APZM5V9iK9jZKt4WCiwUvMH3gCcg3/F4Tcofi8K
         +DbNRJoQSEG44wNWXDMlksifFhsuzO7hRr013jIXDk9di1n8Havja6dsRB8pQydCXuFS
         X1BJOciGPQqI+ySrfv1F17TyMADrfzMx4LfpZxywZZ8QpprLqauxYjdK20C1jE1fxE4Z
         Hmpk0/z1HnGuiMBMMtfOY/X1KELPReKJOld73Wn2RPWJxDAvUNB/TBXc9YKtlQC86Ga/
         xV2P831FBaS1dEuzw1eElaBw5b9+kkZgRqBnIKfCHAhr58rfOQFkY+Fz9Hmwf1dkxBb6
         7Xwg==
X-Gm-Message-State: AOJu0Yzi5pu3k3frzoKcPm0NRsfljOMEOwGVnhTgP8DBI1Zn8Ekp/hws
	k/zAOp6y+cc40q2dCJMSP/JAOoTWoDmNssLHU92+VMSrRIlDjE9rn2bOdoJmMv9DRXV1TDLJRUx
	YX0CLxFcJol1UGUH+L3+6Ssc385G8o2lEy6lUSg==
X-Google-Smtp-Source: AGHT+IFHPdHOjSRo/mo5Rwta0p5srlJH6dpqJHBuIwpiOWdJg87B8XZP9lSSjpLNU3GUvhTc4DHNbgHd3j+vrV8cPc4=
X-Received: by 2002:a05:6358:b5c2:b0:17b:bd6e:22c9 with SMTP id
 wb2-20020a056358b5c200b0017bbd6e22c9mr5635045rwc.8.1709125446965; Wed, 28 Feb
 2024 05:04:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219-device_cleanup-mmc-v1-1-1910e283cf5a@marliere.net>
In-Reply-To: <20240219-device_cleanup-mmc-v1-1-1910e283cf5a@marliere.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 28 Feb 2024 14:03:30 +0100
Message-ID: <CAPDyKFoz04LJr=Qek36a8Aa7bFFkapLE6tHrc=W71uEAFKmOCA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: constify the struct device_type usage
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Feb 2024 at 13:43, Ricardo B. Marliere <ricardo@marliere.net> wrote:
>
> Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> core can properly handle constant struct device_type. Move the sdio_type,
> sd_type and mmc_type variables to be constant structures as well, placing
> it into read-only memory which can not be modified at runtime.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/bus.c  | 2 +-
>  drivers/mmc/core/bus.h  | 2 +-
>  drivers/mmc/core/mmc.c  | 2 +-
>  drivers/mmc/core/sd.c   | 2 +-
>  drivers/mmc/core/sd.h   | 2 +-
>  drivers/mmc/core/sdio.c | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 48daeafdff7a..0ddaee0eae54 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -272,7 +272,7 @@ static void mmc_release_card(struct device *dev)
>  /*
>   * Allocate and initialise a new MMC card structure.
>   */
> -struct mmc_card *mmc_alloc_card(struct mmc_host *host, struct device_type *type)
> +struct mmc_card *mmc_alloc_card(struct mmc_host *host, const struct device_type *type)
>  {
>         struct mmc_card *card;
>
> diff --git a/drivers/mmc/core/bus.h b/drivers/mmc/core/bus.h
> index 3996b191b68d..cfd0d02d3420 100644
> --- a/drivers/mmc/core/bus.h
> +++ b/drivers/mmc/core/bus.h
> @@ -23,7 +23,7 @@ static ssize_t mmc_##name##_show (struct device *dev, struct device_attribute *a
>  static DEVICE_ATTR(name, S_IRUGO, mmc_##name##_show, NULL)
>
>  struct mmc_card *mmc_alloc_card(struct mmc_host *host,
> -       struct device_type *type);
> +                               const struct device_type *type);
>  int mmc_add_card(struct mmc_card *card);
>  void mmc_remove_card(struct mmc_card *card);
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 58ed7193a3ca..5b2f7c285461 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -883,7 +883,7 @@ static struct attribute *mmc_std_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(mmc_std);
>
> -static struct device_type mmc_type = {
> +static const struct device_type mmc_type = {
>         .groups = mmc_std_groups,
>  };
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index c3e554344c99..1c8148cdda50 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -805,7 +805,7 @@ static const struct attribute_group sd_std_group = {
>  };
>  __ATTRIBUTE_GROUPS(sd_std);
>
> -struct device_type sd_type = {
> +const struct device_type sd_type = {
>         .groups = sd_std_groups,
>  };
>
> diff --git a/drivers/mmc/core/sd.h b/drivers/mmc/core/sd.h
> index 1af5a038bae9..fe6dd46927a4 100644
> --- a/drivers/mmc/core/sd.h
> +++ b/drivers/mmc/core/sd.h
> @@ -4,7 +4,7 @@
>
>  #include <linux/types.h>
>
> -extern struct device_type sd_type;
> +extern const struct device_type sd_type;
>
>  struct mmc_host;
>  struct mmc_card;
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 5914516df2f7..4fb247fde5c0 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -66,7 +66,7 @@ static struct attribute *sdio_std_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(sdio_std);
>
> -static struct device_type sdio_type = {
> +static const struct device_type sdio_type = {
>         .groups = sdio_std_groups,
>  };
>
>
> ---
> base-commit: 25e69172db8a31ef8564ce1cf755ac5cb8374daa
> change-id: 20240219-device_cleanup-mmc-04210bcc3d9a
>
> Best regards,
> --
> Ricardo B. Marliere <ricardo@marliere.net>
>
