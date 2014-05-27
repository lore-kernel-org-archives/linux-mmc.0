From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 03/11] pinctrl: sunxi: Move setting of mux
 to irq type from unmask to set_type
Date: Tue, 27 May 2014 10:09:52 +0200
Message-ID: <20140527080952.GC4730@lukather>
References: <1401090486-4414-1-git-send-email-hdegoede@redhat.com>
 <1401090486-4414-4-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="S1BNGpv0yoYahz37"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBXEQSGOAKGQENKDZVNA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1401090486-4414-4-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, "John W. Linville" <linville-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--S1BNGpv0yoYahz37
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2014 at 09:47:58AM +0200, Hans de Goede wrote:
> With level triggered interrupt mask / unmask will get called for each
> interrupt, doing the somewhat expensive mux setting on each unmask thus is
> not a good idea. Instead move it to the set_type callback, which is typic=
ally
> done only once for each irq.

*This* is the bad idea. Nothing prevents you from calling
gpio_get_value whenever you just got your interrupt, that will change
the muxing, and never change it back, effectively breaking the
interrupts.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--S1BNGpv0yoYahz37
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJThEhQAAoJEBx+YmzsjxAgQTsQAKrsWJdiXydTdHjUYOcljtO2
otV3vs/0qU2h/ZBUqUMcdlIIZAgLqR9VOeUhfmAuGOQQiJmHWludoHUm/a5Zjm4e
sMPoBkVTm/UWoE704HxVfs+sOY9VXRtArfCwFWYpLLhMC8LG3Q5buD3hFlRhKK5k
5gFSVuH+TJJoWbGQ4U94FjsBVOLUDTY71evz0q3NsehgDvi0KROJ/blG54ENlyK+
n43EBnihRwNXqZCQjykxJbFKa3iFBOThdC4SDo49pwzfxdUafReB18JzkCeBtRCL
2zBmpnv1f7rIihjn7R28KpbYPegdQlrOB5KICPKemtuvoZmachdFMnNIAgWsBW+K
36NtOahj88t8/iXd+PmP5Z48ubnQSAm7U0BOQemn/jpYrl49xbK19mb/YBG6WM0O
u+CN2ASpdObvVcUIfP5etPmie4+bjHQ1QWYTLd7XFIEYMFf0JtS7XLQCokVG4B29
GhKvOLq9hhbd6NIi0DW5SQJMwPCFqgYKjUlmQR21XSOPh/ckzdi6cmaJ8gOEOkoM
vzJtUyDq1iS900KsGzqS97/k1iOLmO9qjSpLxv8VOBfltaIx1bXBS+fWk24ViV1p
T7zJ/6vaITBDNxQm13+QmScQT7QMXZCPYP8ywllV0iimUQtFW6Y0D3YBuVbHJR44
OP5NihJyxyDI8pP1uxb2
=Bho2
-----END PGP SIGNATURE-----

--S1BNGpv0yoYahz37--
