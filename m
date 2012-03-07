From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 0/4] mmc: sdhci-s3c: use the sdhci-pltfm.c and move
 the header file
Date: Wed, 7 Mar 2012 18:48:44 +0000
Message-ID: <20120307184843.GW3107@opensource.wolfsonmicro.com>
References: <4F55ABF0.1060801@samsung.com>
 <20120306130054.GA9890@sirena.org.uk>
 <201203061415.18836.heiko@sntech.de>
 <CAELcNGS6UynrJPRk1KtEJT3Rm6Jb5_scLm4KKca+dJ1ZYDOVbg@mail.gmail.com>
 <20120306163052.GX19635@opensource.wolfsonmicro.com>
 <4F56D003.5070406@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="je0mZywpqEo4t1RU"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4F56D003.5070406@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, linux-mmc <linux-mmc@vger.kernel.org>, linux-samsung-soc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, kgene kim <kgene.kim@samsung.com>
List-Id: linux-mmc@vger.kernel.org


--je0mZywpqEo4t1RU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 07, 2012 at 12:03:31PM +0900, Jaehoon Chung wrote:
> On 03/07/2012 01:30 AM, Mark Brown wrote:

> > The same IP is present and used with the same driver on other Samsung
> > SoCs.

> I know that used with the same driver on other Samsung-SoCs(S3C64XX/S3C24=
XX..etc)
> I just only used the interface in sdhci-pltfm.c. Nothing difference..
> Why do you think that will break the other SoC?

> Header file(/plat/regs-sdhci.h) also is only used in sdhci-s3c.c.
> And the least portion is moved into /linux/mmc/.=20
> Then included "linux/mmc/sdhci-s3c.h" in plat/sdhci.h.

> What's difference?=20
> If you can explain the more detail, i can understand.
> But sorry, now i didn't accept your opinion.

To be honest I didn't read the series, the diffstat looks so obviously
problematic as you're touching the setup-gpio- files for only a subset
of Samsung architectures - there's been quite regular issues with
updates for newer SoCs breaking support for s3c64xx.

I also notice that this will conflict with the series I've previously
posted for runtime PM support which would push us even further back from
being able to use the lower power WFI modes in mainline :(  Though
hopefully that'll be easier to fix.

--je0mZywpqEo4t1RU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPV6x6AAoJEBus8iNuMP3dMKsP/3N8KSQV3RpSYeyhHcNuTcxj
rLoilLbpulvuBu5gw8sJmL4fFMshTfKgp9wwRsiH1kAaYJ7A5iKUHZCt2K9PRSef
Qnf5UTfTif/ItPY1w/zz9lBfXr0x39IlrtDHPHSaw9VhbCAXrw1/C27rogM79C/W
tidU9TAT/iXH8VrteW0B/OfaCSXq7PygDcgH2uE+s98+vV1ikotzK2LQLPY3mrZr
YJ1o95TDZ10QKZu6RAAiEqP/LdC9qsDWuYTyR4oV94JGtf83S4UJMckItL5e1kTU
T4gZNffMrJsLmy3MaIaT6ot3I+/Vjnbr7GNmzERmd/QHFC4Ppg4npqtENAz6vnT1
1oNevMxhQ4bdOPW47VszZ9BYgsSzeGn3Jg7wcHVrzPYdV4/9ZXd+BwFPlPqbRvDK
xQlMny4bOtdPHoO/+aaLuJjVNuwy5LSKPbAEUN2SGwU700TTqcaN0kBFt58zHmLm
P240+YRwvMbDR3OJwdQggl8svvPNGi8/t+T9s20xrz53eSAH+JZ4bjWCn1sHwNud
NXdNP4Q7oEpTPETOQ2FndukwA5ioUc5diIqKgyFG7jIXyV9ihz0Hh5kucP61FoW4
XiqTuy9XYzcgEdEkCx4U5TIKkmxz+12CrV0P2N/dI6uAnGROVt5y/r2X1M3xA8kr
1h9MAtxL1mSBd7yc2pTJ
=ChaI
-----END PGP SIGNATURE-----

--je0mZywpqEo4t1RU--
