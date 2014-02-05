From: David =?ISO-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
Subject: Re: [PATCH v2 0/6] ARM: sunxi: Add driver for SD/MMC
 hosts found on allwinner sunxi SOCs
Date: Wed, 05 Feb 2014 14:01:33 +0100
Message-ID: <1676482.sbjAhaSLaV@dizzy-6.o2s.ch>
References: <20140204191648.29809.14611.stgit@dizzy-6.o2s.ch> <20140205103949.GC3192@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2087342.yc2NcSH50b"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-sunxi+bncBD2JL37LXEKRBOXMZCLQKGQEGJDPZMY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140205103949.GC3192@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Simon Baatz <gmbnomis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--nextPart2087342.yc2NcSH50b
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Maxime
> I have four comments here:
>   - Read Documentation/SubmittingPatches, especially Section 5 and 12
>     (hints, you forgot the clock maintainers for your clock patches
>     and you didn't put any signed-off-by tags)
Oops. I added signed-offs now
>   - You ignored pretty much all the comments that were made during the
>     review of the first version. Go through
Uh? I just fixed the commits and squashed them together for easier handling.
I'm even using mmc_of_parse now...
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-December/219339.
> html and address the comments that were made.
>   - Each of your patches should compile. Fix the order of your
>     patches.
Done.
>   - Submit a v3, with the changes you made. Otherwise we have no way
>     of knowing what have been fixed and what didn't
Too many patches would be bloaty.
That's why I've squashed them into small and corrected patches.

> Looking forward for the next iteration!
Good :-)
You can have a look at the recent status here:
http://git.o2s.ch/?p=linux-next.git;a=shortlog;h=refs/heads/20140205

cheers
David
--nextPart2087342.yc2NcSH50b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEABECAAYFAlLyNi0ACgkQAeZw77btGjr6zwCglDPMGsllkJPtErxxWEzepqeu
rpoAn3iqBc/AViM5Rnu45QE72zw4y7tc
=eD5M
-----END PGP SIGNATURE-----

--nextPart2087342.yc2NcSH50b--
