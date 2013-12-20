From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 3/7] regulator: add pbias regulator support
Date: Fri, 20 Dec 2013 16:09:17 +0000
Message-ID: <20131220160917.GY31886@sirena.org.uk>
References: <1386670577-3530-1-git-send-email-balajitk@ti.com>
 <1387456720-7202-1-git-send-email-balajitk@ti.com>
 <1387456720-7202-4-git-send-email-balajitk@ti.com>
 <20131219163300.GK27438@atomide.com>
 <52B4124F.8010903@ti.com>
 <20131220155721.GX27438@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oUI2l+Vq7ILP1REU"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:35577 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753454Ab3LTQJo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Dec 2013 11:09:44 -0500
Content-Disposition: inline
In-Reply-To: <20131220155721.GX27438@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Balaji T K <balajitk@ti.com>, linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org


--oUI2l+Vq7ILP1REU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 20, 2013 at 07:57:21AM -0800, Tony Lindgren wrote:
> * Balaji T K <balajitk@ti.com> [131220 01:49]:

> > But interrupt was never used/tested AFAIK, there is some settling time
> > before the generated interrupt status is truely valid, so pbias interrupt is not
> > reliable.

> OK. Do we need the standard regulator property startup-delay-us for the
> PBIAS regulator then? Or if it's always fixed, I guess it could be done
> in the pbias_regulator_enable()?

That delay is supposed to be the time for the startup of the supply
rather than any detection code.  It should be set using enable_time in
the driver if it's not system dependent - the property is there for
cases where the delay depends on system configuration (eg, due to the
capacitor values).

--oUI2l+Vq7ILP1REU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJStGuqAAoJELSic+t+oim9rfcP/2G7Jo4pNQZyK9i4LJRbOKoh
3QoJrWRy6VXROAyXSLGBVP+TPWEMJpuSzu03PusUjFB9pxOA8ZSexgOMyjMq2Bbn
sZwEpsqvrCG5fKAYHq80UOifv0ONxl1mWpAjvLdNqTNz+A9s3rYYS7Pz3u21J2wo
pfyYYsXA7G1ih/cUjEODIGMWxlLjA+sRQBHbDj6fva2aAEW682uiSbkHuDvzihuD
FEn+7Xdf/zhfUlffbrFTu2g3LuFvwQOUm0dWikLeoLFcuugSt+wKQWzyMDmDC+vC
94yKgbLxrE/0NPBFrmHEbXtn6fc5f6X/kjgLlvSyZyaKrdnGd8tJEwJn/Qe0noNK
57x63QbXKPdC9ylbgFOtvAkiymrmv9qHb6snnrx+MZ+lzd4WTBXYKOKevm5jE4qO
HEsh+kY7RfOQemvWI6VgLzOTcFKiPqKWxjitfmUpXxDVwklRP2gIAfaJcTy28H7p
/DC/58GwQ7joOoNtIXivBWNpRqCIyAMmInfHUgvBKO52X6bvqy4V89bdhUN0+u/p
T8NztMDY4npLMGpaZaAY/JYr93wNkOdkp2//rlTcejg+9uF8eW3WpsTbH0OV00gb
X2l6pKE6+FcLlTHP8wfYFmKmCUIWW1DnK019ZjlhAFepUhz+vwZJ83F9TshdUyfG
du92sE/JrJ9t3Y4+fTxB
=QDfy
-----END PGP SIGNATURE-----

--oUI2l+Vq7ILP1REU--
