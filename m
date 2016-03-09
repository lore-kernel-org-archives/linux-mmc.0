From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC 5/7] mmc: sh_mobile_sdhi: Add UHS-I mode support
Date: Wed, 9 Mar 2016 17:20:02 +0100
Message-ID: <20160309162002.GC9443@katana>
References: <1455913003-6140-1-git-send-email-wsa@the-dreams.de>
 <1455913003-6140-6-git-send-email-wsa@the-dreams.de>
 <CAPDyKFovA5iq2yJ18d6hZussOExJn+0HanKGOLALiDGcxVjJnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3siQDZowHQqNOShm"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:52438 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933107AbcCIQUP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 9 Mar 2016 11:20:15 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFovA5iq2yJ18d6hZussOExJn+0HanKGOLALiDGcxVjJnA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-renesas-soc@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, Ben Hutchings <ben.hutchings@codethink.co.uk>, Dirk Behme <dirk.behme@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>


--3siQDZowHQqNOShm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> May I suggest the following names for the pin states instead?
> pins_default
> pins_uhs

Did this.

> The corresponding pinctrl state-names I prefer are these:
>=20
> PINCTRL_STATE_DEFAULT and "state_uhs". These names are currently used by =
mtk-sd.

OK. I'd think "uhs" may be an even better name, because "default"
neither has a "state_" prefix. But for consistency, I'll keep it for now
as "state_uhs".

> I am missing a separate DT binding documentation patch related to the
> above pinctrls.

Was waiting for the bindings to be accepted first :)

Thanks for your reviews!


--3siQDZowHQqNOShm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW4E0yAAoJEBQN5MwUoCm2bBEQAKkw3nPhYja3pA9JFYUrHSpU
Q3ThRzRxH3IVsCRTamj0OoU8wBfNipu/ea/KILhoREdJeBQtoyuA/VLR9Ngm9xc0
Ffb6vnC0fBMqK0wFfWkKiIHKy4U1TOaOWpg5pc58GKHCKeBzaBDiWYBB8O7r56iP
/pH6DL/j3gk7j2cef0Jg+Z3ElOpsz3mmfIj+nAFiLxubUTT/f94lI9zPj2U9PY4J
C5lv9M8Qf4rijjBIVJ0fBV8BUZGx4se2sJNA5RGrJOfZuYtSe3PEpQEQj4skSDs7
tfEoef5nMaF46SBDOwQNJ8Lm749OMSBpAOSh4sw0JBfGJVVBasstndPeNVlEVABC
GrGNVi9GOJw7aKbAaHNb2FybZj/BOeWVOmFzWT6zl/vGOM86u/2um0e/O53oEElM
ofT3C4JjCRnNN7aqCaoSCHknuyijSdcunRw1VPSgY6UnMgKw7T8r4lhEKGVNQPJj
2bd3kLQ06BFUU8o1KUjubka7iqxlkXW65Nq+YFFzNLrtZt8lxUZOcZFrCcCfqfaA
25X81bzAIMT++W0LEP10sbGe0Gt5n5B/tk/vay9nuG9D3hPMpxd34jS7BZCtIjVI
8dZwbdeMbMP7Pmbg+QzbrioqtQ4VUyILtWQ6elnHIfxOivtroNpHZGt9liT0qhep
D2+iia/QAP1cKcMIaOAc
=BGsn
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--
