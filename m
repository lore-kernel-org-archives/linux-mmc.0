Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B409337756A
	for <linux-mmc@vger.kernel.org>; Sun, 13 Sep 2026 17:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789321666; cv=none; b=VRQXxqPgusRszP0IKsFRrs2KmS5JwFIV5akKlBuv4CfokHb5fD2AiMPF7EIyhz/uNjytE6wnkDhZvEStW3vz+hwDBxR/7XxeLOgcrtMKyonl2LAn6jp39+yx7BuhCLU/VMeKslyjoqc+slNtwmgyMI50TggPzr+mhouAsVKhK8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789321666; c=relaxed/simple;
	bh=dpOHoI59DgAETXAJG3aK3/ZrGyZodG9lNyPbGymOtk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NToRV1KFrB/KGHTuayW7pg4RcOaoM7jT2RorPU0OGP66PUH9kj6Kn6suJK4Sx5n7/b31Bsckglx0aThxtNA3AmOlDah7+ZcX5zjBT+22buryiW/Csb5Ljh4c0HrOCNHvix0jE9+qRnDz3L4StnboX/SBvTe2bOdon9ShYQrMSpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=C2lNIjAv; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="C2lNIjAv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=82oA
	MXeOM/wVdIBlxhSh3KHSbx4Ulol1YU0zCWMPa5Y=; b=C2lNIjAveIf9xVvmbwS7
	kMXbLUsNabHlHRv9nepK787sIrGoRwgfb0KnwdiS+WYSzreLAppOvBXMFeqts5uz
	wgy7jo3WAcgRrwmbwYL9QRChgE2sxOsgk8ILMnb8WvZn6TmC05O3sPULw4An10zA
	CW2MT5px3FQ3nR180xNpZGpMeeSwwEsLfRnDv+DMgGot8UzffLPJtrUF8T0cHAcf
	nCfoUkLH+6s5r/3+YuB5GJGFuZWA3KyEz0V+vhhU2BBbx2Sge9+566MhIpUvG1Up
	7at3ula7eIg0is79GsVgwijaoXpQ8br+pYWm21w2anj5o27IVmosiL+Qcnipr6EQ
	Pg==
Received: (qmail 422051 invoked from network); 13 Sep 2026 19:47:33 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Sep 2026 19:47:33 +0200
X-UD-Smtp-Session: l3s3148p1@n9aI6WBbTLUujnu2
Date: Sun, 13 Sep 2026 19:47:32 +0200
From: wsa+renesas <wsa+renesas@sang-engineering.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "biju.das.au" <biju.das.au@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v24 07/15] mmc: renesas_sdhi: Add tuning delay support
 for RZ/G2L
Message-ID: <aqbhsQTKkGfLsEXX@ninjato>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
 <20260820171657.62815-8-biju.das.jz@bp.renesas.com>
 <apk-J8is9MNm7I2R@shikoro>
 <TY3PR01MB113460485B6D3FD62D027C2AA86B52@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PxjBzLQea6JB4Y7t"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB113460485B6D3FD62D027C2AA86B52@TY3PR01MB11346.jpnprd01.prod.outlook.com>

--PxjBzLQea6JB4Y7t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Biju,

> > > If an incorrect device tree binding or a hardware fault causes the
> > > controller to report a version older than SDHI_VER_GEN2_SDR104,
> > > priv->scc_ctl might not be mapped during probe.
>=20
> I agree if there is a memory corruption, any check can lead to
> Unpredictable result.

I was more worried about the incorrect DT binding than the memory
corruption.

> > I agree. We should ensure in probe() that either
> >=20
> > a) TMIO_MMC_TUNING_DELAY has a valid SCC or bail out otherwise
> >=20
> > or
> >=20
> > b) clear the TMIO_MMC_TUNING_DELAY flag if there is no SCC present
> >=20
> > What do you think?
>=20
> I agree, we can add defensive check in probe().
>=20
> TBH, I am not convinced with Sashiko report here, but please recheck my c=
omments
> and provide feedback

Well... your statements make sense with the current state of the driver.
However, there is de-facto a new requirement added that
TMIO_MMC_TUNING_DELAY needs an SCC. This is currently handled correctly,
but since it is not addressed explicitly, I would consider it a little
fragile. SDHI is complex and I am worried that some future logic changes
might break the logic chain you quoted above. This is why I think an
explicit check makes sense - it cannot break and it makes logic more
obvious for future hackers.

Can you agree?

Happy hacking,

   Wolfram


--PxjBzLQea6JB4Y7t
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqm4bEACgkQFA3kzBSg
Kba2UBAAliLKPw6gd4vAKxTeNLW5nhw6kmAzkjcHrtfH/8vjcSSq6pIrb7F1PkvW
JRjxPjMC2zPnTLw7Q679XD7BxjHl8eSDxmFIamfnxJR1/tq9M/URHIQZqKFg+WHa
/WOqgkFmpb8XuLUoI5d6mwxAYC6oG9gD1sUXahKmro2ZqbJNZJoYH0jQdI5qb6cH
jcMyHrgxYn/u+OBPO9weL2NVETjfOrp29tpCeuImb61P8UrV4g6qHg+J5Xe2R1O/
/l+rcRgTn0sO9qbGL4XMbQcJskU6dZR1TCJd7BwMaUSTS95pw1F/HQP1Lffx1t+9
XL0uZ6/vX+9TFMz4LGM3EI6GPAaqv1OcD6N5aRkxxlM1TInkJLw9el3D5FyLWLo4
QQZyi+b2A47tuC+npmNhua+I+m5rMl4R+X2LiwT7h1+fiyHYsM7K2eQ6WkMxelOl
QJvmL/NQPISc0CXPdASaJgJRN2/5W2DVrkz7RoiNamsxjNWEUeT68GRUyhqR8do1
TFrxsNpJrurH1gTIykHlGtjwt7j6hH0BUH8SLQFIeht26GCp40pNKqjOXJusYyjG
5h56OcIONZz0YTB9nILE1dhhX6Y0Duq93I5XK0HZ4xgOLAfD+aJCeWnss7vpprLZ
FkEIKefY3eCaWWXIeKdwd85JJhoUYZ31DjagWD+YkYXaqaoE/N8=
=5xRy
-----END PGP SIGNATURE-----

--PxjBzLQea6JB4Y7t--
