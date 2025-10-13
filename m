Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3302F9DAE
	for <linux-mmc@vger.kernel.org>; Mon, 13 Oct 2025 08:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760345110; cv=none; b=qduIkwffgLnwCJAXwVOZANO6DP6jckj13EqM6wDlWqARpXGaydo+QxDX86Bm60lEXKOazOTmkg3Vsl0SeMIqnIj28feRDFYwDPfwxgTe9oDoCtmc8j0PGVKDs8rpKbt18wTRniDLD0hHTQAIuM5ct1pfqCpKZjlurWX/yycHK3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760345110; c=relaxed/simple;
	bh=HKD1fgO6NWzojLQZEubDCaixzo3Vwrd7JG1LXMQLFcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtmmCm1tXFq/cKnw6ZD8wLu8mG3bo7+DIUYDkt3HaCEQPLyR7ta4QdFMa2z5bt30UJmiervqj2RixUTnf3OSEibsOCjf56LF5tuzIX3m0svPTZIEPMXMu3VwM9+PkG6NrKT2WrG1/yvMauHxtt/NRUB9IqlmurXdPDsSPjqslR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RG+ZVSCq; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RG+ZVSCq"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e326e4e99so23465245e9.1
        for <linux-mmc@vger.kernel.org>; Mon, 13 Oct 2025 01:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760345106; x=1760949906; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QOxheHOLbGrsxmRfqAHNSm9zz+n+Lcr4l/MDPg24sBo=;
        b=RG+ZVSCqtFFZlctgbbvMAxJJjRQOr7xLKsDPkGw/AKVSaKnrmjgUhQ0r5oWWyhB+Y8
         ClMs7yX5yoRHPBuecd8KyNXFuQTbbGjpHn+KS2X4FMY6XLgcfSHL9OFyQSzbtxdZr9HQ
         Si4dtnFPxnoJuS3nJIlOulDgJt4drTuV13+b3WKfbF04n50cZT8wUjJiHCRLmr8fEuJC
         5WByERsUCxehPO61Y0V86eYnIir+XN1V33tw4OcyyrUCHOi/JPWUolv8FAtAQS+TEmHj
         AIkasLbsdCwbipBa8rbf1/Brwo0oVHIqyc6zKzWYaFSq4KYF9vf4FqeZTXJDKqvPIYod
         RSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760345106; x=1760949906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOxheHOLbGrsxmRfqAHNSm9zz+n+Lcr4l/MDPg24sBo=;
        b=PuH2vF5Q0qsELVKcidOP3uH0XO3GMonNMnxn5GL+FL38D8ZfnFyXbrT+O7Ny27I6Nb
         ZUfPd3Y1d3WV72LvnWPcOdscDACvyyeYkluZ05DqUuaXh/TelfXORYCR83v5f3GHqJ7r
         ehpVpfYdolsRov75GnfWbg5BWlGfhGRSlaXjunJPa35vEWSWlmkqdIZlNHPsBrGL4J14
         5UTNcCbPfuRktIiUEitRBCwrNLmE7JriDy85Cvs7FBkZZMrqr4d3mPw7QctIsxWCE/91
         KwXCRUibHAuvIxwB8Cws7dSIEsHtqvgBenDZGGbyy/XXjrD2KidfhnHNg7RRdqSwMAkR
         GUrw==
X-Forwarded-Encrypted: i=1; AJvYcCXXlsU0r+4bpNLCUr3rvebjULEeCnQTZ7MhmSpnX2J5ZLoKMqztdZtYJUzafaOS3hPj8DCLlHY5v2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM69G9xEOHwS+nQT7fo1lMbhMj83nDxeg4DvhadhBxZ0Lmg3oo
	1te2fGE+syY3gaRGnVDDA4SC5XGwdhbUto27u4sU7F5hlIvJUqObBBYuTIxYxoRhmmY=
X-Gm-Gg: ASbGncv5Wf0qtVcijpzYG3qWjo+7K3Vhm/RYWBRhvHkbk+p06h92Qs+yVZnJojAkRPN
	Fb+CXLNsBLuVESnErv1KNfsS9rTdCxBx/xL962CgmvAqdiiqxsc+f61SEVqqls0Y0bjnNd7a5E/
	fsf5K5DE2JRKsKROVinEVglc9x3ldG/fJtdpNBAYJvJyensFhOGQpGBDRpXPyuRyBKZX5Kgx/t0
	PS5kgN65IAVeIrXCICZTezLbjhJGGQymtRFmvpZMsukSMyMhL3YR6jRoMKisugLSVUEwL5ds8Hc
	rKq4y3kGuyTrwEQYoEqoFCqKdImPWqHel0Wxrd00OJpjgpfwPw/7QHK1454RyQYi+2BRPk80FxG
	bXZ+9aT/qLwyGOQoTX6PlOK3CYNXyUUuf+WQsUXl1c1zqmcut0pvrFi2ks8EySCH6SKXHYYSARp
	WFBAAHnz6ngSV8eOghPA==
X-Google-Smtp-Source: AGHT+IFlq00kushikTRZ9pQw76fYJMVGlS1KAsn1jJFd8R+YpP1z2R2tirHj7bFC2RIC39KbSdQyLw==
X-Received: by 2002:a05:600c:4ed4:b0:46d:1a9b:6d35 with SMTP id 5b1f17b1804b1-46fa9ec7718mr147785575e9.14.1760345105437;
        Mon, 13 Oct 2025 01:45:05 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46fab3703adsm121495455e9.0.2025.10.13.01.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 01:45:04 -0700 (PDT)
Date: Mon, 13 Oct 2025 10:45:03 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Rakuram Eswaran <rakuram.e96@gmail.com>
Cc: chenhuacai@kernel.org, dan.carpenter@linaro.org, 
	david.hunter.linux@gmail.com, khalid@kernel.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, lkp@intel.com, 
	skhan@linuxfoundation.org, ulf.hansson@linaro.org, zhoubinbin@loongson.cn
Subject: Re: [PATCH] mmc: pxamci: Fix passing NULL to PTR_ERR() in
 pxamci_probe()
Message-ID: <6j7ix5yof7qmrp6cgxhqver7yimvmgj7dujqu4l7cnzbpjksfd@5sp7am47gigw>
References: <xxtrhbv5qm2crtvc5ejpgu5caadsmms3rfulmosjwq7lumrko3@5mlcpk24hymm>
 <20251012183804.15171-1-rakuram.e96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q3pt22edxgvzu55u"
Content-Disposition: inline
In-Reply-To: <20251012183804.15171-1-rakuram.e96@gmail.com>


--q3pt22edxgvzu55u
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] mmc: pxamci: Fix passing NULL to PTR_ERR() in
 pxamci_probe()
MIME-Version: 1.0

Hello Rakuram,

On Mon, Oct 13, 2025 at 12:07:52AM +0530, Rakuram Eswaran wrote:
> > >
> > > I do not see the need for this code change. "if (host->dma_chan_tx)" =
will
> > > skip "dma_release_channel(host->dma_chan_tx)" since dma_chan_tx is al=
ready
> > > NULL. This code change does not add anything.
> >
> > Yes, stand alone this change doesn't make sense, but if we want to drop
> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->dma_chan_tx =3D NULL
> >
> > in the error path above, this change is needed. Maybe then even
> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (host->dma_chan_rx)
> >
> > and
> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (host->dma_chan_rx)
> >
> > can be dropped.
>=20
> Hello Uwe,=20
>=20
> I had one quick follow-up before sending v2.
>=20
> Regarding the devm_clk_get() error path =E2=80=94
> you mentioned that setting host->clk =3D NULL; is redundant since host is=
=20
> devm-managed and the function returns immediately afterward.
>=20
> > I am not sure that sounds right. Looking at the code for
> > __devm_clk_get(), if devres_alloc() fails, it returns -ENOMEM. If any of
> > the other steps after a successful devres_alloc() fail, code goes
> > through possibly clk_put() if needed and then devres_free(). So the
> > resources are already freed at this point before the return to
> > pxamci_probe(). The only thing left to do is to set host->clk to NULL
> > since it would be set to an error pointer at this point.
>=20
> Khalid pointed out that when __devm_clk_get() fails after allocating a=20
> devres entry, the internal cleanup (clk_put() + devres_free()) ensures=20
> resources are released, but host->clk would still hold an ERR_PTR()=20
> value at that point.
>=20
> His suggestion was that setting it to NULL might be a harmless defensive=
=20
> step to avoid any accidental later dereference.

Why is NULL better than an error pointer? (Spoiler: It isn't.)

> For now, I have dropped the redundant NULL assignment from=20
> host->dma_chan_rx =3D NULL and directly returning the ERR_PTR instead of=
=20
> storing in a return variable.=20
>=20
> Below I have appended proposed changes for v2.
>=20
> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> index 26d03352af63..eb46a4861dbe 100644
> --- a/drivers/mmc/host/pxamci.c
> +++ b/drivers/mmc/host/pxamci.c
> @@ -653,8 +653,9 @@ static int pxamci_probe(struct platform_device *pdev)
> =20
>  	host->clk =3D devm_clk_get(dev, NULL);
>  	if (IS_ERR(host->clk)) {
> +		ret =3D PTR_ERR(host->clk);
>  		host->clk =3D NULL;
> -		return PTR_ERR(host->clk);
> +		return ret;
>  	}
> =20
>  	host->clkrate =3D clk_get_rate(host->clk);
> @@ -705,7 +706,6 @@ static int pxamci_probe(struct platform_device *pdev)
> =20
>  	host->dma_chan_rx =3D dma_request_chan(dev, "rx");
>  	if (IS_ERR(host->dma_chan_rx)) {
> -		host->dma_chan_rx =3D NULL;
>  		return dev_err_probe(dev, PTR_ERR(host->dma_chan_rx),
>  				     "unable to request rx dma channel\n");
>  	}
>=20
> Would you prefer that I:
>=20
> 1. Remove the host->clk =3D NULL; assignment for consistency (as you init=
ially=20
> suggested), or
>=20
> 2. Keep it in v2 for defensive clarity, as Khalid reasoned?
>=20
> I just wanted to confirm your preference before resending, to keep v2 ali=
gned.

Note that in the end it's not me who decides, but Ulf (=3D mmc
maintainer).

If you ask me however, I'd say the right thing to do there is like the
following:

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 26d03352af63..ce896b3f697b 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -652,11 +652,13 @@ static int pxamci_probe(struct platform_device *pdev)
 	host->clkrt =3D CLKRT_OFF;
=20
 	host->clk =3D devm_clk_get(dev, NULL);
-	if (IS_ERR(host->clk)) {
-		host->clk =3D NULL;
-		return PTR_ERR(host->clk);
-	}
+	if (IS_ERR(host->clk))
+		return dev_err_probe(dev, PTR_ERR(host->clk), "Failed to aquire clock\n"=
);
=20
+	/*
+	 * XXX: Note that the return value of clk_get_rate() is only valid if
+	 * the clock is enabled.
+	 */
 	host->clkrate =3D clk_get_rate(host->clk);
=20
 	/*
@@ -703,20 +705,15 @@ static int pxamci_probe(struct platform_device *pdev)
=20
 	platform_set_drvdata(pdev, mmc);
=20
-	host->dma_chan_rx =3D dma_request_chan(dev, "rx");
-	if (IS_ERR(host->dma_chan_rx)) {
-		host->dma_chan_rx =3D NULL;
+	host->dma_chan_rx =3D devm_dma_request_chan(dev, "rx");
+	if (IS_ERR(host->dma_chan_rx))
 		return dev_err_probe(dev, PTR_ERR(host->dma_chan_rx),
 				     "unable to request rx dma channel\n");
-	}
=20
-	host->dma_chan_tx =3D dma_request_chan(dev, "tx");
-	if (IS_ERR(host->dma_chan_tx)) {
-		dev_err(dev, "unable to request tx dma channel\n");
-		ret =3D PTR_ERR(host->dma_chan_tx);
-		host->dma_chan_tx =3D NULL;
-		goto out;
-	}
+	host->dma_chan_tx =3D devm_dma_request_chan(dev, "tx");
+	if (IS_ERR(host->dma_chan_tx))
+		return dev_err_probe(dev, PTR_ERR(host->dma_chan_tx),
+				     "unable to request tx dma channel\n");
=20
 	if (host->pdata) {
 		host->detect_delay_ms =3D host->pdata->detect_delay_ms;
@@ -724,25 +721,21 @@ static int pxamci_probe(struct platform_device *pdev)
 		host->power =3D devm_gpiod_get_optional(dev, "power", GPIOD_OUT_LOW);
 		if (IS_ERR(host->power)) {
 			ret =3D PTR_ERR(host->power);
-			dev_err(dev, "Failed requesting gpio_power\n");
-			goto out;
+			return dev_err_probe(dev, ret, "Failed requesting gpio_power\n");
 		}
=20
 		/* FIXME: should we pass detection delay to debounce? */
 		ret =3D mmc_gpiod_request_cd(mmc, "cd", 0, false, 0);
-		if (ret && ret !=3D -ENOENT) {
-			dev_err(dev, "Failed requesting gpio_cd\n");
-			goto out;
-		}
+		if (ret && ret !=3D -ENOENT)
+			return dev_err_probe(dev, ret, "Failed requesting gpio_cd\n");
=20
 		if (!host->pdata->gpio_card_ro_invert)
 			mmc->caps2 |=3D MMC_CAP2_RO_ACTIVE_HIGH;
=20
 		ret =3D mmc_gpiod_request_ro(mmc, "wp", 0, 0);
-		if (ret && ret !=3D -ENOENT) {
-			dev_err(dev, "Failed requesting gpio_ro\n");
-			goto out;
-		}
+		if (ret && ret !=3D -ENOENT)
+			return dev_err_probe(dev, ret, "Failed requesting gpio_ro\n");
+
 		if (!ret)
 			host->use_ro_gpio =3D true;
=20
@@ -759,16 +752,8 @@ static int pxamci_probe(struct platform_device *pdev)
 	if (ret) {
 		if (host->pdata && host->pdata->exit)
 			host->pdata->exit(dev, mmc);
-		goto out;
 	}
=20
-	return 0;
-
-out:
-	if (host->dma_chan_rx)
-		dma_release_channel(host->dma_chan_rx);
-	if (host->dma_chan_tx)
-		dma_release_channel(host->dma_chan_tx);
 	return ret;
 }
=20
Best regards
Uwe

--q3pt22edxgvzu55u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjsvAQACgkQj4D7WH0S
/k6XTQgAnYuhr6HFwe0UTLXOv/qkl/ksn8ON7M6ANZgUKJX6HEyws28hsk2WIv2R
/pbVJV/AEjvfWbX91QYyV4RhVSTA6A1E1o648gv5fFo62DvZvQ4oKKIKn1dDWdj/
/sjm6MAju+JXmJUif6s7hQSaYuNV7dgFXG2om7PNMunKLImtwIwiBc+ggsLp/ht7
2N2elw3IhAOn1RRzzolQiHBlR/R6PL+ut1S3rgnu8pJaNNkCzPAAt9K1pWHbKtMW
pWBH/W0TcXbc/dRQu8yedZYEWfFTKuCgZzWkNVCR2J63aG7Kzf9lZnrImosQ60k2
AlntrnHiS4bhdPOfPH1BpAKz3UrL0Q==
=4Q/i
-----END PGP SIGNATURE-----

--q3pt22edxgvzu55u--
