Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDE8261593
	for <linux-mmc@vger.kernel.org>; Wed, 30 Jul 2025 09:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753867037; cv=none; b=chdwbd5ToayZLjndnMMgTinm8qYuF4JuXozNaYc2sF7vCIgQwYuWDqUYtV/WRBulw17gOevxO8oVEb79y9Y0i5RkzKYzTIXJ7Brza4RhZsRLv3iyine0TZt6DWZEKE4hMDAcTlCjCK2o5M6zIGCGqcEZjgYza15tt1aZriUp7ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753867037; c=relaxed/simple;
	bh=Dpcd7l4PVdBUAu3dLde4TLawjV16LdfHLmoToUBiLfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUHpauVfGrx320jNMZ6ZZGz0iykDSo/oh1cOM2I7OBDypcM2uGa0qCYga1mbpUQJsD78Dchz93/p1WIYT4WPmIwaErVL18lz4ySgbw7GfUq3EfxGomz5uu2b/l9TQMWIGJuRKupyneXL+gM0QUYRFxRCPMQaYV74qwmrqQEPW3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Nkx9WmDw; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Nkx9WmDw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=z9s8
	RUZxXi4y+NdXdO9wZSa3qlMNEu3jZh6gP4YDP0k=; b=Nkx9WmDwDDT8RiY/j4X/
	gWHBfnqhxiHT79d6s8ImeSbvS5yTL8ft7G2Bpi7n2nkxDhfaI/LD/bsmp8d2Y2CG
	nzYXb2I496R2NEnmmfOddZOkUzPWSQnH2DgsMZJ4EwdAqz3CuWVi/IURIpEU/6kg
	/sv54CbFugA0B6Ccm/7XdiL2dGqfQhvUR2qcFKOEdNJ4UvbtkOhLLAyHrFWcBV1L
	3el553WbzhOztVcPwRP8Ot+DRZ5Pj55H+qKchD2/XhdYgT1x48KMh9SGr62+uSWG
	pjeltvdDAQvyWylRE9AQs5SOm0jYzawu0+dxNL0YdlpSgbzGtQgph+MZ/Bl92SzO
	JA==
Received: (qmail 4115907 invoked from network); 30 Jul 2025 11:17:08 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Jul 2025 11:17:08 +0200
X-UD-Smtp-Session: l3s3148p1@vNAs/SE7cocgAwDPXyC3AG0QzsW8mHdp
Date: Wed, 30 Jul 2025 11:17:07 +0200
From: Wolfram Sang <wsa-dev@sang-engineering.com>
To: kernel test robot <lkp@intel.com>
Cc: Biju <biju.das.au@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Biju Das <biju.das.jz@bp.renesas.com>, linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2 1/2] mmc: tmio: Add 64-bit read/write support for
 SD_BUF0 in polling mode
Message-ID: <aInjE-sduVbBRmJx@shikoro>
References: <20250727160731.106312-2-biju.das.jz@bp.renesas.com>
 <202507301421.AmWhOZBk-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kmR0COAf0tpqolK7"
Content-Disposition: inline
In-Reply-To: <202507301421.AmWhOZBk-lkp@intel.com>


--kmR0COAf0tpqolK7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


>    In file included from drivers/mmc/host/uniphier-sd.c:21:
> >> drivers/mmc/host/tmio_mmc.h:249:2: error: call to undeclared function 'ioread64_rep'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>      249 |         ioread64_rep(host->ctl + (addr << host->bus_shift), buf, count);
>          |         ^
> >> drivers/mmc/host/tmio_mmc.h:255:2: error: call to undeclared function 'iowrite64_rep'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>      255 |         iowrite64_rep(host->ctl + (addr << host->bus_shift), buf, count);
>          |         ^

Sigh, then the guard seems to be ARM64 after all :(


--kmR0COAf0tpqolK7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmiJ4xAACgkQFA3kzBSg
KbaeJA//X+uqDvUdKGGo3FOKu+/F1eXweWNZxFEmeubtke3lHodepW1cA105X33H
oHHK/iVapFK9wT4K3aGqHQGAYhoRtv/pWurW7AZCbZuHiIEvSGr6C5f2yohTYhix
+2+sy6DD1W05jLljxT95UIe2cGe4gq/dBxjuMPY7hBdZWz+JkHGFYpLeAwMwdOVA
SmSrrneaFJG6oA27RNSUO1sB7eGuTIqtLQhTDWEz105GBYsW41qW6QMHDMedejBo
qhTQ0wAgzMzxsGKCraM//3iFdcAbn2mVvMpjMqI9YnlpF/+FxCr9ljzZAlKi1P7x
GQF0IIdofihdw9MXtFH8bStWlNb9nlGqE6ujMSFLViUWqQrBnOZPXHFS19QF9Rsl
FfmMOT0oOTTFd4510V2/TK+q5csNM1rFEx6dTyZi3qu4xiCocZ3kdZ4jRO/qJSlQ
PhYy9s9wOrPvJLUX7avcnBZ7vZodmo/IR7TuN8t38mBQzUGF3oPJhX7wKEC+yA09
iWwj86WvdsaV8tif3CuDU1KlkFYDTtUX4PEG3hLFRuxQeesi9b9AKOtuuHd/8R+h
EPPyK/LyJ/ZMKEvMNAkNWadZjGjne/IvoivkoneCQUTVhZFhIeNGQYZT2MJUDXE4
OYIiKUik0iEhiN7ofwWgRiAJvZqlAswXNxVQKDQFNjRPBZ3Oq/c=
=Wjuh
-----END PGP SIGNATURE-----

--kmR0COAf0tpqolK7--
