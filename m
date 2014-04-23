From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v8 00/17] ARM: sunxi: Add driver for SD/MMC
 hosts found on Allwinner sunxi SoCs
Date: Wed, 23 Apr 2014 11:53:19 +0200
Message-ID: <20140423095319.GO24905@lukather>
References: <1398164497-14212-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rQ7Ovc9/RBrrr0/1"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBIM432NAKGQEGILZT5Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1398164497-14212-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, David =?iso-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--rQ7Ovc9/RBrrr0/1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Tue, Apr 22, 2014 at 01:01:20PM +0200, Hans de Goede wrote:
> Hi All,
>=20
> Here is v8 of the sunxi-mmc patch-set David Lanzend=F6rfer and I have been
> working on.
>=20
> The first 2 patches are depenencies which should go in through the clk tr=
ee,
> Mike can you pick these 2 up please ?  :
>=20
> "clk: sunxi: factors: automatic reparenting support"
> Is uncontroversial and has been favorably reviewed by various people.
>=20
> "clk: sunxi: Implement MMC phase control"
> Is somewhat more controversial as there has been lots of discussion about
> adding a generic phase control method to the clk framework. The problem is
> that there has been a lot of talk about such a generic phase control meth=
od
> but not a single patch. Therefor I would like to move forwards with using
> a platform specific method for now. I hereby promise that once we've a ge=
neric
> method I'll write patches to convert the sunxi code to that method.
>=20
> The third patch is the patch adding the actual mmc driver and should go in
> through the mmc tree.
>=20
> All the other patches are devicetree patches hooking things up, and should
> go upstream through Maxime's sunxi-dt tree.

Apart from the ever-controversial phase control thing, and the minor
comments I had here and there, this looks good, thanks!

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--rQ7Ovc9/RBrrr0/1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTV42OAAoJEBx+YmzsjxAg5W8QAJ/e1BiIHXhRTAMvQzQYpwmj
dFOC7VXKecgTj4GHQ/gM4hmL6BwQ5reryedV8aVsZ9H2E1J/VW5h5EmnVoK6HEtO
hXmc97Bzqmh9gXo4K8Rv8n15E7luaH+49F+TYIKCS0MoaNvbLeJh04MXK4rhp4+b
UsviqvCQLqV9XAKnL3Lr2ESVeOJsR4DPyiZrWqCKPNrx0zfiEhxV9hZx/JK2Urw5
tKWnPg6uXFfPih/g/S0MQ/0vCBKEXgUb5AQxrlwqIdebEdxMjpUIz6BQFaWmmReG
kd2nhGe/AXfi7BS4yTktJ2LxqKgQFav48XRBaN799CCxNXUpkSKqQljvFLxUjuyq
Ze+f/IqBhxDp2P5NVo46eFK5E7ODFvmvLKI6Yqp770PtiwNYwX2m+SIGYDIQEPBF
7PibWy/6yFLXrPAjYHMt8hDG//1xDufaGdAJhHxQA09n2JQ/hVZlNlFx6wLqU2pk
5loB0/f6Y8e+ZhLcsDe+TqS5jaULHwTgswikcTQTix7Km5ZF8xhZZCoTp5pCjnIZ
+vVVRDHlWDxbXLzsmbiMFxUaH3wP4RnN2Kxg8oM41/nEvLhc/GIkKg2kM3V4Hns9
KXzaBEi662TUZgacoNlhM6CvpxFLRV1KWAbP47lcx9mhxGmXQGPFH11FUdg62o06
LvIPPNgjRY4JCs78DX4m
=3a0d
-----END PGP SIGNATURE-----

--rQ7Ovc9/RBrrr0/1--
