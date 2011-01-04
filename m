From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/2] sdhci: add quirk for max len ADMA descriptors
Date: Tue, 4 Jan 2011 15:14:34 +0100
Message-ID: <20110104141434.GA2609@pengutronix.de>
References: <1293096475-19634-1-git-send-email-olof@lixom.net>
 <1293096475-19634-2-git-send-email-olof@lixom.net>
 <20101223112606.GB5044@pengutronix.de>
 <AANLkTi=SRwNq0918xfra=4ZHzNsGT1nBNxpUnPAoSj3-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34352 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378Ab1ADOOk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jan 2011 09:14:40 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=SRwNq0918xfra=4ZHzNsGT1nBNxpUnPAoSj3-@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Olof,

happy new 2011, first of all.

On Thu, Dec 23, 2010 at 10:26:16AM -0800, Olof Johansson wrote:
> > I tend to NACK it (but I am not the maintainer). I'd prefer to see a
> > draft of your idea of a sdhci_add_host_fixup()-function :)
>=20
> See, I tend to get annoyed when I get asked to clean up others' messes
> because something I do is all of the sudden held to a higher standard
> than they have been.

If I wasn't stubborn, the bits would have run out in October already,
and you'd be in a worse situation now ;) That put aside, I anticipated
that Chris is going to pick up your patches nonetheless (which causes no
hard feelings here), that's why I wrote "I am not the maintainer".

BTW I'd say cleaning up mess from the past is not that uncommon in
kernel-development (think BKL), and raising standards is a good thing as
well, no?

I see your point, though, that if you introduce a fixup()-function now,
nobody will convert an existing driver to it. It would be nice to have
the cleanup in one go, but until someone is driving/funding this bigger
step, we have to fiddle with incremental improvements which need a bit
more negotiation, it seems.

Kind regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk0jK0oACgkQD27XaX1/VRuLVwCeLk+5ankREEG+iKk47/Lu8MPe
5U0Anjhy9YJ3KxyJ5rfoobf0USgZsliu
=+awp
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
