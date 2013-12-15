From: David =?ISO-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
Subject: Re: Re: [PATCH 1/5] ARM: sunxi: Add driver for SD/MMC
 hosts found on Allwinner sunxi SoCs
Date: Sun, 15 Dec 2013 22:19:56 +0100
Message-ID: <1743952.noztKtcF2Y@dizzy-6.site>
References: <1387058295-20641-1-git-send-email-hdegoede@redhat.com> <2378731.6b9MyH8v8A@dizzy-6.site> <52AE0E87.2040304@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1403238.niM3Iaa0RE"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-sunxi+bncBD2JL37LXEKRBAN2XCKQKGQE2SLNEXA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <52AE0E87.2040304-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--nextPart1403238.niM3Iaa0RE
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

> > [...]
> > Do you have something like this in mind? ->
> > drivers/mmc/host/dw_mmc-exynos.c
> No, as explained in my previous mail the idmac being shared seemed to be the
> only 2 things the dw-mmc controller and the sunxi-mmc controller have in
> common.
Ok.

> Looking at dw_mmc-exynos.c it still pretty much is the classic dw-mmc
> controller with some extra bits, where as the sunxi controller is
> significantly different (which allows us to write a significant simpler
> driver).
Do you have an outline for such a driver as you imagine it?
I'd be interested into some "experiments".
Maybe you have a repository where you could push a dedicated tree
for some colaboration on this?

regards
David
--nextPart1403238.niM3Iaa0RE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEABECAAYFAlKuHQAACgkQAeZw77btGjonUgCePnIHp0UwSdlN2IzK0Z/FeAMb
RX4Ani5aTjSwWMfhgopv13TzsepiwuCN
=j4+o
-----END PGP SIGNATURE-----

--nextPart1403238.niM3Iaa0RE--
