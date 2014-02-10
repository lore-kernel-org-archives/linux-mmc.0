From: David =?ISO-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer@o2s.ch>
Subject: Re: [PATCH v4 4/7] ARM: sunxi: Add driver for SD/MMC hosts found on Allwinner sunxi SoCs
Date: Mon, 10 Feb 2014 12:35:13 +0100
Message-ID: <7779575.QASLIT4FqB__20877.2938968197$1392032155$gmane$org@dizzy-6.o2s.ch>
References: <20140207212709.24624.58619.stgit@dizzy-6.o2s.ch> <20140207213316.24624.28705.stgit@dizzy-6.o2s.ch> <dac5ec28-3a6d-428f-8ab6-c8f2bb53168f@googlegroups.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2134609.aEC1CZKHjS"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <dac5ec28-3a6d-428f-8ab6-c8f2bb53168f@googlegroups.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Priit Laes <plaes@plaes.org>
Cc: linux-sunxi@googlegroups.com, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Mike Turquette <mturquette@linaro.org>, Simon Baatz <gmbnomis@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Emilio =?ISO-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, linux-kernel@vger.kernel.org, H Hartley Sweeten <hsweeten@visionengravers.com>, Tejun Heo <tj@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-arm-kernel@lists.infradead.org
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
