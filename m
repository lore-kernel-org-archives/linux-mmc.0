From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: Add
 'fixed-emmc-driver-type-hs{200,400}'
Date: Tue, 5 Nov 2019 07:22:23 +0100
Message-ID: <20191105062223.GB1048@kunai>
References: <20191105055015.23656-1-erosca@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191105055015.23656-1-erosca@de.adit-jv.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eugeniu Rosca <erosca@de.adit-jv.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Mathieu Malaterre <malat@debian.org>, Pavel Machek <pavel@ucw.cz>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Eugeniu Rosca <roscaeugeniu@gmail.com>
List-Id: linux-mmc@vger.kernel.org


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Eugeniu,

thanks for this work!

> A certain eMMC manufacturer provided below requirement:
>  ---snip---
>  Use "drive strength" value of 4 or 1 for HS400 or 0 for HS200.
>  ---snip---

I see.

> The existing "fixed-emmc-driver-type" property [1] is the closest one
> to implement the above, but it falls short due to being unable to define
> two values to differentiate between HS200 and HS400 (both modes may be
> supported by the same non-removable MMC device).
>=20
> To allow users to set a preferred HS200/HS400 "drive strength", provide
> two more bindings inspired from [1]:
>  - fixed-emmc-driver-type-hs200
>  - fixed-emmc-driver-type-hs400

Main question before looking at the code: Can't we just extend the
existing binding with an optional second parameter?

        minItems: 1
        maxItems: 2

I tend to favour this approach...

> For more details about eMMC I/O driver strength types, see Jedec spec.
> Keep "fixed-emmc-driver-type" in place for backward compatibility.

If we decide for the path proposed here, should the old binding be
deprecated then?

Happy hacking,

   Wolfram


--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl3BFR8ACgkQFA3kzBSg
KbY0cA//YZ6N9IHHaKq423ABXNnBXaT4hOB/WYncPHRaK6cijvTKtR+eE10CRPpa
ebYVYr6UatR/vR+Pq4QZixmmF5bn1mT2HbzC7nw1QIJm8OKNghOewSSWAoT3HrYn
aBlen9t61+u/wC+Wnv8JZh/3A7XWG4gqkocWUTEihWrJv0uJ/f0rIR78mIV3ADAi
ho5B7QBmmt2Bwsls4SEnpPvwgXwaKay0HoGOyITKE6eIk8Xokbx65KwYa50WTslR
/q2bIZNeIrYx3Tk0zC2Qkof1brwfg9UxhCHPD7+6cbZCRvnI7nHFPQa1FCxqwTtm
XOvB7Afzf5rowAEUnQ7Kofxp7l+zbPGo0BvuBxAQsUYsJjG/AXpso/owQKzM7ob7
+NnKgpkqHtg5wnxtTjOmLJZwfOLLmAEp7z9ibPalFpX2s4WT9kEdqNpkSanwnXSx
bF69QHSM4nPsSCrhPLyowditB/FjtkAHceAiiBHIDcN4v+ytXVTsJbjiESudaQdZ
co0K/mYz3VfdcJ3wDhYUUOx/Lg1ejxhYDV+V9iHxYTeWoYHS9NNny8lnP6U9Bz1v
/E4VBIhDm+LvNE9DH1b9yMxzrD5TnISC8XBtgqkjW9m1DVu1wmtCE/WTeG+0NdNl
zlox2HdI0G4JEJIdLrbNtVfpNMRwurT4UMLKFFPcvpSvIAaIaNw=
=bGHK
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
