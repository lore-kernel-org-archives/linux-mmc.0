From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC 1/7] pinctrl: sh-pfc: r8a7790: Implement voltage switching
 for SDHI
Date: Mon, 29 Feb 2016 12:37:55 +0100
Message-ID: <20160229113755.GA2576@katana>
References: <1455913003-6140-1-git-send-email-wsa@the-dreams.de>
 <1455913003-6140-2-git-send-email-wsa@the-dreams.de>
 <CAMuHMdXQWfYGRAuA-o+baN2dWnx-G1fOtRTU8xApZTxc5h_Sbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:58459 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754010AbcB2LiD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 29 Feb 2016 06:38:03 -0500
Content-Disposition: inline
In-Reply-To: <CAMuHMdXQWfYGRAuA-o+baN2dWnx-G1fOtRTU8xApZTxc5h_Sbg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-renesas-soc@vger.kernel.org, Linux MMC List <linux-mmc@vger.kernel.org>, Ben Hutchings <ben.hutchings@codethink.co.uk>, Dirk Behme <dirk.behme@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulrich Hecht <ulrich.hecht@gmail.com>


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Shouldn't the "From" line have Ben's authorship, too?

I considered the changes to this patch significant enough to take over
ownership. Even more so with the changes you suggested.

> > @Uli, Geert: Since bias support is probably similar, what do you think?=
 Does
> > it make sense to add gen{2,3}.c?
>=20
> It's up to you.
> We can always consolidate later.

Then let's start like this and see later if consolidation is really needed.

> > @@ -4691,6 +4696,53 @@ static const char * const vin3_groups[] =3D {
> >         "vin3_clk",
> >  };
> >
> > +#define IOCTRL6 0xe606008c
>=20
> ... if you use 0x8c here...
>=20
> > +static int r8a7790_get_io_voltage(struct sh_pfc *pfc, unsigned int pin)
> > +{
> > +       void __iomem *reg;
> > +       u32 data, mask;
> > +
> > +       if (WARN(pin < RCAR_GP_PIN(3, 0) || pin > RCAR_GP_PIN(3, 31), "=
invalid pin %#x", pin))
> > +               return -EINVAL;
> > +
> > +       reg =3D sh_pfc_phys_to_virt(pfc, IOCTRL6);
>=20
> ... and use "pfc->windows->virt + IOCTRL6" here and in
> r8a7790_set_io_voltage(), cfr. r8a7778_pinmux_get_bias().

I see. I thought sh_pfc_phys_to_virt was more correct because it
iterates over all possible windows. But yeah, we can probably live with
the simpler approach on Gen2/3. Will change.

Thanks for the review,

   Wolfram


--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW1C2TAAoJEBQN5MwUoCm2/KkQAJer7Mv/n1iqCwlEIoZDkTYQ
z6NBuvrGQ4m6bPb11EFBKXkn3RNRyr1z7c4kTypouikRGFGmrNLoR5DVOsUPxdtg
wf21Lm59K0FjpS6U5jNdlRi54NTsoTbaMxmLRJKOd1PCLDCBDCzHcam/3A5HrNsS
bnGHP/qKwry6mCI1Ez8T4Mr4uv0snkzyOZIi80mSRiydhzuA8isZKTJlezmMxzaK
bNatm6McOH6fyMblYcppnh2VVvb6xc+/HXBbsjKfQGTEBGQaGe0saLBPmfWpNZeD
nUGYMRLI5wtSUe7MAy6kdZdihrPgGwD0IT7AdL3k9T546Q9VmoW3tZPJITTguHZJ
9fXrT/TXtWoK/lY1zqzHvSiV0I5iygPUyq+fX/xywI3bk1GcTQ8QTsF2fzo24ipH
IzbKyXBHgQthvrkYIyuWLsYFDKvU4m5nswCJ2LjE9hoH3t0UlKaFlRue2eZSiqiZ
mOgbvXfRwIje2aPGhSZc/TwZLLmzfpWK21lLAm3xOy1jxJWqbMgao9RcKJakrPhM
fNtOZ1WMVeVfAM4gQ/X46Y4wT1gx7lBwmigG2nVpsyKnb4Y9VWUAiOL7Riq7Jwch
hVBm+ZfG6PUEFKMZIizr1xHstVkD0KauZ6VyFXi1PGvjfgOZJwymE/k8A/NPF77F
RmitlZyai+i2ynlfhU6h
=dFhk
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
