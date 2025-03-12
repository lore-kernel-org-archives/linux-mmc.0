Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B327423E35E
	for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 11:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778689; cv=none; b=uDe2XQSTKEnO5PiOaJ9hsBLNJaJjl2v0YpkmFImtV/Cgi0lsIcesuSiOr2crGCEmsEIGZHaZYFrTZJiv2i9crbzeNuRnmrYQPW1pK9lsoGA7gdFvJQQokK+vfj6VUjkTtChkZbGBHrWHOIO8/5lzNTmazminzfUMBom3b4bu3Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778689; c=relaxed/simple;
	bh=4EpxEebGIkt3dAiSuwAToYX46B3BUWSP1+VgcCtKnnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f4kKlIlwTmY8vUczdvyshgk490DRkBkWdM/JW5HZprZhVwvcGqKwMvdtcBH7OIo/x/Yo2Bw4pypkrm99QjV2KP4Bha27kTRX1uJFCvHpi2tOgH/zzt7MIqurIrn5LfTGAZyYqaWAB5JyiiVNDMDLtjK6sNnIyH4MyTWj90JxDsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BFkyLh9T; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BFkyLh9T"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6f6ae4846c7so61930987b3.1
        for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 04:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741778686; x=1742383486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pX5wJ8TyZ2fG65EaJ0p2X3/WBmqmZSZJ8JhlaRGbckc=;
        b=BFkyLh9Tnu3hhyZ2K9VMGNXlD4MlqJn/csQ9jbrQLW4NM7iep69EZJXvIdtiIdTumi
         MHNZPx6nB1kmqOIg3/kA6Fi7TzhVU1diHImmLkzAdVv0k/1P9CnqRP49z0XAYM8ryG4c
         TRZ3DBQdKyq5xsITyG01VJzzhxj9QZfvNiYseMlgLBHiQIvUKzDzUCjDYpRPI71tkiQH
         g9nk/YMCVRsYncJYFDq0boWnYEKX31D8moMNPN7S5Fx0RtHAEQqtJo13GME2IyhchmIB
         7PmyIW7MyTtW2CFtnGbjds9ZJ8IcSVk+QTwx/9VTbBo769V5YsznBdli4JBXpIN7tHHX
         o4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741778686; x=1742383486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pX5wJ8TyZ2fG65EaJ0p2X3/WBmqmZSZJ8JhlaRGbckc=;
        b=wIB1mMRLTvtHtmZf8NjsyQAgfvDh5ONnsng0vL2usa5IhAlTvSSTtyAAGQAwUJ7fYf
         owDFJb+XcURzjnRBFpO9hT4FOAZw7Ah5f1O7gMSAvJjJqzKuiALmzL7kk1zDfx2bsBb9
         mlNMjLLEd1RdoEk90pUq4ZnBmSxsNvz7kXREciWEZN20aGCNa7AI5nC2RIoRbPPvi/xt
         JDq9HsLj3lMTu6n8WoqHeA6RGu3c9AZvJGd7XXhoF9svnqM8dQo8iLl5B2tnkvPDeTkm
         mmc2gh60DI+QADVhpaM7AsscFiwm3B83r8MlTfKjeUpOffyiwzNtRTvKIneQpw2ozMD0
         4VnA==
X-Forwarded-Encrypted: i=1; AJvYcCW/ExY1YDYk319Mt8b4mjIU0tvjUSIHsSlZaTx9CkulPM6j/l0Po9xiINVQZdVJV+4Dan/Cpa6NAlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzfZx5CgWJ5tjLaBf/5ajJTf6mdhNSbRvovMdUH+jRr210l7jf
	t/vlUnS60TXRFUfC/OlqvgWfvjtI7AfqxXv58TmgY3ljE2HyQBrEXWmvgYGlKXyd06tbESGohkk
	JZ6EXh4E4233MNDlYDbQgSYGZYmCys9T5jjK5cQ==
X-Gm-Gg: ASbGncstuzE7gMd74ah3R3YBnRdVv5u2vFz26lEXDXRojA6NiKG+wuOmUf0RMlT/NMo
	eFnCIvSVywHfkbSmkBS9X6eiA1VbnYrpzdJEsfyr6PWKx4CWLZPddIQR6qeQdkkzyHY2Oiy7aLi
	0DXM9t09wzhTajI/IOcF44PimLlU4=
X-Google-Smtp-Source: AGHT+IGa751co3k+vT0NXf9S0eyV3ShUgfWoqwyOTLQRhI+9cXC1YTsVfxQ9jumBZHE5Pn1Y+xOWTCo1PaAoLOqWsZo=
X-Received: by 2002:a05:690c:6807:b0:6f9:7a38:af5b with SMTP id
 00721157ae682-6ff091d65b1mr102683967b3.13.1741778686722; Wed, 12 Mar 2025
 04:24:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211214645.469279-1-erick.shepherd@ni.com>
In-Reply-To: <20250211214645.469279-1-erick.shepherd@ni.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 12 Mar 2025 12:24:11 +0100
X-Gm-Features: AQ5f1Jq66gEA7DTuXkbofTVBV9ezt_vJXjkBBtGDg8COreMzjqaB68U2MzPDqCM
Message-ID: <CAPDyKForSFLar9i+XJzp35ACTfBsASfnzwp4hYcYamVoRbc3Lw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Disable SD card clock before changing parameters
To: Erick Shepherd <erick.shepherd@ni.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	adrian.hunter@intel.com, gratian.crisan@emerson.com, 
	Kyle Roeschley <kyle.roeschley@ni.com>, Brad Mouring <brad.mouring@ni.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Feb 2025 at 22:47, Erick Shepherd <erick.shepherd@ni.com> wrote:
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

Applied for next, thanks!

Kind regards
Uffe


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
>
