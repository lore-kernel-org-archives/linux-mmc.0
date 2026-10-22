Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792661460;
	b=3+bsrPB7JrIzRk0vctLn4wi1OQ5rXrOSfo6cT/D1eoqAlwjxdru7M8VazaF4WWtgxRwC
	 gW2pg5pEeLxx/aBX+x0pdfgOiNjlh49Rd9KYVbebX1rCZyjdvp5UrowN4pW/aWtnz91kF
	 lL10zQDI94BQnAfOTBecwgYH6eNxQQR7b0SsbzpncCeqHMV5CJGoDKlvJAHrR4oz5BzL7
	 H+QpGq9AHbym2J8D6hR/NiXOs1alFYAuDhohCM4ZcmQh8JPJzW+z2CyPZkeUWnrr+V85R
	 kmbkw5yUFOt7RAQpH32bPi1wBfPNajZdd7Lq9sYS2CWmzCHzXsDw/OsTDuk0fwd0c2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792661460;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=bgMmuHFkYogLF/Eeq6wTohVNZfvdHb4m4Si1W26cc2I=;
	b=1wNfkIt49Vm9zT0mploVwadD92q6ybZ4vFf0MoW93NARJNIkInxZb+UIgAoiy7Sbujfh
	 Kdrzml6kjRXHgQt+9OTw19Bc9vUHSr84jgv1SjbSlFcIXkA3xzw3cwSDTBOyJJCCp3OM/
	 DxmOy0JmvKNPLsl3VGvq0v7gf4M5P1x4C+SwB/LjClqg/Q62hKpAPCfyJhtZsEJISqk0H
	 2u5V4/Z6jGveB8h966vMDiRDbbXZ3BiAH35NRnPjvcTomiAAIOo9fIUIISwPE40tnzHu5
	 JPgdUAOnxG66zjIwZ5mUF6rgVHLOhLUVPVck5m1hqxUPPnIKD/C3sqj/aWE5PqeZvHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=RdnH1TWy;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FDE606A31D
	for <linux-mmc@vger.kernel.org>; Thu, 22 Oct 2026 09:30:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94FDE606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=RdnH1TWy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=bgMm
	uHFkYogLF/Eeq6wTohVNZfvdHb4m4Si1W26cc2I=; b=RdnH1TWy6ekLjoFVP53U
	94XgulBdcTkQPPwtZIXJxxjYUYmpBDAvQvN5dVogERKmDpfiqVLQtHAyDd6Ratmi
	6NIxTIjQ5UVtvjYkQVJqoAy+/QHT0BO51JVnttmgBjtT+KYNGtd3ObJiK6opRBxx
	TisXC7ShjvqtnEzeUb0/49RnRglCjeSbYG3njtF0bjdEwzfruAjOXO0no0HzKrxi
	rnscx+2gatzXkf0qe5e342vijZ+gUKrQv9eD+0Z+U2e060q/NOyqiKNQEzt/wuiL
	uhTpx3IGz52lFdD4JOLjzxi2PYq2POlIWy+bqIcTl0Kaf5DPPZr28E03TJRhzWJy
	rQ==
Received: (qmail 1087945 invoked from network); 22 Oct 2026 11:30:56 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Oct 2026 11:30:56 +0200
X-UD-Smtp-Session: l3s3148p1@r89FhWpeGIgujns/
Date: Thu, 22 Oct 2026 11:30:55 +0200
From: wsa+renesas <wsa+renesas@sang-engineering.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "biju.das.au" <biju.das.au@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v24 08/15] mmc: renesas_sdhi: Add
 TMIO_MMC_INTERNAL_DIVIDER flag
Message-ID: <atnXz00Hci6R-7Ux@shikoro>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
 <20260820171657.62815-9-biju.das.jz@bp.renesas.com>
 <aplBTMnnF1V71BDL@shikoro>
 <TY3PR01MB1134610EEF7D300BA8890357A86B22@TY3PR01MB11346.jpnprd01.prod.outlook.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3gL2mKKOOA5mRAgO"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB1134610EEF7D300BA8890357A86B22@TY3PR01MB11346.jpnprd01.prod.outlook.com>

--3gL2mKKOOA5mRAgO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Biju,

> > static unsigned int renesas_sdhi_clk_get_rate(struct tmio_mmc_host *hos=
t,
> > 					      struct clk *clk)
> > {
> > 	unsigned int freq =3D clk_get_rate(clk);
> >=20
> > 	return host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER ? freq / 2 : fre=
q; }
> >=20
> > Was this AI generated?
>=20
> I kept 2 function as renesas_sdhi_is_internal_divider_enabled() is reused=
 in
> renesas_sdhi_set_clock()while adding support for HS400 mode.
>=20
> Currently, we decided to focus only for basic RZ/G3L support. So I can me=
rge it into
> Single function as you suggested.

Please do. And if the flag is checked later again, I think we can just
check the flag. We don't need a helper for checking each flag, or?

>=20
> >=20
> > > @@ -184,10 +205,14 @@ static unsigned int
> > > renesas_sdhi_clk_update(struct tmio_mmc_host *host,
> > >
> > >  	clk_set_rate(ref_clk, best_freq);
> > >
> > > -	if (priv->clkh)
> > > +	if (priv->clkh) {
> > > +		if (host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER)
> > > +			clkh_shift =3D 1;
> >=20
> > No, this needs to be handled a bit above where clkh_shift is initially =
set up, so we have it all in one
> > block.
>=20
> There is a difference here.
>=20
> SDx_Clock (HS clk) Figure 4.4-8 Block Diagram of the Deformed Clock Syste=
m (7)
> IMCLK =3D SDx_Clock/2
>=20
> SD_Clock  Figure 6.2-2 Functional Diagram of Clock Divider for SD_CLK
>=20
> Currently framework request a clk to set, we set HS clk first, followed by
> SD_CLK.
>=20
> On RZ/G3L, SD_CLK value is based on internal divider.
>=20
> For HS400 mode, SD_CLK =3D SDx_Clock(HS clk)/2
>=20
> For Non-HS400 mode, SD_CLK =3D SDx_Clock(HS clk)/4
>=20
> I don't find an easy way to move this logic to the above.

I get an idea what is the problem here, but I am still confused about
one thing. I'll summarize what I understood:

* as of this patch, HS400 is not supported on G3L
* so, in renesas_sdhi_clk_update(), 'clk_shift' value is 2 before clock
  calculation
* as HS400 is not supported yet, the internal divider is always active
* so, you need to decrease the 'clk_shift' value from 2 to 1 after clock
  calculation

So far, so good. My expectation is now that when you add HS400 mode, you
would need some extra code keeping 'clk_shift' at 2 because the internal
divider is disabled then. But I don't find such code in later patches.

What am I missing?

Thanks and happy hacking,

   Wolfram


--3gL2mKKOOA5mRAgO
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmrZ188ACgkQFA3kzBSg
KbZW+w/9FDXVFDcXzKJv7Zx9UjskHBdfXgUqtxPLq109Y1kdg/Mgvk3oNTJ70IMj
A125l1ch4FlFZOlulIt+1UXWLqeB5UJgE/mLk+k/t0UGP/XNENddjgT23VhbWZmR
PDDtqc3VygI+KXQ2DObPnbQedT0OMUM1FZuOxXntrx9ej5izywlYodI3p4tEEzn3
DP0OEl8OXgiXVFCttHwIIZaqHRxZZxa19ZPVFwsTXgJqucacHIOyzT8PZ7fVnBPq
YRRqECM1q7WriEJjXV0wf5F1SF6QtJ83sn5cwqMw/+4rfSQgbW+//7KqYqMD0MNn
TnQVIWPLUlssaekQ2Rvu0LBfQNeKnCfWKxV+Kde2yy6T7lO/yp8wGNuCTxEwRhDq
UPEPJvsVNsWcFnciqEBgKo1nn2hDHYqRzvgObptvQTFLDiG031zXzX0J8BUvoZgG
vq799wP09GaGyZw5WUBxqa3FORreEwHfPnUy5OuV4tTBgLCrIiX7QJbdGzDHuWbU
ULW9HrBbcMYW8BQeVIBznyR2qZp2PYaSO3C7S5JsXK+NdEcnfv0shTAjYXcSXZtc
wwEi0AtyZURP7DjzPXvt6QDKjGQ8Z/xslWnClrnfLKK6gSWwTqgjsHDcmwAg0eKD
Mv9Cxz5PP3SWZXWU6x99dXptpPUIFV3zt0BHmk8kbohHWanNsbs=
=T5Ds
-----END PGP SIGNATURE-----

--3gL2mKKOOA5mRAgO--
