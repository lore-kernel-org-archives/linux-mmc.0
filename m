From: David =?ISO-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
Subject: Re: [PATCH v7 8/8] ARM: sunxi: Add documentation for
 driver for SD/MMC hosts found on Allwinner sunxi SoCs
Date: Sat, 22 Feb 2014 08:32:03 +0100
Message-ID: <1559221.mEv19UvCzF@pagira.o2s.ch>
References: <20140217095907.15040.81893.stgit@pagira.o2s.ch> <20140217100302.15040.56273.stgit@pagira.o2s.ch> <20140218154212.GL3142@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4305757.gxGONMhGcj"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-sunxi+bncBD2JL37LXEKRBU5FUGMAKGQE3ED7FZA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140218154212.GL3142@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Simon Baatz <gmbnomis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Emilio =?ISO-8859-1?Q?L=F3pez?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--nextPart4305757.gxGONMhGcj
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi

> Please use the real compatibles here. It's much easier to search
> for. Plus, your driver doesn't support all the SoCs you're mentionning here.
> [...]
> Please provide the real property name to use. No need for an example
> here, you have a full-fledged one in a few lines.
Fixed that.
> Ditto. Plus, this is not a mod0 clock.
Yes it is! But maybe the formulation hasn't been clear enough...
> You never talked about the clock-names property, and which clocks were
> supposed to be provided.
Yes I did? But I expanded the text a little bit further...
> > +	interrupts = <0 32 4>;
> > +	bus-width = <4>;
> And you never talked about bus-width either.
I can throw in a line for refering to the mmc slot gpio lib docs.
> Isn't the cd-gpios property requested too?
I can refer to the docs there as well if you like... :-)

cheers
david
--nextPart4305757.gxGONMhGcj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEABECAAYFAlMIUncACgkQAeZw77btGjodSwCdEkcG+urkDQ/kg+g0djh46sfr
QJoAnjY2CuqBqJeFhfHYTwSgil3241U0
=lY4z
-----END PGP SIGNATURE-----

--nextPart4305757.gxGONMhGcj--
