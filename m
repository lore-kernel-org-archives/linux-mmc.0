From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: use for OMAP5 as well
Date: Tue, 9 Jul 2013 09:52:47 +0300
Message-ID: <20130709065247.GD5552@arwen.pp.htv.fi>
References: <1372422894-23729-1-git-send-email-a-bindra@ti.com>
 <51CDB260.8080108@ti.com>
 <20130707201309.GA5429@localhost>
 <20130708074606.GD16635@arwen.pp.htv.fi>
 <20130708195828.GA28218@kahuna>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Km1U/tdNT/EmXiR1"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48132 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859Ab3GIGxG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Jul 2013 02:53:06 -0400
Content-Disposition: inline
In-Reply-To: <20130708195828.GA28218@kahuna>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Felipe Balbi <balbi@ti.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Balaji T K <balajitk@ti.com>, a-bindra@ti.com, linux-mmc@vger.kernel.org, cjb@laptop.org, linux-omap@vger.kernel.org

--Km1U/tdNT/EmXiR1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 08, 2013 at 02:58:28PM -0500, Nishanth Menon wrote:
> On 10:46-20130708, Felipe Balbi wrote:
> > On Sun, Jul 07, 2013 at 05:13:10PM -0300, Ezequiel Garcia wrote:
> > > Hi guys,
> > >=20
> > > On Fri, Jun 28, 2013 at 09:27:20PM +0530, Balaji T K wrote:
> > > > On Friday 28 June 2013 06:04 PM, a-bindra@ti.com wrote:
> > > > > From: Amarinder Bindra <a-bindra@ti.com>
> > > > >
> > > > > OMAP's hs_mmc driver is also used for OMAP5 MMC controller operat=
ion.
> > > > > Considering that the device tree entries are already there for th=
is,
> > > > > allow the driver to be built when only OMAP5 is enabled.
> > > > > This allows MMC root filesystems to be available in "OMAP5 only"
> > > > > configurations.
> > > > >
> > > > > Signed-off-by: Amarinder Bindra <a-bindra@ti.com>
> > > > > Acked-by: Felipe Balbi <balbi@ti.com>
> > > > > Acked-by: Nishanth Menon <nm@ti.com>
> > > >=20
> > > > Looks good to me,
> > > > Acked-by: Balaji T K <balajitk@ti.com>
> > > >=20
> > >=20
> > > I came across this same issue while trying MMC patches on AM3xx,
> > > which is nor OMAP3 neither OMAP4.
> > >=20
> > > Now, looking at the driver I don't see any OMAP-specific bits
> > > (welcome to the multiplatform world ;-) so I think we can just
> > > remove the 'depends' line. Something like this:
> >=20
> > frankly speaking, this driver should be deleted and all users should be
> > moved to sdhci. OMAP's HSMMC controller is compatible with SDHCI except
> > for a couple quirks which can be easily worked around.
> Do we take that as a NAK to this specific patch?

heh, not really. We can't prevent bug fixes to this driver just because
long ago TI decided to write a TI-specific driver when it could just
re-use SDHCI :-)

--=20
balbi

--Km1U/tdNT/EmXiR1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR27M/AAoJEIaOsuA1yqREi0wQAIOEI7pi5VGpX2u0vUJ2Ye3o
ylhhekLVOY+2wU09IoacoG9c3WWqus/JumgDoFJ9IGR7ePgJVQpTcq4x8qIiv01C
Ogn7FdP9gwdtdvh9FD6L+RTrgThHoY/JFo5ol5D/3xSLnpiC5jrIANBxcTsaCGIX
v4Di92uKWj+QTuxm74CQmFh4hZx+eHOfwPW8sdBeIBFNQdZ4xGGB+6HdQpv45PyW
ZDJ7HieODPteIysTKKqEGFa/lZGHHjklqgQEQKISDwkoaP3YzPMmQD/FOBTzzdDW
u0U3/RRQCZ0dW+54wDaqXkb8zkq/ypp78l1nwJpgMq2NqWRu5Owae+2VePoaDoOn
U9gZVzVasqlaJ97Hm1tm5IOko6HWtI6NGKfoZYKnS/E8hKCzycEioMaH0J55uIu4
2b8iyZMeaduSd7GTcBBV1f2yZgViGZEYNdODgCk3gDgy0zYrd1OsPlK3quZpEQ20
0XyP29+x/NZz8GGtEh6zDYT1stv8j20YxJVysk2iU59Sv8uv4xbsWZs5LjuGRxjB
TQpF2obSdZDRecDk3WnBvPApt8p8LxOfgzQjPpqOrdyTQe/Z4/dqIB+1BrUKnV3O
KaLfLY+Sn+VQsA9xrDvKqN6OtRqHYJ2gTAbazO8gkarfoC+TckX4HN7bbJRlm2sT
mL3moqjhRaoHuh4lkI0O
=uFV/
-----END PGP SIGNATURE-----

--Km1U/tdNT/EmXiR1--
