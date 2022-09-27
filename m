Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154BBC54EE9
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Sep 2022 15:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbiI0PWW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 27 Sep 2022 11:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiI0PWU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Sep 2022 11:22:20 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74204F687A
        for <linux-mmc@vger.kernel.org>; Tue, 27 Sep 2022 08:22:18 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id m4so1211465wrr.5
        for <linux-mmc@vger.kernel.org>; Tue, 27 Sep 2022 08:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=+z9Dpw8yVvI6/fHFYyPfPJKtMZ+GPJnurRnrDKgVCAg=;
        b=jvsCVhUJRGgXty6Bv9aKZeMgoeliW9pS03qjYbbzUdZJxeprV/e1G4J2mms/fUB/M5
         c2PRXi8KFJ4gIB8ovcNEkhGaqNIyB9STaplCEQQEdaj7Bdy2sjKQKkIFxZ+bZA6fH8FE
         5ZPCZoQD92PtJRaUfa03fp1nsFyNoWq/J1Bo8VYQ9bXoc5N053LJCbXlMO338/VKKiLQ
         ZAiPy+w8J9Z3e6IM+Uf5jU7WYaxGhdbmrGBEnMIUGeAdHgJy8g7iPYHEfP7EyUzHzq9m
         sX5NT0iB7qOi/29bgGlF+c0TWUEyI7yJ/bGu1yiji6ff0beRJ1co+NqTWvyrg0j8NMx6
         LTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+z9Dpw8yVvI6/fHFYyPfPJKtMZ+GPJnurRnrDKgVCAg=;
        b=ku3iO73t8qpDMo5OZkOy6kroB6gNCo1cFCTfpDVxCgwtce7GRIlPy41ohJt3HKvZvs
         4GAWmx7RA2rHvweX4GgykqA3QIdHZ6QNbzvZbkC1yC93rt631eO0ulVtdFvAA6z4INzd
         CaXWZGgJGqglLR8X1LlUZ3ZZ1Cnnd0kA8wL0smE65hf7iiFJAvGUtlxpeWEDxOyviCOF
         aDhpsVJhSUeSX1Ds6SCKHBTNPwXbZoKziJbicHfMgnJ4GAjomAVW00sBpUjby7a+kHAR
         BrxA3CpM219KLFo4dfEnmcaZCFcix9oWhbmNspJmdGaEQrmB0jj27GpODVLlarF+Ks7D
         9PrA==
X-Gm-Message-State: ACrzQf1g+tkiwaeQDD6gp/bCHK+HWpYLbXiBOSiA3LLQz4D60SsKvl98
        bQ3QPiBSEmhWNT9KaKKcPlA=
X-Google-Smtp-Source: AMsMyM6tOJdz6JT7ysgnL5x+CJx3lyewlTKDqBpjDHz1d1Kg/vYu6kigkFpIcFjQ2jrlVa+necITzw==
X-Received: by 2002:adf:f74d:0:b0:22c:bbb7:de3b with SMTP id z13-20020adff74d000000b0022cbbb7de3bmr2625868wrp.243.1664292136810;
        Tue, 27 Sep 2022 08:22:16 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id z3-20020a5d6403000000b00228c792aaaasm2031407wru.100.2022.09.27.08.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 08:22:15 -0700 (PDT)
Date:   Tue, 27 Sep 2022 17:22:13 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, pshete@nvidia.com,
        jonathanh@nvidia.com, p.zabel@pengutronix.de,
        linux-mmc@vger.kernel.org, anrao@nvidia.com, smangipudi@nvidia.com,
        kyarlagadda@nvidia.com
Subject: Re: [PATCH 3/4] mmc: sdhci: Get rid of
 SDHCI_QUIRK_RESET_CMD_DATA_ON_IOS
Message-ID: <YzMVJQVWVX0Htweb@orome>
References: <20220926192022.85660-1-adrian.hunter@intel.com>
 <20220926192022.85660-4-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2IXhxA4NS4Dtv8hj"
Content-Disposition: inline
In-Reply-To: <20220926192022.85660-4-adrian.hunter@intel.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--2IXhxA4NS4Dtv8hj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 26, 2022 at 10:20:21PM +0300, Adrian Hunter wrote:
> SDHCI_QUIRK_RESET_CMD_DATA_ON_IOS is used by only ENE controllers but can
> be replaced by driver code.
>=20
> Amend the ENE code to hook the ->set_ios() mmc host operation and do the
> reset there.
>=20
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/host/sdhci-pci-core.c | 23 ++++++++++++++++++++++-
>  drivers/mmc/host/sdhci.c          |  8 --------
>  drivers/mmc/host/sdhci.h          |  2 --
>  3 files changed, 22 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-p=
ci-core.c
> index ed53276f6ad9..63613b3d648f 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -297,6 +297,27 @@ static const struct sdhci_pci_fixes sdhci_ricoh_mmc =
=3D {
>  			  SDHCI_QUIRK_MISSING_CAPS
>  };
> =20
> +static void ene_714_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +	struct sdhci_host *host =3D mmc_priv(mmc);
> +
> +	sdhci_set_ios(mmc, ios);
> +
> +	/*
> +	 * Some (ENE) controllers misbehave on some ios operations,

Nice rewording that you snuck in there. =3D)

I just realized, after going through the patches that Ulf has already
applied this, but FWIW, the series:

Reviewed-by: Thierry Reding <treding@nvidia.com>

--2IXhxA4NS4Dtv8hj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmMzFSMACgkQ3SOs138+
s6HOdg//TEcxmhh16D/JuzewpZM70U9dZ+sUeZcMAmiHMfACbjqv1s1aH5cNDlNV
aVUbP7SiB+d02xyUnnLdzfip79zLrRRVqtNQRFOCfZcKba7n+3sy3pbXtGAsz5/t
4gptcLoYwZVvetvFdAek9A3QK1PAnA+zOnZ0B9o4l0OF+OSiTTY8Sl232lkSO7I/
U1KmMssLq49yOQOsNWqmd/cVtlezfRQLk0JQr9pmFPy9c7/VW45QOiysE0vjyNzk
f+bHMTkfan8jRxjZ42V9EGgOZ3Z8+IFAUbeVWHtDN6A4FzXMznSLNJgnmjqQyYSr
13a3P4qiryUaFbMWA1Gd2pDuXNocJaI+b/LKr7kE20szHetUwnleNmZIQacpjiUj
9Ryx+m5Anwy3/msUHSjWstZIIoSZ3C/5Cp+AsCpg0Yb1FET0Mwj3IkvLBowY3no1
6rkCfWbGyDrof3k8fsL2dkquqFIgsI+6ftUUtRFxRz/4d4NFt+sKk4AqjRSiFD4C
LZ5EUmKDeRj2bo8BQ6QbKhuo+Bxo/b1+GuVGobKt+InRMx32Up44kncY2i9E0r4u
onbm7sssRi1t5Vjkzrwy/g0umR3+xvCZ3Mgty6RBhzJJGVZlcHkR+/RUCEmfFaXE
utBSsH0XVWR6CR4yc9ZS2OoMFNzphIG7SCx9zb1pFhkjVsH+JGg=
=fag+
-----END PGP SIGNATURE-----

--2IXhxA4NS4Dtv8hj--
