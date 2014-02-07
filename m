From: David =?ISO-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
Subject: Re: [PATCH 0/2] sunxi-mci: Fix hang on boot caused by
 irq storm
Date: Fri, 07 Feb 2014 15:31:14 +0100
Message-ID: <5177034.yV0C6cz2TQ@pagira.o2s.ch>
References: <1391781641-7382-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8142202.eY5IGWIEP2"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-sunxi+bncBD2JL37LXEKRBBW52OLQKGQEL5S52NY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1391781641-7382-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--nextPart8142202.eY5IGWIEP2
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Hans
> Here are 2 patches fixing a hang on boot caused by an irq storm, which
> I've sometimes observed on my cubietruck during testing. Can you please
> squash these fixes into the next version of the sunxi-mci patch-set ?
Ok.
Good thing you've discovered this issue.
I will incorporate that into patchset v4

cheers
David
--nextPart8142202.eY5IGWIEP2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEABECAAYFAlL07jIACgkQAeZw77btGjpgNgCfQT2Vvi55E9IK4mgcRuUqCt/U
Vc4An3xiJ2UnNseJDrhLBWvy35/BgAuG
=mlh5
-----END PGP SIGNATURE-----

--nextPart8142202.eY5IGWIEP2--
