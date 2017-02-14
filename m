From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 4/4] mmc: host: tmio: fill in response from auto cmd12
Date: Tue, 14 Feb 2017 11:52:26 +0100
Message-ID: <20170214105226.GB1453@katana>
References: <20170213180342.26172-1-wsa+renesas@sang-engineering.com>
 <20170213180342.26172-5-wsa+renesas@sang-engineering.com>
 <HK2PR06MB05484A4141A1A9AC8BE54E00D8580@HK2PR06MB0548.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <HK2PR06MB05484A4141A1A9AC8BE54E00D8580@HK2PR06MB0548.apcprd06.prod.outlook.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Shimoda-san, Ulf,

On Tue, Feb 14, 2017 at 10:06:47AM +0000, Yoshihiro Shimoda wrote:
> Hi,
>=20
> > From: Wolfram Sang [mailto:wsa+renesas@sang-engineering.com]
> > Sent: Tuesday, February 14, 2017 3:04 AM
> >=20
> > After we received the dataend interrupt, R1 response register carries
> > the value from the automatically generated stop command. Report that
> > info back to the MMC block layer, so we will be notified in case of e.g.
> > ECC errors which happened during the last transfer.
> >=20
> > Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> I tested this patch with a SD tester (SGDK320).
> As the commit log, this patch could pass the R1 response. So,
>=20
> Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Thank you very much for testing!

> However, I think the MMC block layer should check the brq->stop.resp[0]
> because brq->stop.error should be zero in this case and mmc_blk_cmd_recov=
ery()
> is not called in mmc_blk_err_check().

I see. Ulf, do you think it makes sense to extend the condition when to
call mmc_blk_cmd_recovery() with checking if stop.resp[0] has one of the
R1_* bits set which are marked with 'ex' (and probably 'erx', too)? I
agree with Shimoda-san, that the core is a good place to do it, since it
is about parsing the R1 and not the status bits of the host hardware.

Regards,

   Wolfram


--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYouFqAAoJEBQN5MwUoCm2/KAP/2aNrmtgMQMDfmNoFJdYMZvh
3HjLgLcCWDytxDYiKuXpFWQj8bPuEi/tuLCEaNsQj1yX/vlwvgsF7rqveJKeSvz6
kioh04a7D9deLLPJNDIHnNjGFcMA8qLUEkIKszWLcbPUCk2YvSLpxIcLLfEQTY/c
1ch/iuFY3cEIKUBPovJoTuzj7N2krf99IoDpiafT6Z653efImTBa5gnejoUQG37N
97A42UdUHZXcDnPK2/R8llvzRozA1HNghpkR15e5Pn/QcGlPGkgpb8R65TCMeKd8
SAk+UIv+AUP7ATbAJq34W4+jLNAqi8Ln09Ko5I1qEzT9qVBM0MMpb5AX3ESU73Cw
u4JPAAS01OGvuuAlOvKVqokt41lcQnAw4KkUD6y0dl2/u4Ew6bY9to0eZPLridH3
r+1PqDvFeU09XtXg/XrNDGdbqpMr3bI139bvxqNhriy47xRClL/GL7JAPsY9Js3u
cdbRoL7L1s8DvDXtmfukdUUw1eVSkj8yZ0xtud7TsjzH/mR4IoZuhtZoTmRowrlg
ft4X9dCes6olZ1N0QzlvrEibO8UfBUGr6HtDq51bzDPzF8bBH2xorN0M0qCayCYA
kOnfsS3DUMreQjPe+kIYRbsi8p81tpLJpr6my4i9PN7ACzyyOe7M+Zrv56EJiMXn
m5CB2chImtN1mivU8sk1
=V3Zx
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--
