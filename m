From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v8 0/6] UHS-I SDR-104 support for sh_mobile_sdhi
Date: Thu, 10 Nov 2016 12:45:49 +0100
Message-ID: <20161110114549.GC1436@katana>
References: <1478182564-18762-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kVXhAStRUZ/+rrGn"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:33484 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755422AbcKJLp7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 10 Nov 2016 06:45:59 -0500
Content-Disposition: inline
In-Reply-To: <1478182564-18762-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org


--kVXhAStRUZ/+rrGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 03, 2016 at 03:15:58PM +0100, Simon Horman wrote:
> Hi,
>=20
> this series is based on work by Ai Kyuse to add UHS-I SDR-104 support for
> sh_mobile_sdhi. It builds on work by Shinobu Uehara, Rob Taylor, William
> Towle and Ian Molton, Ben Hutchings, Wolfram Sang and others to add UHS-I
> SDR-50 support to the same driver.
>=20
> It is based on the next branch of the mmc tree.
>=20
> To aid review the following git branch is provided:
> * https:://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git topi=
c/sdr104-driver-v8
>=20
> Overview of changes since v7:
> * Correct inverted logic in sh_mobile_sdhi_hw_reset
> * Correct value of SH_MOBILE_SDHI_SCC_RVSCNTL_RVSEN
>=20
> Please see http://elinux.org/Tests:SD-SDHI-SDR104 for indicative tests
> results.

Successfully tested on a Lager Board with a SanDisk card and a Samsung
card which used to cause issues before.

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Ulf, I think this series is ready to go for v4.10. All issues we know of
are related to pinmuxing and will be solved elsewhere. We currently have
hacks for that so it is quite clear the issues are not caused by this
series.


--kVXhAStRUZ/+rrGn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYJF3tAAoJEBQN5MwUoCm2+70QAI80WmFzMVGXCnN5ZU2q/Uty
g+hb5ERt+a3oXUb8xtmbt+ZQob93/i1dKY5NpV0FOfl3CM7FNkGnjsV7ows7x2uQ
fBncp3l0Gk83Hi3jlRUrWg+fos236FJQzvh5PtsnjFjsprOsQiAMGHXqZAh9bXKR
Lmu/3Y/EcxlFdpRtrZxTI4289WoXHHldUcN7USm8/2A4fkbg3ERlEad1BxoUa6TN
4JxJD5Un0Ssw2+lJJFEdWip2zOivG60EV7cJmmi7iRnfYQml94KbBcSuw8te2q4X
jCN95tRigkjcD7ThvzZmjxf5RlxNaHpp0GlANpP+J2ZXT/zS1Z+iFLFBjLgq3giU
qz7+g6BUg8MQYmhJmfRAZzdjdfG/6Ba68KEOZRtfC+VrBpWz/fPZjNWxCYwvKofb
PWphepG9DVSzI34wfRG+U3apWcLgAX1Swz13WPn8og4VarNuQ/IPk1eVOBU/aWhb
q9YU4I5gYbnMbJ937ggWkk8n3Rjb+dMjjt6mGP15jL29jqTxzPYu8opMFUm7VMmF
Q6ez+LUO0J/dXVcBnnRpSlxb+Wj9510PfD/VOT4X/pqTLZbnhUPt0BZ/9uXCeG+H
ASrKFwSumtNkjucR0ap1mEFKtjyyVEumCkkWtjjblOm9w+gB2Ne+fjOIk274YO2K
YJ1J1kj9S61YmFFFKJzY
=8X6A
-----END PGP SIGNATURE-----

--kVXhAStRUZ/+rrGn--
