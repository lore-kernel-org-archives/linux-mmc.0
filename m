From: Mark Brown <broonie@kernel.org>
Subject: Re: ARM: shmobile: Koelsch fails to resume due to sh_mobile_sdhi or
 regulator-fixed
Date: Tue, 12 Aug 2014 22:47:34 +0100
Message-ID: <20140812214734.GA17528@sirena.org.uk>
References: <CAMuHMdWTudFK_EiL8xQpmL5OmJxYX1i80WjfAA+L2Dfn21NWtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hDunTjjcyFOMEMuz"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:60484 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755196AbaHLVrt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Aug 2014 17:47:49 -0400
Content-Disposition: inline
In-Reply-To: <CAMuHMdWTudFK_EiL8xQpmL5OmJxYX1i80WjfAA+L2Dfn21NWtA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, Ian Molton <ian.molton@codethink.co.uk>, Linux-sh list <linux-sh@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>


--hDunTjjcyFOMEMuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 12, 2014 at 04:28:39PM +0200, Geert Uytterhoeven wrote:

> r8a7791/Koelsch fails to resume from s2ram with

>     CONFIG_REGULATOR_FIXED_VOLTAGE=y
>     CONFIG_REGULATOR_GPIO=y
>     CONFIG_MMC_SDHI=y

> Disabling CONFIG_REGULATOR_FIXED_VOLTAGE or CONFIG_MMC_SDHI,
> or both, fixes resume.

> Note that SDHI on r8a7791 uses both regulator-fixed and regulator-gpio.
> However, CONFIG_REGULATOR_GPIO doesn't seem to have any impact
> on the resume failure, it resumes fine with CONFIG_REGULATOR_GPIO=y.

> Anyone with a clue?

No idea, I expect it's some bug in the board description - both that
regulator driver and that MMC driver should be very well tested.  Given
the lack of traces are you sure that the system is actually suspending
successfully and not just crashing?  First guess would be that the
regulator is being powered off on suspend and the hardware is trying to
boot from a powered off device on resume but that really is just a guess.

--hDunTjjcyFOMEMuz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT6otzAAoJELSic+t+oim9oU0P/0mK54smN9vb476dceABabq4
3AmahMbMFIlPqJ7Lwy1KeevPonLYRtfzj00e3Yjl9gUVHelKuNSlk1J9FehHuTwi
ugeeVXjlHE6sQrVb2AWD9qID+VxkvB7Sey0YQGEcGDfun0aLyh+i5xw0tKPdoHL1
K71LSaPKwagD0QczpSo1j/oHS4OcIarNs93sscakC4luroa4B6t7a4OUflZI8cf3
8VaW/fNTUZeOlk146V5y9Svgryz12kAPspltav5bagavts3Jq9baGhILbEnX7Xiz
6qoLj/ZMSNqr7weKjZw483TlKU7yH5lYqu24w1sXnHNxdiRmpLlmXoXChWajOcwc
Zj2seTu7WPzsBKh8pVSsmMZuOGlZJmROteiWUBLBEtt3cAtN2EWEfkI2xXVCpLCT
7B6jP2hZVelLnC/MmvdR+spV8g1HuT4NbPok6vjb9NRgi52d1uYAlAMvys4qmdx/
CxSPNGp4VRqtZQue4/jLFjTuH3u98wstAQdXUtvob6yXjNt861b1HONgMDaNoZM9
FQHjUoBxLASe7ZAgWI8VhW+T+X6umpva01c9WZzI6/pjzZ8qqbtEbn2VwQ+MYSvV
K4QVHQvKfFfV2hva8dOAm3TDpARYgCN9Gd6aFla4Nr0kajI6m3ZsvdGL9jxzx3mN
HTY+391XMwRkO7kRwcwR
=8Xvt
-----END PGP SIGNATURE-----

--hDunTjjcyFOMEMuz--
