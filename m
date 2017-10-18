From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 2/3] dt-bindings: mmc: renesas_sdhi: add R-Car
 Gen[123] fallback compatibility strings
Date: Wed, 18 Oct 2017 09:24:56 +0200
Message-ID: <20171018072456.tp3vdcuvkxpu7yd4@ninjato>
References: <20171018070023.3878-1-horms+renesas@verge.net.au>
 <20171018070023.3878-3-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jfajk7u4fn52bx2k"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:56114 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752387AbdJRHY6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 18 Oct 2017 03:24:58 -0400
Content-Disposition: inline
In-Reply-To: <20171018070023.3878-3-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org


--jfajk7u4fn52bx2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2017 at 09:00:22AM +0200, Simon Horman wrote:
> Add fallback compatibility strings for R-Car Gen 1, 2 and 3.
>=20
> In the case of Renesas R-Car hardware we know that there are generations =
of
> SoCs, f.e. Gen 1 and 2. But beyond that its not clear what the relationsh=
ip
> between IP blocks might be. For example, I believe that r8a7790 is older
> than r8a7791 but that doesn't imply that the latter is a descendant of the
> former or vice versa.
>=20
> We can, however, by examining the documentation and behaviour of the
> hardware at run-time observe that the current driver implementation appea=
rs
> to be compatible with the IP blocks on SoCs within a given generation.
>=20
> For the above reasons and convenience when enabling new SoCs a
> per-generation fallback compatibility string scheme is being adopted for
> drivers for Renesas SoCs.
>=20
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--jfajk7u4fn52bx2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnnAcgACgkQFA3kzBSg
KbYNYA//YKLWhob2dqpFBNEKYSF+Wu8k4qnBM7eQRcyRMd9VXtWoAY0z5dvCVLp5
FlQWXohKTNJMLVj8fYP21hT80hndGTdqLspTcFeV4TM5cnZKNwjfz3Wxx8eUxK/2
EB2leHzp7iQTh79bd7pbo7HyTRVInSREHRYX4VdTpkw/dcBI+MmSa4IwiSxcuIae
XRuX1Behy4h9/jqwWFNdEJaR7UokBzP7N1ik7gGXr0sF7J8AGc35tp1NMI17cMcs
Wfmw96hOTYhbphDPpHLiXm1yWKu2q8Xwnnn2JhKcKbFIK10L1XBzYyvhfhD2DXxQ
RJNnb/v8DS78y+eChIxplQJ/5vpj21t4wI7gtsdA/t+zgtPMqFVkaCFxxZwddxMK
Ogu4R8YYC/sz8KYLEA65G7EbNdMHNERGHXw7Nxb6Fs0bYeM5owtKn85SO5EKJLYr
jjs16yHmtAAw9D7iXMt7szB3mQOAEImgj+PvhxV71KRFtwYGUkeBYoAN7xKeX7HN
nGsHIPs4looLULPRPPphkVQYtyCT2gG8e/uJ5kf5IaXIu07ASoKJ9tpCONnNo41A
fAHoOluZPB2RP307xJ+TF37Qc7Kw9h1Bv3PLkMeUnQEP5r71sC+rTkdWoDKMfKlO
pzfMVbTQJ6paixTR/Ixc/GIFj7lEBWEA7fchIHnHd0wb3s1g6Rk=
=nr0U
-----END PGP SIGNATURE-----

--jfajk7u4fn52bx2k--
