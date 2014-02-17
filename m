From: David =?ISO-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer@o2s.ch>
Subject: Re: [linux-sunxi] [PATCH v6 4/8] ARM: sunxi: Add driver for SD/MMC
 hosts found on Allwinner sunxi SoCs
Date: Mon, 17 Feb 2014 08:08:57 +0100
Message-ID: <1744603.zMUgfmoUUP__22411.8887367242$1392621075$gmane$org@pagira.o2s.ch>
References: <20140216050933.728.25526.stgit@dizzy-6.o2s.ch>
 <20140216051133.728.36386.stgit@dizzy-6.o2s.ch>
 <1392542548.11093.13.camel@chi.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0335350112390698170=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1392542548.11093.13.camel@chi.lan>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Mike Turquette <mturquette@linaro.org>, Simon Baatz <gmbnomis@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Emilio =?ISO-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, linux-kernel@vger.kernel.org, H Hartley Sweeten <hsweeten@visionengravers.com>, linux-sunxi@googlegroups.com, Priit Laes <plaes@plaes.org>, Tejun Heo <tj@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-mmc@vger.kernel.org


--===============0335350112390698170==
Content-Type: multipart/signed; boundary="nextPart3048959.7lgtbpbIvE"; micalg="pgp-sha1"; protocol="application/pgp-signature"


--nextPart3048959.7lgtbpbIvE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi
> > + * Driver for sunxi SD/MMC host controllers
> > + * (C) Copyright 2014-2015 Reuuimlla Technology Co., Ltd.
> > + * (C) Copyright 2014-2015 Aaron Maoye <leafy.myeh@reuuimllatech.c=
om>
> > + * (C) Copyright 2014-2015 O2S GmbH <www.o2s.ch>
> > + * (C) Copyright 2014-2015 David Lanzend=F6rfer
> > <david.lanzendoerfer@o2s.ch>
> > + * (C) Copyright 2014-2015 Hans de Goede <hdegoede@redhat.com>
> ETIMETRAVEL
I'm not really into this licensing and copyright stuff.
Could you maybe point out what the correct copyright would be?

> __SUNXI_MMC_H__
Ok. Will fix that.

> Also, you may want to rename SDXC_RESPONSE_* to SDXC_RESP_*, which lo=
oks
> better next to the SDXC_DATA_* defines...
Ok. I will change that :-)

=2Ddavid
--nextPart3048959.7lgtbpbIvE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEABECAAYFAlMBtYwACgkQAeZw77btGjrVnACeOesTow5MFwdxX5un5yfbGWoM
L+0AniCZ+X7GbUJ1GTZiT7O/hN4keCks
=ZcbZ
-----END PGP SIGNATURE-----

--nextPart3048959.7lgtbpbIvE--



--===============0335350112390698170==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0335350112390698170==--
