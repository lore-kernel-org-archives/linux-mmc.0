From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: Re: [PATCH 2/5] ARM: dts: sun4i: Add support for mmc
Date: Mon, 16 Dec 2013 11:02:53 +0100
Message-ID: <20131216100253.GC3037@lukather>
References: <1387058295-20641-1-git-send-email-hdegoede@redhat.com>
 <1387058295-20641-3-git-send-email-hdegoede@redhat.com>
 <20131215135854.GF3651@lukather>
 <52ADBD41.4050104@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1SQmhf2mF2YjsYvc"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBTVAXOKQKGQEZJCXSAA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52ADBD41.4050104-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, David =?iso-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--1SQmhf2mF2YjsYvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Hans,

Damn google-groups removed me from Cc :)

On Sun, Dec 15, 2013 at 03:31:29PM +0100, Hans de Goede wrote:
> >>@@ -376,6 +385,13 @@
> >>  				allwinner,drive =3D <0>;
> >>  				allwinner,pull =3D <0>;
> >>  			};
> >>+
> >>+			sdc0_pins_a: sdc0@0 {
> >>+				allwinner,pins =3D "PF0","PF1","PF2","PF3","PF4","PF5";
> >>+				allwinner,function =3D "mmc0";
> >>+				allwinner,drive =3D <3>;
> >>+				allwinner,pull =3D <1>;
> >
> >Wow, you need both the pullups and a 40mA output?
>=20
> Yes and no. The pullups are enabled by uboot and the allwinner
> sources, most of my testing has been done without them, which
> seems to work fine. I've enabled them to be consisten with the
> allwinner sources and u-boot.

Henrik was suggesting that in most boards it's not required to set up
the internal pullups. Maybe we can just disable them by default, and
we will always be able to enable them at the board level if needed.

> As for drive =3D <3>, we need drive =3D <2> for normal modes,
> and drive =3D <3> for ddr mode. I simply picked <3> to keep
> things KISS. It should not matter much in power usage, as
> it will only make the flanks of the signal more steep. Once the
> desired output level is reached the current will drop off. It will
> use more current when changing the level, but for half the time,
> so the effective power usage (current * time) is the same.

Ok, let's keep it to 40mA then. It will indeed be simpler :)

> >Ideally, I'd like this patch to be splitted into three:
> >   - One that adds the MMC controller nodes to the DTSI
> >   - One that adds the muxing options you need to the pinctrl node
> >   - One that enables the controller on the boards
>=20
> Sounds like a good job for David. Note I've a lot more boards for
> which I would like to add mmc support or dts files in general
> (will do so as time permits).
>=20
> For those boards which already have a dts I'll send mmc adding dts
> patches to David for now so he can add the changes to the patch-set.
>=20
> How do you want to deal with new boards ? Send the addition of the
> base board to you (and CC David as he will need them in his tree too),
> and then send a patch to add mmc to the dts to David ?

I don't really like having a variable-sweep patch serie. Just send
your DT additions to me, saying that you depend on the MMC serie from
David.

I'm pretty happy with the DT bindings so far, so we can even merge
these DT patches before the MMC driver has been merged

> Or should I simply make it one big patch including mmc in the initial
> commit ?

I really prefer to have patches as small as possible (while being
reasonable). It's much easier to merge and allows to have a cleaner
history.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--1SQmhf2mF2YjsYvc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSrs/NAAoJEBx+YmzsjxAg3vkP/ihq7PB7oFr4rotMHLVnG3PZ
PrX0vCHEeK/s8f3s7UpL7osUypwq/esGgOVmfEPPZ5H6QzITUiRyM2j/KQN1a16z
yPUSSUWTm5Q8OgWNh9EgTth6II1Ubv7m3sOltAq1O/ArtWoGx14/84bizXlhm6OB
gvgA/GqONB8xyOe69igACsO6S5sXBLFyZps9ehcZe3689X15YfkxOFP7bKNWKv8T
Y4Wnk4M1o4uterg0pyF8BoOHagq2UBqtIBXV1fbJZO6wxy3AU4qaxcJKo4mfefUB
1foBPxItduRt4c78foHNuXGbyE8cqhL6dxQSsVEJEZbm2sP/ymhLu4XqGLM5PpMt
A6fLLwIIY7yUKj/zFSSRgovlUxN+BnjI6JTLqeBvHk5w0KK3v4BXyENoHDBX/6Vq
/eecxy6sjBUjlw1oTxPAQWI4mZjrw13S2EbabwE7kybWoMK9IvEE3IpfYgoGztRW
oComMYap9SQdm4uMfm+NC01nhOhkiGnQ7dnRpzFMH/39C1//9wns/dIlfQtkoSuR
JvIzkPyTPdH11rYugfJY1ktnnTiTvjA+1BI84udABgwZdGBTyqE9amk5dXrJ9l1g
6Q6Z5v4l/n9M67cuKioF+LnrGuXqMC60bwi1l2GEJsulLqXuXoXg7RLU1Jn5/I5Q
YBHQEOASW0EIvXHzaDkT
=6/FL
-----END PGP SIGNATURE-----

--1SQmhf2mF2YjsYvc--
