From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 0/6] ARM: sunxi: Add driver for SD/MMC
 hosts found on allwinner sunxi SOCs
Date: Wed, 5 Feb 2014 11:39:49 +0100
Message-ID: <20140205103949.GC3192@lukather>
References: <20140204191648.29809.14611.stgit@dizzy-6.o2s.ch>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2/5bycvrmDh4d1IB"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBDNKZCLQKGQERSHPFCY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140204191648.29809.14611.stgit-GPtPHOohwllnsqa/0SyWJQ@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: David =?iso-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Simon Baatz <gmbnomis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--2/5bycvrmDh4d1IB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi David,

On Tue, Feb 04, 2014 at 08:24:13PM +0100, David Lanzend=F6rfer wrote:
> Hello
> The following patchset adds support for the SD/MMC host found in the Allw=
inner SoCs.
> It contains all the necessary modifications for clock environment and als=
o the device
> tree script modification which add it to all the boards using it.
> The clock environment function needed for phase offset configuration has
> been proposed and implemented by Emilio.
> This patchset is the second attempt to send this driver upstream.
> I'm looking forward to the acceptance of this patchset into mainline.

I have four comments here:
  - Read Documentation/SubmittingPatches, especially Section 5 and 12
    (hints, you forgot the clock maintainers for your clock patches
    and you didn't put any signed-off-by tags)
  - You ignored pretty much all the comments that were made during the
    review of the first version. Go through
    http://lists.infradead.org/pipermail/linux-arm-kernel/2013-December/219=
339.html
    and address the comments that were made.
  - Each of your patches should compile. Fix the order of your
    patches.
  - Submit a v3, with the changes you made. Otherwise we have no way
    of knowing what have been fixed and what didn't

Looking forward for the next iteration!
Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--2/5bycvrmDh4d1IB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJS8hT0AAoJEBx+YmzsjxAgRR0QAKqkCdwusxTRAK63xejPuXyV
u1beyvWAOP09eGQND3kpjFZuaq2LedqG2avBtVqC4GSbIh89akWVDhr6kbjkOoPu
3VaTqtkN5FNoQ8bfS/PJIl3S72p+DBku5BOkT+yNcLiDPNkyc0RnkR/mTywBIMVd
671eJMuS/jV8jacROOuyAQmFfKwKjl6Y7S7RMNTMmR273XM3znpRU4U1i8ir4mPw
N8kMOc0yK1FZ7t7zibckhnpCf7Y0Mb/UBjz5l5rd2prwoqtMkhGhHwlSnA8J4YK9
szs4iY4cH+4wwsPh9pFNVooIHEMFIjL+MgwGls1ovwnDLmQKfzFYogkSltCZeO0B
SJgd02wagzp/X/4te5iJ1kOYODp8192bVSICIPtCvLRKbBvJq3cGSY8UGj0GqUr3
dGXRqomhzE37AOc5tCe7Wdssu7qxjhn5KlqyOqdvZlMjxvI2s8TMKzNgARpku93M
wMFcQ5N+Rw9vdH0QwqCVxXS6v+2PP8gm4bQC/X4ToWRUjBs5oC3MJOdrUkn+QI5I
1TlclebP2lcXccgGBOqEUAt6mbXHCMayEiISxPpHlkZTPENSibms2lzpOGZVyuwp
SiWTHOiHsjJSdP/81ZLLW+sY5EIgW0xNIVhIHEjazNjx2znEteCFVSnSYdU3YMRb
3Kl9pTh9i5KW3VBzC81j
=74X7
-----END PGP SIGNATURE-----

--2/5bycvrmDh4d1IB--
