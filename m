Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F0A1A0B0E
	for <linux-mmc@vger.kernel.org>; Tue, 13 Oct 2026 12:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791894828; cv=pass; b=oCXnTH/ywYOrTdDOxcQijfW3OV2JvRrb1egO0BzMdvrTM+9Cddb18sJb5Vk42j+VWIMIpogN2vDq/JJM7ie6gHcnH9Gq+H6CMH1RfE3xLQ5mBh+GEDt8/JasDbEqEiXsvm3fPkEay78x4CCCJAYOu+EM0+cHwiBofkVC1lg2DI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791894828; c=relaxed/simple;
	bh=malNc4Z8Q/D3ZpIXlgQO3mA291yVDUA9+s/OmI4RFs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gGeOFivfAJsX3qQDWsiJQU+bXjt3KVDGVQpa+J6WxXhy5rEEc7tyIwSAXt4XD/JhY54NxLuaXc4qkFA0FrjV6C498zb7aTeWo56vsJ7aR+3sVjEPlwsf6tIZ4vtw8F9mmDT+Uw4Fr+G6nS6OA6CRjTz6Zbjr8bp4rIJ21oAumjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=gIBKfAmP; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="gIBKfAmP"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ab41538192so2050000a91.0
        for <linux-mmc@vger.kernel.org>; Tue, 13 Oct 2026 05:33:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791894825; cv=none;
        d=google.com; s=arc-20260327;
        b=SRoreup67CcZqoGx3jn1G8he9MTEu1Myd/J82aegkMi/PGSHZZ5EZYLYya3AscAozz
         l1WZ+U+hFY/auLlZTMlZD6LgWw4xc0uUeT4YMYlK5tVHWsX1K7/Gf4makfbmGL6Usn0J
         Ljzmf0NtjayiTzpk7uasJhJhZG2HZUjzxXazBvXm2UErq+BFGHA6msWgCRqu9hUYMxz9
         laCMsaR5UNvLSThoYIttUF7xyizSKZyzB4iT88rKrV5ajOYHljtLDSLhYdmwZZt4J2su
         5AnO5U/g6FzUU/ruE3AC7m4tjVbzEZAcSJRkEK1RsEcCXJr2xpOigpX8zqANuo9dPgE0
         p8gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0BcRktes/U5lVo22Fcl1qWv50r+fNV+F5WhzGJEWnCY=;
        fh=67VkE9nP/lYpWUIOLIppyzww0xqn/IRbxRwXqJpWtSQ=;
        b=M/A0z6nEPY9XakLbaxf8swWHX69+mSwul27xlbbwXFyPJXwno7u5k64kDdppu21u1v
         +jpvRhcZsTG2dh9FLL2hJtanYonK2ZHDwoZxE+nKTT+3L2WZe5TamlgDIaf+O3HizaHo
         +G+egGmlPvne8v7WryjHvP7MW95ynS8HRqRE3STgkAUIjiT2G155kGEs6u02C0AYD3Fa
         PUMF7lfE92ZejPhPCTr1DbtSNTULdXPym5nFYpR08tZ9p+3hORgGQHojOA5v5xkY//VD
         BnDSBypnkKqrroC4KW2g6cjBWh85L5nKTG5uYUFKSZ8Rv9nz/FAbhLl4+q6BC2sd0lTy
         sYng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1791894825; x=1792499625; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0BcRktes/U5lVo22Fcl1qWv50r+fNV+F5WhzGJEWnCY=;
        b=gIBKfAmP56mxPQIp8PGfxnufePCCVaHJhdXFJvsP731MWa26QaAKUKgTRM6ww03p93
         4myXV0bby8j7/vsbHfJK+5LKj7ubcHjmZfU4jZBf74vacA+rID7yhxfv3j/tkr7oTteX
         wJ+wSUuGwkFmYVD7CDDgvbX2Zcd12/P3L0TZDMZlaaXY3mv0rcYmHa8cS93WlRqv/Cwx
         xLIQhawdwzbIZCt0JqCGbAgXpnuBTXctz8fGU1zBD708KlX4Tj6JFVuykx1/bwkhUK6u
         8ASQVb8MMsyxthH826ejYaOQNwuaROL/EfP9Uxmc4fou3Fyk9CbW/dbloqkHmqpUk2xx
         9eBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791894825; x=1792499625;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0BcRktes/U5lVo22Fcl1qWv50r+fNV+F5WhzGJEWnCY=;
        b=upt/PfDZVOwwtExh6wPbdeU0a3/BxDIY/rdqw7sdAT/V6BaKbtY4ztrRBO3a/iM53B
         UMm1HHEa5b/AWt9FgGmRlB2IE4MxHaZpMuHzJJOobs9H0xLtweqEZoyfpR/pE1hEPVPB
         593AQrye/4KK49+R0njolEkypdCrALr8e2xxH7598B1TR+kgc+C74tGhLcIKGr7utLS2
         rw8voHGAJ6Jwtp+frpvwET24ERihk9DnYiRBUVcJG3fXAljgdm2B3uF4ovuXUx8s5NOp
         0OeDT9ZQC2UKRCNsfmhAph5bBTLH1fqiJpkTGXUM4FbVALQHLnX+u1v/IEkWeE3uFDlF
         RpTg==
X-Forwarded-Encrypted: i=1; AKwUvBx5Fr+7WBnyco+hKdfAeE/S8gbW/kfZtQ/79jF/8mVe9GjXyitUUiBJTl3hh1TV/J05dkTdxH6qkWs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIv4Y3K7XwFKlOZ49YAdf9Nfl32AQxr+cAcmZkr31SdK5YBKOWi
	DQdBLLrGx5tEoYl5hgj2DxN8QLqSW+Yhg8HblGVYFbwE+1xSvFtY/+XvSQDCEQ3rzIcYMRM59Hm
	dWkpJxtXtfCW1v9pL46mtiUkqnGclaW4kM9O4tRhr8g==
X-Gm-Gg: AYBFou1BnrD4xcEjLJVhi3bRN9enxzerBGJhvH4HCGQqyVIz87TlCgAayxYFBdEKxUl
	E72CTXG6QpwSuJyX2K84xGYilvCVXzNCWDebdvejK8b/DLpoZ9XzWK+vWDGg8EIO95O+oUVF2fk
	OBZjTwa/8MtHAWXAe7iWBwmF5TKf0f1DKiKl3HPo0IRkl9C+oh54vT4Fe0UH2PdbUmzC/gfSSR1
	n7po+MT8Jc6es9/ODcnMaeqU1NkJ79VLap2sLZ13yP05jghv0PKBH85scBRD+FjjI/0ZXsC6qx6
	0gyq4f4K0RWXPjzLfQHTbZ+luBytAUj0ue283Ke9wA3Yjhn3lyITBTET4qnY8xUAN5IUty5PtOw
	0umxayNkc/S8PJQf9FF6FY10An3gvus4to3vW6imaku2egg==
X-Received: by 2002:a17:90b:2688:b0:3a4:adea:50ad with SMTP id
 98e67ed59e1d1-3ab3a775938mr10437579a91.27.1791894825280; Tue, 13 Oct 2026
 05:33:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918153414.909333-1-aubin.constans@microchip.com> <e75041b4-8450-43f6-bf6d-35a31812f8e1@intel.com>
In-Reply-To: <e75041b4-8450-43f6-bf6d-35a31812f8e1@intel.com>
From: Robert Marko <robert.marko@sartura.hr>
Date: Tue, 13 Oct 2026 14:33:34 +0200
X-Gm-Features: AclHuK-ahRr2oJBzP7-hAKuKrqD2xh13uJApDX2EwOd8IrbrNAm5T9Br4ypdnAk
Message-ID: <CA+HBbNF59tx+FhWke_Q8ie9O5_4RrPPPJm=iALiBKQb0Tp8ChQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-at91: disable selectively clocks on pm runtime
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Aubin Constans <aubin.constans@microchip.com>, Ulf Hansson <ulfh@kernel.org>, 
	Eugen Hristev <ehristev@kernel.org>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Romain Sioen <romain.sioen@microchip.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Ludovic Desroches <ludovic.desroches@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Ryan Wanner <ryan.wanner@microchip.com>, 
	linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 4:35=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 18/09/2026 18:34, Aubin Constans wrote:
> > From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> >
> > SAMA7G5's SDMMC run-time clock disabling is not supported.
> > Add support to avoid this scenario for SAMA7G5.
> >
> > [Amended with a fix from Romain Sioen below this line]
> >
> > Sama7 boards are impacted by an unbalanced prepare/unprepare
> > and enable/disable clock management in sdhci driver due to
> > the lack of support for SDMMC clock runtime disabling,
> > managed instead by the PMC driver.
> >
> > Add conditions in the preset function to manage clock
> > depending on if the board support runtime clock disabling
> > and if we come from the probing or restoring procedure.
> >
> > Add boolean start_clks variable to manage condition
> > in preset function.
>
> The commit message is a little confusing.  There is no functional
> change yet - this is just preparation, right?  But it reads like
> it is making it work for SAMA7G5.  Please make that clearer in
> the commit message.

Its just preparation, I posted the series for LAN969x which requires the sa=
me so
Aubin posted the Microchip tested commit that SAMA7G5 will also use.

I am waiting on this to post the v3 of LAN969x support.

Regards,
Robert

>
> >
> > Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> > Co-developed-by: Romain Sioen <romain.sioen@microchip.com>
> > Signed-off-by: Romain Sioen <romain.sioen@microchip.com>
> > Signed-off-by: Aubin Constans <aubin.constans@microchip.com>
> > ---
> >  drivers/mmc/host/sdhci-of-at91.c | 36 ++++++++++++++++++++++++--------
> >  1 file changed, 27 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-=
of-at91.c
> > index 7c4ac65f247d..399856643e57 100644
> > --- a/drivers/mmc/host/sdhci-of-at91.c
> > +++ b/drivers/mmc/host/sdhci-of-at91.c
> > @@ -39,6 +39,7 @@ struct sdhci_at91_soc_data {
> >       const struct sdhci_pltfm_data *pdata;
> >       bool baseclk_is_generated_internally;
> >       unsigned int divider_for_baseclk;
> > +     bool pm_runtime_disable_clks;
> >  };
> >
> >  struct sdhci_at91_priv {
> > @@ -149,12 +150,14 @@ static const struct sdhci_pltfm_data sdhci_sama5d=
2_pdata =3D {
> >  static const struct sdhci_at91_soc_data soc_data_sama5d2 =3D {
> >       .pdata =3D &sdhci_sama5d2_pdata,
> >       .baseclk_is_generated_internally =3D false,
> > +     .pm_runtime_disable_clks =3D true,
> >  };
> >
> >  static const struct sdhci_at91_soc_data soc_data_sam9x60 =3D {
> >       .pdata =3D &sdhci_sama5d2_pdata,
> >       .baseclk_is_generated_internally =3D true,
> >       .divider_for_baseclk =3D 2,
> > +     .pm_runtime_disable_clks =3D true,
> >  };
> >
> >  static const struct of_device_id sdhci_at91_dt_match[] =3D {
> > @@ -164,7 +167,7 @@ static const struct of_device_id sdhci_at91_dt_matc=
h[] =3D {
> >  };
> >  MODULE_DEVICE_TABLE(of, sdhci_at91_dt_match);
> >
> > -static int sdhci_at91_set_clks_presets(struct device *dev)
> > +static int sdhci_at91_set_clks_presets(struct device *dev, bool start_=
clks)
> >  {
> >       struct sdhci_host *host =3D dev_get_drvdata(dev);
> >       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> > @@ -174,7 +177,14 @@ static int sdhci_at91_set_clks_presets(struct devi=
ce *dev)
> >       unsigned int                    gck_rate, clk_base_rate;
> >       unsigned int                    preset_div;
> >
> > -     clk_prepare_enable(priv->hclock);
> > +     /*
> > +      * Manage clock prepare/enable procedure depending on if the boar=
d
> > +      * support runtime clock disabling and if we come from the probin=
g
> > +      * or restoring procedure (for backup+self refresh).
> > +      */
> > +     if (start_clks)
> > +             clk_prepare_enable(priv->hclock);
> > +
> >       caps0 =3D readl(host->ioaddr + SDHCI_CAPABILITIES);
> >       caps1 =3D readl(host->ioaddr + SDHCI_CAPABILITIES_1);
> >
> > @@ -223,8 +233,11 @@ static int sdhci_at91_set_clks_presets(struct devi=
ce *dev)
> >       writew(SDHCI_AT91_PRESET_COMMON_CONF | preset_div,
> >              host->ioaddr + SDHCI_PRESET_FOR_DDR50);
> >
> > -     clk_prepare_enable(priv->mainck);
> > -     clk_prepare_enable(priv->gck);
> > +     /* Same clock management as for hclock */
> > +     if (start_clks) {
> > +             clk_prepare_enable(priv->mainck);
> > +             clk_prepare_enable(priv->gck);
> > +     }
> >
> >       return 0;
> >  }
> > @@ -254,9 +267,11 @@ static int sdhci_at91_runtime_suspend(struct devic=
e *dev)
> >       if (host->tuning_mode !=3D SDHCI_TUNING_MODE_3)
> >               mmc_retune_needed(host->mmc);
> >
> > -     clk_disable_unprepare(priv->gck);
> > -     clk_disable_unprepare(priv->hclock);
> > -     clk_disable_unprepare(priv->mainck);
> > +     if (priv->soc_data->pm_runtime_disable_clks) {
> > +             clk_disable_unprepare(priv->gck);
> > +             clk_disable_unprepare(priv->hclock);
> > +             clk_disable_unprepare(priv->mainck);
> > +     }
> >
> >       return 0;
> >  }
> > @@ -269,7 +284,7 @@ static int sdhci_at91_runtime_resume(struct device =
*dev)
> >       int ret;
> >
> >       if (priv->restore_needed) {
> > -             ret =3D sdhci_at91_set_clks_presets(dev);
> > +             ret =3D sdhci_at91_set_clks_presets(dev, priv->soc_data->=
pm_runtime_disable_clks);
> >               if (ret)
> >                       return ret;
> >
> > @@ -277,6 +292,9 @@ static int sdhci_at91_runtime_resume(struct device =
*dev)
> >               goto out;
> >       }
> >
> > +     if (!priv->soc_data->pm_runtime_disable_clks)
> > +             goto out;
> > +
> >       ret =3D clk_prepare_enable(priv->mainck);
> >       if (ret) {
> >               dev_err(dev, "can't enable mainck\n");
> > @@ -344,7 +362,7 @@ static int sdhci_at91_probe(struct platform_device =
*pdev)
> >               return dev_err_probe(&pdev->dev, PTR_ERR(priv->gck),
> >                                    "failed to get multclk\n");
> >
> > -     ret =3D sdhci_at91_set_clks_presets(&pdev->dev);
> > +     ret =3D sdhci_at91_set_clks_presets(&pdev->dev, true);
> >       if (ret)
> >               return ret;
> >
>


--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
