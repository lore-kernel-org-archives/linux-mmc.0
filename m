Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0760B3085D5;
	Thu, 19 Jun 2025 03:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750303770; cv=none; b=svFI1PbMbPRVrDONA6hxXorSiHHCViPDUc0OdBber5HTuQQo7jmRysCxjPQABc3PlZuz0K3BRF8fspuj/pSE5s+rWNVqD+qlzyMcXWbhaT3kDkkLOwr77qd5oFwu9Ta/aPrflKg9sB+EaGc6vUAegk4EVZJSwb3maL7Hgnwy4FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750303770; c=relaxed/simple;
	bh=gdA1ufI75FONkqqQf8NfzlHW6Y2cmGyDetYBhCY2gw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UqR8GfmaXkazajN1+xZ5HQzy1YIWnO7fM9ljfl34rzoSzdpP+G50GG+aBhGEOqyBqPnB+VlIxVLgmO1poxAbzf77/Vl4a3WZQCqPJALRJUvF7Np1oTKbUP3MBcrYDzam24NpLME6/NSUgA0XEkIb7/kryt8Xpy/viKqA4Fhbyek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDUVmuaP; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDUVmuaP"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32ae3e94e57so2367501fa.1;
        Wed, 18 Jun 2025 20:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750303767; x=1750908567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYhzFWJzI9UlladlO2dAWyHdoSKei7zYj+K+uaksEws=;
        b=gDUVmuaPMy1XklcareAaW6Wz3Wk7q4td/1vjxZ/neoGGi6YqIMXTxSh0pwwk/NHs3q
         /i+q2cj4bC3dLNpDWaLLV2RPSv91ZUWTT3NO0rnLDZLn+4vmWycndgth1hVqqFmZZ3fU
         bUUgXYvT7eilCAzxYS3VOrdNRhHfVgNlL5ZbFRaffElFtPylPLo0OuG1i57zkwTrWhfw
         Jz0C86CX1giOAU3AdyotFND8UPA3ggsRnLFo9wwryR55+x7+a5D3qP3gdIkYIJndx9Jm
         WXcZQkPt+DkJEZkBl0834QylhINgokZEIVcVqaj04BuyMIvYASMX9XMxWnD4zAQzKDut
         L+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750303767; x=1750908567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYhzFWJzI9UlladlO2dAWyHdoSKei7zYj+K+uaksEws=;
        b=FKi81bNDcvFG1zknmH13C8qCp3mCfbfoeCWWSs5kphgZH6lQjSTOITLfxw3k3auuh6
         VQQ6OC4E6ctAOqi3waX7lDEPaZ0D1Yevr9DzF4i+XqL5zEO+G++SbC635OQ+UxsVxXAm
         EGw3GSmQ9F6Iv1yRkaaUsumV1tzJLrQc9RZSHI3rg4pWcfK1xIDWlPVCjIXxqiSh9og3
         mBk4ZceyZWllbLQkQ+/wpBmIg/Wtiflm6wWwCiGdDsilj8S8+hrhNopbV3KVZxef4I9n
         ntZqJ0KASbNVb4n+l5jOkv1y9FTk/b7lpSKw1ohuZYMLfgjR4OftCQkLIxk4KKJE6UnZ
         SFwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWm1Cr7GOau0zL7fkf3AjZFBcLjgttECdlFtRqSxFwzO75kUkLVwSM/D8HnTKVBfayjLryi934QcaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZHLi3ngFuzDQALFBdjkoLQmEnM/vBt5I5GJRRqmyLyq6KIIQw
	qqQAVbA4QRpAwMAuMIkMcEd3GqgDTu6QnobUCb2GUt6viOqsQ/T0zrbHK82i0pGMWZiU9lTALUg
	a6QFXcrWWWB8mtBHpIYX4/WyecOUt2+bfpuli
X-Gm-Gg: ASbGnctD1YbiGvKf2IAMi0jiCQZvgb1k2TZUDOjHpqB/2CoBc8K5Fo0/uEPnhM/whZF
	hLN9E+XxoFr04aNDw2dryvxiVebMFpnjY8ApFzLOVqkvdGUuUgMbI4DRVxegHn+IWTnWy/bDVvl
	ptenhjrhqGlGSI52nI6JPIGvnKf2FTsJ9ISYUDpQV8RQ==
X-Google-Smtp-Source: AGHT+IHo6gaXZIBwtDICYjRmBy2lCnaTZmS13pLTdA3jU3/u50xhgqUOzsD/nfg3YkM+rcXm2RVuo7RAhOPT+0A69d4=
X-Received: by 2002:a05:6512:3da4:b0:553:2868:6355 with SMTP id
 2adb3069b0e04-553b6eaef99mr5351437e87.18.1750303766810; Wed, 18 Jun 2025
 20:29:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211214645.469279-1-erick.shepherd@ni.com>
In-Reply-To: <20250211214645.469279-1-erick.shepherd@ni.com>
From: Jonathan Liu <net147@gmail.com>
Date: Thu, 19 Jun 2025 13:29:15 +1000
X-Gm-Features: Ac12FXwTwZcThbMsdrIZ3CuDL5CyuC2d7ChWPC9bXLWvaZnAZw3_4H7GMKXTur0
Message-ID: <CANwerB1u9JMm+p+HNOHjj67Zw=5XhMOrLAMyXbb5jBwgQbCkVQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Disable SD card clock before changing parameters
To: Erick Shepherd <erick.shepherd@ni.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	ulf.hansson@linaro.org, adrian.hunter@intel.com, gratian.crisan@emerson.com, 
	Kyle Roeschley <kyle.roeschley@ni.com>, Brad Mouring <brad.mouring@ni.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Erick,

On Tue, 11 Feb 2025 at 15:46, Erick Shepherd <erick.shepherd@ni.com> wrote:
>
> Per the SD Host Controller Simplified Specification v4.20 =C2=A73.2.3, ch=
ange
> the SD card clock parameters only after first disabling the external card
> clock. Doing this fixes a spurious clock pulse on Baytrail and Apollo Lak=
e
> SD controllers which otherwise breaks voltage switching with a specific
> Swissbit SD card.
>
> Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>
> Signed-off-by: Brad Mouring <brad.mouring@ni.com>
> Signed-off-by: Erick Shepherd <erick.shepherd@ni.com>
> ---
>  drivers/mmc/host/sdhci.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index f4a7733a8ad2..5f91b44891f9 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2065,10 +2065,15 @@ void sdhci_set_clock(struct sdhci_host *host, uns=
igned int clock)
>
>         host->mmc->actual_clock =3D 0;
>
> -       sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> +       clk =3D sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +       if (clk & SDHCI_CLOCK_CARD_EN)
> +               sdhci_writew(host, clk & ~SDHCI_CLOCK_CARD_EN,
> +                       SDHCI_CLOCK_CONTROL);
>
> -       if (clock =3D=3D 0)
> +       if (clock =3D=3D 0) {
> +               sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
>                 return;
> +       }
>
>         clk =3D sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
>         sdhci_enable_clk(host, clk);
> --
> 2.43.0

This commit is causing eMMC to sometimes fail to detect on my RK3399
ARM64 board after updating from v5.10.237 to v5.10.238.
Any ideas?

Regards,
Jonathan
