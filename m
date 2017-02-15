From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 4/4] mmc: host: tmio: fill in response from auto cmd12
Date: Wed, 15 Feb 2017 16:02:41 +0100
Message-ID: <20170215150240.GA1430@katana>
References: <20170213180342.26172-1-wsa+renesas@sang-engineering.com>
 <20170213180342.26172-5-wsa+renesas@sang-engineering.com>
 <HK2PR06MB05484A4141A1A9AC8BE54E00D8580@HK2PR06MB0548.apcprd06.prod.outlook.com>
 <20170214105226.GB1453@katana>
 <CAPDyKFobQ07u_xUgpm7iQRJkCqVS9_6JvyoTDhqLM-R3qCFeGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:37466 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751297AbdBOPCp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 15 Feb 2017 10:02:45 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFobQ07u_xUgpm7iQRJkCqVS9_6JvyoTDhqLM-R3qCFeGQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms+renesas@verge.net.au>


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > I see. Ulf, do you think it makes sense to extend the condition when to
> > call mmc_blk_cmd_recovery() with checking if stop.resp[0] has one of the
> > R1_* bits set which are marked with 'ex' (and probably 'erx', too)? I
> > agree with Shimoda-san, that the core is a good place to do it, since it
> > is about parsing the R1 and not the status bits of the host hardware.
>=20
> The method we use to indicate a stop command error to the mmc core, is
> to set ->stop.error in the host driver before completing the request.
> Perhaps set it to -EIO or -EILSEQ.
>=20
> In that way mmc_blk_err_check() sees the error and invokes the
> mmc_blk_cmd_recovery() to deal with it (response parsing etc).
>=20
> Does that work for you?

It would work, yes. Since R1 response format is hardware independent, I
wondered if checking for ECC errors wouldn't be better suited in the
core. We roughly need something like this:

	if (stop.resp[0] & R1_CARD_ECC_FAILED)
		stop.error =3D -EIO;

We can copy this into every driver, of course. Yet, I wondered if we
couldn't have a helper function mapping the R1 error bits to an
apropriate error value and call that just before the check in
mmc_blk_err_check().

Do you get what I mean?

Thanks,

   Wolfram


--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYpG2QAAoJEBQN5MwUoCm22rMP/jpxlPyf1rj+yGUHLkPo0Pz4
wHWJWi9emTYt5/6cDTQH/mtNdMV1yj5J8c5yL/PNZPg/ufyQTyOcquZbyqrSkpFA
kGObEKaLy/AhMifC7xlg3CD1wsPpXVZ2fHsyHivdfknDhyM3b5RAHXpHLyyVpOrm
V2AYOAZuACfkYwkva/XV83Px+sbPzQ2U1sJQHub35mspVJWAqL/1c/0V72BFjBMt
lhAhY+JIUykpXfwMs34Vz84Gm4JgnGM6JVefiseJhSFzpBOW5xSQZMTJTtg7g9LY
FCjVIpJup5MZL+OtnYCrjfC3z/OD5bSI2pZ2XdqYNcvBs45Igl+ak9i8UujVehT2
DKZ1IzqlNHzT5xNbmqdElVjRkMxk/zFZW5414cpn7CeqWMOJpuGp7ekjko1Zq3FK
eMyOEUZQ9YLbbFXc5tbgECUrBCIpfUhmm6umrWmnuD2DrFjC8TodQ4dC7b52W3Qh
1jQxi3HJyorVFTPu9m9xD+YI1vfrTXiqPk/yaXWcI7DGjIIJAREO9pl+hfKksL4U
Js9OpQpg+Pp+m4NoG4mFXjEEuqIVMHpMUyeRTWuzOSipj2xHfC26bh7PUB/mivUu
tQUC2Sw3KYfFp80iabzUNfxf5pm0u0+oTpMwrlkxU2V4mkPqvL7dgrxAx+shIP7i
gRt8gFKPenhPhpADb1p0
=ec9M
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
