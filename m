Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D31153BD8
	for <linux-mmc@vger.kernel.org>; Fri,  3 May 2024 13:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714742128; cv=none; b=BUn/AZ1+eYTMI2oEWXl+Me/jytaB75l78foB73IIKN13k5Q7hP65hGid3+duIU36cMBD85QFJWS1rEFowG6Gxv5ihKtrc9Ktxr2DG4vqbbmiijlkpzPVxAQfvmuxDCKEPwAwf0vXvSZDkW4Lqvy109OQyb5E19JUEekkO7cl5iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714742128; c=relaxed/simple;
	bh=xrqzZwgdph5DRS4i3SCKXCa1JY0Gomt5Ypf74Pq1OsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W6hK8IsduxLYsMlnpH2ms8Kk/DUydHYs59UkXcG4LzBFCYLWMcdRQbglPD1+JGLzUiPxloE9v5qgerzbLggDOAzPz4vI/DtjK66ISw21s3Uf1FPLBeEEdseEWTyXHmHALJlo+v4Wa7W1yEoEcPtBMoNW7+DbCzF1OXUE4zscUX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mbnuzj+F; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mbnuzj+F"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dcc6fc978ddso2650708276.0
        for <linux-mmc@vger.kernel.org>; Fri, 03 May 2024 06:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714742126; x=1715346926; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yRI9l6TRFX4cl/D/dHvxIPz5B9asZPit4lxB7Ww5SAs=;
        b=Mbnuzj+F1O2ftcNQQa2gjKwnUIEzNWptcRetBceho0Y5Aa8AJhE/TqlCMOjfFt/M06
         LZ4McigjWo0z4CA2xJGkMjOGRNpBJ2+h53A2VJAJpsKsqyC6Ktn0LzTOYk/SXmEsBmgs
         v0XPoc+nMYnPxKy1KT77c5XS9JwIITbHaby7NRXwSdubet8A+jjQ8tiEb8BNkSwTVgpd
         +CiquOg/lyTUnwkHHDdwj8lqAJCZ8DL/exZO3hqVIN1Zc6yablOs35WHNXnU1ZJmTyo1
         xQ4iVz4vjrfdD3HXBMZTrdF2Tc3RHFv93D3EkvxgxMW2EPHkzYVy+tKgfgSmHMbk7pCe
         vHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714742126; x=1715346926;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yRI9l6TRFX4cl/D/dHvxIPz5B9asZPit4lxB7Ww5SAs=;
        b=pidxzBe+I8IN2Zr3CyYAOKBEayibDc5N4TR2deDWZ9+/8iBXTPoz4HTqGnVXSOg2G5
         4BVMcc9XkyiGrRkyvcxApGAVJj98XI1LzdW7sVqJSpZp2cUrwYkQnfFjxWfJwCtP+Swl
         hQItBlaQ56R9+gpDz/DXNcUjYpxSFdIwhbbZnIme7m5HOzu2MeolroH329CDbT63qwjC
         H6SWucoxDq9XEvlWu0zsXx3u38B6qR6e8R9fP4UAQyy5DjyeepHB9ugho140f9Xg/Mfb
         eI9CbvabAOfax5foi6/Nycc84/7/lUN0t+RSHxkCXPIpC6nDnmc8mFpCJ+GliCFFRxT5
         3uMg==
X-Forwarded-Encrypted: i=1; AJvYcCUU0rX7U1Kb4nSBdJ/71hyq3dhMFsj3F2Zcm8Y4hMkfL3emBfEcPvptI+KZ7FsYCRe/RRCWjhnL+4oJXY9qTq4SJNI1BThLQuQH
X-Gm-Message-State: AOJu0Ywr8hPqMvhu804zOZPQBG5a9mV99LYcwbTMLFAjxKHsS33Vpxmi
	IJA3Udf0t6awZBh6yRk+oaRoAHrn9de/2N21h3meq/lwck6TWDMNZo4/qAevSycqLJ2Sz5vyu/A
	nBvdLo/GaJfSqMEw5XOspTpA1yIO4EPN9zkGVRA==
X-Google-Smtp-Source: AGHT+IHAuATqJlUN1KaAG6j30rTHBUQbuirlBENRxW4a0MCgvAe9RQrcnJ1n9j7vzbMqMlM2SL8OuwZJN888gEQV8HM=
X-Received: by 2002:a25:aacb:0:b0:de8:a500:ffdb with SMTP id
 t69-20020a25aacb000000b00de8a500ffdbmr1856096ybi.26.1714742125931; Fri, 03
 May 2024 06:15:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430093724.2692232-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240430093724.2692232-1-claudiu.beznea.uj@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 3 May 2024 15:14:50 +0200
Message-ID: <CAPDyKFrPZ5XF93MD+g03UQP1d4WSPoop=VyAhzwLu9KV436KkA@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: renesas_sdhi: Set the SDBUF after reset
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: wsa+renesas@sang-engineering.com, linux-mmc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Hien Huynh <hien.huynh.px@renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Apr 2024 at 11:37, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> For development purpose, renesas_sdhi_probe() could be called w/
> dma_ops = NULL to force the usage of PIO mode. In this case the
> renesas_sdhi_enable_dma() will not be called before transferring data.
>
> If renesas_sdhi_enable_dma() is not called, renesas_sdhi_clk_enable()
> call from renesas_sdhi_probe() will configure SDBUF by calling the
> renesas_sdhi_sdbuf_width() function, but then SDBUF will be reset in
> tmio_mmc_host_probe() when calling tmio_mmc_reset() though host->reset().
> If SDBUF is zero the data transfer will not work in PIO mode for RZ/G3S.
>
> To fix this call again the renesas_sdhi_sdbuf_width(host, 16) in
> renesas_sdhi_reset(). The call of renesas_sdhi_sdbuf_width() was not
> removed from renesas_sdhi_clk_enable() as the host->reset() is optional.
>
> Co-developed-by: Hien Huynh <hien.huynh.px@renesas.com>
> Signed-off-by: Hien Huynh <hien.huynh.px@renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Changes in v3:
> - shortened the comment introduced in renesas_sdhi_reset()
>
> Changes in v2:
> - fixed typos in commit description
> - limit the comment lines to 80 chars
>
>  drivers/mmc/host/renesas_sdhi_core.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index f84f60139bcf..d9503f9f6e96 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -589,6 +589,9 @@ static void renesas_sdhi_reset(struct tmio_mmc_host *host, bool preserve)
>                         sd_ctrl_write16(host, CTL_RESET_SD, 0x0001);
>                         priv->needs_adjust_hs400 = false;
>                         renesas_sdhi_set_clock(host, host->clk_cache);
> +
> +                       /* Ensure default value for this driver. */
> +                       renesas_sdhi_sdbuf_width(host, 16);
>                 } else if (priv->scc_ctl) {
>                         renesas_sdhi_scc_reset(host, priv);
>                 }
> --
> 2.39.2
>
