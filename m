Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC6E319855
	for <linux-mmc@vger.kernel.org>; Mon, 18 Aug 2025 10:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514548; cv=none; b=Ut45ZeJkigImhrmT6NI9+hWV+oaVLgDwHkYrA+H7lq1CaHIP7848xWdkgYkWs9t4iPsVjvGB1kLBGkKqN9xPKXdrq3ICwebFRDd6uYPmQYAo8z2jrBfZ0FJCYtVKCiqcZ89hz8J0wAdudUpAOcgySQIeM0E2QtBwAL9GikXmP2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514548; c=relaxed/simple;
	bh=iHvNIYoVtM0gtmhzVNDj0P+hg4qdzTTYa8AKTvPgEcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y4u0y8nO/VaQ+K6k04wS2OzD8QT1zztxaWeEI0/npoTiAuEn8Tb756wgJBrK7xnz7sI8RY/Xy83rj0LnvaT2h2ogqysZz+mm/K3+gkOhEd+JzUiMOM4Y/gVqMBlihe6UCLsKpZO4TI+Fnlu88OkAucUg62hoJpbGjY2fHhGbt78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kD86IGkO; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kD86IGkO"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71d71bcab69so26399237b3.0
        for <linux-mmc@vger.kernel.org>; Mon, 18 Aug 2025 03:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755514546; x=1756119346; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JC9hJ08acql9I6gPRIBiwIU0+h4AM1URG+SiBRg5N5k=;
        b=kD86IGkOKItmRd329e72CKnck5nAbNNmZzBh9bnP9JskvN8mK988Jzq1r9hlPxUNcm
         eN8ER1Zy0j87jBEc8DE/gKmbHPOXLfEtqUBaqMn6bzrqrz706iwqX/Nkpb+AGWwInPKl
         Z9v63vCuFIqj/GJl9OZssy+mXhN8NZlKNPw8WLIMqgzbTn5BzfPSgALOqkApl6pNdJQ5
         uuwXe9eXJF8pOX0Ust/y7/sl0NUBkJ/ODtEAQz64xZy3p4rcbrHD0tYHo7DO7SGKfONF
         YqrSwaAT+mhRSBh2jwONGhd2NKdVmAcpgj9qx7rAuSu8vwT2scAEd56kff8O1m9S/ItT
         0yrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755514546; x=1756119346;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JC9hJ08acql9I6gPRIBiwIU0+h4AM1URG+SiBRg5N5k=;
        b=b6Ld7G9w5pEQgod/9RHtb8br53LGQ/7HAyBeCOK1pkjmchs5OI7nvWjfS1YEUwt9Te
         oTdPC1nnooEw+JB9KFz7hkdLNmWCjYwlA9LGD4SLdSM3E/zlx1TNH4l2mCmw6b1CLLUh
         e1vGePRQ/QSHOb9FMdCsyFElNdC2/zQa1kpAg4T/ya/rPe8oW/gUn5UoaaEuNmD0wEdy
         7txU3SD04RX44eF9e5tIOg66kZYJ23WkyuV0YNP8KCRm6rRaMMzFXwaP/TUGYdsmIDN/
         cJSDs4jrYUc3am6ied41AeQyHqG/lTvchwOvtaPj6hrIUfFcs3z2Y8O6Wn04fvEPJMI3
         207g==
X-Forwarded-Encrypted: i=1; AJvYcCV2jIS37oX939wLY7+91hYB1vxo4HIao3dXI6/QnsnaCG1JdnVAYF/n9mt3j396fiXmUEUXOvs81Js=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVph5hS9e/1frgSb4fp649r14cgxNRhm+NQbYkwradFpo8QfUQ
	skqnGxW3S/olP3Onbc/fBaW+D5JUs69i/7y1jkTOdkzjZpnEQ/QEkCqjh6L+6uGAzJAyqWBhQGc
	1nJClCKj33TDmDrkTdx4e4OrSgbPQVkocPFLevuEDyg==
X-Gm-Gg: ASbGncs6PLPq6BXdJd06er4Xy0wIwAFtcQ4w0CkYYKkVCDu7fG9m+a0779OmNXtymRL
	SzLH/u9cosrY2CYRMzc4Ng1PgSM5wRAd8OnzfoDtfGnMU0MW6mLe44sGMHYYQBh4u15ioo42mYS
	d657diXAmx926WFipmj+IKFI+f5Nq56bvDDuJs9Z1cCTQUkcpBKGvdb8ua0ej+RWBF2BRmMOgVI
	pM7wyhv
X-Google-Smtp-Source: AGHT+IEJTkVP+1K5o7GJEioZhNvRiV/+3+KOjFOMU5W0tfTvsqjZdrEBlWJvBYcKuor7yLdO8Lk+wVhX68UKDrA8wAs=
X-Received: by 2002:a05:690c:3609:b0:71c:1673:7bb7 with SMTP id
 00721157ae682-71e774aaa16mr105428807b3.13.1755514546131; Mon, 18 Aug 2025
 03:55:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250629203859.170850-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250629203859.170850-1-biju.das.jz@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 18 Aug 2025 12:55:10 +0200
X-Gm-Features: Ac12FXwQkLY8qn_v81dOCAFgoFZ2JHmLbmrbQI4CNQWFczXEWLCAbRxpDcxVexw
Message-ID: <CAPDyKFozdeAku=c7HM10ARL6-uJv43LaEa80+gSHa-uBNGmnVA@mail.gmail.com>
Subject: Re: [PATCH RFT] mmc: host: renesas_sdhi: Fix the actual clock
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 29 Jun 2025 at 22:39, Biju Das <biju.das.jz@bp.renesas.com> wrote:
>
> Wrong actual clock reported, if the SD clock division ratio is other
> than 1:1(bits DIV[7:0] in SD_CLK_CTRL are set to 11111111).
>
> On high speed mode, cat /sys/kernel/debug/mmc1/ios
> Without the patch:
> clock:          50000000 Hz
> actual clock:   200000000 Hz
>
> After the fix:
> clock:          50000000 Hz
> actual clock:   50000000 Hz
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Note:
> For HS400, the division ratio is 0. I don't have a board with HS400 mode
> to verify the fix.
>
> I believe for HS400 Mode,
> SDnH = 800MHz
> Divider 2 = 400MHz
> Division ratio 0 = 400 / 2 = 200MHz
>
> and for HS200/SDR-104
> SDnH = 800 MHz
> Divider 4 = 200 MHz
> Division ratio 1:1 = 200MHz
>
> Please correct me, if it is wrong.
> ---
>  drivers/mmc/host/renesas_sdhi_core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index fb8ca03f661d..a41291a28e9b 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -222,7 +222,11 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
>                         clk &= ~0xff;
>         }
>
> -       sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clk & CLK_CTL_DIV_MASK);
> +       clock = clk & CLK_CTL_DIV_MASK;
> +       if (clock != 0xff)
> +               host->mmc->actual_clock /= (1 << (ffs(clock) + 1));
> +
> +       sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clock);
>         if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
>                 usleep_range(10000, 11000);
>
> --
> 2.43.0
>
