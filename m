Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237D7258EC6
	for <linux-mmc@vger.kernel.org>; Mon, 18 Aug 2025 10:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514509; cv=none; b=G8sVw0V4iPkaN3+cu8P4ngqZXVuzJ0NSqYK7p4uXOhNowOhRDcwTpb52oleYGX+7affz/SFA2JcOgX2bGqghThOA1Su0ErB4lIX6P1C6jtQDx5LZYBYyUHHuC7jorSuT+JUb/lkuK+Vk9liAY7ORHMp0sZzsLrAHbRueqY2cx6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514509; c=relaxed/simple;
	bh=vKDK/kYGYGr3RNTrZOVtB8efO78WdGaAxvqLdCCFNkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bPCWp+69UHPhz6rPZm4MAZ3KlhLtFXr6OAuaS3iQoxHbqZ9osGVf3w5C7bEjGhtF8q9aPNdyjpkTM/Z2bsXVh6A9Tl5WoNQjF7ESxGFgfGLInf49ZAp8HItxr9KfdJVQciYeQWelnF11RaOk6rRNUaB6mCAS8wyFKb2knxjg2hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fvGv6hWK; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fvGv6hWK"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71d603cebd9so42878387b3.1
        for <linux-mmc@vger.kernel.org>; Mon, 18 Aug 2025 03:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755514507; x=1756119307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZJY1gsF1lWmEDHABfwXMbA6h49KOw8eSN77E9oJk8Y=;
        b=fvGv6hWKZ0XiMmKz7NBH6ioHgg9wc9PcAHW8YLpD17Pnszqxj75036BT2lNJ22WSvD
         qzAyE02ye5lnH3MpWuw2WPTnv4+9xL/wtd4vYb8JTXPWgoNwoiwDOsdrcqmuauP7VLCT
         ZjfI6aVhxm+zRrwgRcyzlDM69Ugqg8ubkWLVtMXKpcqIeByor9anKxayJASZUnZBmFat
         wtgD7XKtphwXeL9k7szM51MWyV8cIN06QW37G96dXrW6TO0qaqsAV4ohe3v5ospDK9Eb
         jShBkaciStQ5IYFf/R8LxiXpDNkxJ0+ccWCZCEfxa1zi4bcqifpFyAYlKok/v8ncBqXz
         DLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755514507; x=1756119307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZJY1gsF1lWmEDHABfwXMbA6h49KOw8eSN77E9oJk8Y=;
        b=klevs//zfUnfUgtNZ5khH5Ls3HXj7pV+LMVbcXAKRkqWPDhe+HFYbVaJ/jYV4TfRgc
         ZDBfuk6IqkQleJxxPPJrd7739OBQNBCHR2wAHoAFDFKXSIyYD7za2S3NePhfeguQ+09Q
         U0Iwb5y49w0a9Exe/ql8Zq1L0m9kXFk1ofxt9p6DTssIvuAh2Iv4OZG3Vdpun1oTR/mQ
         myE2DQ73/LEa2QejkQaTNHB7SNKgGdG4QAHU51Eaf3CveMrBgw+JwODDvlUqP+E/8VZh
         URz19A0fJ4fGI9tIQtHewuv+5za67ZO+by0IFaCyas//6+/U0SVTzDOcEcnRmXzULiUz
         Kxyg==
X-Forwarded-Encrypted: i=1; AJvYcCV7+CpuP9ZuvNhyQBo205VyPFrWOkwVMB6KS060Tbb9Llp40MftsElYfrvI2uKCSgPoaSy9vT9zj2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcKtuoBNduedX33y84ht2aNPrk5vbhX11z1ql8ofyoq8Gvqd4E
	Lhe+NnpoLjDC0yHnJOm5IlH+vDhaOUyQt3p5PeFAvrd0SrXniXlvQ0X/7WxCE5PfgqWJx6lOsXX
	vw4J5MvmjnwPLUbnNY48JTG8TM9yhXaoELuNhYIUBHXmwVjwnONio
X-Gm-Gg: ASbGnct2mezgqzI+N6O/Cpr9seVEQEVcd96dWHhS9FuAod9uah8Izl6rJ574LcaldE4
	1eJZYMN+vXUMAQlnuKj02IoN2P0CjzkLHCDkAin8VS6kF8ys/ZT0J+eCX0k0awNWMcp+pNvFqQ4
	7ziiMdojB6mA3LSBszFPUl7wg88zFoMhKEJQjzI7uSvh/XyMLNPmAVLrBaF5IH58r9emxjs9YUn
	eBSqvzNuGagSJ58GB4=
X-Google-Smtp-Source: AGHT+IE+mHNvMRJ77rqIA60/oTCoGLQVxT3XrHizX3j02VMu9a/GMJErQeXbYxChNDQVnwbnKryLXNBZT9D6RggJe7Y=
X-Received: by 2002:a05:690c:4c0b:b0:71a:154:f2aa with SMTP id
 00721157ae682-71e6ddb1126mr120053737b3.11.1755514506632; Mon, 18 Aug 2025
 03:55:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7b124fe1-4f7b-4218-b564-e16ad2c3882f@intel.com> <20250724185354.815888-1-erick.shepherd@ni.com>
In-Reply-To: <20250724185354.815888-1-erick.shepherd@ni.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 18 Aug 2025 12:54:30 +0200
X-Gm-Features: Ac12FXxG-p66A79sRwFlMCXjIzKTCitp1sNv6f6375C2O9l8KBFwRdXaD8n6E2U
Message-ID: <CAPDyKFq=5sc2kCv2EH7KH8RCpOq3JCgVD3dete-k+c-ZmjUL=g@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Disable SD card clock before changing parameters
To: Erick Shepherd <erick.shepherd@ni.com>
Cc: adrian.hunter@intel.com, brad.mouring@ni.com, kyle.roeschley@ni.com, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Jul 2025 at 20:54, Erick Shepherd <erick.shepherd@ni.com> wrote:
>
> Per the SD Host Controller Simplified Specification v4.20 =C2=A73.2.3, ch=
ange
> the SD card clock parameters only after first disabling the external card
> clock. Doing this fixes a spurious clock pulse on Baytrail and Apollo Lak=
e
> SD controllers which otherwise breaks voltage switching with a specific
> Swissbit SD card. This change is limited to Intel host controllers to
> avoid an issue reported on ARM64 devices.
>
> Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>
> Signed-off-by: Brad Mouring <brad.mouring@ni.com>
> Signed-off-by: Erick Shepherd <erick.shepherd@ni.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-core.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-p=
ci-core.c
> index b0b1d403f352..7ef821d16d39 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -689,8 +689,19 @@ static int intel_start_signal_voltage_switch(struct =
mmc_host *mmc,
>         return 0;
>  }
>
> +static void sdhci_intel_set_clock(struct sdhci_host *host, unsigned int =
clock)
> +{
> +       u16 clk =3D sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +
> +       /* Stop card clock separately to avoid glitches on clock line */
> +       if (clk & SDHCI_CLOCK_CARD_EN)
> +               sdhci_writew(host, clk & ~SDHCI_CLOCK_CARD_EN, SDHCI_CLOC=
K_CONTROL);
> +
> +       sdhci_set_clock(host, clock);
> +}
> +
>  static const struct sdhci_ops sdhci_intel_byt_ops =3D {
> -       .set_clock              =3D sdhci_set_clock,
> +       .set_clock              =3D sdhci_intel_set_clock,
>         .set_power              =3D sdhci_intel_set_power,
>         .enable_dma             =3D sdhci_pci_enable_dma,
>         .set_bus_width          =3D sdhci_set_bus_width,
> @@ -700,7 +711,7 @@ static const struct sdhci_ops sdhci_intel_byt_ops =3D=
 {
>  };
>
>  static const struct sdhci_ops sdhci_intel_glk_ops =3D {
> -       .set_clock              =3D sdhci_set_clock,
> +       .set_clock              =3D sdhci_intel_set_clock,
>         .set_power              =3D sdhci_intel_set_power,
>         .enable_dma             =3D sdhci_pci_enable_dma,
>         .set_bus_width          =3D sdhci_set_bus_width,
> --
> 2.43.0
>
