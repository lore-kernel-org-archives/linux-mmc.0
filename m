Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711262356C7
	for <linux-mmc@vger.kernel.org>; Mon, 17 Mar 2025 10:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208713; cv=none; b=BrxDLfCe+yQs8vxdzvz/c5aIMnNqN7AFohdLRgu/QnqtkxZvNSlNqNMNa9TcbVxLkTADRq1XddVZEDsnjD0ZWjNoLN8IM3hE/5treAz8xxvb59CZIbStrczG5XZ0aJAWaM2qr7D6zvRp/S9qTxPpj0XpIPqOPGwrruXoV9zfmuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208713; c=relaxed/simple;
	bh=SSJphfXCG2zCHPK6zCaKsC/SKYxjclRr36SEoRuzCYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OQ0oNwyZgYh1+aDP4IJkR5S//c8yUGOM99mYomZt0viHrHaV71/ZqvxG0OjhmbRuEBHFN340snyfoSwB0whb2ShDlUbLr6X8xu5cR02iJayF0kkEnqH9DVc4SUWSAUM+rZcdx2JjKyeztpyQgEADh+THAEKv3DgN0/TGS9n5OIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UzjFmyQN; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UzjFmyQN"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6ff1e375a47so36247957b3.1
        for <linux-mmc@vger.kernel.org>; Mon, 17 Mar 2025 03:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742208710; x=1742813510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yzwXCamUoTIUofZgcVBDy5XB48d1gyjHMwR9usrTvc=;
        b=UzjFmyQNl8zWD2AFanI+KJNP+74g6g45uUuY4j9T+ddntv3g65ypV2RizBC9GwBMyT
         CE8Jko3KpcGB/MtVucLma1lHCEOI25m+KoXYz+TwIDUxjzdzZT9VlhlICnCAECYUTEVX
         JbhXy9oxr20DoEpkHKXeB9o+5wWFQdHqC4cFry8GRsc/nGQ/yQodcTpTeMitU3Bknpmr
         e/QbCS+Kwemj+5ZapkSAAXQZoVvWSmvaR9lYTZZT7+vmY+NbtXXw9hwq45A0p/otbdvX
         euYMzQ84w0gITmXBbGGiy3wXopEOacIlfTVXeHClClpVmz7nE5/G2i8ual4gMRpQI/d8
         ShMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742208710; x=1742813510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+yzwXCamUoTIUofZgcVBDy5XB48d1gyjHMwR9usrTvc=;
        b=DEX0N+372xZ9dc3rFVpNfZ6EZUrvvW/5iBPo9GP006T6cOxCs2goXN65nZZ/fpBpMY
         kOkvEu0p2FD3CAJTynWmNGbCJbgzM3sHK/lr91OMJpQ6zaSgVZpFi3GAOagW2rVLS4Up
         G/j/mdVKt/I4kXhsjdkRemOn9QYBxmaza/Uz2gIaW6Hym7l9A0THYlUmyPoOcWmqJhfe
         +JmWszW/zF2mFLW6xL4gbJGOsrWAluK2VNbCUHPO1u8FzeVPG70cC0lEbFMoa8P5ke7f
         wqT9DwvG2x//L6gMwhLAnu2kI5pMgy5P6MWLEZwUrK+tRuKm68NMEaxBnOYEHas2DFdY
         ghWA==
X-Forwarded-Encrypted: i=1; AJvYcCVIH3CaxE1vwTcMhFkTTRCy3uVLsybaKved1bYuhFnylRLwGLOyRAAJwB3yS+D4dgXY4Id1qLgOquU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7ZG2UTa3S5WclRjHu8WOyvxtq/USy/p7M6T/GItcdZlFfccZ4
	4kX9Vhu13hAzwUGxTjMcLL+H4UBa9EEkRWyfZv1BrCriIaoC5vNYWPWXa+yAA0lG+KuALh0zsFL
	1QWij9bOixblklHg4s4wJbbLJYg+9FczGdS7koQ==
X-Gm-Gg: ASbGnctdEJHCtmI2/SkTzC8NFrDUdg6gP20trWYPzjIaeR2nZqc2mLHu7bDavsMn3fc
	p9MkE5DtajpIP7BbylFq4xiV9uOOPCLg50a2WN4puPwv/O6dMPeVw3tGn89xzkxJDIj9ydKvxwi
	tU7pmLq70T8hRdwzB6+DKXEDTAoMs=
X-Google-Smtp-Source: AGHT+IHrpsNOZG0XVeApLlEX5Asu2hMQi9J2yKqum00y7qSmPZ38e0cxpvS/V3TQKrtP/AMHKZMhNpxTHaPPWWrkxLA=
X-Received: by 2002:a05:690c:61c4:b0:6fb:9bbf:d53b with SMTP id
 00721157ae682-6ff460db0c7mr152934337b3.36.1742208710230; Mon, 17 Mar 2025
 03:51:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310140707.23459-1-balejk@matfyz.cz>
In-Reply-To: <20250310140707.23459-1-balejk@matfyz.cz>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 17 Mar 2025 11:51:14 +0100
X-Gm-Features: AQ5f1JpZXdl7aZ24okiADw3I1eeMD-rDqu62KRWTaTVzBq0hjnVagCd7gLvyRJ8
Message-ID: <CAPDyKFp+dZUuif4b0rH9G8NkksgQrVDeHWzWfeRz2TY_9j_gyA@mail.gmail.com>
Subject: Re: [RFC PATCH] mmc: sdhci-pxav3: set NEED_RSP_BUSY capability
To: Karel Balej <balejk@matfyz.cz>
Cc: Adrian Hunter <adrian.hunter@intel.com>, 
	"open list:SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI...), linux-kernel@vger.kernel.org (open list)" <linux-mmc@vger.kernel.org>, phone-devel@vger.kernel.org, 
	~postmarketos/upstreaming@lists.sr.ht, 
	=?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Mar 2025 at 15:11, Karel Balej <balejk@matfyz.cz> wrote:
>
> Set the MMC_CAP_NEED_RSP_BUSY capability for the sdhci-pxav3 host to
> prevent conversion of R1B responses to R1. Without this, the eMMC card
> in the samsung,coreprimevelte smartphone using the Marvell PXA1908 SoC
> with this mmc host doesn't probe with the ETIMEDOUT error originating in
> __mmc_poll_for_busy.
>
> Note that the other issues reported for this phone and host, namely
> floods of "Tuning failed, falling back to fixed sampling clock" dmesg
> messages for the eMMC and unstable SDIO are not mitigated by this
> change.
>
> Link: https://lore.kernel.org/r/20200310153340.5593-1-ulf.hansson@linaro.=
org/
> Link: https://lore.kernel.org/r/D7204PWIGQGI.1FRFQPPIEE2P9@matfyz.cz/
> Link: https://lore.kernel.org/r/20250115-pxa1908-lkml-v14-0-847d24f3665a@=
skole.hr/
> Cc: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>
> Cc: stable@vger.kernel.org
> Signed-off-by: Karel Balej <balejk@matfyz.cz>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pxav3.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav=
3.c
> index 990723a008ae..3fb56face3d8 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -399,6 +399,7 @@ static int sdhci_pxav3_probe(struct platform_device *=
pdev)
>         if (!IS_ERR(pxa->clk_core))
>                 clk_prepare_enable(pxa->clk_core);
>
> +       host->mmc->caps |=3D MMC_CAP_NEED_RSP_BUSY;
>         /* enable 1/8V DDR capable */
>         host->mmc->caps |=3D MMC_CAP_1_8V_DDR;
>
> --
> 2.48.1
>
