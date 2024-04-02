Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853276A8A8
	for <linux-mmc@vger.kernel.org>; Tue,  2 Apr 2024 10:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055460; cv=none; b=KoBQvaL/W3btv5DUl+LjyWqwWi5cDrPZoeyQsQ4fLUE5ZZkoL45RoUpQ053IpPke7POtSLG3MZ3MAinUE9DvoLWbpukRu7qzPeL0Kj7adLbSXGC8FZMJGNTXyUPwJo4zENBWHoz2bA2QwiWWKHqyMKEa13MrtlbGhSVJOuDaxYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055460; c=relaxed/simple;
	bh=wzQQNRkk/cIJeNXurzU1rbOp4yzYxebV0qz2Ei6O5JI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SiT3GLJy50N6kMZkSFaf6h4nFd7L79oe6Ix2qY4UbAfPZVefqlezz9I5ON54uiZb01nWM1eD70xRFjROvYYrchCGGlUb1l0W0xyalnmnukqpqPexQ5WlZmbDz5nncSAj+zEou01+2W+4vbohGTEflFMWfrf/o4k9yuPJA+38k2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iW6au1Wo; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iW6au1Wo"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6153e169066so1169687b3.3
        for <linux-mmc@vger.kernel.org>; Tue, 02 Apr 2024 03:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712055457; x=1712660257; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4YHqSqNnvCBnfvFBqJv11ufJI1u3AY17gf0vN4REjDw=;
        b=iW6au1Wo7YSYvo37ijC5j0qTZTJV02WByLo7dB5iGY8QVEfxo454hmIKusFtg0syvi
         ONFe+HeV8x2IKzLY/kdUVsg5jh2N8gfq5I6mOGfT9/PNaMFfIVKEH5BZY0XD7RH2rwOw
         cGZm2mxF+Dn3psM2n3T4r8ydRT5G6SFfSl1sjBOgXhlEOI4KEmTTWaji1SeYbHWU9SaI
         KPJv8LadsP5rEANsXtlQZYKbAkCz9+AeuLT8kmwYs5c9M5PXM+ic0GYGwqNLmcLA4Nn8
         yEPuNmU/PTaf8zqq8BSnR6cBklqZBaQ7xsBsrj8ZZYvG3pj9u56ovME17NaRB/pJ2hrB
         HlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712055457; x=1712660257;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4YHqSqNnvCBnfvFBqJv11ufJI1u3AY17gf0vN4REjDw=;
        b=Lth9HPUaszLoOkz1wbGLe6E/Xcfw7l8mxUQ1kOjLpaWxpJEr0p8TuKRHgwFQznRtea
         d9QqaV69uFDQZ92Sz1/PE0cyjEsb+HXtyr0g7xhaJS/lB8aLWQmpbWNrAgf4ToFyj85p
         aLQ+55yii7SfbTNZc8jG3spvH6/DodOsGdkwDsrANwXdvKtQPM2Ckpv6SWEqSY4ndGqb
         8ZL7tfhUIl/JVfqP0P5JVlxd0+yGqqr0iBhRih/KjnlLeTKR9IejLgFw2bi/gMr08q7x
         x/4Wt2R+qjdGBPJOK8lngr2NPRYflwQU13OaWFjeJAowYA5UOZKrJbokBWL/9aZ2W+e3
         hb7w==
X-Forwarded-Encrypted: i=1; AJvYcCU2Nj0NWBAQs9sXsClsIA+QFOPc9OM45Ol11Ot+dBsCidnTVIpyoRsgHjfmlg8Dibrv53vAcXnfZvzdHJhesPTtjBJOyxBK6yvm
X-Gm-Message-State: AOJu0YxDwJRBdeziEs4M54V3IsF9FmNMUYVU+fBQt7qViTHsF+l7vr39
	PtuyMpi23ZEutP4SQG6k4982uiIgVV0YEYWUaBPb/BZNqBECr8Z0i+lPqKS/hMaeF92wa8ihLOE
	v+fXJQI0sE13u6c70kLbOoip1n+rYfvEE9gLv7Q==
X-Google-Smtp-Source: AGHT+IGgzSZ2JPE3HDf7VGawmgSPSJjQToKcv+LLCVOO4BPYFSbmLubksF4TLEbW5Dw4jfNw/sq7EGDlqA7OfMewmEQ=
X-Received: by 2002:a81:710b:0:b0:60a:74d:7ff3 with SMTP id
 m11-20020a81710b000000b0060a074d7ff3mr11793721ywc.47.1712055456211; Tue, 02
 Apr 2024 03:57:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326164733.15271-1-adureghello@baylibre.com>
In-Reply-To: <20240326164733.15271-1-adureghello@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 2 Apr 2024 12:57:00 +0200
Message-ID: <CAPDyKFruMSy0CQphbP6Z8YVeC1xP=N68C+MTV8jzVkdvjyEUuA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update Angelo Dureghello e-mail address
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Mar 2024 at 17:49, Angelo Dureghello
<adureghello@baylibre.com> wrote:
>
> Update my e-mail address to adureghello@baylibre.com.
>
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aa3b947fb080..c3e365b9d759 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8512,7 +8512,7 @@ F:        Documentation/devicetree/bindings/crypto/fsl,sec-v4.0*
>  F:     drivers/crypto/caam/
>
>  FREESCALE COLDFIRE M5441X MMC DRIVER
> -M:     Angelo Dureghello <angelo.dureghello@timesys.com>
> +M:     Angelo Dureghello <adureghello@baylibre.com>
>  L:     linux-mmc@vger.kernel.org
>  S:     Maintained
>  F:     drivers/mmc/host/sdhci-esdhc-mcf.c
> --
> 2.43.1
>
>
