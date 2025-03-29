Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1921613C3C2
	for <linux-mmc@vger.kernel.org>; Sat, 29 Mar 2025 16:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743267035; cv=none; b=os+YlNzmAT7VbwdcUU3ajJvR1ats+tL1GhYHK4vXkuUoVQ0KL1fwrdF7M3IwHkvIeF1Pf0FHw0ADlHoaugMhq8FzLaYS7+QIR/MtDNFbdNF+jnDKPQ4itD+6TsR/0doETj5oHsgrKuM5rBLU1YdI5BgEFhLfiNBHnU3+w2NwGaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743267035; c=relaxed/simple;
	bh=+mzCCqPEjg1KZx0K4/NUiDxTI9/Cj+i+wRoxGKEEoTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPf1Ecgmx2B8Bs9JVzzea9lC1PINTsrpE8Fejk7jTYNqhohf9MZsIW8h4SaiEXHTGLGNzj1/hlQUeghtOsnQl00wEGcXIXf3mUrCOh5P1A9HB0ZShupaiYFOTkgu2xug7zLLhKdP9r4AfWzctDmXjk3YEqWHPcDhScFIuULqjt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=M3saolUP; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="M3saolUP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=+mzC
	CqPEjg1KZx0K4/NUiDxTI9/Cj+i+wRoxGKEEoTI=; b=M3saolUPwyzoki070zBK
	8MQ4fV2uCEPQ1yxRSSlR2Kg+Qqm9ysAtuRgNB8yb8M0Lu9v+yjbEsqv3bjfHG2cV
	obElYV5lCKtNb1v2DgFV821NUH5sLS5A4dDosWOGpDg56Hoynj1EUNFMrgF3Q51M
	v077PHgk5b1v7plfUqQ9OjfaWwIL4+t5PSE2R3DK12YSiabgxYvLx9+1bg/SDlTn
	ZYS2KjuKU3M74GuAz+ws4WsUd8v6DHVcXpacP8Ntt/eRjNZPbEiP9p3iibmcJFq5
	1ACeXodkNWvg7cD0jXwIJ401Ij/cOBEdnMQjqHKTYO7cYIp+SakAB0gD4V4QLCnP
	wg==
Received: (qmail 623764 invoked from network); 29 Mar 2025 17:50:26 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Mar 2025 17:50:26 +0100
X-UD-Smtp-Session: l3s3148p1@I0bZ+30x6RJtKjPL
Date: Sat, 29 Mar 2025 17:50:25 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] mmc: renesas_sdhi: add regulator dependency
Message-ID: <Z-gk0TDKv28vxCCn@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Arnd Bergmann <arnd@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250329164145.3194284-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AHSC+jOfV9WNN0eH"
Content-Disposition: inline
In-Reply-To: <20250329164145.3194284-1-arnd@kernel.org>


--AHSC+jOfV9WNN0eH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 29, 2025 at 05:41:26PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The driver started using the regulator subsystem and fails to build witho=
ut
> a dependeny on CONFIG_REGULATOR:
>=20
> ERROR: modpost: "rdev_get_drvdata" [drivers/mmc/host/renesas_sdhi_core.ko=
] undefined!
> ERROR: modpost: "devm_regulator_register" [drivers/mmc/host/renesas_sdhi_=
core.ko] undefined!
>=20
> The 'select RESET_CONTROLLER' needs to either go away or get changed to a=
 dependency
> in order to avoid Kconfig dependency loops here. It also turns out the th=
e superh
> version needs neither RESET_CONTROLLER nor REGULATOR, and this works beca=
use
> CONFIG_OF is not set there.
>=20
> Change both to a 'depends on', but add '|| OF' for the superh case.

!OF

> Fixes: fae80a99dc03 ("mmc: renesas_sdhi: Add support for RZ/G3E SoC")
> Tested-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Other than that:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thank you!


--AHSC+jOfV9WNN0eH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmfoJM4ACgkQFA3kzBSg
KbaVeA/9HvjnwFDKYJFf2gk7C52LvtC6J3WOkYKoxC1Ial8IpRZ2RqzO4DZztQeA
DX0F+2CzHMcdkhpJQOahCkzrGuqoeMGhmkPfK2Vv8Z1ArTT5HUV0+MSLfc4mW+Ut
KXDhlfe2k0Eb2ZKqkOTfWYjuwXBQ8qW6LiQZH1fjwjGDsTmn2F3zoImKb3elO9P2
tmAsM7HVsmQd+qCuzjo3A0HkSJ9rLseNCkICUP4tcqbsIVxilp6zmvZq2+5NznNT
yQbqUAh0P9zjXRCCdEfA84rrsNyw6I6agXnLP3lj55uDJOMh13+kT2nV7O+rAQg3
jda8Fja5vn8rFW0fFjjAvbddbL4o3G/BNmtMlUr6f81q6fIkDXG3dz98x7Mmm+lm
bh2E+qy8qb00LD9tes/HluxTyIVjHoWxfe0kKyeXK2JuOxmzWnYbWsc/nVyLYYFx
ZYVbeLaWBKq3ha95EKvx4UR9N5vIdGly+9rvNOJplA1hb0FsmgaSsDb0A6VQ3XdB
N5PLve8YkUWwMBEn0XD1Rfm/qnr6C3kwGHwM/okRngsoDtv0824tP24wImqKrqE2
xtuvMsN+t2DCU79p/oUleZxXOBWB7CHyQxHvVhgcupol8zAcler5+sKqnenD1AGl
xH1cFDQHWPsHdAnUge84bnb1Qh76ZwBF9CcIkUbiVye4PBqokjA=
=wgl4
-----END PGP SIGNATURE-----

--AHSC+jOfV9WNN0eH--
