From: David =?ISO-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
Subject: Re: [PATCH v4 4/7] ARM: sunxi: Add driver for SD/MMC hosts found on Allwinner sunxi SoCs
Date: Mon, 10 Feb 2014 12:35:13 +0100
Message-ID: <7779575.QASLIT4FqB__29785.1470917978$1392032150$gmane$org@dizzy-6.o2s.ch>
References: <20140207212709.24624.58619.stgit@dizzy-6.o2s.ch> <20140207213316.24624.28705.stgit@dizzy-6.o2s.ch> <dac5ec28-3a6d-428f-8ab6-c8f2bb53168f@googlegroups.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2134609.aEC1CZKHjS"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <dac5ec28-3a6d-428f-8ab6-c8f2bb53168f-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Simon Baatz <gmbnomis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Emilio =?ISO-8859-1?Q?L=F3pez?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--nextPart2134609.aEC1CZKHjS
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi
> > +            (cmd->opcode == 5 || cmd->opcode == 52))
> Aren't these the ones defined in linux/mmc/sdio.h:
> 5  - SD_IO_SEND_OP_COND
> 52 - SD_IO_RW_DIRECT
Yes. They are...
Changed that.
Also I removed the camel cases and the defines within the struct definition.

> > +struct sunxi_mmc_clk_dly {
> > +    u32 mode;
> > +    u32 oclk_dly;
> > +    u32 sclk_dly;
> Do these members have to be u32? They all seem to be smaller than 10.
Yes. Because of situations where it gets used in bit operations, and shorter
types mess things up and prevent the driver from working ;-)

cheer
david
--nextPart2134609.aEC1CZKHjS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEABECAAYFAlL4uXQACgkQAeZw77btGjovpgCgrjjxftD8MfEMous18vmmBe4v
/AgAn2+dxNZXiX4DmmpIMEKaqVh0yEwi
=AKAv
-----END PGP SIGNATURE-----

--nextPart2134609.aEC1CZKHjS--

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
