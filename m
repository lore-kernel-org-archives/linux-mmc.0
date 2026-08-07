Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDB547F76A
	for <linux-mmc@vger.kernel.org>; Fri,  7 Aug 2026 13:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108612; cv=none; b=tIMOABEfKfa7XgqT34YdblrZ8dlfalZwwdWnsjw7zkmlWIv88++sr8kXiZ9ZuBJnB11WHiA8NvuAg2NZOAnHlLYjnyUvZyLfAtJ6QHDqgPY8iTVQMl7vusR56VnYy2421TScF/U6Ucug0ZBF2cgP8+FxHC27sxnahhL2cyv5HoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108612; c=relaxed/simple;
	bh=kCe7+ovW97xnpwebauqhnPTjDQ/9rPidEkTfLc/PfTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z97FoMPyabfwoJZCaakp2Tu3Ar7SQR/PKYDBvUHXx/AcuCR3J9wP58CRq2PQzwZ/GK98zAjttI14WEOmGEUTeffIWlu2CWCn9uSfwaQs03U8NyvIoSZ9UbZC32iWiRqoSs7Ia4YPC/m8vh6ldqmXj3M8ZzvJr0E7fILvwGVBpTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5bf95ade656so1159133e0c.1
        for <linux-mmc@vger.kernel.org>; Fri, 07 Aug 2026 06:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786108603; x=1786713403;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CNCX7FMkI+eIPoPw4/O/hZx4FHa2CnaRhnoCRy0wWYI=;
        b=a5pRB30ddNcFlAdle7gnbhODPqgelAODfHFexx6t3mE4fhZiilmZ3PtQDV8sGJOv+3
         3Di4WWnQ5uJHmMxb1AFsH1wd0WebmE3GF5WWJNgy2HD/yFK72cvjq0XkfgsiG2uduk1V
         YWF6vnWD9pjuMAt5g9YtwFTw8m3zG8qs3tc72hKNfcgq74NizS27O44IiTPLqCiwo+Uk
         y8MIO+0xvHoEz352A5gFujyJFssxpdGhUv331fFSaVEueK4kGxj9S+L7spUgiL8Chlx4
         9Od2MowugisDCJyYZbmb8W6GrpZ4/Ejy1aCS0WgPVwfIYC/8oLPajzzkcRp/tu2mXZiy
         wJrw==
X-Forwarded-Encrypted: i=1; AHgh+RrZsLDn7LcYphZ7GSyK54HuLrxx7EgzkftXQhgld+ciDavKvqv+HNMlG95zJE7GclZ/9rvawUE2s4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyYEjxaNT5UqXP8/q37AbWBXfEItk2S/q53DdubXDNBQR2euNb
	KDvSkkOiY79QFYDlWSwAK4Ec0G0eA3o63hey62PR009yTZUnpEEyCDe9BdAzKRb3
X-Gm-Gg: AR+sD11Np1XqfGVkkUqjemPzQoaGVywe20yt3UjThTs9ZapSg5XGzTdZ5IS0ioAMGOt
	GLvKwQjBf3/EeBfKWpndukaMFsTWB4InrRZFAVCI+XGXY+zublbqFeTXro8aRiZnRU4Ven4olcC
	eeEqSPX9BstHspZuzEEa/wZnOBQJtI4dJfKmeUGfPnaceIdflFqodjdMMVCt2BMBQQCyA5CeD6n
	ENwlH2gNtMpriV/DC4VHIOMtocpFVrQXJc8GE9x/OnNdr0p6EteIJMqIflF0i9xz4XdjfrGwr5a
	os3SeekorrkPGiSBqsESMDddeDVs9WKGh/j11ebdAlwwCMKEzugWdWwUJw630aWnAOSdsg6FstZ
	8P19p0DaU8+BWGTBYQdYoPaz9zY/mcT3IEeKs24bWZy7f/kn94Lm/goMgcWj/W7ljcpdyQJsyBW
	Tv4ZMhYpMGfE0FFNmsm3Mn79DGSc99pU/yi4Mg++8g8FplRMEhaDJxqYYvSzKe8ynWoH6YXCdxa
	7ZjmpJpB6zAv0ZB7klK+qTacNjU/g==
X-Received: by 2002:a05:6122:d89:b0:5bd:cb34:1b70 with SMTP id 71dfb90a1353d-5c4092da336mr389808e0c.1.1786108602600;
        Fri, 07 Aug 2026 06:16:42 -0700 (PDT)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-979f2e53b38sm433738241.3.2026.08.07.06.16.40
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 06:16:40 -0700 (PDT)
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5bfaf91daa2so801193e0c.0
        for <linux-mmc@vger.kernel.org>; Fri, 07 Aug 2026 06:16:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrzZBrV2uQouUfTvQAQ2SdNfNxp0QORn9fy03nwn4arnuBYmgMxIPA9X5Sn6JhD90jOvp2zENxqQcg=@vger.kernel.org
X-Received: by 2002:a05:6122:d89:b0:5bd:cb34:1b70 with SMTP id
 71dfb90a1353d-5c4092da336mr389660e0c.1.1786108600257; Fri, 07 Aug 2026
 06:16:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730113200.36456-1-biju.das.jz@bp.renesas.com> <20260730113200.36456-6-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260730113200.36456-6-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 7 Aug 2026 15:16:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXAFX1bji7Q+OAmDRYmQ8Gezxhf2RsrBOV34AXLOBgLPw@mail.gmail.com>
X-Gm-Features: AUfX_my9Sfq3h2qGUbcX_HTTH1M-D8wf0nhKfba41o9CddFp_OLJvLenzCoUQpM
Message-ID: <CAMuHMdXAFX1bji7Q+OAmDRYmQ8Gezxhf2RsrBOV34AXLOBgLPw@mail.gmail.com>
Subject: Re: [PATCH v23 05/14] mmc: renesas_sdhi: Make clock divider mask configurable
To: Biju <biju.das.au@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulfh@kernel.org>, 
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Thu, 30 Jul 2026 at 13:32, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Add a clk_div_mask field to renesas_sdhi_of_data and tmio_mmc_data
> so each SoC can specify its own divider mask instead of the
> hardcoded CLK_CTL_DIV_MASK used in renesas_sdhi_set_clock().
>
> Default to GENMASK(7, 0) at probe time when unset, and populate all
> existing internal/sys DMAC of_data tables with this value to keep
> current SoCs unaffected. This lets RZ/G3L, which has a wider
> divider field, reuse the same clock-setting code.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  * Assigned of_data->clk_div_mask in renesas_sdhi_probe().
> v21->v22:
>  * Updated commit description.
>  * Added clk_div_mask to of_default_cfg and of_rcar_gen2_compatible.

Thanks for the update!

> --- a/drivers/mmc/host/renesas_sdhi.h
> +++ b/drivers/mmc/host/renesas_sdhi.h
> @@ -41,6 +41,7 @@ struct renesas_sdhi_of_data {
>         unsigned long sdhi_flags;
>         u64 clk_mask;
>         int max_divider;
> +       u16 clk_div_mask;
>  };
>
>  #define SDHI_CALIB_TABLE_MAX 32
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index d893a263e770..5dcbb431e1e1 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -224,7 +224,7 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
>                         clk &= ~0xff;
>         }
>
> -       clock = clk & CLK_CTL_DIV_MASK;
> +       clock = clk & host->pdata->clk_div_mask;
>         if (clock != CLK_CTL_DIV_MASK)

This strikes me as a bit odd; should CLK_CTL_DIV_MASK be changed to
host->pdata->clk_div_mask in the check, too?

>                 host->mmc->actual_clock /= (1 << (ffs(clock) + 1));
>
> @@ -1138,6 +1138,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
>                 mmc_data->max_segs = of_data->max_segs;
>                 mmc_data->clk_mask = of_data->clk_mask;
>                 mmc_data->max_divider = of_data->max_divider;
> +               mmc_data->clk_div_mask = of_data->clk_div_mask;
>                 dma_priv->dma_buswidth = of_data->dma_buswidth;
>                 host->bus_shift = of_data->bus_shift;
>                 /* Fallback for old DTs */
> @@ -1186,6 +1187,9 @@ int renesas_sdhi_probe(struct platform_device *pdev,
>         if (!mmc_data->max_divider)
>                 mmc_data->max_divider = SDHI_MAX_DIVIDER_DEFAULT;
>
> +       if (!mmc_data->clk_div_mask)
> +               mmc_data->clk_div_mask = GENMASK(7, 0);

CLK_CTL_DIV_MASK, perhaps?

> +
>         dma_priv->filter = shdma_chan_filter;
>         dma_priv->enable = renesas_sdhi_enable_dma;
>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
