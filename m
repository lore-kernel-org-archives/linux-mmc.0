Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1EC472F9A
	for <linux-mmc@vger.kernel.org>; Fri,  7 Aug 2026 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786109307; cv=none; b=QKEt3tM1iOLnnERrgMrvD+/FIhWXpvUtM4TLzqIHas1j91RntAs1+4/L+QvP3Qr1tyI3jgvVzhnA180qpzdgkvgJfrUApIUUGo/33w+Iq+Ll8Kxn4YSVmAX/1fd2FVVaXObiKUEr3aC2VJe+11lA+zJ+CFQnGhuX+xZbJHpBS5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786109307; c=relaxed/simple;
	bh=iGEucwuv0cDETFySrvCtSDoMSdRLS4yfZWG/9BrZsOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dw9VacQwuu+3qyHuh9PiTSnbHtcj55zUTbMBwPyGMYBWxdqMpu0KOyV3sHBFbvEhZA3dPDM0qvRwucLCQBgm64M/lTWnz4e+X/NcjNRfIO4lRtTwkbtbrdBEaTdNNd5DuK3VCVUoVy84svVBbUezFwz+gUDkilKjHI/f8P4x7bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e99ef0902so185827085a.2
        for <linux-mmc@vger.kernel.org>; Fri, 07 Aug 2026 06:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786109301; x=1786714101;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ihkRYHxMD45hBtXtL0ryyoy4S8BR0bYvAoTcaodyV1g=;
        b=TSxMBJwUNUxdQFi8OVeq7o6nz7wrGPzfiWiDuDRm2Ub8AoaFYTfCSfnVGmqb77RxAH
         KrRUkXd88MgDm7WkRQJhX2MkfCoIzz4uKo20n4x/g5MUGXbH/yRZro+PDXAnCoPU5x5r
         ZwHa42KWgtHYB+5tbXc1RK+4TKlEik1j96LGQReoYKrjv6OWmKyDY3rVy/NWmP2ujJ4A
         vKe4PVfzk8gqKgGCqtFS9++MjyRgsLRhqX102vu4qAwVTdGNgMi8ZdK0j63e37/ve5Nj
         YYN+lkDjLRuQtQzXBXqk3Amb+7RqRSNkCzxq7JQa+PvyaTmB6+i4FTgdyy2GBkd/Y76/
         E/4Q==
X-Forwarded-Encrypted: i=1; AHgh+RrpATqIhX5XfUC1nXv/9cDNRrjIrrrJaN39pa4G7W0/SjI/OLxyC4sfJPNsigM6fLAX6EJ16q7mg/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQL4OLcHpfeI0rtgtdm74GBfPnS0YccZRNC/5UbPYWXpiHap+4
	ZmXmBoQXZvMg3D+9UQrDH036SJ4j8bDH5tC4gqUHni2N2s3ryywtO21rW2bymrmP
X-Gm-Gg: AR+sD11NNxG7TiT6GAwct+85snjWikGyWEX0UR6U9RYP+R6buHyfQuaiDfpLH6HHfOa
	LUMPUm2jmtnWNKzCh87xl9uhO0ieuuv1RrXii13FirCIaWdH6mVOPDRxqxOSCmvlq82XN5r2k8l
	m1ZzcE11vdrCtuggkPw5k1PhAaCHIHwqKcx9ZRZAb9GOOaiRKfIDeqTAnUCsjHneQSrrYiUCMdV
	iEHEkjQMN+24+srSZYDYGRm+GOb5oBHFsvjRBirS34JZXKmdNpWrkzJFFS3h9unlWoC1AtunDYx
	WaZY5SGIdgzkEuw+JJsXa5Fd7Dx28EzxSJtQ+kbOWH6weURgBTkNC8Wz46/KtPMa6F+N+SMU2ZA
	og/tV/qyVo3ILVe5Mo88fRQHSCBA7xp7bMluLJQTpkTbVCgjHOs29fqHVc62/UO16FADvjaZIPj
	po37YCoLVphyIioi8dG+rwRHdgoNrQa5N/UVwamYmXq4embjU70Ml1TwYRjtFzpHKJtulSrSC65
	9czugVlJfIPvPKEPUH/Az+aJg==
X-Received: by 2002:a05:620a:628d:b0:92b:9df9:faf6 with SMTP id af79cd13be357-9364914e653mr2586861685a.37.1786109301040;
        Fri, 07 Aug 2026 06:28:21 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e290054sm148241985a.40.2026.08.07.06.28.20
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 06:28:20 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-9773c6ea885so959222241.3
        for <linux-mmc@vger.kernel.org>; Fri, 07 Aug 2026 06:28:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoxBtFiYf9WWckQAwXdPtlwP8xBTHyIekqgM7njCw6qB8SKvtsMEnrrWJZn8jW2D1FTYFBs4iNZEtY=@vger.kernel.org
X-Received: by 2002:a05:6102:4bc2:b0:738:84c:6b3 with SMTP id
 ada2fe7eead31-760e6ed510fmr5729903137.3.1786109299935; Fri, 07 Aug 2026
 06:28:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730113200.36456-1-biju.das.jz@bp.renesas.com> <20260730113200.36456-11-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260730113200.36456-11-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 7 Aug 2026 15:28:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVd-PQBPvoof650UjXfSZqg2kGN=9kOnVUDgZvnGUOLcQ@mail.gmail.com>
X-Gm-Features: AUfX_mzIOXg0IiwN3D9gDKa8uwjJk9QQ4Yu2cWICJeqOqyAGpD8yG0bvdP7SOQ0
Message-ID: <CAMuHMdVd-PQBPvoof650UjXfSZqg2kGN=9kOnVUDgZvnGUOLcQ@mail.gmail.com>
Subject: Re: [PATCH v23 10/14] mmc: renesas_sdhi: Add RZ/G3L SDHI support
To: Biju <biju.das.au@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulfh@kernel.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, linux-mmc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Biju,

On Thu, 30 Jul 2026 at 13:32, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> RZ/G3L (r9a08g046) has an SDHI controller that differs from existing
> platforms in clock divider width, a second HW adjustment register,
> and an extra tuning register.
>
> Add TMIO_MMC_HWADJ to mark controllers with a second HWADJ2 register
> (offset 0x010), programmed by renesas_sdhi_set_hw_adjustment_delay()
> alongside TMPPORT2 (0x3FFF at 3.3V, 0xFF at 1.8V). Clear the new
> HWADJ4 register (0x022) at tuning start when TMIO_MMC_INTERNAL_DIVIDER
> is set.
>
> Update renesas_sdhi_set_clock() to write the clock control register
> with a 32-bit access when max_divider isn't the default, moving bits
> [9:8] of the clock value into bits [17:16] of the register =E2=80=94 need=
ed
> to drive RZ/G3L's wider 11-bit divider field via the max_divider/
> clk_div_mask support added earlier in this series.
>
> Add SDHI_VER_RZ_G3L_SDMMC (0xce10) and handle it in
> renesas_sdhi_sdbuf_width(). Add of_data_rzg3l with RZ/G3L's wider
> clk_mask, an 11-bit max_divider of 2048, a dedicated tap table, and
> the relevant flags including TMIO_MMC_INTERNAL_DIVIDER and
> TMIO_MMC_HWADJ. Wire it up via of_rzg3l_compatible (fixed_addr_mode
> quirk) and register the "renesas,sdhi-r9a08g046" compatible string.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v22->v23:
>  * Updated tmio_mmc_reset() to handle 32 bit divider register in RZ/G3L.
> v21->v22:
>  * Updated commit description.
>  * Added `clock &=3D ~GENMASK(9, 8)` to clear the divider mask bits in
>    the register value.

Thanks for the update!

> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c

> @@ -253,7 +256,17 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_h=
ost *host,
>         if (clock !=3D CLK_CTL_DIV_MASK)
>                 host->mmc->actual_clock /=3D (1 << (ffs(clock) + 1));
>
> -       sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clock);
> +       if (host->pdata->max_divider !=3D SDHI_MAX_DIVIDER_DEFAULT) {
> +               u64 tmp;
> +
> +               tmp =3D FIELD_GET(GENMASK(9, 8), clk);
> +               clock |=3D FIELD_PREP(GENMASK(17, 16), tmp);
> +               clock &=3D ~GENMASK(9, 8);

Add #defines for the magic bits?
We already have CLK_CTL_SCLKEN for BIT(8).

> +               sd_ctrl_write32(host, CTL_SD_CARD_CLK_CTL, clock);
> +       } else {
> +               sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clock);
> +       }
> +
>         if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
>                 usleep_range(10000, 11000);
>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
