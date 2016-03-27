From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] regulator: core: Ensure we are at least in bounds
 for our constraints
Date: Sun, 27 Mar 2016 10:08:59 +0100
Message-ID: <20160327090859.GH5028@sirena.org.uk>
References: <1458587912-32665-1-git-send-email-broonie@kernel.org>
 <1458587912-32665-2-git-send-email-broonie@kernel.org>
 <56F0624C.8010004@gmail.com>
 <CAJKOXPd5h0Cq++OxdiXytNJH94PN4Kh_wM3M=p3JdU1m_qyFTA@mail.gmail.com>
 <CAJKOXPcBOT_8NOH-=sEHSP0Rc+=Dvz-aqVTsBTMKg-VNWqQotw@mail.gmail.com>
 <CAJAp7OgGQ3qm-_QhydvN0n6QeNoHFdso4zOk41qvVJhKNeRn8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="N8ia4yKhAKKETby7"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:43784 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751879AbcC0JJN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 27 Mar 2016 05:09:13 -0400
Content-Disposition: inline
In-Reply-To: <CAJAp7OgGQ3qm-_QhydvN0n6QeNoHFdso4zOk41qvVJhKNeRn8Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bjorn Andersson <bjorn@kryo.se>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>


--N8ia4yKhAKKETby7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 26, 2016 at 04:50:41PM -0700, Bjorn Andersson wrote:

> Reinstating the following snippet in of_get_regulation_constraints()
> sort this out:

> if (constraints->min_uV && constraints->max_uV)
>                                        constraints->apply_uV = true;

The existing check in the patch should be an || not an ==, or possibly
we should just not bother looking for min_uV at all.  I just pushed out
a version of that, let's see how that goes.

> I did look at an alternative of having regulator_set_voltage() pass
> and call set_voltage() if the requested voltage matches the
> constraints, but this does indeed seem to mess things up. So checking
> in with you before continuing on that hack.

Yes, not everything is writeable.

--N8ia4yKhAKKETby7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW96MqAAoJECTWi3JdVIfQhd4H/2jPS6G+FM2FtxDs9sQ0JmB+
Xff+TTzJhL5/EzuPbKzc0XLNmezpa3Jj2zCq2lkYzN9aSFw/0/O0qGVsNqbWeINO
yxh0Z1SsG/h5j44HrW49R7Er4xpNDd2aInTBqLUXwu7NTD+U/ZHSH/HY3YlR4Vow
4NDlFx3+eojeA4FCIH5cZ6qquMezsssVOI77+lud3GDs3p6QHGwGI5wGI9hRR/Zz
udYWSt5NhRXffW2OoNGUnilRjZh6I3zXKnsNG9KKs4/5gHwXOSrHxtnzlaJ5QcdZ
9TOKxsea5COnZDg2LMVOUiDjQ470BJsgydu+93bkXj/KzYkw4LHq1ifc94xj+HM=
=rhow
-----END PGP SIGNATURE-----

--N8ia4yKhAKKETby7--
