Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B6F20CCD8
	for <linux-mmc@vger.kernel.org>; Mon,  7 Apr 2025 16:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744041934; cv=none; b=uX6U/47ohIPuB1hNyPz9NormvjxnSpPBvngAHDFgND/dO468hNGNVMCIvFSPG0NEKRicd9RKs1SgsJWRYwvj7cDXMmnO4mf7ABoVTKXqZY7j5o3jagO0BIqhTJmIXfVIXZH5Jf5ppOd30WNxg1+2q7J9q+lpr0fC2ExZiLgnAN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744041934; c=relaxed/simple;
	bh=zaIj6bf60mYQTXK0HVRjO1dYSIbBBHmtY9FFgcvGbo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eh+fYdWYv8pD8F2BNrh+9lQSl2cFjqAuaQwtL4jzobhM+ady8LQyX7O0LBgbhrwDUR312ajPOW493KSRgAm0IgfTv5skbz1JjLE5tkwzGVShlawRsGBbmcVzl+iNnSWHSthCuy3LWaO3sNYvEjK5FXHLVKI+rXAVZw50knVoWYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mDrUICLP; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mDrUICLP"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7020d8b110aso43077207b3.1
        for <linux-mmc@vger.kernel.org>; Mon, 07 Apr 2025 09:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744041931; x=1744646731; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iyMXJxNU8APh7FepAd2LYAIeH/3a57mIaJumXNTEoaA=;
        b=mDrUICLPrqvFpUD1L0lkc4goXFB/5JVCBd+tqksExz2wxw5nc4+YXqcfgARDQ/pmPV
         o3qMUtWKYTgs1WNfZaEa362T8Oij5Kkhska+BseTv/9x+VM//jqT8WyWEB578en5p1mF
         0u5zXc/Xw8R52EsJNaKlVEZSJZYWlauZhS6eCWboYuKKKH8HvvX9b1k3r9wdviSEeJs6
         PKJcsRnmmkuyA4YbY4m2lurdmO+s3un/NerKAfZQXTifXbw1zNWulzXaNa2lqDpGGqOF
         cWCqc/bbHyG9Mi+S77+kqezOwkYYVuaTrroV1ZgYxh/u7eOdpmejVHhD2+tDiX8SfxO7
         3GMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744041931; x=1744646731;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iyMXJxNU8APh7FepAd2LYAIeH/3a57mIaJumXNTEoaA=;
        b=j4qULbwGn44cX0SIl1IQao9pkp2NB1p40BVZ7n0Iz98WMJdTninFNbhwevBuWP4uII
         mL2+sxfznyJAXcJwXkBhywhbD5fTDzp8znRIkATR7nAnyclTcSr/Ef9qCbEkxQ8mLgvT
         QJBZxrYg3sahD8cqT2f66Fgzgy3yVQvmsE8AA+jyQ3NieRztbUfCLnapltbD76Uinuht
         QCxWqY3mOt/R6vICcSvROdh0BWwrT6J5wdAIAC9LbEd3nebtDG+FufRX4oElLaDr+yCO
         w/sBWHaxNrzATVhmSqJbfTm1Q9TMVC8dogVqkQeQScr4hFnCPBIO8U2gSQmYZi6mn7i5
         RLeg==
X-Forwarded-Encrypted: i=1; AJvYcCUI1j6mokoR+W2ZckUADSSs+sQ6JhWuo7Ozag6psEYbkCOlXgVdERGSbIpBYlDzwcHy/qXJU3f0rFs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw79cek4RzjuOz+n/XgjcvfVbPqGv09DBbmtY34345O09gdubNX
	aANsnVW3jUcjD2DihAJCsm1ieHrUc8hVxscYSZWt+Ps+9P8vGlOpYhGWwDnRWYAz3OLtqHRWgUt
	zb87vVaYfAJh815BtweVtCtvIfOtGEe5Obbk6yA==
X-Gm-Gg: ASbGnct8j9uNZkGbhbONTSyOMiKBZgEG2JruLnNNZlP69M3Q0zc11J8Eqa829QKfY9P
	p1qjneBOZ2fTYdXgBwDKLe//t7K+BW2GItWdHNwJJQaezqbDXydRcH8zZPKzKSteZInOyRaQ6uZ
	/usXynwBI0Y6Dq+/l+OLf7OuvyYpw=
X-Google-Smtp-Source: AGHT+IFOHXrnkpBrQieKVZtIVdGZ28aD/0/BwHgFx8drk8Z2Zph8fJ0SKnIaOVRyh9bmDUc1XD5U19PreZpfxaF6YFQ=
X-Received: by 2002:a05:690c:b13:b0:6ef:6f24:d093 with SMTP id
 00721157ae682-703e14f5f9emr226254967b3.6.1744041931060; Mon, 07 Apr 2025
 09:05:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250330221732.56072-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20250330221732.56072-2-wsa+renesas@sang-engineering.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 7 Apr 2025 18:04:55 +0200
X-Gm-Features: ATxdqUHTMeuPepFJsQ2xSTB0Ac9B1r0lgCNmw4z146LWlOQ_Pb00QDY0YlXE9_Y
Message-ID: <CAPDyKFr5xP5=Xo54Z9WgHuCegeUbfHo4HVn8du+SXRoghHAMAw@mail.gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: disable clocks if registering
 regulator failed
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 31 Mar 2025 at 00:18, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Because the clocks were just enabled, bail out to the proper target if
> there are problems with the regulator.
>
> Fixes: fae80a99dc03 ("mmc: renesas_sdhi: Add support for RZ/G3E SoC")
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/renesas_sdhi_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index cea6af5daf99..8c83e203c516 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -1179,7 +1179,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
>                 if (IS_ERR(rdev)) {
>                         dev_err(dev, "regulator register failed err=%ld", PTR_ERR(rdev));
>                         ret = PTR_ERR(rdev);
> -                       goto efree;
> +                       goto edisclk;
>                 }
>                 priv->rdev = rdev;
>         }
> --
> 2.47.2
>
