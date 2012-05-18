From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 07/29] mmc: add a function to get a regulator, supplying
 card's Vdd
Date: Fri, 18 May 2012 17:04:19 +0100
Message-ID: <20120518160418.GK4039@opensource.wolfsonmicro.com>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
 <1336057558-11031-8-git-send-email-g.liakhovetski@gmx.de>
 <20120503154252.GO3955@opensource.wolfsonmicro.com>
 <Pine.LNX.4.64.1205181059560.23140@axis700.grange>
 <20120518151837.GD4039@opensource.wolfsonmicro.com>
 <Pine.LNX.4.64.1205181727320.23140@axis700.grange>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Xsn3knLL3qrmRbVI"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1205181727320.23140@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--Xsn3knLL3qrmRbVI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 18, 2012 at 05:39:39PM +0200, Guennadi Liakhovetski wrote:

> 08/29] mmc: sh_mmcif: add regulator support"). But perhaps giving=20
> preference to the regulator is bogus. Maybe I should just switch both, or=
=20
> even give preference to the call-back. What do you think? Switching both=
=20
> is, perhaps, the safest bet.

I think most things either give preference to the callback or complain
if you try to set both.

--Xsn3knLL3qrmRbVI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPtnLzAAoJEBus8iNuMP3dnlkQAIHHqp2rR/ro8/bcOTy/PQAG
oRrdZ9C36b8tBIrPP1HvKVN+fxyQwcuxO1BLnVe6LzZi6N7vufZy+Rp44AXesDg+
RlEpZNHMRIFB0iaOTRVvzKPGgD2T2R40MJYk2TKkXgqZhAwy4UNk8xnezDu/D9kz
sfp/RVGPv3uKx1+7uEKd/j7Xag+A9WeI84jy547y7pDDe+OCfhkto+LOX7sU/WC7
6T3WRkGiipMl029gWdMuV+x9jutQalcj+IOb3pNN2vH4u/IhIliEPxnCMSIf8Afx
M7LCgUALtjB4xsfw+EE+mCLBIJ0d3i8OW+DgdRBfiyhIeY0d53iiaNw9ksvWPqdV
Yt9if9qjLBGG5OVuAAvR4PtH21fxR0EgRpJiP3McxRxWcExEebmM3XBTRP07K3Yk
mPMz5FBEaSXuZ26+a65kGk8sMorK2xydjNmCoaWh9zuQiVqZF7C3W8wNvPsxRvLM
fW3wWl+mYn+sM7Y7W8BP0EBMotenJ6zC8x8k5uT1k7KvHv9a+ztL0C2ru+HV1qs+
a/ctleTrKMJAZX75MQ7XT+OUBntG0s/GtXSiN/EwA3Kakr+/hcLATqI0VtVEwvdE
x8xfyabukKUMBo0WHRCblXkGvxMIHeMXA3ThHW6OjNNaga7BAGUWcGPP7kvmwwU9
AINI3RTNy+czw/yBjTeD
=lwqX
-----END PGP SIGNATURE-----

--Xsn3knLL3qrmRbVI--
