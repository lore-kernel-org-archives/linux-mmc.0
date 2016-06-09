From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC v4 01/14] regulator: of: Add helper for getting all supplies
Date: Thu, 9 Jun 2016 11:29:25 +0100
Message-ID: <20160609102925.GS7510@sirena.org.uk>
References: <1465465471-28740-1-git-send-email-k.kozlowski@samsung.com>
 <1465465471-28740-2-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sCshgy9RPHTe3gCr"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465465471-28740-2-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Heiko Stuebner <heiko@sntech.de>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, hzpeterchen@gmail.com, Bartlomiej
List-Id: linux-mmc@vger.kernel.org


--sCshgy9RPHTe3gCr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 09, 2016 at 11:44:18AM +0200, Krzysztof Kozlowski wrote:
> Few drivers have a need of getting regulator supplies without knowing
> their names:
> 1. The Simple Framebuffer driver works on setup provided by bootloader
>    (outside of scope of kernel);
> 2. Generic power sequence driver may be attached to any device node.
>=20
> Add a Device Tree helper for parsing "-supply" properties and returning
> allocated bulk regulator consumers.

I'm still very concerned that this is just an invitation to people to
write half baked regulator consumers and half baked DTs to go along with
it, making it a standard API that doesn't have big red flags on it that
will flag up when "normal" drivers use it is not good.  Right now this
just looks like a standard API and people are going to just start using
it.  If we are going to do this perhaps we need a separate header or
something to help flag this up.

In the case of power sequences I'd expect the sequences to perform
operations on named supplies - the core shouldn't know what the supplies
are but the thing specifying the sequence should.

>  drivers/regulator/of_regulator.c       | 86 ++++++++++++++++++++++++++++=
++++++
>  include/linux/regulator/of_regulator.h | 13 +++++
>  2 files changed, 99 insertions(+)

The external interface shouldn't be DT specific, the Intel people are
busy importing all of DT into ACPI so they'll doubtless want an ACPI
version.

--sCshgy9RPHTe3gCr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXWUUEAAoJECTWi3JdVIfQEcEH/AtEa8HHkDnNy1eSEmi2KWSH
eb/X8Sjgcoig7sMk5GckV39Umc+4WXVOxj9OYorOOhJqAat4uaFDzyNlEXx6O4Tx
c1XWpJpdkDobo8I95Cac2NiG+2qwrRSFfT+RyPD+OkJiU4V+KcsI+xpjkGUK0k1E
9NoQPOi5c5Psa4wd+d3yzgQXPDdNRGwZEvDc6ok9DDMZSLxDMBqQwVHI3RLp0IGV
/ebd4oXgPuC6n0HwgC8usjj7MwrL6Z6cwMALbJLw3jNlun4/Hi07ZdjJTNKwJ95Y
bQ+7gNgLos07NGfr/2XO7oC4EsaRfkK8gCEQT2pEpOnUF9H7x40rM7O4xhOw488=
=spnK
-----END PGP SIGNATURE-----

--sCshgy9RPHTe3gCr--
