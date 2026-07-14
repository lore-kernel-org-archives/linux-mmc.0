Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC8C46AF18
	for <linux-mmc@vger.kernel.org>; Tue, 14 Jul 2026 13:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035864; cv=none; b=FWQ9bFkTYvPR4asq+aquLjkOJ6/3l8tgMFYqmYry7NcwdVUZIqAFLJ0UWe6/6bqVlFaclUabY7XiM6IchGjd6ONn+4mNNmG7Cs2Lvuw4NzaPbMt1NH6h1iPLgOLlVSoZjLg73DVdaW916XdyAXBkUcO7I4OcL58prqsnwjmA0HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035864; c=relaxed/simple;
	bh=7ltIk942FlcNb7c4P0iS7YuMPIYJUL+J93HcQaMBRJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jhw68BQTOdNKdC7XjVVxtZUtx5iefrQ4HqD7vJkHG0l3FADdPapCgEOun+T6d1ztmYBULfatBCDCz/6QjojoXxovZ2Rf50gNllbTIAHBfDFffqkl7sEagRrlwByPvharD+W/98AfJeYuZY9abr61ozda2KAvbqTX45SV5MNHf/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-69c5f6f7a40so5616685a12.0
        for <linux-mmc@vger.kernel.org>; Tue, 14 Jul 2026 06:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784035861; x=1784640661;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FfpdozjO3owtTfsOTXpWhJUHafNjaGvEr4pDq5DSDJg=;
        b=UloKNoAHGCIrHO89EbwD7V7XbAIQZT3SP96Rft/8GLts+oDmiZuxpqbuEpnTXRsI/+
         QEY0PiVzN1aROpH9x4wqYP6HpGO7CkQzMjzh3oYjKFOuL/88OqL0vHP9hB82Gs5X+TdF
         rTOgZGqVahEGtgie1S5hFGhyJ+Yt1ute07q9udxyNVhPcpnyY64jBmasigyiMmK+TkTq
         1eETje8J0471cSYIUfgw/RJPvyQvo4ITF+ORA3kLyLzPQVA+7YXz9FwKWKQkVIvtC876
         datWCswxnWPEQawHNHc5PTdyFjht5tTGdfnhZJjgnbzvbWMpw5CF2L5MONCKwgYaLld9
         /7qw==
X-Forwarded-Encrypted: i=1; AHgh+RpK8ulIbqmHmmB2ikLk9ZI4GveCVlUP6lylSl+/Q5cE9JthcKWixT8CGQ2osJCPusNpAOmWGN1cztM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMLezZP3huk683Abd02/5faz8Mlk8bFLX1nFZJf6dOijswd2zS
	wW0TetW08T3fNkm4EyXU2cx0IqemWKf3Nijf4ZNZ3a5bH+hdFfZjpvoTmGRDxB3zKL4=
X-Gm-Gg: AfdE7cmiTt86ylir2JdoLK64YEBKJdBV/J93vyNtNV3IseEp0sMMXyPoiRHZlVPkGsl
	anDjLU/knsmfI+IzpzH23mJO6ftBmL2wTudTGx02pSGdzLpw1Zq4m5lMv6wCDacqY+mJvSyEJZ2
	RqsTwPwAQVxUshrADKr67+HyBUq7LMmb//3WS5D2mu0e0SlX7NDkfImLmOolvO7+/vjt5C7UVC3
	BhY98dCfbnVYpSobfARUoKfWMyjzHTeusMWebPrIh+XkzhBdCfj3aTj5Qw42lbrA0BSck/60GRA
	u69cRTWkrHDIERglzBhNRkErtBMG9L6UTutmrFdOioPSMROKM0q3fb6Vj5ohe16mK9JhLFJTJ1B
	3tx3TKXgFe5D8xGg8IcLjqt89ufBG88+1R2sf/JkwjGxS8qx7GRr8sRPYC3yz+MRoBVjzsdWyqY
	WTqnSNPsyVIgNyT/9kBShv9/RBKqgPb42ULKw=
X-Received: by 2002:a05:6402:448b:b0:69a:596f:ba0d with SMTP id 4fb4d7f45d1cf-69c5f254768mr6342264a12.33.1784035861160;
        Tue, 14 Jul 2026 06:31:01 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69cd292452bsm1601944a12.14.2026.07.14.06.30.57
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 06:30:59 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-698aa7ba3e6so7658297a12.1
        for <linux-mmc@vger.kernel.org>; Tue, 14 Jul 2026 06:30:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq+LAkH67HK3tanJsVJ2EI/h8zkDo5Qbih4fVYfKw9ppNEB53CLP2VjegMrnbNVGiPifEZBpt1G2fE=@vger.kernel.org
X-Received: by 2002:a17:907:1ca0:b0:c12:80a6:2df9 with SMTP id
 a640c23a62f3a-c161e9400admr641458666b.8.1784035857577; Tue, 14 Jul 2026
 06:30:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709192916.630794-1-biju.das.jz@bp.renesas.com> <20260709192916.630794-9-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260709192916.630794-9-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 14 Jul 2026 15:30:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW00Z-Kj7nQiZ+W6fuj20grD9GUg93K8dCKH0wWh4U7ng@mail.gmail.com>
X-Gm-Features: AUfX_mx2ffZ10VqYnA4gH8_EiW4TggJsmyvBwCVek-BHgyJ2IKNd_EuJjfrBJ5o
Message-ID: <CAMuHMdW00Z-Kj7nQiZ+W6fuj20grD9GUg93K8dCKH0wWh4U7ng@mail.gmail.com>
Subject: Re: [PATCH v19 08/12] mmc: renesas_sdhi: Add RZ/G3L SDHI support
To: Biju <biju.das.au@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulfh@kernel.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, linux-mmc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Thu, 9 Jul 2026 at 21:29, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> The RZ/G3L SoC (r9a08g046) has an SDHI controller with several
> differences from existing platforms, requiring dedicated handling.
>
> Utilise the TMIO_MMC_HWADJ flag to identify controllers that carry
> a second hardware adjustment register (SDm_SCC_HWADJ2 at offset 0x010).
> When both TMIO_MMC_TUNING_DELAY and TMIO_MMC_HWADJ are set,
> renesas_sdhi_set_hw_adjustment_delay() additionally programs HWADJ2
> with 0x3FFF at 3.3 V and 0xFF at 1.8 V. A new RZG3L_SDHI_SCC_HWADJ4
> register (offset 0x022) is also cleared at the start of tuning when
> TMIO_MMC_INTERNAL_DIVIDER is set.
>
> Add a new version constant SDHI_VER_RZ_G3L_SDMMC (0xce10) and extend
> renesas_sdhi_sdbuf_width() to handle it alongside the existing Gen3
> variants.
>
> Introduce of_data_rzg3l with RZ/G3L-specific parameters: a wider
> clk_mask of 0x200000200, a max_divider of 2048 (reflecting the 11-bit
> divider), a dedicated rzg3l_scc_taps table, and all relevant tmio_flags,
> including TMIO_MMC_INTERNAL_DIVIDER and TMIO_MMC_HWADJ. Wire it to a
> new of_rzg3l_compatible entry using sdhi_quirks_rzg3l (which sets
> fixed_addr_mode), and register the "renesas,sdhi-r9a08g046" compatible
> string in the OF match table.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v18->v19:
>  * Update commit description.
>  * Updated handling for clk divider.
>  * Renamed TMIO_MMC_HWADJ2->TMIO_MMC_HWADJ to make it generic for
>    hardware tuning delays
>  * Dropped duplicate SH_MOBILE_SDHI_SCC_TMPPORT2 macro

Thanks for the update!

> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c

> @@ -234,7 +236,14 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
>         }
>
>         clock = clk & CLK_CTL_DIV_MASK;
> -       if (clock != CLK_CTL_DIV_MASK)
> +       if (host->pdata->max_divider != SDHI_MAX_DIVIDER_DEFAULT) {
> +               u64 tmp;
> +
> +               tmp = FIELD_GET(GENMASK(9, 8), clk);
> +               clock |= FIELD_PREP(GENMASK(17, 16), tmp);

This fails to build on RZ/Five, due to missing #include <linux/bitfield.h>.

Oh, fixed in v20...

> +       }
> +
> +       if ((clock & CLK_CTL_DIV_MASK) != CLK_CTL_DIV_MASK)
>                 host->mmc->actual_clock /= (1 << (ffs(clock) + 1));
>
>         sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clock);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
