Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B913E158538
	for <linux-mmc@vger.kernel.org>; Mon, 12 Jan 2026 02:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768184371; cv=none; b=mjt3wY7eqRA/Q7T9uR0ncqEcBY5O1e6y9UxKPS4cRdBcMuXiMyIXRR/To/kHW7DsDwXM/GTy3aZbahLFbq5YDJPLbzwYkmysQaXXsdHdNS/7ajEfpc3tW9bclqAuyjaeR/i53/cx6zEzfeURA7kTb5sIU378TO8ItYfdb4nZOgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768184371; c=relaxed/simple;
	bh=LIDGLkK6lEnNHIkqOZXsxXCxMXJeAEB3JVRy+CUiN0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PNcg33P9EfOPFF+6W6feWct7A72QDAaG0Hzb7DEY5DGlzfNCEdE3iEipr/ZVuLOo9cFmjAndyJKHmdSf3MHWlHrQ+KJM0JPCeC6W27xYeco3Qtun2jabuCVtSLT1nIVUZKl698Di5b99UFhmTy+ee53bv+UZGnEeD0pfmbdXIjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZzyqAv7; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZzyqAv7"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so974132166b.2
        for <linux-mmc@vger.kernel.org>; Sun, 11 Jan 2026 18:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768184367; x=1768789167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9CqPVmy6Ha693TlqqNOvrdHx9uT6DiCM4/UcIA3Wsg=;
        b=CZzyqAv7JfNfDerUAGbb3wrc5YaR1oqrfNdlpziOSLEV7U3wKONzIRXz12uKXeDhLx
         F3DAWtLHgN5WSDMPMXITVXITukX8KccBWN7sOGVqKs3KbtZYBXf6KyN0q3SparXO8M3U
         hjgoqf7bYbIyrC7mD7G4J1XJQ45iapFhW2+oCgfikzNvNnnezezEgah2oDiVvnf9XOSn
         BckRlC1/FoFtcuOoC7pf3AjjXSMbrGXbbzeK7TgsCnx6IEmO7SwjxFQ4ulUNLPyAFVul
         GGmX1ehBqSlQLaHXjucmlspHMCjsUCk/CtWCpdTLCQ0VerqlcGUvpqiFFydgnkBlVOeu
         0UpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768184367; x=1768789167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y9CqPVmy6Ha693TlqqNOvrdHx9uT6DiCM4/UcIA3Wsg=;
        b=Z/ITVtNvF4RgDWa6ePcLVFSaDj63xbe/rwBc49sispzzJyI42sXZzALcbUQUkU3BAi
         tAJnbs8QuTNYTWGNJEwWBn0d3Mhdjci47FT+1O/lkhka80Pp0HffPeiEXiPHqgO7ndZ0
         /Kl/Pd55Mhjx5epeilFTg5iwT1sua/HZ/o46JHzyAwq8pcfeFrgX2Yw+E5e3/QrMT0Vy
         hZrkR1PdKtuADrRngAsOa33BS59kiQ5xrG8snXyBWZ0SxV3DaKdAt3JrRfUqJmTIx/IH
         O1NXbbhYArl9OMljJ7hU6P5cBwIoGoPjl97nuubiLU8K3zahOG5qAKrbFRavJ09oVkrR
         IyyA==
X-Forwarded-Encrypted: i=1; AJvYcCWeTr943FX0UEYN9y2yvaNkGgqzbTLA9ZQ04RkWqwFv2+DdEVlStVLPJqVvRhV9+89GIHA2QjA1D0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy6ERbzJKeLGUr5hCLDz+LnYvvSdiI3D+5VNbiU+sWf+uq2lFt
	uL9DdcibMazopqpMZY5B5zsXVtIM/QDHXARMZ4X9Q311NN55nkuiqli6VOktLDNo0yfmB1A3Kwe
	JrD84rOBpJ6uOwkMDmSjmJ0riLd4Ai0M=
X-Gm-Gg: AY/fxX4AXevO2aoiMjYYTUevgvshICVwF5GeX4f/9T1qzlGLgw7yNiy8bc36RQzckwC
	mXPx+56vDxEq6xkelkG54Tpx0NmDytlH/HPAktnvGBNhucKaEgz6sClx+x88GihRF0YURqhEjZz
	3ye9r8U/xw+U8T/p7jA1fvjC6ZiuSpUyyR6KPITXxq7nUENCw/N9IPPk4ir6tM1/QlYqJ2c0rk8
	baxf6eNfjRer9QD6MmBQDMZUsiHTsuUY6bco+ThzNaws8NkPaL5hWX4j9GZiZ9CPj6SCh4=
X-Google-Smtp-Source: AGHT+IHmORAEgQ32ky+5zNyQndAMCM5ZXl9uM2UzyA2fv3laEONieJPXSJhojc8yHVlsUEJsAR+UXQ0vjeoUBC+pjN0=
X-Received: by 2002:a17:906:7954:b0:b87:2579:b6cf with SMTP id
 a640c23a62f3a-b872579ba1bmr48157466b.41.1768184366965; Sun, 11 Jan 2026
 18:19:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110-mmc-pwrseq-v1-1-73de9d6456f4@valla.it>
In-Reply-To: <20260110-mmc-pwrseq-v1-1-73de9d6456f4@valla.it>
From: Sarav K <sarav.devel@gmail.com>
Date: Sun, 11 Jan 2026 18:19:16 -0800
X-Gm-Features: AZwV_QgSEfcWyHC1hg1pQP0Ytmz0hobumz-hHhgTKwyXnFZkK-y0xSGUiX4IamY
Message-ID: <CACRMN=d8YX1LG4NSPnNXGnU2u-Ej7wsTom_DpVrD4T_byRE2CQ@mail.gmail.com>
Subject: Re: [PATCH] of: property: fw_devlink: Add support for "mmc-pwrseq"
To: Francesco Valla <francesco@valla.it>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2026 at 7:28=E2=80=AFAM Francesco Valla <francesco@valla.it=
> wrote:
>
> Add support for parsing MMC power sequencing (pwrseq) binding so that
> fw_devlink can enforce the dependency.
>
> Signed-off-by: Francesco Valla <francesco@valla.it>
> ---
> Resending this patch as it slipped through the cracks (of my attention,
> at least).
>
> Original submission is at [0]; there it appears as a v2 because it was
> the first time I used b4. It was also part of [1], which wasn't really
> a patchset but a follow-up to the boot time SIG meeting.
>
> I added Ulf and CC'd the mmc list, hoping they can (more
> authoritatively than me) reply to Saravan's question:
>
> """
> I took a quick look at the documentation. It's not clear to me that
> mmc-pwrseq always points to a supplier. Can someone with more
> experience on this confirm that is what it's supposed to point at?
>
> Meaning if A lists B as pwrseq, is it always the case that B needs to
> be powered on? The binding documentation doesn't say anything about B
> needs to be powered on first. It's just saying A and B have an
> ordering requirement.
>
> If the meaning of the binding is _ALWAYS_ B needs to be powered on
> first, then yes, this patch is correct and I can give a reviewed-by.
> """

Ulf, in case you missed it, this email is directed at you or other MMC folk=
s.

Francesco, can you see who added support for that property and direct
your question specifically to them (in case it's not Ulf)?

Is this fixing a specific issue for you that's pressing? If so, we can
land  this and then see if anyone complains.

Thanks,
Saravana

>
> [0] https://lore.kernel.org/all/20250930-mmc_pwrseq-v2-1-80a8c6be0fb0@val=
la.it/
> [1] https://lore.kernel.org/linux-embedded/20251126-beagleplay-probes-v1-=
0-c833defd4c9b@valla.it/T/
>
> Thank you!
>
> Regards,
> Francesco
> ---
>  drivers/of/property.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 4e3524227720a596b0f12976f83357851e9b94f3..05ae33a58b5aec0a8f4d3b723=
7ce88066d86dc9d 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1410,6 +1410,7 @@ DEFINE_SIMPLE_PROP(post_init_providers, "post-init-=
providers", NULL)
>  DEFINE_SIMPLE_PROP(access_controllers, "access-controllers", "#access-co=
ntroller-cells")
>  DEFINE_SIMPLE_PROP(pses, "pses", "#pse-cells")
>  DEFINE_SIMPLE_PROP(power_supplies, "power-supplies", NULL)
> +DEFINE_SIMPLE_PROP(mmc_pwrseq, "mmc-pwrseq", NULL)
>  DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
>  DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
>
> @@ -1557,6 +1558,7 @@ static const struct supplier_bindings of_supplier_b=
indings[] =3D {
>         { .parse_prop =3D parse_msi_parent, },
>         { .parse_prop =3D parse_pses, },
>         { .parse_prop =3D parse_power_supplies, },
> +       { .parse_prop =3D parse_mmc_pwrseq, },
>         { .parse_prop =3D parse_gpio_compat, },
>         { .parse_prop =3D parse_interrupts, },
>         { .parse_prop =3D parse_interrupt_map, },
>
> ---
> base-commit: b6151c4e60e5f695fac8b5c3e011cfcfd6e27cba
> change-id: 20260110-mmc-pwrseq-e885e677ca2b
>
> Best regards,
> --
> Francesco Valla <francesco@valla.it>
>
