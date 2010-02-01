From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: + ricoh_mmc-port-from-driver-to-pci-quirk-update.patch added
	to -mm tree
Date: Mon, 1 Feb 2010 21:35:11 +0100
Message-ID: <20100201203511.GA3093@pengutronix.de>
References: <201002012024.o11KObAY010344@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34170 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754821Ab0BAUfQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Feb 2010 15:35:16 -0500
Content-Disposition: inline
In-Reply-To: <201002012024.o11KObAY010344@imap1.linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: akpm@linux-foundation.org
Cc: mm-commits@vger.kernel.org, maximlevitsky@gmail.com, linux-mmc@vger.kernel.org, philipl@overt.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 01, 2010 at 12:24:37PM -0800, akpm@linux-foundation.org wrote:
>=20
> The patch titled
>      ricoh_mmc-port-from-driver-to-pci-quirk-update
> has been added to the -mm tree.  Its filename is
>      ricoh_mmc-port-from-driver-to-pci-quirk-update.patch
>=20
> Before you just go and hit "reply", please:
>    a) Consider who else should be cc'ed
>    b) Prefer to cc a suitable mailing list as well
>    c) Ideally: find the original patch on the mailing list and do a
>       reply-to-all to that, adding suitable additional cc's
>=20
> *** Remember to use Documentation/SubmitChecklist when testing your code =
***
>=20
> See http://userweb.kernel.org/~akpm/stuff/added-to-mm.txt to find
> out what to do about this
>=20
> The current -mm tree may be found at http://userweb.kernel.org/~akpm/mmot=
m/
>=20
> ------------------------------------------------------
> Subject: ricoh_mmc-port-from-driver-to-pci-quirk-update
> From: Maxim Levitsky <maximlevitsky@gmail.com>
>=20
> This patch solves nasty problem original driver had.
> Original goal of the ricoh_mmc, was to disable this device because
> then, mmc cards can be read using standard SDHCI controller,
> thus avoiding the need in yet another driver.
> However, the act of disablement, makes other pci functions that belong to
> this controller (xD and memstick) shift up one level, thus pci core has n=
ow wrong idea
> about these devices.
>=20
> To fix this issue, this patch moves the driver into pci quirk section, th=
us it
> is executed before the pci is enumerated, and therefore solve that issue,
> also the same is preformed on resume for same reasons.
>=20
> Also regardless of the above, this way is cleaner.
>=20
> You still need to set CONFIG_MMC_RICOH_MMC
> to enable this quirk
>=20
> Signed-off-by: Maxim Levitsky <maximlevitsky@gmail.com>
> Cc: Philip Langdale <philipl@overt.org>
> Cc: Wolfram Sang <w.sang@pengutronix.de>

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktnOv8ACgkQD27XaX1/VRvTaQCgl5BekUX9lkigLocJO2Xi4PA8
hDYAoLJ1yln2eJhR+QDANZJm1oj7BEbM
=go61
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
