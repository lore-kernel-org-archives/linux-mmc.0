From: David =?ISO-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
Subject: Re: [PATCH 1/5] ARM: sunxi: Add driver for SD/MMC hosts
 found on Allwinner sunxi SoCs
Date: Sun, 15 Dec 2013 17:33:57 +0100
Message-ID: <1870422.7CyGeURSCU@dizzy-6.site>
References: <1387058295-20641-1-git-send-email-hdegoede@redhat.com> <20131215134415.GE3651@lukather> <52ADBAA3.7060507@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4905000.Rr5rH6eoGM"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-sunxi+bncBD2JL37LXEKRB7NTW6KQKGQEXHV6RGA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <52ADBAA3.7060507-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--nextPart4905000.Rr5rH6eoGM
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi
> David, since you'll be doing v2 I guess you'll be filling in v2. FYI
> I've tested this on sun4i-a10, sun5i-a10s sun5i-a13 and sun7i-a20.
Yeah. I'll take care of it.
I'll work out a V2 which incorporates all the comments made on the first patch
set you've handed in.

> It uses dma in bus-master mode using a built-in designware idmac controller,
> which is identical to the one found in the mmc-dw hosts. Note the rest of
> the host is not identical, I've looked into reusing the mmc-dw driver but
> that does not seem like a good idea (manual sending stop commands
> versus auto stop on sunxi, completely different registers, etc.).
It's already a good thing, that I know now what the command set of the IDMAC 
controller is, since I had no idea how to configure it exactly.

> The plan is for David to send v2 of this patch-set so that should take care
> of that :)
ok
--nextPart4905000.Rr5rH6eoGM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEABECAAYFAlKt2f8ACgkQAeZw77btGjo3AgCeKUWJf0JbPMPiiGEyy0ul8Xts
yCMAoKBPFPDZ+kxvsJdI0j5zBuYiWxE3
=pRaD
-----END PGP SIGNATURE-----

--nextPart4905000.Rr5rH6eoGM--
