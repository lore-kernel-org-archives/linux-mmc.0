From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC PATCH] mmc: tmio: check mmc_regulator_get_supply return
 value
Date: Wed, 4 Oct 2017 20:30:24 +0200
Message-ID: <20171004183024.zv6oir7bc4te4k24@ninjato>
References: <1506079337-12882-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <7e1bdda1-d790-0db2-540c-69fabe22850a@rock-chips.com>
 <20170922160405.wfpi4fyziz3sxtmh@katana>
 <TY1PR06MB089584E681911E2C49953F29C0730@TY1PR06MB0895.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="j7eg6qu7bcxyfs3o"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:36148 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750937AbdJDSa0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 4 Oct 2017 14:30:26 -0400
Content-Disposition: inline
In-Reply-To: <TY1PR06MB089584E681911E2C49953F29C0730@TY1PR06MB0895.apcprd06.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>, Simon Horman <horms+renesas@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>


--j7eg6qu7bcxyfs3o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Fabrizio,

On Wed, Oct 04, 2017 at 10:50:54AM +0000, Fabrizio Castro wrote:
> Thank you guys for your comments!
>=20
> > > > However, there are side effects to it as the mmc devices will be en=
umerated
> > > > in a different order (due to -EPROBE_DEFER), this means this patch =
would likely
> > > > break existing platforms.
> > >
> > > However this doesn't. The user daemon should never relies on the
> > > sequency of probing the mmc block part. We neither support to provide
> > > alias for the device id, nor guarantee the first probed controller get
> > > the first block id. Please use PARTUUID for rootfs, etc. So this
> > > shouldn't be a big deal.
> >
> > That's exactly what I thought as well...
> >
> > Thanks for the patch! Will test it the next days, but it looks good
> > already.
>=20
> How is the testing going? Any problem with the patch?

Sorry for the delay, there were some other things in the queue...

Well, the good news is that it didn't cause a regression for me on R-Car
E2 (Alt board) and H3 (Salvator X board).

Sadly, it doesn't also fix the SDR104 problems on Alt. I had a little
hope this could be the culprit, but sadly it is not. But this is not a
problem with this patch. It still fixes a valid issue.

Looking how other drivers deal with the issue, though, I noticed they
only bail out on -EPROBE_DEFER and would continue on other errors (if
mmc_regulator_get_supply would throw them, but it doesn't). So some
digging why other drivers do it that way seems to be apropriate to me.
Or asking Ulf :)

Kind regards,

   Wolfram


--j7eg6qu7bcxyfs3o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnVKLwACgkQFA3kzBSg
KbZTOBAAnmGc6G/l49u0I4l0BoobBR2G4iL8BM96U7Rkky58oVUO5dgxzDEv/R3D
Ts9Sg94iDd0VsAdRtNh3XDSOfg/VDZfIxkQZJM7rS9/PWijc/p/lGSJJxYbbQVC1
dQp/IcBI058+iPSXZDrVzqPoYc0LohU4FnKLBps7nhv1pcon+ah6xKA/4vl4tipy
q+ZCMNidDLvxEPqRasal8xM/LTCDB+au+OIpxqkgIW2NCGs/+Y17tfduMGnsjY6k
J2bUEC8IPViJCXOvlNVzxxLFszoeDUFSCAl+IJjiZtxcCDNz9Kr5Ms2SN1cY46Bi
CWpi2jl2/Q2dNsEdRxp1taMNK3UVsf/PbMjAuMTx0xk+avyyInRc20DmYDtwhd5J
1CYTCgh7fm3V3jh45Uhp2X3KAaCuDWZftGpfBodK9k1OvjjULwOEsa+XK0QPevbt
B1Abx9DDiJTs2ZsclA5fe92hd4K2Bhi845mBvTxaecnzZcBwoCt1wQv1HTzvHIwo
Bgv6eomIZHkHMWTqSo7eOTw1MVW3Jiy/5/6UHI1LPzVFRme+Tjdl1TLhYJxZ2uZv
segI+/SdaJvNSPQzFXcC98dZ8JOhISMHA6CHlmai79oYQ9PYGLFibNUyyO8h0yvj
5q99i+cUYhdqOW0Z1BYskMDmlVoqgr4cXGhjVJ3bHPN0xTv/SNI=
=Lskd
-----END PGP SIGNATURE-----

--j7eg6qu7bcxyfs3o--
