Return-Path: <SRS0=PvXF=7E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791ACC433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 22 May 2020 12:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54921206F6
	for <linux-mmc@archiver.kernel.org>; Fri, 22 May 2020 12:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6yVQ1Kx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbgEVM0v (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 May 2020 08:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbgEVM0v (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 May 2020 08:26:51 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA369C061A0E;
        Fri, 22 May 2020 05:26:50 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id l21so12810524eji.4;
        Fri, 22 May 2020 05:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/d/N+iY2vi2oOOegKYz1lfxX7C31LAb0x1+2j8xtYc4=;
        b=c6yVQ1Kx/FjCjuiE19vDvj+D8R39o2+KtQ6JkkjLiL9+43cajWhiwIZ5LEm3tQoehn
         TP8bqAyZbbTnBul63cNDGo+JOz5FAbktVU+LAJFii927GwzIylK4ZFdZFKQg6XpyeKhL
         uXjGvWmRYZDX0gslNgLDj24Vo6AosWSCaX942y0nraMkU3bJs3G4+UsbnQgLVhqG3bTD
         U3HKloWtZXyTZChF0yYqlh00wVeMsdLm6T1NM4KSxpVp+5UNKtFdFfQij4qpdshuC1b1
         QGYf9pV+dPCGFdpnmjYbX3ygqZWrGEwb5oBSQbYXKefyZhylJQzLGZfurX4hVkn2h7J4
         GobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/d/N+iY2vi2oOOegKYz1lfxX7C31LAb0x1+2j8xtYc4=;
        b=Xfas6N+nViLm6lavM8n1jGyTl/UFSonFG+STKsFEflvgWtKbb8bYwDt8PfDFsNYlDO
         FqSh7HOypDfCbcuDGPlZsWRZUySED9RFx9GiK+PIfMRz7w7WpjE4vtoUuynsd6xC5p6u
         ND305qjGlrsjHer8nePFSPI5IiHNfQ6U8I4r9ax+3BwEvHMfREwAFhumuMWxCXYBPXNo
         stWIl1E0nNVkK51xIILj2zyFKxdDcXUzjTp/stQcst9TgJxoxT/jMJswA5/bxCuteFeu
         CNfRe5i54tIhYwDJyEDy8Su//dvmrw2c/Kfqp+CBd7Odaydz/KQKOQ7fbhL32Z0wwxKz
         /7Fw==
X-Gm-Message-State: AOAM530xxcKuHZC2hOxXXuStGzca6E/zfsbZsRHm+fZuy3EYvVp9ur1M
        jj0nBCY43q8OTVUytpm39dGiSQbD
X-Google-Smtp-Source: ABdhPJwha6Ty5DEDnbwo7UrQnYUXwATtXJwCkl/VPb13J0Kq5MRaAjnSfNDmf1MMKK32s2WekX9j1g==
X-Received: by 2002:a17:906:2dc8:: with SMTP id h8mr8313224eji.108.1590150409343;
        Fri, 22 May 2020 05:26:49 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
        by smtp.gmail.com with ESMTPSA id 93sm7262983edy.49.2020.05.22.05.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 05:26:45 -0700 (PDT)
Date:   Fri, 22 May 2020 14:26:44 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        jonathanh@nvidia.com, digetx@gmail.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH] sdhci: tegra: Avoid reading autocal timeout values when
 not applicable
Message-ID: <20200522122644.GE2163848@ulmo>
References: <1590005337-1087-1-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SWTRyWv/ijrBap1m"
Content-Disposition: inline
In-Reply-To: <1590005337-1087-1-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--SWTRyWv/ijrBap1m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2020 at 01:08:57PM -0700, Sowjanya Komatineni wrote:
> When auto calibration timeouts, calibration is disabled and fail-safe
> drive strength values are programmed based on the signal voltage.
>=20
> Different fail-safe drive strength values based on voltage are
> applicable only for SoCs supporting 3V3 and 1V8 pad controls.
>=20
> So, this patch avoids reading these properties from the device tree
> for SoCs not using pad controls and the warning of missing properties
> will not show up on these SoC platforms.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 57 ++++++++++++++++++++++++------------=
------
>  1 file changed, 33 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegr=
a.c
> index 3e2c510..141b49b 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -605,6 +605,39 @@ static void tegra_sdhci_parse_pad_autocal_dt(struct =
sdhci_host *host)
>  		autocal->pull_down_1v8 =3D 0;
> =20
>  	err =3D device_property_read_u32(host->mmc->parent,
> +			"nvidia,pad-autocal-pull-up-offset-sdr104",
> +			&autocal->pull_up_sdr104);
> +	if (err)
> +		autocal->pull_up_sdr104 =3D autocal->pull_up_1v8;
> +
> +	err =3D device_property_read_u32(host->mmc->parent,
> +			"nvidia,pad-autocal-pull-down-offset-sdr104",
> +			&autocal->pull_down_sdr104);
> +	if (err)
> +		autocal->pull_down_sdr104 =3D autocal->pull_down_1v8;
> +
> +	err =3D device_property_read_u32(host->mmc->parent,
> +			"nvidia,pad-autocal-pull-up-offset-hs400",
> +			&autocal->pull_up_hs400);
> +	if (err)
> +		autocal->pull_up_hs400 =3D autocal->pull_up_1v8;
> +
> +	err =3D device_property_read_u32(host->mmc->parent,
> +			"nvidia,pad-autocal-pull-down-offset-hs400",
> +			&autocal->pull_down_hs400);
> +	if (err)
> +		autocal->pull_down_hs400 =3D autocal->pull_down_1v8;
> +
> +	/*
> +	 * Different fail-safe drive strength values based on the signaling
> +	 * voltage are applicable for SoCs supporting 3V3 and 1V8 pad controls.
> +	 * So, avoid reading below device tree properies for SoCs that don't
> +	 * have NVQUIRK_NEEDS_PAD_CONTROL.
> +	 */
> +	if (!(tegra_host->soc_data->nvquirks & NVQUIRK_NEEDS_PAD_CONTROL))
> +		return;

Hm... so what exactly is the difference between NVQUIRK_HAS_PADCALIB? I
think Tegra30 will also end up calling tegra_sdhci_set_padctrl(), but it
will then write the default (0) value for these drive strength. Is that
okay?

Thierry

--SWTRyWv/ijrBap1m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7HxQIACgkQ3SOs138+
s6ECKQ/+MUyZimUTr+GNyYhG0txsozb2smT7J9qvfa3wFzJQt8aO9n84YGm4Hlng
V6xRd8ZOd96YaY05+gWu9CUiymbHSNQISxCb2K1IghSf+LNJcMxQQMAnEnhgtHHF
LaAR5bZtaaSxvxE3ToKP9cJkRjMgwYloEEaK+voYD+PPSzltvr3juqJe8SxDQKy/
1Kc64KUbdYA7xFjMCZzDJ6mdNkZ5P74p7ftp7mfjhI4cTIVy62YGQuaQOmLpb7Sc
4NthQrnlM64CZyD9okaqpArOw5hthoSQUD+vBGVEUCnyM6SBUmHZegSkxP51YJuF
x6ehf/ubBhc0YbviwSPW/ErmY1wp/w/FWM6P+j4sryxRoTMPuGcj25Pw7ZQa3VGz
NPtpMZLedcdftFSfUmqfuAUZ2wVMQEU1acm2lLNZMTtziICudTYfuivu4l6a7tf4
nm0MGXiqjaGq1V2uafvzBEBGlTapRKLWFUQSb9mlL6xKh3KMQQunrUEg4uJaxk3V
MAOHVWw8Igp3xC+DDUe9TuF7/RtwNiD1TiRQTiJgM4l0GbCShgP9iOJ2aN7vA2QR
fUL6aULacD6eoT1HNE78TQjhqNddT5F5zuA6jETEJedUitUPmzHYKy8XITli0hTi
VtsGGz9DVDvAkUhkQ9eKmsQFkJGYT5je7yRzOjpokZim2xSZg8A=
=npis
-----END PGP SIGNATURE-----

--SWTRyWv/ijrBap1m--
