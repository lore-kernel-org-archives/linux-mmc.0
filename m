Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912F942FCB4
	for <linux-mmc@vger.kernel.org>; Fri,  7 Aug 2026 13:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786109125; cv=none; b=TrPkfpIJFVvRtn0QLw+T9UvBi3DilK7wijWYB/8oyXdN4P/LycFr9FmBXdewDBfQyRukAHItq+j7bC8/lh9dlS6tTFVNFBjR7giGn8sIy7NYalJ7tYrv0WUxqBuULbuYKV3iT4eZigW+Ew7ooj89/RNqH/i3qlgRlWWj4NZ95As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786109125; c=relaxed/simple;
	bh=a19jPmi+GzVCvFFZOgNfOCBH89do39+pNlklgVN8luE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TtWETPN3ZsOk/FoCuu8K6xinFVByWeRnCe/BKnVcuwu1jhbXZohTwdBztTuF3VErQ1RVdJa1IxGQOLYrwj5MKUFtpEBdhiJ+956mhZS8K5y7D9BFk+mIMJQEEDTjLkUgI0bsxaH9pWcE2oiVWt1y75NMgQnFlMjI9a1EM9C/rAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-9696319e14dso1282370241.3
        for <linux-mmc@vger.kernel.org>; Fri, 07 Aug 2026 06:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786109120; x=1786713920;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=s+oxSUT87w6ZNNbKpTMGnmQcsBsam/5hlyl/VeXKudE=;
        b=tGZrzhgJtj52Foq/Ww5pzq3qxWWz7H5X9pqY3oXDmT4gJ9X6DJZhwJ0crzbIB7oEu5
         Mom/eAhWz7daqeERZkQORM4BKP+xW1X6y6fWZgRreUVz0YFenEWL5Y+wk4NWvTXjoXk4
         A7Uy9BMPrgWZm09ZXRUDSxeFEAdlV8AU11L05xjn4o4KyrKzFOxRCsTRV0saZ4Ge/nmI
         urThWtUnbS+KCoFX8YZHy86erGgHDRe60NR8UzKwRStoWmHvqeaM8x8AWhtK3fdzY9V5
         iiv4dK/SWE8xgp2GpH+kyZ4RPBjuA7XmzQOJ/KDwYAA2Ve1+9ctxezMbUz6XA36/69CU
         33RQ==
X-Forwarded-Encrypted: i=1; AHgh+RrU8K/3yeQAffrKPv+HPQPR3jJatUoWBmK5Gn5xyFdTfaasTBfF9oXn9n0r/9BFz0wK/QN0UOksdxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1YK3EoYeU+HQIG/tfpKOwNLay6FYaQhv90hvNLqFWZxFKZb2L
	NrCPp3MlRRMdNpwHCGYZ5W2PSMAuYdilF8omhBPMCHivsNs3/zELB3Gf+L4bfq9D
X-Gm-Gg: AR+sD12OBQtpvR3z1Zp4y+MmcqD/38ipn1LoMbIJLGypgnBCXrfA1mYbyHtdxEWHc3S
	xOeTH5gTyWdY84yd8hFTd3WL/8Zla36rwEUTB56A0Xf1Qga/a2TEAw+Xyg1AhJP8JTNG5gCllOm
	JmKWbzdfzTtfOzvzvbZys4f8IG0UCwy63GHueQ5kqH5taUv13Ge1qL6aRV+FXuVQUkdYqw3PMPE
	yjg5m70+6n7KYDnDGon8gXMAnqpx5azzY0Vu+c7HCdh9nIZs509iEEYJSOC4q8pUjQ6aeSibMwl
	WsIEdQ9wsvLNj9EHP6eAhhFxfitwX4kLp+ROvqVbL28zrhNL38AA4KIF5r571+8LBj43PZf8qZn
	8gNW1vUPUsahsX0UZWAnfEHUNInm5kjfa9tQ6vD3W5b58wCeo5aUBuSDHheVyhe7tVPVF3E8PWs
	sFwk8wEX5VYAtJEN0t1xUgfjoBjoBwFm1RN4GdWEad6rSRokZFG6XkzwUHdIOL+tQnoqltOLoVl
	fyI5TRaphtsMvbLBwu1wM0pPw==
X-Received: by 2002:a05:6102:5691:b0:738:bce9:6afc with SMTP id ada2fe7eead31-760e3194f65mr5789064137.0.1786109120439;
        Fri, 07 Aug 2026 06:25:20 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-764013f0724sm792599137.10.2026.08.07.06.25.17
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 06:25:18 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-9690c99c917so1186706241.2
        for <linux-mmc@vger.kernel.org>; Fri, 07 Aug 2026 06:25:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rorhwf6XBxIGgYK5UJyTW6XVbYg8Nx5jRCSKpuneUbiOGbdbMv08Yu1qg6Ui0V8sQIrF6ULyqGdMl0=@vger.kernel.org
X-Received: by 2002:a05:6102:4bc6:b0:740:2664:801b with SMTP id
 ada2fe7eead31-760e851e3e5mr5577733137.11.1786109117333; Fri, 07 Aug 2026
 06:25:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730113200.36456-1-biju.das.jz@bp.renesas.com> <20260730113200.36456-14-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260730113200.36456-14-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 7 Aug 2026 15:25:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUkagUkD=HhfstYyazZdv25F6ab-ZM7k9T0=EQtfindvA@mail.gmail.com>
X-Gm-Features: AUfX_mzQPeCDyQ1wyaJV5V4Fa3iFtKPteQt78XLxVMU8eg754UK0SgY97Mc3Jfs
Message-ID: <CAMuHMdUkagUkD=HhfstYyazZdv25F6ab-ZM7k9T0=EQtfindvA@mail.gmail.com>
Subject: Re: [PATCH v23 13/14] mmc: renesas_sdhi: Add RZ/G3L HS400 support
To: Biju <biju.das.au@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulfh@kernel.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, linux-mmc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Thu, 30 Jul 2026 at 13:32, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Add HS400 support for the RZ/G3L SoC.
>
> RZ/G3L needs a second HS400 enable register, SDm_SCC_HS400MODE2
> (offset 0x020), alongside the existing TMPPORT2 path. Add a
> TMIO_MMC_HS400MODE2 flag (bit 16) for controllers that need it.
>
> renesas_sdhi_hs400_complete() now also sets HS400EN2 in HS400MODE2
> when the flag is set, and renesas_sdhi_reset_hs400_mode() clears it
> on exit. Add renesas_sdhi_set_tmpport() to mask off only the lower
> 16 bits (TMPOUT) of TMPPORT2 when writing it, preserving the upper
> bits on controllers with HS400MODE2, instead of the previous
> unconditional zero write.
>
> RZ/G3L HS400 supports only one divider value, so
> renesas_sdhi_set_clock() now forces the clock value to 0 before
> masking when HS400MODE2 is set and the internal divider isn't
> currently enabled, rejecting any other divider. This also completes
> renesas_sdhi_is_internal_divider_enabled() from earlier in the
> series, which now additionally checks that the current timing mode
> is not MMC_TIMING_MMC_HS400 before reporting the internal divider as
> enabled.
>
> Enable TMIO_MMC_HS400MODE2 in of_data_rzg3l to complete RZ/G3L HS400
> support.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v22->v23:
>  * No change.
> v21->v22:
>  * Updated commit description
>  * Added a renesas_sdhi_set_tmpport() helper to set delay values.
>  * Added a check in renesas_sdhi_is_internal_divider_enabled() to
>    return disabled status when in HS400 mode.

Thanks for the update!

> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c

> @@ -355,6 +366,22 @@ static inline void sd_scc_write32(struct tmio_mmc_host *host,
>         writel(val, priv->scc_ctl + (addr << host->bus_shift));
>  }
>
> +static void renesas_sdhi_set_tmpport(struct tmio_mmc_host *host, u32 tmpport)
> +{
> +       struct renesas_sdhi *priv = host_to_priv(host);
> +       u32 val;

u32 val = tmpport;

> +
> +       if (host->pdata->flags & TMIO_MMC_HS400MODE2) {
> +               val = sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2);
> +               val &= ~GENMASK(15, 0); /* TMPOUT MASK */

Add a #define for this magic value?

val |= sd_scc_read32(...) & ...;

> +               val |= tmpport;
> +       } else {
> +               val = tmpport;
> +       }

And then you can drop these...

> +
> +       sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, val);
> +}
> +
>  static void renesas_sdhi_set_hw_adjustment_delay(struct tmio_mmc_host *host)
>  {
>         struct renesas_sdhi *priv = host_to_priv(host);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
