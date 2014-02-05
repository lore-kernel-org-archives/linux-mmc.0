From: David =?ISO-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
Subject: Re: [PATCH v3 0/7] ARM: sunxi: Add driver for SD/MMC
 hosts found on allwinner sunxi SOCs
Date: Wed, 05 Feb 2014 18:17:46 +0100
Message-ID: <2733138.OsaPkZKnhk@dizzy-6.o2s.ch>
References: <20140205134741.3027.50207.stgit@dizzy-6.o2s.ch>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1438517.AOmo1C3tjv"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-sunxi+bncBD2JL37LXEKRBSHEZGLQKGQEDS6NFIY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140205134741.3027.50207.stgit-GPtPHOohwllnsqa/0SyWJQ@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Simon Baatz <gmbnomis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Emilio =?ISO-8859-1?Q?L=F3pez?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


--nextPart1438517.AOmo1C3tjv
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

As Maxime has pointed out, I've forgotten to add a changelog
in my coverletter.
Here is, what has changed in this revision:

Changes since v1:
=2DUsing mmc_of_parse instead of diy dt parsing
=2DAdding nodes for all mmc controller to the dtsi files, including sofar=
 unused
  controllers
=2DUsing generic GPIO slot library
=2DAdding additional MMC device nodes into DTSI files

Changes since v2:
=2DAdd missing Signed-off-by tags
=2DStop using __raw_readl / __raw_writel so that barriers are properly us=
ed
=2DAdding missing new lines
=2DAdding missing patch for automatic reparenting of clocks

cheers
david
--nextPart1438517.AOmo1C3tjv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEABECAAYFAlLycj0ACgkQAeZw77btGjq4IgCfVDzZHDDb0w0JZ2ZrHfngQxay
Ed4AoLAsD7YPn2Biiwrp3lrn7zgmkaZG
=2Ypc
-----END PGP SIGNATURE-----

--nextPart1438517.AOmo1C3tjv--
