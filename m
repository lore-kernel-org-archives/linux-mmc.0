Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5A617CD
	for <linux-mmc@vger.kernel.org>; Fri, 26 Apr 2024 05:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714108129; cv=none; b=i0JpbBNGoyQYWL0bNJ5CanOTx7gMLNCY3V0WPk3Wcu1cscd/2eJ2PvNnF+w17vs/4mLM1WvxuZFATeDGMl3hy5L/pyL4yF7KR0oUjLlPwwEOK8DqkTSJ+82pfvy4ojMzdFn7+Lsp7MAuf0tLWn+MwekLf9yhQi6ZjQwWOGfktA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714108129; c=relaxed/simple;
	bh=1LBhiAAzsix5kBJ7XstPViIgPB3xqpoWGEuihbF6h80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZwA9nAYVUKIOvbOL8HiMxK5foKn5Cisc+lTAcEH2pAFeCZWJssl+1c2zIFI14Eph5h13qx0HCnToGte5kyNrKzT/oxblSZzufbIS+8ODSMdDwDuzS5uxnisyJktCMDBLTNtHW5bwaSnhFsPb7O97fBPzF8RLkgwUTT/WS5F5fs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=chK9Rx4C; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="chK9Rx4C"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-de469a634fbso2080863276.2
        for <linux-mmc@vger.kernel.org>; Thu, 25 Apr 2024 22:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714108127; x=1714712927; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q9qYK6scXFU3hWFQO57QP2e7QzwrtzpT92BwSQPl/Ws=;
        b=chK9Rx4CmSO4WB1nmYQwDfCdxOIaxwLzFuaC+HA1lYR2aNZiNMdp4Ql+tYUEsBfs8V
         2GpH4pe3envr6cD9PuDnQJAJtDwhaENtuWpkhm6bEXxX3mTVuLi/o2H0x7mlEDooJK4A
         BzAyd4EcMbS5/bZpiAQavopDUc/AXHqM/S4lisFU/thGEEg9ZDTSLpOC1L2WXEh2dz8v
         17D+CtssRtq8hR8Y7QfWuLKuJlws9I6bW0rYGTpr+8AnD9LhBq+isyU6MxrGgEX8Ze7A
         82iIrWnQIWCCh+DAGuSNlJBRT7tldnwPc1gC+MLjDxm7kfAg+s1StF0Lb/BzwozCMBQX
         5Oeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714108127; x=1714712927;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q9qYK6scXFU3hWFQO57QP2e7QzwrtzpT92BwSQPl/Ws=;
        b=uMokxu+uRLPCo3YwGxs085CIfOTZhJ4yeUjn7TZS371aDC+U6WgcDB2u0PfQHvzv2J
         mPVPVGXwLgDX6IacMrCsWKozaL8wxxF34wby+vGxmnw9E4YnSYd9RBc6P9Bzg7NHMhew
         e1kWVm7GSTjcz30OLn0sSqEYwZ57mqCLDJVImVNHIyxg2UPATVoSXXPmp6aZseRnuOt9
         lRkL/UlPgObmlxa5O5++GYphotpVZGKKnEhtwzp3DJ7yjcJNgkQF3iyJ/GaEjhdAUVPv
         tCXBBOReKUrfxHGw4VZ/cRqPP6SLHA0dTtKzGPLGoMhqoNVmn5ICFb0TKtN9vvKK5USb
         soYA==
X-Forwarded-Encrypted: i=1; AJvYcCVeRkYzVlKk3M21F8yu5i1y/So6/2EBLejKLSrrZcC9MeOSLGd4S25MXzP3aykN+sd+TULQH+tVYE5kgkKrRImsH/uyws8EF1GI
X-Gm-Message-State: AOJu0YznZoM4P/k2xZ6ha1ZITm22zn7KGDrhYuhG97s8lacb3avS0ViV
	/ICrFtFXfGisJ3poy+87TwTCpa7gI87sSfrZM7mKG4jLed7qnqvZA9l7lyWkIwFX2X+bnQzAOkE
	Fz+Om1isYawl5ABEeRA1r/Won6p+X4N1lY4jxVg==
X-Google-Smtp-Source: AGHT+IH16hO8vwDnyxZrKnMooAxMmGR34X0+CmzuCVy2Rc0FqatpjC5Clkv6zfTfOM8jNaRnnuwXmkNi1ffzofnr41g=
X-Received: by 2002:a05:6902:2303:b0:dda:c5ca:c21b with SMTP id
 do3-20020a056902230300b00ddac5cac21bmr1953339ybb.37.1714108127133; Thu, 25
 Apr 2024 22:08:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410135416.2139173-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240410135416.2139173-1-claudiu.beznea.uj@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 26 Apr 2024 07:08:10 +0200
Message-ID: <CAPDyKFovRYQOCM8UqFcsP+MiUd2ViKJhgHUMH6hgBiqtdBxmkg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: renesas_sdhi: Set the SDBUF after reset
To: wsa+renesas@sang-engineering.com
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>, linux-mmc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Hien Huynh <hien.huynh.px@renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Apr 2024 at 15:54, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
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

Wolfram, when you have the time, can we get your opinion on this one?

Kind regards
Uffe

> ---
>
> Changes in v2:
> - fixed typos in commit description
> - limit the comment lines to 80 chars
>
>  drivers/mmc/host/renesas_sdhi_core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index f84f60139bcf..5233731a94c4 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -589,6 +589,12 @@ static void renesas_sdhi_reset(struct tmio_mmc_host *host, bool preserve)
>                         sd_ctrl_write16(host, CTL_RESET_SD, 0x0001);
>                         priv->needs_adjust_hs400 = false;
>                         renesas_sdhi_set_clock(host, host->clk_cache);
> +
> +                       /*
> +                        * In case the controller works in PIO mode the SDBUF
> +                        * needs to be set as its reset value is zero.
> +                        */
> +                       renesas_sdhi_sdbuf_width(host, 16);
>                 } else if (priv->scc_ctl) {
>                         renesas_sdhi_scc_reset(host, priv);
>                 }
> --
> 2.39.2
>
