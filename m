Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE8F25A350
	for <linux-mmc@vger.kernel.org>; Fri, 10 Oct 2025 07:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760082695; cv=none; b=OqQsWtbIe9ri8KVY/af3hyWYGFTtRqjGGuTEU2yWBo9NlbAULNF0P+TfvT/BmJuPxFxT4kc4JtM3nPN+EHGF2uWOvnuJW9nTlMb7Gvr8AA4yjtXQ4dITwhKe26VIcabXwwyZ+W6/9UraEuFUJEYr+XbjVieBs3ka+HxlL9Rkv7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760082695; c=relaxed/simple;
	bh=tt49xrXtVpFHvrmaE8g0BGY+WJGnGApCCdck7Gjl4Og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SSH4KGRT3gr7Jb2w5yYEM99PSRPK5/pDn6RcBm9LmHniIiWYUPUpZ/2aidtaxZ/pm2ALyRsGpcEJb+IWZfyLMD05MTljLcRz4b/S8l5NDbLiL/47Q+Hvc3j1P8YN5XV+7zPb0Hd6XlNvUraS7jv17BX403RDW787fyxW/TG/6zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-54aa0792200so1206295e0c.3
        for <linux-mmc@vger.kernel.org>; Fri, 10 Oct 2025 00:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760082693; x=1760687493;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3tf1CQi/sgE81q0/fyoZiILag+XYr+CL6lgyll+N0TY=;
        b=FDejPzaB7rEE3zvQGvCuvFZZ2pFHweKu3sEWsQqyY8UQGYErzi2u7ZBfJWyP8I8FE9
         m7UQLrL9bPzvN6JZy2XXAtJNYCBtxYHMvqSXR+Z9C0+I2mCeRMJhZrpaT794blVQu0LF
         s/xEmDMCKkGV9Yiaj0fq1z72ahasLTwKHShFoBOCXQXF6F5SnbJ00oKBpwv8YcDucfVy
         gYBDfFy11BULhOsC8/AEe7hNzwvLU3w3ZFoNJfxSXWX81swaXlIeLfGH/2lmUjbkTMjZ
         lzbRse8DZdGOQ/sHKKMjzAUcHfB40L2faCpTuQdq+vMEqy39F95ROPQdzty6v7bKCioY
         mQGA==
X-Forwarded-Encrypted: i=1; AJvYcCVl5YSRcanPe5u4j87IbcNrKHgWwLRpA+z1Fswuvyq1Se8WG4cy1dyZ2Y6qRpzvyqxps0OWV7ISUv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT73AY+5bMJgqy2Ux14Nqmef2fp5NjK5tEk/QA+GvKqSmXDWSw
	Vg/HY7tThj5D6RRNl2nK7ncLU+1X9xIcEXTD4l0wKyfBaslOyhWcdH3ORwQbbHcY
X-Gm-Gg: ASbGncvkRIWRfTlkWjFNB7MJacX5Lltgy/O3w2ZpqP6lU2g8ts42XuIFTN9QrB4MbXw
	yo3QCb4MOVhHGqYR7r/dogvmT7SGMo1vr0yqeoHb5Eso2PMzMpjOeDYu0Tw6mixHrqgZwh+Lq9r
	WuZoaR9F9MCFlEw+DicaDto2dmdAIBRIvCvuv2LQ6bntIC0VGDOIj6EDTindD3SmJALyRns4aPF
	NJRGGqCIVkrS8LyAAV62+GUVZmkbtB6YiFN+D94d5DCeYB5c2CxOkiMEoqDDghl8ymhHQxyqDNc
	D+JFhhkZ8AY6kjxN4rL4QCb7cwrNF1VgVP8G3cBRlVqk8hfHsVrRZqjieQZZBJSzmqnaqcSHYmQ
	Rww5JVyRPVL1wqBHNFs9oMeHdMUU+VrBDKSL0fLMjq87NcEHuSExqQbLpSWMzDczaZ4lbFxR6ve
	O1QRM=
X-Google-Smtp-Source: AGHT+IHRgc6pUKZtbeuAjgnu5y7P1SH1atVO/WTqS5RBNA4wUDvEOnoJC80I46xwSeTPPN5GQ7bwUA==
X-Received: by 2002:a05:6122:4592:b0:549:f04a:6eb3 with SMTP id 71dfb90a1353d-554b8b95420mr4469455e0c.9.1760082692826;
        Fri, 10 Oct 2025 00:51:32 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d7f01e3fsm544214e0c.7.2025.10.10.00.51.32
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 00:51:32 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-556f7e21432so1637115137.2
        for <linux-mmc@vger.kernel.org>; Fri, 10 Oct 2025 00:51:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVONOMA/7adFTvRVwZI3Udmsfg5xpxWaaMqL/X6sVnZJBniK3BzO4bitVeYO4fzANrhz/lZOlqCF14=@vger.kernel.org
X-Received: by 2002:a05:6102:4189:b0:59c:5e29:dd8d with SMTP id
 ada2fe7eead31-5d5e2357eadmr5268262137.28.1760082692002; Fri, 10 Oct 2025
 00:51:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008042526.3312597-1-claudiu.beznea.uj@bp.renesas.com> <20251008042526.3312597-2-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20251008042526.3312597-2-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 10 Oct 2025 09:51:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW__Nw=oViQSPUb6zKbwRjXC7+6kUevHi1GzTTxrHxKkg@mail.gmail.com>
X-Gm-Features: AS18NWB-cVB-iwvWk7EDZu1kqM52AbtETFWL0OEi3TyJ5GDM7sXgbpoJi74-NbE
Message-ID: <CAMuHMdW__Nw=oViQSPUb6zKbwRjXC7+6kUevHi1GzTTxrHxKkg@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: renesas_sdhi: Deassert the reset signal on probe
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: wsa+renesas@sang-engineering.com, ulf.hansson@linaro.org, 
	p.zabel@pengutronix.de, linux-mmc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Claudiu,

On Fri, 10 Oct 2025 at 07:06, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Deassert the reset signal of the SDHI controller during probe to avoid
> relying on the previous bootloaders. Without deasserting the reset signal,
> the SDHI controller will not function.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -1103,7 +1103,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
>         if (IS_ERR(priv->clk_cd))
>                 return dev_err_probe(&pdev->dev, PTR_ERR(priv->clk_cd), "cannot get cd clock");
>
> -       priv->rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
> +       priv->rstc = devm_reset_control_get_optional_exclusive_deasserted(&pdev->dev, NULL);

Note that this has the side effect of asserting reset again on probe
failure or unbind.  Also on SoCs that boot with reset already deasserted
(e.g. R-Car).  I don't know if that would be a problem.

>         if (IS_ERR(priv->rstc))
>                 return PTR_ERR(priv->rstc);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
