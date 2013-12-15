From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/5] ARM: sunxi: Add driver for SD/MMC hosts
 found on Allwinner sunxi SoCs
Date: Sun, 15 Dec 2013 17:21:09 +0100
Message-ID: <20131215162109.GI3651@lukather>
References: <1387058295-20641-1-git-send-email-hdegoede@redhat.com>
 <1387058295-20641-2-git-send-email-hdegoede@redhat.com>
 <20131215134415.GE3651@lukather>
 <52ADBAA3.7060507@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8i0lXXx49qphuFT"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBYNPW6KQKGQEMAPLCHA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52ADBAA3.7060507-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, David =?iso-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--a8i0lXXx49qphuFT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 15, 2013 at 03:20:19PM +0100, Hans de Goede wrote:
> On 12/15/2013 02:44 PM, Maxime Ripard wrote:
> >Hi Hans,
> >
> >I won't comment on the MMC driver itself, and leave Chris comment on
> >that, but still, I have a few things.
> >
> >On Sat, Dec 14, 2013 at 10:58:11PM +0100, Hans de Goede wrote:
> >>From: David Lanzend=F6rfer <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
> >>
> >>This is based on the driver Allwinner ships in there Android kernel sou=
rces.
> >>
> >>Initial porting to upstream kernels done by David Lanzend=F6rfer, addit=
ional
> >>fixes and cleanups by Hans de Goede.
> >>
> >>Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> >
> >Your commit log is a bit sparse. What capabilities this controller
> >has? Is it using DMA? If so, how? What SoCs are supported/it has been
> >tested on? etc.
>=20
> David, since you'll be doing v2 I guess you'll be filling in v2. FYI
> I've tested this on sun4i-a10, sun5i-a10s sun5i-a13 and sun7i-a20.
>=20
> It uses dma in bus-master mode using a built-in designware idmac controll=
er,
> which is identical to the one found in the mmc-dw hosts. Note the rest of
> the host is not identical, I've looked into reusing the mmc-dw driver but
> that does not seem like a good idea (manual sending stop commands
> versus auto stop on sunxi, completely different registers, etc.).

Thanks :)

This is exactly what I expect from a commit log of such driver ;)

> >>+static const struct of_device_id sunxi_mmc_of_match[] =3D {
> >>+	{ .compatible =3D "allwinner,sun4i-mmc", },
> >>+	{ .compatible =3D "allwinner,sun5i-mmc", },
> >
> >Please use sun5i-a13-mmc as your compatible.
>=20
> Can you explain a bit why? In essence currently we have
> 2 versions of the mmc controller, those found on sun4i
> and those found on sun5i and sun7i. I thought that the
> norm was to use the oldest soc version in which a revision
> of an ip-block first appears as the compatible string ?

Indeed.

> Note I've tested this with both a13 and a10s SOCs, if we
> add a sun5i-a13-mmc we should also add a sun5i-a10s-mmc
> and a sun5i-a20-mmc, or would that then be sun7i-a20-mmc?

And the A13 has been the first SoC in the sun5i family, hence why we
should use sun5i-a13 as the prefix here. If the A10s and A20 would not
have been compatible with the A13 MMC controller, we would have used
sun5i-a10s-mmc and sun7i-a20-mmc, respectively.

> To me just having sun5i-mmc for sun5i+ socs seems simpler.

And if we ever find out that A10s or A13 differs in some way, we will
end up introducing a compatible that will be sun5i-a10s-mmc, along
with the sun5i-mmc we already have, which is not really the more
consistent thing we would have done.

> <snip>
>=20
> >>+	mmc->ops		=3D &sunxi_mmc_ops;
> >>+	mmc->max_blk_count	=3D 8192;
> >>+	mmc->max_blk_size	=3D 4096;
> >>+	mmc->max_segs		=3D PAGE_SIZE / sizeof(struct sunxi_idma_des);
> >>+	mmc->max_seg_size	=3D (1 << host->idma_des_size_bits);
> >>+	mmc->max_req_size	=3D mmc->max_seg_size * mmc->max_segs;
> >>+	/* 400kHz ~ 50MHz */
> >>+	mmc->f_min		=3D   400000;
> >>+	mmc->f_max		=3D 50000000;
> >
> >Hmmm, the tables earlier seem to suggest it can do much more than that.
>=20
> I know, but this is what the allwinner android kernels are using, actually
> in case of sdc3 they are putting 200000000 in f_max (as that is often
> used for sdio cards) but then later in set_ios they clamp the passed
> in clock to 47000000 Mhz, so I seriously doubt that 200Mhz has actually
> worked. Hence I've simply gone for a safe range for now. If someone has
> cards capable of doing 200 MHz we could certainly run various tests and
> try to improve this, but for now this seems a sane range to start with.

That's probably something that you should mention in your comment then :)

> <snip>
>=20
> >> +	/* indicator pins */
> >> +	int wp_pin;
> >> +	int cd_pin;
> >> +	int cd_mode;
> >> +#define CARD_DETECT_BY_GPIO_POLL (1)	/* mmc detected by gpio check */
> >> +#define CARD_ALWAYS_PRESENT      (2)	/* mmc always present */
> >
> > Just a question here, have you tested to use the external interrupts?
> > (Is that even possible on the pins that are used as card detect?)
> >
>=20
> No I've not tried that, there was code for this in the original allwinner
> driver, but no boards were actually using it.
>=20
> As for it being possible on the pins being used, it is possible on (most)
> port H pins and the cubie* and a20-olinuxino-micro boards are using PH pi=
ns
> for cd. Others are not.  One thing which worries me about this is debounc=
ing,
> using polling is automatically debounced, using an external interrupt won=
't
> be. Ideally there would be some common code somewhere to deal with gpio
> connected buttons (which this in essence is) which does debouncing ...
>=20
> Again I think this is something best left as a future enhancement.

Yep, definitely, I was just being curious :)

> >>diff --git a/include/linux/clk/sunxi.h b/include/linux/clk/sunxi.h
> >>new file mode 100644
> >>index 0000000..1ef5c89
> >>--- /dev/null
> >>+++ b/include/linux/clk/sunxi.h
> >>@@ -0,0 +1,22 @@
> >>+/*
> >>+ * Copyright 2013 - Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> >>+ *
> >>+ * This program is free software; you can redistribute it and/or modify
> >>+ * it under the terms of the GNU General Public License as published by
> >>+ * the Free Software Foundation; either version 2 of the License, or
> >>+ * (at your option) any later version.
> >>+ *
> >>+ * This program is distributed in the hope that it will be useful,
> >>+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >>+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >>+ * GNU General Public License for more details.
> >>+ */
> >>+
> >>+#ifndef __LINUX_CLK_SUNXI_H_
> >>+#define __LINUX_CLK_SUNXI_H_
> >>+
> >>+#include <linux/clk.h>
> >>+
> >>+void clk_sunxi_mmc_phase_control(struct clk_hw *hw, u8 sample, u8 outp=
ut);
> >>+
> >>+#endif
> >
> >Hmmm, I see no implementation for this function. Didn't you forget
> >a file here? (and it should probably be a separate patch anyway).
>=20
> The implementation is part of Emilio's clk branch, but he forgot
> to add a header for it, so I'm fixing that up here, I guess this
> should go through Emlio's tree as a separate patch.

As far as I know, this work has never been posted, let alone
merged. Anyway, the dependencies you have is something that you should
mention in your cover letter, so that we know what to merge, in which
order, and when to merge it.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--a8i0lXXx49qphuFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSrdb1AAoJEBx+YmzsjxAg+VUQAJs5tyBLXemYQzj8Ds4Kxug2
9GGeMSbefraJa9oBFXOK0UoWes5H3Ug1qaNWwFsERbDiWqDJ4iCIbUPAEd8ne5qz
VOzV4YSxbBtoVpSyniAey/6XPeg/CXVyBrmzkl3Dvmn48LskBL1MGchyLBJnc7HU
+/oM/smy82nshtkgWQLtb9o/fpT5N9sVC4rY1yaBwhlSMG93I+23QLs6mvLWtedG
XmR6bES+hTAf9Z3xwUycWXOR+SCPs2Z9wpSwJp4UvatguNVtWwf/daC8RHuyFiCR
dVouUcT/yXB1Cdr1OUgkudndLjptRpO52A4p5B/rlwJZMEWc7dA6HwDuU6hTbv5w
twkmlQTb6dzU1GUhPaXOKKKfbQVuqaQ3s3K9pjgqZgG0nY6ipq6gF1kdxfCZKocm
8S6/Z6R+Qaxr8up6ja1xOc+sCRihMvBZyUms6d2Hbh3MjXeALyHyS7tKDgwIdT63
DwZTwfmCVuJB7Chcrqs3okEbtUXpVOCTN726i5wKsTWl/zTYeraOlfq7G0WBpApX
3SZPcYHhnSuj0bJaVzdMXQ3ZFRAzRm84qsCo7/pST2S0CfMZNhkOcZPvj6ld1e6u
k3/uh2g9tqyfijRjh4U7POYoD/kp4WilDl0Ap0wmX9QJbbC0feJKzhEg9jm/B5Pn
wiFkTLLTvRrzxg1BpvXi
=Mb/y
-----END PGP SIGNATURE-----

--a8i0lXXx49qphuFT--
