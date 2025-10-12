Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508F327F4D4
	for <linux-mmc@vger.kernel.org>; Sun, 12 Oct 2025 14:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760278552; cv=none; b=feNpcq1Xr3Y652e3vLaqI+gZqNP0BSdv5R4t2qFssLCpucmrhp9zFTjDH40OeF2tFd31WSks7KsiQmISnjgZaMf5LPIrM8ygc6+rrWXQP9UhleRzB+X6gvRvcsPopv4Y05a553KiGAmwPXiiTWjsYEfReAjz5KlvHP0oDYhHEqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760278552; c=relaxed/simple;
	bh=pQYo3AL0hKKQM74twJtSkHbfx6sfxE/SN/JlvBlE2gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPqxIQ4T+oOugXfzIjTFIHXSlfTxcf7g/EwqHIj4H/ZIePT7YDsVTaWwYwGRYwSOXpKF2oUOt8CsD8K4DW/oulm5vJAyRd3P6sr178mvMjv2t+vItp49VwwmI8+/0gUOuY1o6dKpDwUrwGTkgszbnuTTXCm58vFmmvRbmf0Ax24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=a4WFHAvK; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="a4WFHAvK"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b472842981fso433936466b.1
        for <linux-mmc@vger.kernel.org>; Sun, 12 Oct 2025 07:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760278547; x=1760883347; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2XMzMC6esunaiQcFjYreM2qMVnAAkLc/iCHafaRbgJo=;
        b=a4WFHAvKBM/vx4qIGm03nVdgZ6+kSgoVDywWL9wLYkTVLBcIbtasVQta1yRDXbZDld
         giw91L0vkW30QGKMwW3Y2Qr1MdQAQF0Tn2fArjjhEK+YLkAgHpWAynYSmp1/+15lGGve
         2/4OdG/gs1/CsEYo4nbLgjz/QOR9IB7sBX5ZpbWD6fEZswQA0cTSBlWBGn+Lavm2vQhq
         LOobt5vkoY/WKVvKxJqZy5pmMjrB1zFBr+JG37tPcNSUwmYb4qUmZoLXJwI4abinCOR9
         WkBLs0L2Q6YbBrmQnc/1LU6YCnlxLcqbcfalSM3O+gY3PHMSWfO+IMnVDL+CyH/GTttc
         0QYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760278547; x=1760883347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XMzMC6esunaiQcFjYreM2qMVnAAkLc/iCHafaRbgJo=;
        b=X2EoQjWqx0gTTg+PwI6F+JjSh5mjI3IZS1qU3357edN+IHHDS/2kUferXqV7OMkKJM
         s+dh3Ip+ZgDIm5Kr42xApZ7H131HPfi/rEBRt8GS5yldMjLNXYUuONKuzmE7qC3nb/BY
         vLEHBKX/8eaAMz8GZ319ELmlqjohrBHupTBxjTjCm+WNjOc4wDpzQTcdWeuW2ilWxyB5
         +/vEUAFgE9PLYKsj2TYaBtLQbRGXxnbRIAy1YFkl+cO5H3807jU8l8W11pauiKdRuc1R
         CZqzARvyyN3PRqN07vTVOnR8Cn01PrxCv2xpR4do3aCRhbHPZgBM7Wn3G0f/AIrNcAm9
         AeUA==
X-Forwarded-Encrypted: i=1; AJvYcCW2ByTtpfBEJkh357tkHRZqNhWSDogOmik8bKYWetpj/FTOcwSMAJCbe/qQfvasZrsDKCrhbx4t2UA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGBvqxrgY5y7xk4pF4mzMbPJgfxjQkAsmRkqQhn/53sg8b6aNG
	ksI4YHdE4T0rxXAMWBmlI9LpEJTRetx1LoVCuEE0xp5OPGMf4XZT7ecWSTPuqPJUn4w=
X-Gm-Gg: ASbGncvZQ/YX6B87yTMtvbH5GfEGN6SGa5p/Wlr/TUOi0+yIYLJqnpGm16QTVOR68dM
	tzKKfOf7BGjlcuGx5i/VtBDPu27JM9B1yiwrcQWILo5qaamjKj1oFjyT+wlVvc8P18D64pb1wCb
	+neLB40DFxLTkGCS5E6QG2LsFxopwbYwhxVzES0yGafGRcYlq+JHKogydm0MYUvtRte8FIon/U1
	YowMs1wScZLEh7l+z7wpH8GWvuLXrrwQOXymdHb4DahnmyXh1trRSMFYtKDkv2wIiCMs4ArQsDZ
	Nn8iCXzra2/IAIIHygYilUsv3x0i0kCCL1WWNyYLTkZTfCZSCpU4+Kpme2cSXiqBOP0z/d+7vh2
	QLDvcJSmr8yEcov6s47nN7XHyS+gjswOT/2+0B+oHFji+/g==
X-Google-Smtp-Source: AGHT+IHW9hfSXC3QTPqo0OscrZQ5y9QPHTSmHKiSG71n5Gr9WACU3hTAEq7OXxbr/C9bpmT+R4SoBg==
X-Received: by 2002:a17:907:7290:b0:b45:a03f:d172 with SMTP id a640c23a62f3a-b50acc2f5bemr2022051166b.57.1760278547399;
        Sun, 12 Oct 2025 07:15:47 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b55d9526885sm722816166b.84.2025.10.12.07.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 07:15:46 -0700 (PDT)
Date: Sun, 12 Oct 2025 16:15:44 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Khalid Aziz <khalid@kernel.org>
Cc: Rakuram Eswaran <rakuram.e96@gmail.com>, chenhuacai@kernel.org, 
	dan.carpenter@linaro.org, david.hunter.linux@gmail.com, 
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	lkp@intel.com, skhan@linuxfoundation.org, ulf.hansson@linaro.org, 
	zhoubinbin@loongson.cn
Subject: Re: [PATCH] mmc: pxamci: Fix passing NULL to PTR_ERR() in
 pxamci_probe()
Message-ID: <xxtrhbv5qm2crtvc5ejpgu5caadsmms3rfulmosjwq7lumrko3@5mlcpk24hymm>
References: <pe4sz3hamkxhahvwqzdq3p3q5u3yeqpdscl5rvvoo5gdfbbrl7@joiz2oj5y4so>
 <20251009152744.9734-1-rakuram.e96@gmail.com>
 <aliep4j5jmbdixu5cmqztoxwp3jv4r4hi63qpvhughepsepzb3@qh3mwgryf5ny>
 <3a73daeb-1353-463d-a1f1-22cdece1326b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aiu3n4mecyew6rsx"
Content-Disposition: inline
In-Reply-To: <3a73daeb-1353-463d-a1f1-22cdece1326b@kernel.org>


--aiu3n4mecyew6rsx
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] mmc: pxamci: Fix passing NULL to PTR_ERR() in
 pxamci_probe()
MIME-Version: 1.0

On Fri, Oct 10, 2025 at 11:59:57AM -0600, Khalid Aziz wrote:
> On 10/10/25 3:59 AM, Uwe Kleine-K=C3=B6nig wrote:
> > Hello Rakuram,
> >=20
> > On Thu, Oct 09, 2025 at 08:57:38PM +0530, Rakuram Eswaran wrote:
> > > Your suggestion makes perfect sense =E2=80=94 since host is devm-mana=
ged,
> > > explicitly assigning its members to NULL has no effect.
> > > I=E2=80=99ll remove those two redundant lines in v2 as you suggested.
> > >=20
> > > I had one small clarification regarding the remaining host->dma_chan_=
tx =3D NULL;
> > > in the TX DMA error path. Since that branch uses goto out,
> > > the cleanup section below may call dma_release_channel() on both RX
> > > and TX pointers. Setting TX to NULL there seems like a defensive step
> > > to avoid accidentally passing an ERR_PTR() to dma_release_channel()
> > > =E2=80=94 is that understanding correct?
> >=20
> > Ah right, so either keep host->dma_chan_tx =3D NULL or improve the error
> > handling like:
> >=20
> > diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> > index 26d03352af63..e5068cc55fb2 100644
> > --- a/drivers/mmc/host/pxamci.c
> > +++ b/drivers/mmc/host/pxamci.c
> > @@ -715,7 +715,7 @@ static int pxamci_probe(struct platform_device *pde=
v)
> >   		dev_err(dev, "unable to request tx dma channel\n");
> >   		ret =3D PTR_ERR(host->dma_chan_tx);
> >   		host->dma_chan_tx =3D NULL;
> > -		goto out;
> > +		goto out_dma_tx;
> >   	}
> >   	if (host->pdata) {
> > @@ -765,10 +765,11 @@ static int pxamci_probe(struct platform_device *p=
dev)
> >   	return 0;
> >   out:
> > -	if (host->dma_chan_rx)
> > -		dma_release_channel(host->dma_chan_rx);
> >   	if (host->dma_chan_tx)
> >   		dma_release_channel(host->dma_chan_tx);
> > +out_dma_tx:
> > +	if (host->dma_chan_rx)
> > +		dma_release_channel(host->dma_chan_rx);
> >   	return ret;
> >   }
>=20
> I do not see the need for this code change. "if (host->dma_chan_tx)" will
> skip "dma_release_channel(host->dma_chan_tx)" since dma_chan_tx is already
> NULL. This code change does not add anything.

Yes, stand alone this change doesn't make sense, but if we want to drop

	host->dma_chan_tx =3D NULL

in the error path above, this change is needed. Maybe then even

	if (host->dma_chan_rx)

and

	if (host->dma_chan_rx)

can be dropped.

Best regards
Uwe

--aiu3n4mecyew6rsx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjruA0ACgkQj4D7WH0S
/k5xlggAgtLA7I1LRrMqGE2N6WwAa5nB4GYA3H8oaIjnY1v1N7b2t/tjbdECN/3m
wmWnIH7UeQIHQYMkvrgbI6mM04/6cozbV1BQIZoC6ZfrO19YNVaUHiSdSkVa884A
XAD/t/z+4zSPlD9pjhAg+619Ub8KrPG7yPyARwRCN2g47NG+M0nRRjk30Y7POueH
YY+3vQFFxB0F5dDqz1PDyrNZUrMiEOCbzVOulU03FaMyCEK5P2LFNKurm3yhO975
Zx9pxi/JnDAw2slWZEnq+7VcuGgzpCvACFWXwM8f5jycbwnkp5/SzyNRu9x1iwRh
6gMBuzVYVkazusRPTkjGRghdLSedgw==
=AexD
-----END PGP SIGNATURE-----

--aiu3n4mecyew6rsx--
