From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] mmc: core: sd: implement proper support for sd3.0 au
 sizes
Date: Mon, 13 Jan 2014 19:46:45 +0100
Message-ID: <20140113184645.GA17979@katana>
References: <1385428585-17516-1-git-send-email-wsa@the-dreams.de>
 <20140113124117.GD2586@katana>
 <861u0bdahb.fsf@void.printf.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:36335 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751316AbaAMSqv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 13 Jan 2014 13:46:51 -0500
Content-Disposition: inline
In-Reply-To: <861u0bdahb.fsf@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, H Hartley Sweeten <hartleys@visionengravers.com>


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2014 at 06:04:32PM +0000, Chris Ball wrote:
> Hi Wolfram,
>=20
> On Mon, Jan 13 2014, Wolfram Sang wrote:
> > On Tue, Nov 26, 2013 at 02:16:25AM +0100, Wolfram Sang wrote:
> >> This reverts and updates commit 77776fd0a4cc541b9a528eacc1d31ca47eb1ae=
7a
> >> ("mmc: sd: fix the maximum au_size for SD3.0"). The au_size for SD3.0
> >> cannot be achieved by a simple bit shift, so this needs to be
> >> implemented differently. Also, don't print the warning in case of 0
> >> since 'not defined' is different from 'invalid'.
> >
> > Ping! Chris are you there? This got reviewed and acked, and I'd even
> > think this could be suitable for stable.
>=20
> Sorry about that!  I agree, pushed to mmc-next for 3.14 with stable@ tag.

Thanks. As buildbot reports, this will probably need another patch for
blackfin :/ Sorry about that!

=46rom: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] mmc: core: add #include to support size defintions

Fixes an error found by buildbot on blackfin after adding the fix for
sd3.0 au sizes:

>> drivers/mmc/core/sd.c:49:5: error: 'SZ_16K' undeclared here (not in a fu=
nction)

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/mmc/core/sd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 6f42050..585d44d 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -11,6 +11,7 @@
  */
=20
 #include <linux/err.h>
+#include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
 #include <linux/pm_runtime.h>


--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJS1DSVAAoJEBQN5MwUoCm2Vg4P/11BWePy9VV5qm5USmRmWiPy
8Z0/WOmIEqFpPoz3AMhsecJzGYz1ot1jJ2sxPjNo9NO3HEZ6CWoO+gwMb5PidiT9
jcSRl8bpZy7/11sa3E4BdraDZjpvrjGxLhNPZsAY5IRnrNP1H5E55UJBcb5oyJXa
3L2o7G3tf8vfRQXiHuQ+eG2UsrAe4pJWxRqWAsWoNZjFU6Ou+TCaiiuSOf8sbmxQ
D1Ntge/90qkY71XcaFWYSkL/DBM2mwOyxNIM+FmxVyZreGYOq7M+I8WY0seRZ2aQ
Pbe7NyJxx4AP7xD7/X4QI2elvMm/NEIjJ0McCTEE9QqQ+yenrerMkLxT2nRrAZ8g
jeHYWasiAlIxQfAIEnzbUuKDGOA/GnatMX6+rMmSET4wavCfwDWoR5e8CfShHxbf
MqWxkeHVPg6FNODGAhHEMeQAD7mWQYU0p+zRZA1+aIXoY6cgED17JXI9wrhMnXmB
ADw+VFX69MbRDQCO+U1GGUXgkLO9YWW9AdNMeKYZmiFGzc2TrXSpDyvIJB1rSIlI
q5GZSRW56FbdqwzYxS77lFSJUPkXYbjtOFkmjOSuovoH8afeddl1NOt+mJvxclFm
SvZBPzZ0NNdKHsv8dTjRqw9uKtuo0Tl8SDzQzsrSVEC+Kh/p/5b8BH3raQxrQumA
ohzZ8jI+zLpklVQyA5V0
=uHJD
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
