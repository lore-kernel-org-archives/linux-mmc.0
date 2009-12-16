From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [RFC PATCH v2 0/4] mmc: wii: sdhci controller support
Date: Wed, 16 Dec 2009 13:42:34 +0100
Message-ID: <20091216124234.GB4283@pengutronix.de>
References: <1260829459-23518-1-git-send-email-albert_herranz@yahoo.es> <20091214224552.GA21934@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41039 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755527AbZLPMml (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Dec 2009 07:42:41 -0500
Content-Disposition: inline
In-Reply-To: <20091214224552.GA21934@oksana.dev.rtsoft.ru>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Albert Herranz <albert_herranz@yahoo.es>, linux-mmc@vger.kernel.org, akpm@linux-foundation.org


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 15, 2009 at 01:45:52AM +0300, Anton Vorontsov wrote:
> On Mon, Dec 14, 2009 at 11:24:15PM +0100, Albert Herranz wrote:
> > This patch set adds support for the SDHCI controllers found in the
> > "Hollywood" chipset of the Nintendo Wii video game console.
> >=20
> > First, the existing sdhci-of driver is splitted into a core part and
> > a eSDHC-only part. Then the Nintendo Wii SDHCI support is added as an
> > add-on to that, re-using common code.
>=20
> All four patches
>=20
> Acked-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Interesting coincidence, I'd need to tackle these parts right now, too, just
with a different aim. The eSDHC-core was also used in the ARM-based imx35,
which means I need the code using a platform device. Just yesterday, I thou=
ght
about ways to do this. My favourite idea so far is to implement a
quirk-infrastructure. So, roughly:

Let the matching-structs look something like this:

static const struct of_device_id sdhci_of_match[] =3D {
	{ .compatible =3D "fsl,mpc8379-esdhc", .data =3D "esdhc", },
	...
}

Then, we have a sdhci-quirk.c making use of a struct like this:

struct sdhci_quirk_data {
	char name[SDHCI_QUIRK_NAME_SIZE];
	unsigned int quirks;
	struct sdhci_ops *ops;
};

and exposing a function like

	sdhci_apply_quirk(host, sdhci_match_data);

which will then go through the table of quirks to see if the match_data mat=
ches
a quirk-name. That could be used in sdhci-of.c and shdci-pltfm.c equally.

I am still looking into issues like abstracting the clock-handling, make bi=
gger
quirks optional and checking if there is a graceful way for a quirk to keep
extra-data. I'd be happy to hear opinions about the current sketch
nevertheless.

Kind regards,

   Wolfram

PS: This shouldn't affect the above patch-set IMHO. Factoring out the
esdhc-stuff is a step in the right direction in any case.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkso1boACgkQD27XaX1/VRvDFwCeMi/POxeFAwirP/KVAqsqMX1b
DxEAoL0gyW6JDd8WxmDfjN4ukJIAeBMo
=VmG3
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
