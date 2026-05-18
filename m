Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE9F3FB044
	for <linux-mmc@vger.kernel.org>; Mon, 18 May 2026 13:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109765; cv=none; b=djN+KtTRf74QbNkbrNvJAzIW5m9MjGXV3AIPoqILhl/FkTfROtw7ngONbtn8Wz+M7YBtVnSa3QeKVW9DC1r3nIli1OS1B2CeGu1jRmEt0g2ymX05Iro3C/3p7EPoFk/QcvsKLrElC5zjiurXfqnyDD6/2K0mxTwVNwTJgqoI2o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109765; c=relaxed/simple;
	bh=V0P9WDALJ1I2iIIoWPjcR0w4g1HygrqhqYPjuNek90k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NGAmEqr/dVZzggsrmsZZiuBtTnatIR6DLmh8eeVqBGlhPMRbbEnv4sW9u1JPqHKJofRFz3hFjs6RA38ZYMAQMjlVaxMhCdUaS1/UmSzID1JIkdDR2sOCEeEvqFLk2TdLrnhSO4YQMthu+DX9wKyI6OuoDPdC9ejFb6plS44ALXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-577500ac0e4so499246e0c.0
        for <linux-mmc@vger.kernel.org>; Mon, 18 May 2026 06:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779109763; x=1779714563;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4P5QLcEzhZH+iMBp8Kosg+9RMRtsU7zMDBAroJzlJGY=;
        b=nzNjMgVtwpbHQgdJkY8lLqzogLWQDvdrdqbj2GZIAsr0CbLasVEzsal+QYt82rsIcq
         7dQ0JMt0Bi7EVWDmTFJoP8KCbP4T2CjpJhJzqkmwXai3JyePzbrOtPXqtw5UeS1X0aOf
         KFyzcEF7os44crwY4a48MZpjWiiy/0LWx38EKuwOBLVaCPI8ZjMRo4wqwsSntqRPeBJr
         VdIjROOjfnKvHIy1hbod4fV8q/lgtl7P5lxoVwoNwzCuxr+wqLVvKtLwr70x1YFG36nf
         jF/2ArWY6r0ulQ2PBNZK9VVmvqIr6gX9TAUVeJMw5QdapyqBx4LkycXPhVV6tPlPgMlJ
         NEmA==
X-Forwarded-Encrypted: i=1; AFNElJ9RvGkvPQDixKpps4RYGCgWxv9MZIEcg0jpgk1JkBGMYuYEWAiCjmbt1GY7/gcwjeL0WiMoOxqW/wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOA8FIkdCi4iQRYGx2VSyTNv4z/86KIjGvm6iVP6pc6fsyeCUX
	eu7/PULPxJsPhk1ee0bPIuceen1MDTpSEU5yQL6ltr2Aey5Ors1dYa/T0mm81ByE
X-Gm-Gg: Acq92OGlTrTjSrYLsYxRdJM8sDzeOBG+Bkn2McgxrEyd94+V/w7jbFkQDeUyTZEbfVQ
	V1A+L1Hz/7RGoBJL8UQKkxb3sPYn/OmNgsySx2DpoJc1iBf8mjIEv4cAhrN9h/e8LDVukZQ4LB2
	rHdrutn1jLtPcOvcXKVEgjzerU7B5nybond9N0KkXT/nhg80qloi3AAy1V6KqXzGwPR1/7XYBRw
	Wx9rkmwehlxL77OelrWKTpzJtAPn066c+NHd7SEbO4py/IPIc0lYYyj3+7XbpdqE/pkkM/4CinL
	gRxFrXNw9w7uHbPOGW8Nk+9CA7zdqmgzi/W2nW3kY+WrIssF7E0DINNmNP387kPBGu2JzVFVDQx
	Ry2Ew8eDjd8GrYDqWevvDPKX2UP49PvrfAdggxnpnX09TBZWcFmlG3iIfdc2Ce7d/s0MS+uKZtb
	7DIIbhRsOoMCGQeItN82+kcZXxG/PHQ+B4muM9Iy8FrYcercMf0C8W0Cz/y9gJ8HCaXVcpeU4=
X-Received: by 2002:a05:6122:2a02:b0:56a:fff5:b4d6 with SMTP id 71dfb90a1353d-5760be71006mr7099900e0c.4.1779109762693;
        Mon, 18 May 2026 06:09:22 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95fc2cc387esm4768919241.4.2026.05.18.06.09.20
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 06:09:21 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-960ae134040so35514241.3
        for <linux-mmc@vger.kernel.org>; Mon, 18 May 2026 06:09:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8uACRqA2hwN6kQw/F7jNiMWGHX06jtOaAHNGENd2utgCNrYjkmZPSNPH2yk4bNnd1sB5fy0+FI+h0=@vger.kernel.org
X-Received: by 2002:a05:6122:4d06:b0:56e:f262:9113 with SMTP id
 71dfb90a1353d-5760c0943cfmr6808832e0c.14.1779109760741; Mon, 18 May 2026
 06:09:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514212024.1624517-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260514212024.1624517-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260514212024.1624517-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 18 May 2026 15:09:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXdSuiJ77bjoP7UQD2FK=rdprh06=13kDfVt4otPmwLCw@mail.gmail.com>
X-Gm-Features: AVHnY4K0v1qwmuRJJHyFwdOzfeyYUi3b4ZKmDJqEEb1F8PYs48qlTeg31JaGAKU
Message-ID: <CAMuHMdXdSuiJ77bjoP7UQD2FK=rdprh06=13kDfVt4otPmwLCw@mail.gmail.com>
Subject: Re: [PATCH 2/3] mmc: renesas_sdhi: Add SDHI quirk for RZ/G2N
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulfh@kernel.org>, 
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Prabhakar,

On Thu, 14 May 2026 at 23:20, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The RZ/G2N (r8a774b1) is identical to R-Car M3-N (r8a77965), so apply
> the same sdhi_quirks_r8a77965 quirk across all revisions, as is already
> done for R-Car M3-N.
>
> Fixes: c9af138c42f0 ("mmc: renesas_sdhi_internal_dmac: Add r8a774b1 support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -224,6 +224,7 @@ static const struct renesas_sdhi_quirks sdhi_quirks_rzg2l = {
>   */
>  static const struct soc_device_attribute sdhi_quirks_match[]  = {

This array is meant for quirks, i.e. to address issues on specific
SoC variants that cannot just be identified by the compatible value.

>         { .soc_id = "r8a774a1", .revision = "ES1.[012]", .data = &sdhi_quirks_4tap_nohs400 },
> +       { .soc_id = "r8a774b1", .data = &sdhi_quirks_r8a77965 },

Hence I think the RZ/G2N entry should be added to
renesas_sdhi_internal_dmac_of_match[] instead, referring to
of_r8a77965_compatible.

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
