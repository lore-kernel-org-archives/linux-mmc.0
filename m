From: David =?ISO-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
Subject: Re: Re: [PATCH 1/5] ARM: sunxi: Add driver for SD/MMC
 hosts found on Allwinner sunxi SoCs
Date: Mon, 23 Dec 2013 11:36:29 +0100
Message-ID: <2155426.QS1WdjUNS8@dizzy-6.site>
References: <1387058295-20641-1-git-send-email-hdegoede@redhat.com> <1743952.noztKtcF2Y@dizzy-6.site> <52AEF060.6000405@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2038696.8WcruQbqiJ"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-sunxi+bncBD2JL37LXEKRBP5E4CKQKGQE7EZBT6I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <52AEF060.6000405-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--nextPart2038696.8WcruQbqiJ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

> I think that we're miss-communicating a bit here. What I'm trying to say
> is that trying to extend the dw_mmc driver to support sunxi is a bad
> idea because the sunxi hardware is quite different. And that the
> sunxi hardware having autostop allows the existing sunxi-mci driver to
> be much simpler then the dw-mmc driver.

> IOW the much simpler driver already exists and it is the sunxi-mci
> driver.
Ah! Ok. Now I get it.
Well then. I'll try to incorporate all the changes within this endless thread 
until I can get together a patchset v2 I can hand in.
Now that the lectures have ended for this semester I won't be too tired for 
straight thinking on daily basis and will be able to create such a patchset.
And please excuse my contentless answers onto the last few questions
but I really wasn't myself - so to say -  at this time (half asleep)

-david
--nextPart2038696.8WcruQbqiJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEABECAAYFAlK4EjwACgkQAeZw77btGjoPdQCfWWpXbw8rESwsFZMRKfqWYdDi
7gwAoIXSi+z4z0+z2NFT2A03bKFMtTDE
=FEFn
-----END PGP SIGNATURE-----

--nextPart2038696.8WcruQbqiJ--
