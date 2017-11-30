From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [bug report] mmc: parse new binding for eMMC fixed driver type
Date: Thu, 30 Nov 2017 15:39:05 +0100
Message-ID: <20171130143905.vbl45pvopvlj6b3h@ninjato>
References: <20171130092027.pt4i5knisyv2c6pr@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ewpdjnxgvbfhzvhz"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:58640 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751976AbdK3OjH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 30 Nov 2017 09:39:07 -0500
Content-Disposition: inline
In-Reply-To: <20171130092027.pt4i5knisyv2c6pr@mwanda>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: wsa+renesas@sang-engineering.com, linux-mmc@vger.kernel.org


--ewpdjnxgvbfhzvhz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> The patch 6186d06c519e: "mmc: parse new binding for eMMC fixed driver
> type" from Oct 15, 2017, leads to the following static checker
> warning:
>=20
> 	drivers/mmc/core/mmc.c:1309 mmc_select_driver_type()
> 	error: uninitialized symbol 'drv_type'.

Thanks for the report!

Correct. The code used to be in mmc_select_drive_strength() which
already has:

	*drv_type =3D 0;

After the code move, this was missed. I'll send a fix today!

Thanks again!

   Wolfram


--ewpdjnxgvbfhzvhz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlogGAkACgkQFA3kzBSg
Kba3Ug/+KbVUMGo0MZnkQIxC1dG5SQhU5pvUytpLoSJhuEm9HMveApv2PGmDB5+t
zOpMKy71CEcxTT/DynWN0qN8OG5LfkTN+rE1z5phIZre83Y7y3Y/jhCEOEwd1xSW
k3eQyXinc2uMQXK4qwCG4O5qhZ93iaLidBELEnwMC5m2iy+wLwTD1l5Q3F6QFddl
KaijK/wUHqotX3nrwyWfDGApuqMV8sl9Oha3wjqGtNe4diEUvLgJmS0LQpury9WC
obGFrdALcYIATPctjtr+iCvJPYll/2zl7kbDFVRreq+nRONIgQ88nw1KrgiTdQTj
NxsK6i7noAhYh7kIjZFvdyzXk5lSUWx/QnJNpcLDp/L8qYno+9b5BF/BwHvOEgTb
y7tFhEeElz4ZGnPGXyJx3n0nZ76/1/DzbE6WghMRye8TRbzZInexiU7ognATv+VX
C/GKAIX1ySc+OLlcu6IMXx8BgTCHDboZTHeqSlUPdffwbt9GQF7/4CtSGQyqnAYe
xRP8RSywb3YPN55QLsUufiSO7kFM4ttL7ojKJg65z7sFpkDFpe1IFqBZHDbCey3T
9W/EL/KeQr9tvI6mUcBviLt5HQvnZ2JXPGDsJV85RRcgH0YaMC8+b49eVek4NIXC
FdjI9Kyak38S8DU0KjEGmE76kDxUezymbW7wPDwOFG5yEfSk008=
=8n6p
-----END PGP SIGNATURE-----

--ewpdjnxgvbfhzvhz--
