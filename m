Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A041ACECB
	for <linux-mmc@vger.kernel.org>; Sat, 29 Mar 2025 09:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743241573; cv=none; b=JjfHbJ6JttRGvMl/JtF7Ks1j6WxCeODwfZ2th/5hYPuJr6DjGFpph4FSGJsqkMLF2tbYzZEYFurPsrjAsz8OYwegRat+rnrvACxLHyTLJpMe0soC5yUyFNGZiyh3bWMFwCUZ9SZpEg5/ZxUmtNpix4TfaGQxOr9giPD8npqP0kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743241573; c=relaxed/simple;
	bh=Hb8ysB66hxEAh9mlzTbuAs7VggLR/MFkO8LW84DrR8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEAgQPCFnhNN066G+NDxTvfKwBN2N/m0nZvzZDx5F6IY9TtLU0xqLleZnux880bmBFfNDOLFzRfrW755n4syt1RPGISG0LsuIUWHoXxzHbCSCBSedUkQ1D2aZXrdetoq5nZTtDBj74qGwnWLWINlWN4sPoH+mfkF0OCBk14io5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=BfiEpz1g; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="BfiEpz1g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=5jlT
	P6RYaTmkWIrMko3cdQZEI4AZGqrNdA8VQvmQJiA=; b=BfiEpz1g8Sxtsppck/DY
	9aN7Thqu6BJhLO+/rwAWpsQOHnFcs0g0sa7zNNAIMLuMzsA75XNusBCqkVQCtmBR
	BCjiNo/zpeh6YZWou8egyz0O8Pfkr/2+gK9h5Jll8kRWI0a2iCegj4qlz8HH0RGu
	K+NOWQAFCs0i1kjFAITdqlCUNxs8qa7cf5V207Ubi1VqMa6bMpr52jiGB5myKUvW
	vUwRAHgurTYsSqYyRbypXfCC+NdYwohVkOhIFubU+oNoAcRXLc2Z5zpyErTQKj6p
	Q8M4ITuOfWpv9MgtMJIDlAWK+Mn+RGkUCtDAvGxuketp60ohslYDY8sPIKcADnmt
	hw==
Received: (qmail 536054 invoked from network); 29 Mar 2025 10:46:09 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Mar 2025 10:46:09 +0100
X-UD-Smtp-Session: l3s3148p1@Vv57DngxuoogAwD6PzqDAV8182DI+BaV
Date: Sat, 29 Mar 2025 10:46:09 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: renesas_sdhi: add regulator dependency
Message-ID: <Z-fBYVzkxZOqZixB@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Arnd Bergmann <arnd@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250329082123.2325267-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9lYPVq6q1UuMQzpU"
Content-Disposition: inline
In-Reply-To: <20250329082123.2325267-1-arnd@kernel.org>


--9lYPVq6q1UuMQzpU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 29, 2025 at 09:20:52AM +0100, Arnd Bergmann wrote:

>  config MMC_SDHI
>  	tristate "Renesas SDHI SD/SDIO controller support"
> -	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
> +	depends on SUPERH || (ARCH_RENESAS && RESET_CONTROLLER) || COMPILE_TEST
> +	depends on REGULATOR

Hmm, this is too strict IMO. SuperH does not need REGULATOR. But adding
REGULATOR to ARCH_RENESAS like RESET_CONTROLLER will still fail for
COMPILE_TEST, right?

Maybe we need to maintain the dependency in Kconfig after all:

	depends on REGULATOR if ARCH_R8A<whichever needs it>
?


--9lYPVq6q1UuMQzpU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmfnwWAACgkQFA3kzBSg
KbZpZg//Xr5t2VxRBLh0EUWTDTksEt6CYULIyViDwDmFEiLL4u/i4LUhtJjFu4Sl
psrx06xDtxQ1SlB4DxB4hDq8aVNdimoKt8z2hhGn5ENR3GEO2EnEaibHDLvE0OR8
xYrBcZY5wZ8NvW/vFdLxN3zqezK/2Wltfm7bMsFbANIRlNUzwKiRvKrgxTk1od6h
3uluCA53H5mDg6O4O39QIain9nvAAC0TDmomqh22KN1gwNXOqh7kUcQ5olt2qIVm
PWSUdWnI7fDXAqKUkt5F4nkULwYxrnaZsksgAKrPWR6sstr4AD/SA5neOVfebcKk
33AGGWM1EsgDu5jq9WhKXpeDvNRITASlIvKmIPqghT88eXCMuh726bjm6dPLVdc8
Bpr/8G/agTWbZirVb1IEYPJK3qylNpyvd4Lkz0mnUFe/1dDPcqTz3FFSlhoO0CYN
xxzWVVr+ACNUr176L5A4XQ59xtZdU49lw52SW0D+iBsj+FsSCYUJNVLifNBBnK1+
aqISTk9XRIXKT/76PEZSwWvKayAhW5n9//Bi2/uxcsaU8cqKIGyq+j9kHOb0fjCv
h1a3aUqTm7CzszpDEQmf4UuFVNA+PqZVPrBP5QsemFCHiCuWRcqDY+oKVFyz2EQ5
Ohi2xRjO4jEV3ZU2vklu8FeYv1nNF44K0ZvTReX2c4NLpQGYKzM=
=HCr+
-----END PGP SIGNATURE-----

--9lYPVq6q1UuMQzpU--
