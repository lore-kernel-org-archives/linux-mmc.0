From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] regulator: pbias: Fix is_enabled callback
 implementation
Date: Mon, 14 Apr 2014 22:16:44 +0100
Message-ID: <20140414211644.GG12304@sirena.org.uk>
References: <1394250929.3892.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="doKZ0ri6bHmN2Q5y"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1394250929.3892.1.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Chris Ball <chris@printf.net>, Liam Girdwood <lgirdwood@gmail.com>, Balaji T K <balajitk@ti.com>, Florian Vaussard <florian.vaussard@epfl.ch>, Stefan Roese <sr@denx.de>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--doKZ0ri6bHmN2Q5y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 08, 2014 at 11:55:29AM +0800, Axel Lin wrote:
> The is_enabled implementation is wrong in some cases:
> e.g. for pbias_mmc_omap5: enable_mask is : BIT(27) | BIT(25) | BIT(26)
> However, pbias_regulator_enable() only sets BIT(27) | BIT(26) bits.
> So is_enabled callback will always return false in this case.
> Fix the logic to compare the register value with info->enable rather than
> info->enable_mask.

Applied both, thanks.

--doKZ0ri6bHmN2Q5y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTFA5AAoJELSic+t+oim9JQMP/20rRsKXT4ak8E0OlIBfw+vj
ySYYv/ipvCFqanhlxPW6w+n5xSvjCaJFslktkXSkDwrFo4go/9I0yOGge3jr+viV
15HfMROhNBtZmRJX213U+XJZaw/0KINnTvZqlMwo2kcDhdJ1wg4/YXQhliY38pv5
CJpcoW5sMulsn3EqgZN/8dGUyDkf2dvi8QJTjME39vAdzazfe/87RojokdtveneG
L09Z5fBVP5/oAtzP9Jz/Md8JVC1FjmDOt8+L+hMAlL8fp/SHUb1zfS064PLh/0qz
1Jp/T7IhaaM0QBa56XzH986PeQ5f1EUA3g8xpn+WBmixUCAk+2FJuC+7+KhfZ89h
EXzPQtSAK5VfxCZHcAfQqCbtK7FADLQTOUsLgQ2QyEDi5JxOMofd4ZQ/Ec+M8gTC
cmMz3eG7KJv4nBeBKxW4o2Bz0wLPkKGGdoNJ2kFiOkhQUNFPzPpJKA5EMfhUy1oi
zBhHkCUSTJXVQ2YWoSlOPKbW4Qjs2ubdR6iWdMZmVoog26ri3ktkRFSCMHNH7NWD
opajMEQYrYL0m6MNkeLbyS7JqbN8uUaCaEQbvfuwtW8Mp4XmQ+Zy07LnUBhDiL0n
zKNBwomtPF8PHk6gQRqEh0ufiC+4QwgqlOGbyykxhAc0W355aAyboB639rKFlXku
OKcfAhRSYyZJZ2mXdhyL
=A465
-----END PGP SIGNATURE-----

--doKZ0ri6bHmN2Q5y--
