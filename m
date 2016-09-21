From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 1/6] mmc: add define for R1 response without CRC
Date: Wed, 21 Sep 2016 08:00:33 +0200
Message-ID: <20160921060033.GD1484@katana>
References: <20160919205750.4766-1-wsa+renesas@sang-engineering.com>
 <CGME20160919205932epcas1p3cec11c9dbe2589f7d50fee5932797933@epcas1p3.samsung.com>
 <20160919205750.4766-2-wsa+renesas@sang-engineering.com>
 <ee4fe6b6-14bd-a0a5-9d6c-30c314ed83c3@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="osDK9TLjxFScVI/L"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:44025 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750858AbcIUGAl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 21 Sep 2016 02:00:41 -0400
Content-Disposition: inline
In-Reply-To: <ee4fe6b6-14bd-a0a5-9d6c-30c314ed83c3@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Dirk Behme <dirk.behme@gmail.com>


--osDK9TLjxFScVI/L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 20, 2016 at 06:25:37PM +0900, Jaehoon Chung wrote:
> Hi Wolfram,
>=20
> On 09/20/2016 05:57 AM, Wolfram Sang wrote:
> > The core uses it for polling. Give drivers a proper define handle this
> > case like for other response types.
> >=20
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > ---
> >  include/linux/mmc/core.h | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> > index b01e77de1a74de..4caee099b63a28 100644
> > --- a/include/linux/mmc/core.h
> > +++ b/include/linux/mmc/core.h
> > @@ -55,6 +55,9 @@ struct mmc_command {
> >  #define MMC_RSP_R6	(MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE)
> >  #define MMC_RSP_R7	(MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE)
> > =20
> > +/* Can be used by core to poll after switch to MMC HS mode */
> > +#define MMC_RSP_R1_NO_CRC	(MMC_RSP_PRESENT|MMC_RSP_OPCODE)
>=20
> MMC_RSP_RQ_NO_CRC is described at Specification?

Yes. JEDEC eMMC Spec v5.1, chapter 6.6.2, in the note:

"NOTE While the actual timing change is done, the behavior of any
command sent (like CMD13) cannot be guaranteed due to the asynchronous
operation. Therefore it is not recommended to use CMD13 to check the
busy completion of the timing change indication. In case CMD13 is used
the host must ignore CRC errors, if appear."

And the MMC core does that. In mmc_ops.c:

70         if (ignore_crc)
71                 cmd.flags &=3D ~MMC_RSP_CRC;

And ignore_crc is used in mmc.c (last 'true' parameter):

1023         err =3D __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
1024                            EXT_CSD_HS_TIMING, EXT_CSD_TIMING_HS,
1025                            card->ext_csd.generic_cmd6_time,
1026                            true, false, true);

This is why I put the comment above the define.


--osDK9TLjxFScVI/L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX4iIBAAoJEBQN5MwUoCm2mkwQAJ7/L9jFiVrE3363M6TaQJuh
0IIWfnx4ggV/iDw+Fjs93fioDGEXXluPYpiNr+5Y2uAYLT8l6KnjAhBknuE/Sgbw
h7E3C+XPZLBaMXSXlDv5uF7fvgxck1Yb8ODSHpc+OKK5egOnfFbUBxmlyWpMsod1
gibnur2yM6isybxzR+kI8B+gZWBu8jMqIIG71iJg+zPzwpPeQwa5N1sL2J87dkOL
W0MvIV6rFA0Vt6mxNYSerdvlgUk45FNjj4DcE/ywvJIltNk6ATTb6HiabYpeVA9c
CiVbKu65rvQUzyA++tGLktA/D6zEmSHgVDck59ZvqgiRIGMBUcu/Qy3ViC3guIKE
+z3jLXzpdS9LlQiusq0cemt9+/uVF6aWWOhbemw4I8s6oAOz2Y6hfHgplDecR9E7
9eTgvr/Pb5yOyrRwQHfEWaWGiry+oqraqALmVGouOA7gavLiE89GMF03Ux/l2IDL
FN69EfZAjM8Ym9vv+FqyXOryIUqwmsUW7dMkf9F+0ySL2dyQLqxz4IgnVqVVu2K4
3mnUa2XiAmOgv30LMIkaU1B8fl53eMw6qnxJfPsCRBxcYy5DfOJQh+UsxJXzjT2R
fu53n+gDKUMJvJt+hHc3oWONm6gc/9Xh5Qr3bO/JXXMj4aYI9IzX3caZF9MnmvXq
bmdS4VJE4iOb66CDaeT6
=bTo6
-----END PGP SIGNATURE-----

--osDK9TLjxFScVI/L--
