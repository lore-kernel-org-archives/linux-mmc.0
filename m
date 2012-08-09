From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH] mmc: sdio: Fix PM_SLEEP related build warnings
Date: Thu, 9 Aug 2012 11:27:56 +0200
Message-ID: <20120809092756.GA1020@avionic-0098.mockup.avionic-design.de>
References: <1344495413-7164-1-git-send-email-thierry.reding@avionic-design.de>
 <201208091127.03119.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:61719 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755589Ab2HIJ2P (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Aug 2012 05:28:15 -0400
Content-Disposition: inline
In-Reply-To: <201208091127.03119.rjw@sisk.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Chris Ball <cjb@laptop.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2012 at 11:27:02AM +0200, Rafael J. Wysocki wrote:
> On Thursday, August 09, 2012, Thierry Reding wrote:
> > Power management callbacks defined by SIMPLE_DEV_PM_OPS are only used if
> > the PM_SLEEP Kconfig symbol has been defined. If not, the compiler will
> > complain about them being unused.
> >=20
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
>=20
> The pm_no_operation() thing is not necessary at all, AFAICT.  I'd just
> remove it entirely. :-)

I don't actually have a setup where I can test suspend/resume with this
driver, but if you say so I can follow up with a patch that removes
pm_no_operation(). It should work because many drivers without proper
PM_SLEEP support do not specify .suspend() nor .resume() callbacks
either.

Thierry

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQI4KcAAoJEN0jrNd/PrOhLjkP/AgpUObNA0zfD5YE1FWq6877
mXhKka6tEFxjNfDUsmyPeaduXNit6elm7jkfejK46HsOSZsOta46Kn+4B7E3YgAo
VCBXcCnJnhRdS9VGXsVmbDZAfNLAnTKTY1nYxfUeyvNNe0Sz/4LL0vLvtZ+09QkF
ngidZX4pWEGdsz7O6WiS7e29riUfvmZtrmAINCAfNh/Oi5esqZEt3EsNmhtX2Stl
Hvb2e6n5i9ecfnOJG7cAHM+SLBYpFcZGtEB3SeLmXqzQJ5XJg4uUqL/TL+5UX5WZ
bZ96HkgwMysLuxUxJvvxYqjFoYoqD7mq5iB7e/ySMt56aUBCysFfF4/DGOLpEYVH
IlUr2fiOAAaOIF8Sq2JUAVPMIkgFm4eHqFGpkv/xqKrDLMGfTXAsGqXBhTX5+vrq
CNGibQqJFTVS3W2K/X4Ch7PVzWaQLW47+UTc1f+qRaIA/bDYtDzwcEKwTBdSWEkp
wjhK5jwXTQqV3R6Gq9PKXhO1NFwgtdmUROCA2tU3n8wYqC6KABlbpXBOg4aXc5TW
GT0dKUht/wDjphuS7xc0t8NfroyWQPamQML4NQM/m80LT4ipLhiVGo41ue6eoUSn
SvelnZpwejquJXzkcxZSr5a5xpvstwGVDLnHh6U6NDPeBMjaevzttXQVDIy0C5JM
7dyJEKP2pQCoyNQDNSsl
=b1HL
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
