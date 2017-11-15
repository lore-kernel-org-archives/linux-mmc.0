From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH RFT] mmc: core: use usleep_range rather than HZ magic in
 mmc_delay()
Date: Wed, 15 Nov 2017 15:48:28 +0100
Message-ID: <20171115144828.i7lvvn52b7ob4pgi@ninjato>
References: <20171114225520.6793-1-wsa+renesas@sang-engineering.com>
 <CAMuHMdWXXUCKMs94NK_40BQj-6YVGeu41Z6DJAjwqRf1yZe_-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="csw3znhshcay4ml4"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdWXXUCKMs94NK_40BQj-6YVGeu41Z6DJAjwqRf1yZe_-A@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: linux-mmc@vger.kernel.org


--csw3znhshcay4ml4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > I did mainly test the insert/eject cycle because powering up the cards
> > seemed to trigger most delays. Transferring data did not cause any calls
> > to mmc_delay() for me. Please let me know if someone knows a test patte=
rn
> > which should be included before applying this change.
>=20
> JFTR, with CONFIG_DEBUG_ATOMIC_SLEEP=3Dy, I assume ?
> (also for the other patch)

Actually, no :( Did this now and retested, nothing showed up luckily
(would have been really a surprise, too). Also, added those config
options to the configs in the test branch. Thanks for the pointer,
Geert!


--csw3znhshcay4ml4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAloMU7wACgkQFA3kzBSg
KbbA3hAAsF6svwlgoGSVRl08dEj3hkLMtaRYH5uqkiMsgxZx6/uQgszu33Kks8pv
Q4eQlupp+FTdIXYYLIQzeWWoenMFt+vStOV+Qe9q8af17Vyy18WHxECPeEceH44D
3UyNpfid35F7J6eGQ0i7xMMnLpcAe6fz4OtFjlfmxeZPRatbky1JSfcO2L0Fc8OT
iRttS4vt36Nf7yJYhHFJ9FD8Uk9DY46z6BxQ6ta0/YXKfhXi8TzJ/ZqE3oIjdvSg
R327Gr78eIRljYB2eqHRtxHMJ8oVWcEfDayG3sADvMZGQ2kcVtMWpAcd3BhAAESF
pxG0pgTVEKClegNOvjSfDLwy3AFODTg+zkflnma2tswh7hxd0AN97tXDQ3mkDzuI
FuubGx2hJQub/8UTpLFkSLjfmdLp8JaMbh6btEj1sPYyXlCrEXZM2vCbIa1qik8I
JX5YahlKSreKgHP2jNuXT6Zdm39uUj4Qnu38gdgUDhJf66rCpLJ0h5AbLfOSJ2A3
EW77uP8YxTlB8ZZANorV3IeFxO/X5yu0whDkRlp7yrg5ZhcUV0tWECQX06U6OqSW
oQIDMCrzYlEN2r+B+7Iz//LqHenK0w6Qw9ji2oMYv0RXpLspm/z5Oxroh5kVEwyN
90VGhJNY7G9Z/LJ5gq2zfmjLkXt5dRuqSg1/A9EPiVL/ch0geOA=
=t3AB
-----END PGP SIGNATURE-----

--csw3znhshcay4ml4--
