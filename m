From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v11 1/6] ARM: sunxi: Add driver for SD/MMC
 hosts found on Allwinner sunxi SoCs
Date: Sat, 10 May 2014 12:06:52 -0400
Message-ID: <20140510160652.GM7047@lukather>
References: <1399714443-12459-1-git-send-email-hdegoede@redhat.com>
 <1399714443-12459-2-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1whYXOlSGJlk+LY"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBU7ZXONQKGQECVLKDLQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1399714443-12459-2-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, David =?iso-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--k1whYXOlSGJlk+LY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 10, 2014 at 11:33:58AM +0200, Hans de Goede wrote:
> From: David Lanzend=F6rfer <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
>=20
> The Allwinner sunxi mmc host uses dma in bus-master mode using a built-in
> designware idmac controller, which is identical to the one found in the m=
mc-dw
> hosts. However the rest of the host is not identical to mmc-dw, it deals =
with
> sending stop commands in hardware which makes it significantly different
> from the mmc-dw devices.
>=20
> HdG: Various cleanups and fixes.
>=20
> Signed-off-by: David Lanzend=F6rfer <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Chris, I don't think we ever got a review from you on this? Do you
have any comments on this patch? It would be great if we could merge
it for 3.16.

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--k1whYXOlSGJlk+LY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTbk6bAAoJEBx+YmzsjxAg4/UQAKgUc33A5OgHoRSH3yCmeY+6
ZxnWdMpRrKd0rW5foPsa9UAsusdKX6sGhASxLvTfoCS/cZ4TKmYkS83DuVoCsJRr
/34BTBm5eL0mIxAe6abPz1sF8hXQle4MvleN/gdQXyS/UHIRjgrsEdgtWXdiGOeu
C1v/OuL81rNpGwjkPW5HuHsYamIhD/u18x9LIptZJ3vAVSxfGsxCnPnE3ChG5T0G
6gv8AcBXVuE0q52nwLVSOsrriJ4gMZd93VQaZ+/aqFxqtbubrU/Awen5YlRG1VcK
99LM2WxuFzvPhspDyy3d/nkKYRkuKpe9QEejvb12nLr17rjZ2O+4C7O/iK47zq7q
qDqCnTxcPhnr9gEwIiRiibnmV3b9waYwCdgNLl0pw1oKx5K6sjaj+SJ6Hy43tkge
B4cDIfb2CU8JYoDJpgtDRvjKFTnQYvGP+KM6Aom0n/OB00CksoxWEtr7SirdJvZI
3uLszbZZggum9isFVySrgup+jXx9zgmMPaqfxmxz5iCoaD2yUFeiyZ0vhNNg2vOv
M8NpGY8yz3ijHVW42lmhUnG7DfBaXN2pZmU2n30fDhYdChlQ3lVnRri0mTMR176H
i3eo5J7jVLPpu7kD565/LCj1dFFEJa6hJiQU0Dme+9hEwOlU/16FWPvGFzS7BHKG
Uq17JyGjaNEccK8Bnfke
=Hhsc
-----END PGP SIGNATURE-----

--k1whYXOlSGJlk+LY--
