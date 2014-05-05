From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v10 15/15] ARM: dts: sun7i: Add basic support for the
 Cubietruck WiFi module
Date: Mon, 5 May 2014 17:46:45 -0500
Message-ID: <20140505224645.GC9464@lukather>
References: <1399046249-19472-1-git-send-email-hdegoede@redhat.com>
 <1399046249-19472-16-git-send-email-hdegoede@redhat.com>
 <20140505040212.GC11606@lukather>
 <CAGb2v65egbY5-ZeioLuoTatQ_y6iQ9n=auiiCRNAvTEj1z59hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="da4uJneut+ArUgXk"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:41382 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755985AbaEFANn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 May 2014 20:13:43 -0400
Content-Disposition: inline
In-Reply-To: <CAGb2v65egbY5-ZeioLuoTatQ_y6iQ9n=auiiCRNAvTEj1z59hA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Emilio Lopez <emilio@elopez.com.ar>, Mike Turquette <mturquette@linaro.org>, David =?iso-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer@o2s.ch>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>


--da4uJneut+ArUgXk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 05, 2014 at 12:20:56PM +0800, Chen-Yu Tsai wrote:
> On Mon, May 5, 2014 at 12:02 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Fri, May 02, 2014 at 05:57:29PM +0200, Hans de Goede wrote:
> >> From: Chen-Yu Tsai <wens@csie.org>
> >>
> >> The CubieTruck has an AMPAK AP6210 WiFi+Bluetooth module. The WiFi
> >> part is a BCM43362 IC connected to MMC3 in the A20 SoC via SDIO.
> >> The IC also takes a power enable signal via GPIO.
> >>
> >> The WiFi module supports out-of-band interrupt signaling via GPIO,
> >> but this is not supported in this patch.
> >>
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >
> > It doesn't have Chen-Yu SoB. Chen-Yu, are you fine with adding it?
>=20
> My apologies, I didn't notice this patch still had my name on it.
> Looks good.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> (or Acked-by, not sure which applies in this situation.)

Since you're the author, we need your SoB.

If you were not involved with writing (or merging the patch), Acked-by
would have been appropriate.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--da4uJneut+ArUgXk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTaBTUAAoJEBx+YmzsjxAg8oIQALXZQPTWBGtTJyrnf82jra5L
KuhLhS98Abq2mokSpVXm2sI4JRh2hnQJ9mRxJZTYbQqZK1HszNCxwh/D7PkCUrWs
i8sQgvOegw670WoJaKXtFIM6a8y0+h9ccuCU02nNYnRtYEMw5xfjbzArxmArMUEe
PeVEkdXD9iwZJKhjvw+fcqGMTagYdHlO4SRaIgMcKeQDlh06wFiCLyWTQfFB3P/y
3OiqviTYzZOlbzso/tb0hyfPZsW/Qbvg6C0KU90xba8xOsUgTlmp8sF/SecjQd8x
MUPLN2fi2uCgevfXmwmZa7CkSQZ2WCdu/KU1PavGmdFlEvWY/m/KqgbJoXS/Crq4
pQeCiMfsLaDeMD7JtpaPamcXehNuAhiGhsRR3FFAmCJCPqv02BY6RsRjzf69wsdD
7cXYfVpgl/s7kclvcsokVR5c/9TxIKAEjnEeLHnW0sQPCBvFGCKXGo3Z0jV+dNhh
fTe3OTfsC7EU+DMN0yrjOAjMnjZpTe6sKUxOjnQnK/r0scnPPnNM6HFH29j6I3dj
hOROk/T+QD2JgLvil7an1drAv68pKfI6lcCgzyZfJfClH8qtL5EDH/J3UeMFg62I
eF0nab6GsxaqKCvFtRwzN/lhZdkjmhnDKSW5//psJEZ18mVP6GlCLLsTkEK/aB0D
6Y4Z9c49Q9/vJR5TyVBz
=cjm7
-----END PGP SIGNATURE-----

--da4uJneut+ArUgXk--
