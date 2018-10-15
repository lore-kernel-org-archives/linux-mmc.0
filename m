From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] mmc: tmio: simplify the DMA mode test
Date: Mon, 15 Oct 2018 13:33:32 +0200
Message-ID: <20181015113332.uqnd4kmoabzto5kr@ninjato>
References: <1539356588-18191-1-git-send-email-yamada.masahiro@socionext.com>
 <20181014223636.GH3260@kunai>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7goolrfafe6rco6m"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181014223636.GH3260@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org


--7goolrfafe6rco6m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 15, 2018 at 12:36:36AM +0200, Wolfram Sang wrote:
> On Sat, Oct 13, 2018 at 12:03:08AM +0900, Masahiro Yamada wrote:
> > host->chan_{rx,tx} represents the DMA capability of the platform.
> > Even if DMA is supported, there are cases where we want to use PIO,
> > for example, data length is short enough as commit 5f52c3552946
> > ("mmc: tmio: use PIO for short transfers") mentioned.
> >=20
> > Regarding the hardware control flow, we are interested in whether DMA
> > is currently enabled or not, instead of whether the platform has the
> > DMA capability.
> >=20
> > Hence, the several conditionals in tmio_mmc_core.c end up with
> > checking host->chan_{rx,tx} and !host->force_pio. This is not nice.
> >=20
> > Let's flip the flag host->force_pio into host->dma_on.
> >=20
> > host->dma_on represents whether the DMA is currently enabled or not.
> > This flag is set false in the beginning of each command, then should
> > be set true by tmio_mmc_start_dma() when the DMA is turned on.
> >=20
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>=20
> I like it. Much easier to read!
>=20
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Tested on R-Car H3 ES1.0 and ES2.0, M3N, and H2. No regressions,
especially no performance regressions (since "when to enable DMA" code
was refactored).

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--7goolrfafe6rco6m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvEewwACgkQFA3kzBSg
KbZMBRAApYq21ZuXhgZCqB8ZFEjOPPo3rbUqZiTDFtUIaIbfywVpqLMtbeIjGn2K
7Sx6fuvtIs+usb292zwZfV4RBQHJek35T60MAs2z/t6Ye4WjKQlTinWEMwqQfoJW
mbFZc6jlXlA7vTc4ji72l8htng7weUuqAruwuPtoE57dHLNIKyUxyKd2zAmwN7yg
DFfrGmiDHh7B9s/bewdmMFbQ3lLz/LNOHyrhOtYH0l7gLPPN79BhF2NnOa7aqf/d
ATR81u/VQAGnuITtY6PQhxhNO/EKaFXv1awO244yczvs72M441t4hWG66gMgDB6g
d7aVEajAuARFvgYpJ0t2BxI1mMtAOFCjS/zN26lyl3tk4UHSC/vX4s/6WL99Dra8
3Hyi1mfLWL6ypusEpXeEQPAEAqH8W5nfYpTU3WzxsZaLElS3qOMfvYBk/hAnI2c6
OZJcOcN7NL/4NN38tOty2jWCLB5RSBwdbmmR33L1GhmQ+0T2nTtrO6nmVah1RkXi
juQn9Zdox/vJr5vIG1O0nex87v3r2MKDdfGrGFkbvD3hiqGXPhX2906pQrkiSCux
S0H0QIo7tj0cxkxDzP14s8Rkus3mLFhkHrdWSYANFKWh2fla+jIJUhP67Ydgs575
gelVZHlD8xxC/d3ncv7LiFKeWQQLMfFUeqUEIsDCPCXKUrbC46g=
=J9y+
-----END PGP SIGNATURE-----

--7goolrfafe6rco6m--
