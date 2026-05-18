Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6F43F9F46
	for <linux-mmc@vger.kernel.org>; Mon, 18 May 2026 13:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109680; cv=none; b=QHMOX5RUY+dHkJH5vW6Tl/esp6hfPKCzEOsCKegP7Lj2PEP6jnuMT4IkVXl4EdZwozCeI+ouSlC78X1DaO3QL/GtlYjkGHGDdD0Pf0gu4NkVNw4e8sOpOewaPO7kTdAuPGq8tR1akebzmOVXxAra5+iwEefSDWinqdpBM5aWm9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109680; c=relaxed/simple;
	bh=bLoHqx7iz89YsOH9/yJgX2I07MLCqfljXasqV1HWAJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JqKwMVavZ81e1psOZmkbKlUX9YEAYRjuc6Cny+OOx7vUPDuBIGIjTcfSr416FgngdCM1penq3iftXrqbR+7dmemy8+k3Z/+Uy7pOhVGIJe+11Ty07SL+/+Sy5jDZT1z7YCyYbreNOebaEItSJDF+jjg4Z9AnLKIsrSPbJVQzeK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5751770a178so608193e0c.3
        for <linux-mmc@vger.kernel.org>; Mon, 18 May 2026 06:07:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779109678; x=1779714478;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8A4vYkByGT4hltTC530nDELFOVxe5LtgHJp6bYwWpg=;
        b=V3BZUzepYnAtwhgdVrbvj/hl2h9kCRUlrS6BnU4Yc8zwJoYHE46vYI2r4BAb98XQyE
         DInzPrl7UqrRmISA1oHRgueKMtQMos4xkHiZdj9kb/oXQV4s5KEgtM7rVxBScU75fEvg
         5lw72mYNpgQsHsolxbpvwnfMcYcOe5rfo+YmYFUYotxOKg8qx7kQKz/jPRBLomEbozEN
         VWdc3F67yzdH/nLrHYdrawtHjSYkfsuC1DWH+63vmKUpWff3tCTeQ3ajnu0V/mVTJPOH
         TEbo2uZmLVT0z6/rClL5lVQwz+tqLU+gcdeXxij2FJPh5XYVHZnL/poYwiq9nP2zJaPM
         JxIg==
X-Forwarded-Encrypted: i=1; AFNElJ9eB6Rhua/Lqx78VzP8D9hgITvdzIyCyrqyH5ecKCGIk0UgRGuYzqtuv7VCaD1vJmnInyPOC9B6KqY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn3cd0Dlkk3PjF+gVbqawexxHmtwWvgJ5ZleG1g5XjaCM5wlD+
	lJyF8IRt3M7EtYBfHuB/fF0OCxgBm5u4tu4h7F21j0JTmVv69vNpnZLLTXPsRwN1
X-Gm-Gg: Acq92OEgHkKHtJF08h9eQM1y+4lRMOQlCjfTb9/ie0bY1GLdj5H0uJZb3Yw8k9FdEKy
	xI/765L2uABTEgFLLUkdg6cYmfYH9IufzkLul/ZcVHvkcu/1+d7iHXcOzO/xEOlwvOWcV7iYoR7
	EOWGhMpJYmmDQcu+ZDnktdnl9Vveu6CG6mA+QddrVqujbwTU9Z66fM7oFeVKjxMcTe0uOGBkd8W
	yzMosY4fl/gKSMsEmKK/y952tj43I5pr5SRHJAm1UKj29Cy7JJOjPN5JOQuPOTY7AP55z/J/pno
	JSWIwV7ycMY9MHfWvONnNPIbqiOW73Z+IyUpw5up8SRdlgBi3pbgiUhsepIMIXlAhCkhwT3K2ZN
	zYuciqBXq0EV2JPuzVXgyID48pNnw4cbj7lZ6HZY9+CKGpsJLaZHastGeHJPqkwp++lh9HszKyW
	JCS5cuUbr9eEk/puiHKEocqViVMkghPTplWWZDn30cWn+GWFOOEbHvPpXqxiAi1Wzy3aHOI8jsx
	8o=
X-Received: by 2002:a05:6122:2988:b0:56f:a3e2:66a4 with SMTP id 71dfb90a1353d-5760be39af3mr7266512e0c.1.1779109678131;
        Mon, 18 May 2026 06:07:58 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95fc2fe0a69sm4619736241.13.2026.05.18.06.07.56
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 06:07:57 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5752b27958fso699972e0c.1
        for <linux-mmc@vger.kernel.org>; Mon, 18 May 2026 06:07:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ978d9S+sa4lJ25xMP7gbSYhxPIXixPj9tvPz/QymKL76HQLfEH+764E5zdAwtfpgjWXG4v/NN1Jic=@vger.kernel.org
X-Received: by 2002:a05:6122:da3:b0:56d:9e98:4676 with SMTP id
 71dfb90a1353d-5760c09d17bmr7729115e0c.13.1779109676420; Mon, 18 May 2026
 06:07:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514212024.1624517-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260514212024.1624517-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260514212024.1624517-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 18 May 2026 15:07:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXDAJjWGRLQb6jfvzUPAWymmTC3yE89UPyiydykHN4u6w@mail.gmail.com>
X-Gm-Features: AVHnY4IiZkti6BwVvlbvdUVkcYDNCX04P78NcYM0PkLVTLe5ljlG3OOT8x4qAls
Message-ID: <CAMuHMdXDAJjWGRLQb6jfvzUPAWymmTC3yE89UPyiydykHN4u6w@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: renesas_sdhi: Apply bad taps quirk to RZ/G2H
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
> Apply the sdhi_quirks_bad_taps2367 quirk to the RZ/G2H (R8A774E1)
> SoC.
>
> RZ/G2H is identical to the R-Car H3-N (R8A77951), which already uses
> this quirk to avoid unreliable tuning tap positions. Use the same
> quirk entry for RZ/G2H to ensure consistent SDHI tuning behaviour.
>
> Fixes: 31941342888d ("arm64: dts: renesas: r8a774e1: Add SDHI nodes")
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
> +       { .soc_id = "r8a774e1", .data = &sdhi_quirks_bad_taps2367 },

Hence I think this should be RZ/G2H should be added to
renesas_sdhi_internal_dmac_of_match[] instead, referring to
of_r8a7795_compatible.

>         { .soc_id = "r8a7795", .revision = "ES2.0", .data = &sdhi_quirks_4tap },
>         { .soc_id = "r8a7796", .revision = "ES1.0", .data = &sdhi_quirks_4tap_nohs400_one_rx },
>         { .soc_id = "r8a7796", .revision = "ES1.[12]", .data = &sdhi_quirks_4tap_nohs400 },

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
