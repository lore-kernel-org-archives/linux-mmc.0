From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-s3c: Enable runtime power management
Date: Mon, 5 Mar 2012 11:52:10 +0000
Message-ID: <20120305115209.GA3224@opensource.wolfsonmicro.com>
References: <4F51697C.40408@samsung.com>
 <1330735602-22409-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1330735602-22409-2-git-send-email-broonie@opensource.wolfsonmicro.com>
 <4F549A0A.5020402@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4F549A0A.5020402@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Chris Ball <cjb@laptop.org>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 05, 2012 at 07:48:42PM +0900, Jaehoon Chung wrote:
> On 03/03/2012 09:46 AM, Mark Brown wrote:

> > +	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);

> Could you explain why use 50ms?=20

It's essentially a random number, some other devices use the same one.
We're just trying to avoid suspending between back to back requests.

> > +	pm_runtime_use_autosuspend(&pdev->dev);
> > +	pm_suspend_ignore_children(&pdev->dev, 1);

> Is there reason that ignore_children use to set the true?

So that we can suspend the host without having to have the MMC card
suspended (the host suspend is not visible to the card).

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPVKjjAAoJEBus8iNuMP3dbGoP/0fZTUx4TUYy1CWx7iUBJo/f
zHQF7Kd+M3HtDItN9hEpprg/ICvqClcJtkXwcOj1vMBIDoQbVoJLSV89eC/7uBRg
eHEOKQU0lq2AtVKM+fuwG8ci//qHMjjai24ZbDXH50hWWq0qAOc0WFNfdTacq9/y
ozXZO9+8yRiBX+dQLJptoYWrOGZFZ7ozhir1hU8MZbJ/ogYP9rUKsF15YBhgcO7u
2s1e5QvsOPvTWZoiUREkR+4QtKkiLiUBB+gy3SZzcYMu92XQdGsYar/2jsfIo3+t
9WxrJ+hl6sf3l3a6NMK6joWsdX/UWSU6maRP1KFYqVGPKmoKbMJCQSR4uHGIpxZ1
bp9X64bUnpEiuEr2blCjGRtqH8OCgxJKu2DYRkGKXIwCIIwdUb3lEQmmc0Zy/nUs
Vcr7Rnyh7kU3Av+FE9tmuZShVk5qlmtCxu+X7z6my4AR9VDNZHw21S1Y3K6zE8Lf
mnOFhr1ezDK6IIMrcIu6cEm0N4IHdDYldN1JJgW78mivbJlnFrycxNr5nm8e73Ml
nR0ChgSc8Xs3oaIXd5YheKfanLCRed0zs/AH/MNUTkPrijAvtgf20GomcHu7IMr9
viiS9NYE+HPpK7wlj9sBfZCG8d1qCPIikT98qlsnROrQtrKBIdDAO8L7/ZmUFCot
ggJobFOKUzElQKu5/v81
=9h6J
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
