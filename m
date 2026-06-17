Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054D43EA955
	for <linux-mmc@vger.kernel.org>; Wed, 17 Jun 2026 12:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781698880; cv=none; b=cO7D19QLnLniusRQetjzR0xWeFwobx2fHyISah8DQkGWb7nyOt38F4WbPS2TwawVpjnWE2gW3SQ9ewjBOuz5PG17aiRYqUUSOJ3UKIJEnG1YXIsgJugwkB9Vo5quoI5otG7fgdLj5gr70zphgiJIl9QgBcTIEYYrv+dDoOaAoGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781698880; c=relaxed/simple;
	bh=DOJzyoPjoIQaGjtQIJ7B/hL9ICdOm7hNrKaUaI6NCxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WB1rmxbb8Yu8PWq17DLpaHT7tE/E8gtnva9yMQCTTWmfodLLsYmdQkM9pZhGCPz3iF48L5cOf+zXGsHcMc+2R1Hh9ePWH7/g4ntK/rK5coogk3hykpxEAS/eHYpgsw42m5xK85mirRepWSIeAGpUDwpWdQyWAhQtBmLXaBquA0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=UyKTZ9sp; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="UyKTZ9sp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=DOJz
	yoPjoIQaGjtQIJ7B/hL9ICdOm7hNrKaUaI6NCxg=; b=UyKTZ9spYwsQ70NQ3dvG
	wXAB9Nuu8IrmGqTQUrrtqGM8+rhX/su93ICBm5vMbikME5i/5pdrkWcRn92i2IlW
	MleZePv/SrOO7O0j8FKubWJUd8ksn1CqBfXxORyuGhi9SeAMf8+phQ1vzXmSyaYn
	2OD4ZpekWF2JGTYCgKY0TUM1nPGjkRIdZdn2DgkXG8L0YYEPO6azgKgTanmh1ycb
	QZPVZwGtxWvq7cXH2hzWjk3FDVVr7Aiypeu/azOqcDqgT0ZZR2UegewZoLboCze5
	7gO5HyLmRAkk1XoPo2VwCqAy3MukGfEWrxhCntP+UKHRTsyN89IVWNsxwlux4Qy+
	GQ==
Received: (qmail 160825 invoked from network); 17 Jun 2026 14:21:16 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Jun 2026 14:21:16 +0200
X-UD-Smtp-Session: l3s3148p1@i4qXGHJUYNYujnvI
Date: Wed, 17 Jun 2026 14:21:15 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Biju <biju.das.au@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>,
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v17 04/17] mmc: renesas_sdhi: Fix whitespace alignment in
 struct renesas_sdhi_of_data
Message-ID: <ajKRO0lgr_99tr34@shikoro>
References: <20260603065731.93243-1-biju.das.jz@bp.renesas.com>
 <20260603065731.93243-5-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pspjYZpyJz02snC2"
Content-Disposition: inline
In-Reply-To: <20260603065731.93243-5-biju.das.jz@bp.renesas.com>


--pspjYZpyJz02snC2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 03, 2026 at 07:57:04AM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Remove extra spaces in the renesas_sdhi_of_data struct definition,
> replacing the tab/space mix used to align tmio_ocr_mask with a single
> space, consistent with kernel coding style.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Should be merged with next patch IMO.


--pspjYZpyJz02snC2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoykTsACgkQFA3kzBSg
KbaZ0w/9F9QqAQJru8OWzn1OfQ314+h84S5pgYQiU7ffhCBndR2593/jFQoENz+p
ipE5tlQrakubjQs0hO4sEZyXfD8LFOCQPXii/KSklhSwROH7lMhcHRGfXc4eu5f3
pyTL7ZSWkN7wG6DaD01XdDARAkV3gSs7LCIhhaeoR64k3NoJaoKtHy0yyGkcZ/Wh
IHasdaqzfIaG4ZQxr+HIupwaF5n6Pa+Qcf9jRPoKKjoKA4o7jNEhw/r/8sMzTllS
eyX2RV+t+QjkLeCPco/XM3vX1cjxUkrSOtkGp8sfYLE7W893JvOYQS6KRf0Zhujj
zn7q4k3apW2sw8AM6SM77Org9P29teLCro0TP+T+RGgZ/sCrP6vEYEarEwcObLUr
jqLr8wGamk5V9r42z2qwz2Z4fNX74pQm+bX1gvxOmljgoQ83HzZ/9W4eCbRzivH0
ZTwFK7/UeSBwfDLu3jyPg09L2YKPJ2zCctaMzpxR+LStOk+dgvkI+pWq81q546iM
x/XgiXHDf4N7el3bduft0KMPCiqHCEW9y8GL9BFuskMJujL9d5MTpyxDWHtmIyHb
oE+5gb/Db0+n+qjwXKS+iugAtZHnYWxSSCBWz9wsykiwsZhIpGgSFeNzVTQ0XUuH
+c+vDneLCnwF5RM8JuKSWjdRzELjQaaJR0ZqIOyBzHyCHhHDCHQ=
=LQ7H
-----END PGP SIGNATURE-----

--pspjYZpyJz02snC2--
