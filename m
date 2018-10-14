From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] mmc: uniphier-sd: fix DMA disabling
Date: Mon, 15 Oct 2018 00:33:29 +0200
Message-ID: <20181014223329.GF3260@kunai>
References: <1539356258-12374-1-git-send-email-yamada.masahiro@socionext.com>
 <1539356258-12374-2-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="udcq9yAoWb9A4FsZ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1539356258-12374-2-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--udcq9yAoWb9A4FsZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 12, 2018 at 11:57:37PM +0900, Masahiro Yamada wrote:
> Once DMA is enabled, it is not possible to disable it because
> uniphier_sd_dma_endisable() always sets the DMA_ENABLE_DMASDRW bit
> regardless of the argument 'enable'. It should disable DMA when
> 'enable' is false.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--udcq9yAoWb9A4FsZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvDxDkACgkQFA3kzBSg
KbbF8Q//egWXiLpPEMi7CydMxGxXSSOv4kYYnHrWPe+FW2b1LG4nTU36VQibTrub
Hk+U7gng3Xu2+MBTpvu6I1WrJ/thmdazuqa8RAqxfpHA318suhBibpR8EUfdEea9
M8Z+l1povsbHqVAkXsTlshySgxzlfjbih/NCTmBzq5/ZbIDC24buacZIsl3YQMDW
c05MLNRXJbHbKKJ1mOYJQfWV7aQCXwIlX2NQBN76w8xD1Y4MsMH64UD+asQNKC1h
G0KdvMIDh0DZ7kDB90ZJgrukVZ1cfH5NaYkQABbWhUop9QAb2Ua5sxYaqZhOT3QT
6HbBidN1n+CvxGlKJIFRmwE5z7bLJnL+ZpIRGhjMDUoiAO+5zNRGV26j6tshsz9C
KQ5r8i8fQYDPdpWZW2QBK6G3r3CnQLyF+Qid6I0RlvVHUdrQqZpRrfzFE9PP+9Jc
PTOo/0N3e+F2nk5qinW5tSTV6UIcoXqZGfFAcHtGuInDTevKk1aAIJZcrsYJfTuG
GOHNshlRNyRr0KlkPEfa68PcVdmehPzj0M3nkPaJm+Qw9NTIeuv4DyTtrV7IBL3R
Kbon9m2PPm+xYCM3ALaNYePbCRRsP40xnnSTUxXYSbTAvgVe/uQN2oIYl4eWa1Ep
gA/wqJq88mZPU+hZAy0XtRG66LYWPSLULzRyau++7LfofWmiAQQ=
=zpu+
-----END PGP SIGNATURE-----

--udcq9yAoWb9A4FsZ--
