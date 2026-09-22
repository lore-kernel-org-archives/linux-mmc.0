Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103E153ED17
	for <linux-mmc@vger.kernel.org>; Tue, 22 Sep 2026 12:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790078664; cv=pass; b=mK4rOUJ+J5GOVct+RR4ZbA8N7yW/9noJg1TOSUYV+h3J04jLWbssyW08TS8ZOKZ1vFcYWfGFThKa2cPFceHfeUO4COwQhzbNwjR0bqbTzkRDWI4f2Qw08XWoAMbUafPKp7fqTWAFK+nGYakCvDOu0651NMaAlXVIHSgLIqE75yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790078664; c=relaxed/simple;
	bh=saOqqMO6ORxyXnY0o31VkIfdYDLd6fh7SS1hLcwbeg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9ieBWXuMKftTZNxvp3HYkY27aJC/x1TyPIq0pbdk+xlqOk2UHOBSoxwlD75RjoK93U5bPLK4Uz6lFsBk+IOZxY4OXCSJo+BFuxpZvFASLaDlnCvIdoOiC3OxSntu/iX4tDOSl4J5mhKEHAiY24m82SLn7jfG1bpqeBtkYzUIUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=JdQU4ozc; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="JdQU4ozc"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-853e2610bb4so533379b3a.0
        for <linux-mmc@vger.kernel.org>; Tue, 22 Sep 2026 05:04:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790078662; cv=none;
        d=google.com; s=arc-20260327;
        b=nfHhJxbt3YEBmuy3o3A2a6S8B/JZmaN6s9BDeGy2aUXI3tIk+Igsf6HkgMaXHtdZnr
         zdVcXY0uSHk1H7a2olTUJDeCUA6hkJFqHMRvXKD9OsfonOW2eQbdgeuqiMg1sZHtNsU4
         B1nV0fwdHtNAqMCWBFrokLLcl75jAFwqaf3eReBYF+XIGZwkDUwgZlRCgljowl9BKp+4
         i/5SnnUfggzkXeGDeRhP4HwKoQ7hUz4JZXovIwu0p/WJNEm5mXDaho0sAIohcU8ONbuX
         r0yigqbQp2WrgwmQUB8DmVfesBdN3s00gnWGmFu8givIGwEaL53rrfSShwaCylAa/Y6t
         OPxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CUpeNq3+QaUFHKyKU5yfrM/FkR0pBOt5e12bFHIM/Rs=;
        fh=9ayxd9+zkyZu7suT/e0cd4iDkh8loR4X6noF60r2RdE=;
        b=VCFdsGax0hrSvp8kSwgV6YRXWmnyA/6UBFqeb8T8YoQNp4JbzH7YjK9vkAXAQhj/yu
         CtML5Ts5ZwCbpsFHth5JoT2IjK9ZxI5Ovb2v0CfSMO6nogXqeVr3hhhDsHSrO10ORuZA
         +hyTxox3Q17jqB+wXqfZx1EpvHzp1Q3C6Ejb7jKJlFRxf4Ewe4bI7ekHSju1LUimWnIQ
         +8nLOg/wD7P/ZwHLHsVUSNnQKrof0ONEyluUHgMPMRgsKFja01UquAC/toikMQ5cOnRk
         JApxDp7ijhFw6cTnK87haiiCfBCszAjb1qJkn6rWJ/I2vy7Lf47byUhrRdJ/GsfqPTK0
         2WDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1790078662; x=1790683462; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CUpeNq3+QaUFHKyKU5yfrM/FkR0pBOt5e12bFHIM/Rs=;
        b=JdQU4ozcJCsLbPnqyumtwe0XM0EpQs2SblMpMjsIkYAUzVeO19hHsxxu0hC+MrusyY
         0JTSVVr6aeFyuY3w4KQzreBHKue8RAC/81mH7YVBeGvtrG23EmUtxnWhwXPozDTwdzzs
         NPjumF2YIDGD5hMhtSmxY7NFsmGI1oP9yf88Gq00dSSNZk1cmtCKmHLecUmYpxtoja1Y
         zxK5MBlPrf44emPF9ei+UwLlde2bAGQFdxPVX5hzrEXPGnrikEVLKWZcpMHUxoFlm6VN
         13HtiMJDQUkG8HDnnlRmCkdYtxhEAaFynWV0vtZxxKb5rjalKZymZNrxlmKgkGh83Jj1
         +tWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790078662; x=1790683462;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CUpeNq3+QaUFHKyKU5yfrM/FkR0pBOt5e12bFHIM/Rs=;
        b=n6IUprAT56TcUBZh8jva4FdfKL79QDSQJlN3Ps1bDLJ2JKQKSr7hHmgEa2b755Uibt
         atHoG+eKhGdRm7Y5J1sMChLSvo6IS63ozun3xOUkm7iPDOYG6KUOBH7DFwbcm0l5lA7d
         rlTvEYTvUeKNYk0ThhSlQBmgQ+9AKKWMizohMHgyjzQ3U5n1FE5a3qJAJBGYSoucSrK8
         OxOPWVWcoezxmabg5nfu2AQT4oEV3vPV1wao5PAT7B1h0ZIkgo57ByT2n0MhrEo80Gfx
         JsvRh82tRecN9uTqKREUgUPMP3AZ3gcPCEMCoV5vrZ5QYh+XnNNC0PKn4CDj9tN823EZ
         ya/w==
X-Forwarded-Encrypted: i=1; AKwUvBwVWyktkWUr90FNM85zxI2uIfbeW6pN+X8ULjGQVkqti4eQqJXJDNJBy1EAokMRM4JIsg3M6Oge6xM=@vger.kernel.org
X-Gm-Message-State: AFuF++kjCmWy7axr/kR9V5ZDGtV0jlHIYo+2dJIwu0EOJwepAGHRf7nq
	CkPclwlmYbXOU2hHZ+YcjwcbmPZ0YY+n5mjd+Qp2aJDkJ+gK7dY26p+g5qU9aRg2Ie2mWqBpWXU
	4xlSRT45lqqT3zUXmSiTQvj3XYRq7Zno218SKJAGRXQ==
X-Gm-Gg: AYBFou09phtbxjSICiBTs9/i39SIbQtiWNHaIRi9shzbun+QAxu+HR+KyAEyCnUxSNh
	g652ttan+C+Eog7OuTxUsXTH/BhLdVzg42SHy+6lPf44MdyntGL9/1j/gCLnPS4/8tWF6sA4PXi
	uzTfypmlo0ol9oxz0gKoxSAqIbv4npuVLfk9yfGNyk9CsqXBxz36JXqODvw5TmlKXi0K1KvO+kY
	/XebXbNvTyK1+v6vu9P8FCYP/G6YsCi2AlUh4rBKIeewD6QZYd94D8wv7EWvbqd4PSm1/wXG31S
	fLxhkwZLdHGdBI215iTsa47wJk3na/HHdGgLp6XLAWUMY8daD2oxpym6TM3rnab1j6t6YpGookR
	aB73ioe4vQ94zMODNdRZJS99ds8zkMCqhFeU=
X-Received: by 2002:a05:6a00:3a12:b0:878:3705:5724 with SMTP id
 d2e1a72fcca58-87c85de1562mr682886b3a.48.1790078662177; Tue, 22 Sep 2026
 05:04:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918153414.909333-1-aubin.constans@microchip.com>
In-Reply-To: <20260918153414.909333-1-aubin.constans@microchip.com>
From: Robert Marko <robert.marko@sartura.hr>
Date: Tue, 22 Sep 2026 14:04:09 +0200
X-Gm-Features: AcwNN1WHiWWomoXHzFPUnhbd-xc9yh6WSNzq7MyJexGie0-v5X9TH742BS0QVU8
Message-ID: <CA+HBbNHG-hTMLSeRKAb1hz4mDna3LDmoPA6CJ_DG6_oRWZajmg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-at91: disable selectively clocks on pm runtime
To: Aubin Constans <aubin.constans@microchip.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Eugen Hristev <ehristev@kernel.org>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Romain Sioen <romain.sioen@microchip.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Ludovic Desroches <ludovic.desroches@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Ryan Wanner <ryan.wanner@microchip.com>, 
	linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 5:35=E2=80=AFPM Aubin Constans
<aubin.constans@microchip.com> wrote:
>
> From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
>
> SAMA7G5's SDMMC run-time clock disabling is not supported.
> Add support to avoid this scenario for SAMA7G5.
>
> [Amended with a fix from Romain Sioen below this line]
>
> Sama7 boards are impacted by an unbalanced prepare/unprepare
> and enable/disable clock management in sdhci driver due to
> the lack of support for SDMMC clock runtime disabling,
> managed instead by the PMC driver.
>
> Add conditions in the preset function to manage clock
> depending on if the board support runtime clock disabling
> and if we come from the probing or restoring procedure.
>
> Add boolean start_clks variable to manage condition
> in preset function.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Co-developed-by: Romain Sioen <romain.sioen@microchip.com>
> Signed-off-by: Romain Sioen <romain.sioen@microchip.com>
> Signed-off-by: Aubin Constans <aubin.constans@microchip.com>

Tested-by: Robert Marko <robert.marko@sartura.hr>

> ---
>  drivers/mmc/host/sdhci-of-at91.c | 36 ++++++++++++++++++++++++--------
>  1 file changed, 27 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of=
-at91.c
> index 7c4ac65f247d..399856643e57 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -39,6 +39,7 @@ struct sdhci_at91_soc_data {
>         const struct sdhci_pltfm_data *pdata;
>         bool baseclk_is_generated_internally;
>         unsigned int divider_for_baseclk;
> +       bool pm_runtime_disable_clks;
>  };
>
>  struct sdhci_at91_priv {
> @@ -149,12 +150,14 @@ static const struct sdhci_pltfm_data sdhci_sama5d2_=
pdata =3D {
>  static const struct sdhci_at91_soc_data soc_data_sama5d2 =3D {
>         .pdata =3D &sdhci_sama5d2_pdata,
>         .baseclk_is_generated_internally =3D false,
> +       .pm_runtime_disable_clks =3D true,
>  };
>
>  static const struct sdhci_at91_soc_data soc_data_sam9x60 =3D {
>         .pdata =3D &sdhci_sama5d2_pdata,
>         .baseclk_is_generated_internally =3D true,
>         .divider_for_baseclk =3D 2,
> +       .pm_runtime_disable_clks =3D true,
>  };
>
>  static const struct of_device_id sdhci_at91_dt_match[] =3D {
> @@ -164,7 +167,7 @@ static const struct of_device_id sdhci_at91_dt_match[=
] =3D {
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_at91_dt_match);
>
> -static int sdhci_at91_set_clks_presets(struct device *dev)
> +static int sdhci_at91_set_clks_presets(struct device *dev, bool start_cl=
ks)
>  {
>         struct sdhci_host *host =3D dev_get_drvdata(dev);
>         struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> @@ -174,7 +177,14 @@ static int sdhci_at91_set_clks_presets(struct device=
 *dev)
>         unsigned int                    gck_rate, clk_base_rate;
>         unsigned int                    preset_div;
>
> -       clk_prepare_enable(priv->hclock);
> +       /*
> +        * Manage clock prepare/enable procedure depending on if the boar=
d
> +        * support runtime clock disabling and if we come from the probin=
g
> +        * or restoring procedure (for backup+self refresh).
> +        */
> +       if (start_clks)
> +               clk_prepare_enable(priv->hclock);
> +
>         caps0 =3D readl(host->ioaddr + SDHCI_CAPABILITIES);
>         caps1 =3D readl(host->ioaddr + SDHCI_CAPABILITIES_1);
>
> @@ -223,8 +233,11 @@ static int sdhci_at91_set_clks_presets(struct device=
 *dev)
>         writew(SDHCI_AT91_PRESET_COMMON_CONF | preset_div,
>                host->ioaddr + SDHCI_PRESET_FOR_DDR50);
>
> -       clk_prepare_enable(priv->mainck);
> -       clk_prepare_enable(priv->gck);
> +       /* Same clock management as for hclock */
> +       if (start_clks) {
> +               clk_prepare_enable(priv->mainck);
> +               clk_prepare_enable(priv->gck);
> +       }
>
>         return 0;
>  }
> @@ -254,9 +267,11 @@ static int sdhci_at91_runtime_suspend(struct device =
*dev)
>         if (host->tuning_mode !=3D SDHCI_TUNING_MODE_3)
>                 mmc_retune_needed(host->mmc);
>
> -       clk_disable_unprepare(priv->gck);
> -       clk_disable_unprepare(priv->hclock);
> -       clk_disable_unprepare(priv->mainck);
> +       if (priv->soc_data->pm_runtime_disable_clks) {
> +               clk_disable_unprepare(priv->gck);
> +               clk_disable_unprepare(priv->hclock);
> +               clk_disable_unprepare(priv->mainck);
> +       }
>
>         return 0;
>  }
> @@ -269,7 +284,7 @@ static int sdhci_at91_runtime_resume(struct device *d=
ev)
>         int ret;
>
>         if (priv->restore_needed) {
> -               ret =3D sdhci_at91_set_clks_presets(dev);
> +               ret =3D sdhci_at91_set_clks_presets(dev, priv->soc_data->=
pm_runtime_disable_clks);
>                 if (ret)
>                         return ret;
>
> @@ -277,6 +292,9 @@ static int sdhci_at91_runtime_resume(struct device *d=
ev)
>                 goto out;
>         }
>
> +       if (!priv->soc_data->pm_runtime_disable_clks)
> +               goto out;
> +
>         ret =3D clk_prepare_enable(priv->mainck);
>         if (ret) {
>                 dev_err(dev, "can't enable mainck\n");
> @@ -344,7 +362,7 @@ static int sdhci_at91_probe(struct platform_device *p=
dev)
>                 return dev_err_probe(&pdev->dev, PTR_ERR(priv->gck),
>                                      "failed to get multclk\n");
>
> -       ret =3D sdhci_at91_set_clks_presets(&pdev->dev);
> +       ret =3D sdhci_at91_set_clks_presets(&pdev->dev, true);
>         if (ret)
>                 return ret;
>
> --
> 2.43.0
>


--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
