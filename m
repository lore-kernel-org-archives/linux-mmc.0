Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0E245BD7C
	for <linux-mmc@vger.kernel.org>; Mon, 18 May 2026 13:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109817; cv=none; b=mEIrWWbitbGInnEhg4TSk/VxzbS7MnIv0uLTSixOmWdxgO4dd4Bt7GQG8kYlcyIvJxAawkdXoyzGBzphzH2cmSXPZBVSrreaqP2c5NE3pkw2uchX9YxlHUB+NjGHVMuht7ACg/ds0dPKK65juCHwrYY3R7vrFX/GxJxuInclOVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109817; c=relaxed/simple;
	bh=G7+udxGdMzW311PV93iVyWCQ/w9rFtkOUgJWnF/y29o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pkYBByMy343Of7IIzI6B8Ja2qygSvgyHiL2f5vs7H2jJaAUVLvTMtVlxfhf9gfssVjwz99lwnz+3UTJ9loR1zAqSAQGF8vjXUaJA5408X/VmNKbUdJkQAkAxo0seZS21Whv2FEE2RfeJGPx3sUYJYjyGScddQrwsaHGXo2v0MNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-575602688deso701158e0c.1
        for <linux-mmc@vger.kernel.org>; Mon, 18 May 2026 06:10:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779109815; x=1779714615;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHrpzbVHUORDOZVtpFM2vQlzLjhthGfdMakUGRCP+CQ=;
        b=BGCz8dImcLgLy48D6rFw7AHmuawhr2+U6rUH30gt55MXKw0L2GuAsvvVj2lSiKudam
         gfYRGF3Tla9zsREwzsUpk1ndNaTj5zDHN70YJCOag069CNhJDoMukLYDxzWwk0evK4vd
         9O4Oa1arVfd2y7mNwBe+3RPpzdQGvTl1nhDQry/IRVmmUsuRQM7MA1Bq8RG6f61vaEew
         +/qo2P/wJl1FRFPKi0dkIf3RatBUgCPDHfti0xdmecUS6OGhzsQQdlVZVHXmBYsNlLUU
         Z7DNdBOFWS3Ute/gj6zhESsuU/NOGBYCDi9HnDT+/W/zOIgu3GljjGQHSxDK13WDAzrX
         IA1g==
X-Forwarded-Encrypted: i=1; AFNElJ/bpa8bvXC15U3+U6aCB8YwhTKKm6TTa/TTKWSq6DKsnhE2uQwxHKgKXn48oLBglLHK7hlMOO7UiK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YynGRHhdijVZCCSV/zguxjpJiKYgAje5Mam923QbnMWGkpLkum2
	/bja6O2NVOEdEjvEvn9Fp6KeqWcjGPVaOAWqgLGG6FiCXGnQePJi2UyR4gms0MMs
X-Gm-Gg: Acq92OGpmMM7Bb50PDY/3btuELIshnvMmd9uQTrV8CqDRMbOVttN5HWQs/mZiDDJD0A
	xwEvahxy3q3k+AM9jdF/WYo0aVp3WjStOQzJ5k8nspCdEW02ZgnsvqsQlb5WyA7NPqF5NrD7ZW1
	WB5KfYynGYHaTf38ZMoTyB791WNYDJtpnATb2Hs+2yGfDx499B7GgWgEN2ncsCC442xKusFo6bX
	JFznShSk8+o2yYYtzq/seMX/wQCO03Sn9VOzUq+V5c5lNrO4P3G3drDAz6fxLgMzyFz4LWUhhdI
	XgxI8w32tyQc7EPtzjnrJz9dGMwedbooF/dFPzoMmw4FzvUYffOoNDTDbImspQPbu6dDzhPfU7j
	vs4XVua6iEkKOdd7oqb05NsB9jlmj1p8g7FNaU1M8tOPkUcWaFLYndjKvLv3itFdN07KMAoDVhg
	JxJHvayRz+HZPhxSK7vcyCA2F7G//wpqwxL13kobuQ/8z9Sush2NjHUZ2fiZ6IYjvP1aEnqAeyj
	4E=
X-Received: by 2002:a05:6123:128:b0:56e:ded3:98eb with SMTP id 71dfb90a1353d-5760bff04ecmr6990229e0c.6.1779109815099;
        Mon, 18 May 2026 06:10:15 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95fc2c9a215sm4630097241.3.2026.05.18.06.10.13
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 06:10:13 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5752b279662so694314e0c.2
        for <linux-mmc@vger.kernel.org>; Mon, 18 May 2026 06:10:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/JoHuiEd4SepDCHRErvqyd0yVJEPxLKvIo0Wa+FUvw87Rgp4+AhSJd+gckTgEOwrGc66wsKlyxY7M=@vger.kernel.org
X-Received: by 2002:a05:6123:2e2:b0:570:f670:587d with SMTP id
 71dfb90a1353d-5760c1db187mr6653637e0c.12.1779109813267; Mon, 18 May 2026
 06:10:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514212024.1624517-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260514212024.1624517-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260514212024.1624517-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 18 May 2026 15:10:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWGiJ_SQag2ZdYsz-rgiUp1X7OuA=9BwzdCp2MvKt4NGQ@mail.gmail.com>
X-Gm-Features: AVHnY4L_CmKmFv6NTtb7Ex2zBx473PgByWg0FHBUS3H5Q5GXZk_wFPvmtDeeWDM
Message-ID: <CAMuHMdWGiJ_SQag2ZdYsz-rgiUp1X7OuA=9BwzdCp2MvKt4NGQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] mmc: renesas_sdhi: Add SDHI quirk for RZ/G2E
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulfh@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, linux-mmc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Prabhakar,

On Thu, 14 May 2026 at 23:20, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The RZ/G2E (R8A774C0) is identical to R-Car E3 (R8A77990), so apply
> the same sdhi_quirks_r8a77965 quirk across all revisions, as is already
> done for R-Car E3.
>
> Fixes: ca804a5615a7 ("mmc: renesas_sdhi_internal_dmac: Whitelist r8a774c0")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -225,6 +225,7 @@ static const struct renesas_sdhi_quirks sdhi_quirks_rzg2l = {
>  static const struct soc_device_attribute sdhi_quirks_match[]  = {

This array is meant for quirks, i.e. to address issues on specific
SoC variants that cannot just be identified by the compatible value.

>         { .soc_id = "r8a774a1", .revision = "ES1.[012]", .data = &sdhi_quirks_4tap_nohs400 },
>         { .soc_id = "r8a774b1", .data = &sdhi_quirks_r8a77965 },
> +       { .soc_id = "r8a774c0", .data = &sdhi_quirks_r8a77990 },

Hence I think the RZ/G2E entry should be added to
renesas_sdhi_internal_dmac_of_match[] instead, referring to
of_r8a77990_compatible.

>         { .soc_id = "r8a774e1", .data = &sdhi_quirks_bad_taps2367 },
>         { .soc_id = "r8a7795", .revision = "ES2.0", .data = &sdhi_quirks_4tap },
>         { .soc_id = "r8a7796", .revision = "ES1.0", .data = &sdhi_quirks_4tap_nohs400_one_rx },

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
