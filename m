From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 1/3] mmc: sh_mobile_sdhi: add ocr_mask option
Date: Thu, 20 Oct 2016 15:05:30 +0200
Message-ID: <20161020130530.GA4177@katana>
References: <20160912141507.6837-1-chris.brandt@renesas.com>
 <20160912141507.6837-2-chris.brandt@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160912141507.6837-2-chris.brandt@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Chris Brandt <chris.brandt@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 12, 2016 at 10:15:05AM -0400, Chris Brandt wrote:
> In moving platforms from board files to DT, there still needs to be a way
> to set the ocr_mask setting for the tmio driver during probe. Without this
> setting, the probe will fail because the supported voltages are not known.
>=20
> This patch will also traditional platform registration platforms to
> migrate to DT.
>=20
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>

I'm fine with this change:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Maybe some details from this discussion could be added to the commit
message?


--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYCMEaAAoJEBQN5MwUoCm2ni0P/3qBJocXBEjeYDyD0P7abech
L7oq5tsfIwZIhAeBN+DFlDqXKt/alkSlUrDUhKU9rTvSWDaDuiDTOd7sXoAUGAxh
/ZW9O2tiTJ8iHgo4MhrCgd8/ABYvVyY+1a+2bR9u1NOH6UnKU/+ueTFu6mad7nq0
4rMMM3eC+rRP+kZo5arXxnD0YrfmVOO+nj8l32VNeeZeWlqvn4tqmIe6D6FfZZWS
lr8wUXbshhCF6XNLcN8w650SRNUoSFO1vw51xMKnlfaWtX7+f7W9uD+Pvk68Gr5Z
nXRKSNpI8vqZ4D6xaOoyWIqNhqIDHOV/RohYajeYla6Xskr83AAMDIZFUIURM+W4
MwXOkuqfBf456iaUdBFdPNBPnGP+p6iQsSnVUmsxu4r4YMistq0U42gxnrQp3BCo
W3NuLA8rdqYAIqhRgSIlwq08u2TQVVROvW9uu9ItbDWieMOKoalhlVddgrTFX7t/
b3b9a+XFmq/+ajylNCBL7snTFJXDo5tiL0tgdB0wjy1NeJOgsPPmPU9qJMjPilH4
wqyPQTCPqAyAgiocXtP3nf99fX9M9I1fbnETR6RTx/Bc+GVYjymFexbHQr+HGiEA
t3K9OAU4TnLJ69s/ZmPiYMdCFb0t6cCHb1tWQz4AfmDti6OEssEbTuDqIn2mjB2c
5v4czX6njLjadcg9jPyA
=/mch
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
