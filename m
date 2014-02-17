From: David =?ISO-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
Subject: Re: [linux-sunxi] [PATCH v6 4/8] ARM: sunxi: Add driver for SD/MMC hosts found on Allwinner sunxi SoCs
Date: Mon, 17 Feb 2014 08:08:57 +0100
Message-ID: <1744603.zMUgfmoUUP__33049.4992238984$1392621054$gmane$org@pagira.o2s.ch>
References: <20140216050933.728.25526.stgit@dizzy-6.o2s.ch> <20140216051133.728.36386.stgit@dizzy-6.o2s.ch> <1392542548.11093.13.camel@chi.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3048959.7lgtbpbIvE"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1392542548.11093.13.camel-4jXc9Jz4itA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Simon Baatz <gmbnomis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>, Emilio =?ISO-8859-1?Q?L=F3pez?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


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
> > <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
> > + * (C) Copyright 2014-2015 Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
