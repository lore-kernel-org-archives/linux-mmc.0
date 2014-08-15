From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] mmc: core: Use regulator_get_voltage() if OCR mask
 is empty.
Date: Fri, 15 Aug 2014 23:29:14 +0100
Message-ID: <20140815222914.GM17528@sirena.org.uk>
References: <1408019940-11153-1-git-send-email-javier.martinez@collabora.co.uk>
 <CAD7vxxKvzxvmzgx=S5ZZn54ts99ca2TqBYFvY1SXZQZDkhjq3w@mail.gmail.com>
 <20140814151958.GY17528@sirena.org.uk>
 <CAD7vxxLHtk2ywHGoBtDp6x3-5BtDdaFnCdc_pfgMwq63Cg8Qow@mail.gmail.com>
 <53EDBB5B.4000209@collabora.co.uk>
 <CAD7vxxKvZCxnDpPn3X1Uch_6m7Hfj_vApNfxUS2Wex9BjjBUdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l0GZ4SE/qP5NVpaF"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAD7vxxKvZCxnDpPn3X1Uch_6m7Hfj_vApNfxUS2Wex9BjjBUdg@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tim Kryger <tim.kryger@gmail.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>, Haijun Zhang <Haijun.Zhang@freescale.com>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org


--l0GZ4SE/qP5NVpaF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 15, 2014 at 07:19:41AM -0700, Tim Kryger wrote:

> That is a little different from my suggestion where the constraints
> check is skipped when the regulator output is fixed.  It effectively
> does this now when the regulator itself provides the fixed voltage.
> However, the checks aren't skipped when that fixed voltage is coming
> from an ancestor.  Why the difference?

Nobody has written suitable code, and please bear in mind that even if
the code is written there will probably be cases where it's too
expensive for whatever reason so Javier's change is going to be needed.

--l0GZ4SE/qP5NVpaF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT7om3AAoJELSic+t+oim9h3IP/R1CiGNSrZBydfF6pdNiMt5B
Z8vjp/9GOdQkZqKc/xgXZc6Gki8n0g6k6VpC+/EPljalIvmIwS3b/Ln94Eu9PhcT
0kp0WU+zVYkCZ+jX0caIt/O0OIC0yWAsf0VK/OMpcFXQbQYfZRQgeeItYQ/lC8eJ
nJ18yHXD5eu7dw2CXJtt9jGDkOktC67knVtZHC50gYrEgtMoGG/lxHq0muGvByHT
InKV339duP9hiNehPotRnuQ50ZM7u4RdWuRlGGOt33s2q7vk876I51cxrjJS0X6v
zA//XD5QgdjyNhbIe1Q4N04mv+Un240EpqOYl0QdR6FuC/Wg7N/h0j4FSgdLIRCc
IGKeLE+qRg/j28MQdjxX7dwRJqIv1LWd4WpHFkionkPJoLBcDA/U1N4/EJAxgh6M
JmSn/g3GVIEEYc4EhVzESctPReGgAmntRBiHDHsW8Dwx2zRN/9jaCwi9vYuIDMke
4ktZJFHLpmfTeJ6iPt3v4NGRxxglDAGNFrra/keiRwZcpLCoSugERaQkpOmcAyt3
BrzrgslYLAQS+ubzp/Em5DqwD9Ygz0YdsRhSWCG6jR2JoKMKxJzOy3SFf4qyc1bv
h05oU6pySwgp5qG8ZOv7SR7d6e8ZxHhr0WvDT4ovPy3ssMMN1S2Kyjn2RPGNWC8S
n7xCUoG0TJNRH5FIyW1E
=C0ZE
-----END PGP SIGNATURE-----

--l0GZ4SE/qP5NVpaF--
