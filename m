From: David =?ISO-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
Subject: Re: Re: [PATCH 1/5] ARM: sunxi: Add driver for SD/MMC
 hosts found on Allwinner sunxi SoCs
Date: Sun, 15 Dec 2013 20:35:17 +0100
Message-ID: <2378731.6b9MyH8v8A@dizzy-6.site>
References: <1387058295-20641-1-git-send-email-hdegoede@redhat.com> <20131215162109.GI3651@lukather> <52ADF7D8.2010900@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2739466.6b5a1m7l26"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-sunxi+bncBD2JL37LXEKRB7MIXCKQKGQEDIXEV3Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <52ADF7D8.2010900-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--nextPart2739466.6b5a1m7l26
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi

> >>>> [...]
> >>>> +	mmc->f_max		= 50000000;
> >>>> [...]
> >> [...]
> >> in case of sdc3 they are putting 200000000 in f_max (as that is often
> >> used for sdio cards) but then later in set_ios they clamp the passed
> >> in clock to 47000000 Mhz, so I seriously doubt that 200Mhz has actually
> >> worked. Hence I've simply gone for a safe range for now. If someone has
> >> cards capable of doing 200 MHz we could certainly run various tests and
> >> try to improve this, but for now this seems a sane range to start with.
> > That's probably something that you should mention in your comment then :)
> Good point, David ?
Yes.
a) We should mention any reason why we did what.
b) If there is room for optimization we should mention that as well since:
	i) we won't remember every single detail in half a year
	ii) someone else might need to follow our considerations

> Right, my bad, sorry. I was so happy I was finally ready to send the patch
> upstream (I finally had fixed everything on my todo list), I rushed the
> cover letter a bit. I was planning on putting things like this in there,
> as well as why we didn't try to extend the mmc-dw driver, but I forgot.
Do you have something like this in mind? -> drivers/mmc/host/dw_mmc-exynos.c
Might actually be working if it actually is the same IDMAC controller.

cheers
David
--nextPart2739466.6b5a1m7l26
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEABECAAYFAlKuBH8ACgkQAeZw77btGjo5CQCeJI0cqd3EkDzEfTc2BNNTaZq9
X4EAoIv2OVrXUVYK3Jy9egK5q3xFuogy
=kH4X
-----END PGP SIGNATURE-----

--nextPart2739466.6b5a1m7l26--
