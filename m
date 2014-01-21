From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: Add support for Erratum 2.1.1.128 in
 device tree boot
Date: Tue, 21 Jan 2014 12:05:49 -0600
Message-ID: <20140121180549.GS30451@saruman.home>
References: <1390260542-22213-1-git-send-email-nm@ti.com>
 <20140120233941.GG6516@saruman.home>
 <52DEB078.5030005@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U2mKMzaWgYxzMy3/"
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52DEB078.5030005@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: balbi@ti.com, Balaji T K <balajitk@ti.com>, Chris Ball <chris@printf.net>, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

--U2mKMzaWgYxzMy3/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 21, 2014 at 11:38:00AM -0600, Nishanth Menon wrote:
> On 01/20/2014 05:39 PM, Felipe Balbi wrote:
> > On Mon, Jan 20, 2014 at 05:29:02PM -0600, Nishanth Menon wrote:
> >> When device is booted using devicetree, platforms impacted by
> >> Erratum 2.1.1.128 is not detected easily in the mmc driver. This errat=
um
> >> indicates that the module cannot do multi-block transfers.
> >>
> >> Handle this by providing a boolean flag to indicate to driver that it =
is
> >> working on a hardware with mentioned limitation.
> >=20
> > sure there's no way of reading the revision register to figure this one
> > out without having to add a new DT attribute ?
> >=20
> I did a quick patch to read the Module revision register:
> http://slexy.org/view/s21TKvlWlR
>=20
> sdp2430: Revision: 1.2, Spec: 0.0, normal interrupt
>=20
> OMAP3430-ldp: (ES2.1): Revision: 2.6, Spec: 0.0, normal interrupt
> SDP3430:(ES3.0) Revision: 2.6, Spec: 0.0, normal interrupt
> AM3517-evm: (ES1.1): Revision: 2.6, Spec: 0.0, normal interrupt
> AM3517-crane:(ES1.1): Revision: 2.6, Spec: 0.0, normal interrupt
>=20
> AM37x-evm: (ES1.2) Revision: 2.6, Spec: 0.0, normal interrupt
> OMAP3630-beag-xm (ES1.2): Revision: 2.6, Spec: 0.0, normal interrupt
>=20
> am335x-evm:(ES1.0): Revision: 3.1, Spec: 0.1, normal interrupt
> am335x-sk: (ES2.1): Revision: 3.1, Spec: 0.1, normal interrupt
> am335x-beaglebone-black:(ES2.0): Revision: 3.1, Spec: 0.1, normal
> interrupt
>=20
> sdp4430.txt: (ES2.2): Revision: 3.1, Spec: 0.1, normal interrupt
>=20
> OMAP4460-panda-es (ES1.1): Revision: 3.1, Spec: 0.1, normal interrupt
>=20
> OMAP5uevm:(ES2.0): Revision: 3.3, Spec: 0.2, normal interrupt
> dra7-evm (es1.1): Revision: 3.3, Spec: 0.2, normal interrupt
>=20
>=20
> OMAP3430-ldp seems to be the only one impacted with module revision
> 2.6 -> so using revision information is not really helpful here. Hence
> the usage of a flag in dt attribute to indicate hardware impacted by
> erratum.

alright, that's too bad. Seems like revision in this module isn't very
useful :-(

--=20
balbi

--U2mKMzaWgYxzMy3/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJS3rb9AAoJEIaOsuA1yqREMNQP+wS3w/GDoF7wWzNiiN0cd3om
QEIXQzVbegQTPZ4A1eOX1BhR5NJHU9040e0WicTMaHwSoW0OrxLufp6Kq8dLvwn9
07Vli+l7qhBKhdWanMuaMwgt77AC56N4/TZy5RNWv66HXLsCUGtaEzrcv4fYMUor
Hscxctejdm9HAVU/ZpJKju1cXtea85gVCRdzaEU6fHt5xfmag6++vpuu2asopkru
618OKGh5vMWco7H1S44Rwn7F1EuxA1xv5wGJ8kGd/KKLfLZ8iJP42P9QQ+XBW6nf
NmBVb6omPRPNCgDT5LH+45meqdUNGhF4xkEoNDVnP3paJdgzndagVc0FwEAiHIhL
dXWq+J7UUgxtaLyR+0zZtzerfNvIpnly8NvVYFZDDyLylYI0hvOpswmKcxPAlUpy
bzXdS+ixmIf6qw+U44SqDIvUvY6Fe8G6YEsfbWawCqPdtgtdfHU59BL31y5V25zt
chX60CImNvcPODgexy+FUJN38FVxbwP6CfcFq85Q13u/bXgmL1sVeWS8xevnkMjv
gX57yV4zzYkTa2gsHyVAMlhJli5AtkKCwxKZWVqEITkJCRUyuV0Mqmz5vsupgrmY
KIPzhyrQ82cQSbyI5YP9l7U4EWjY1cW/eY4xVFr062ttsRqgx8DgzbMK1cPX1sMz
KpJjDJ/nZIe5moqj629t
=7mFc
-----END PGP SIGNATURE-----

--U2mKMzaWgYxzMy3/--
