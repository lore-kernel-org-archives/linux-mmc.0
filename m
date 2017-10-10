From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: renesas sdhi driver and DMA
Date: Tue, 10 Oct 2017 22:32:29 +0200
Message-ID: <20171010203229.rrwxkrczuk7piqh6@tetsubishi>
References: <SG2PR06MB1165F16A63D6793DBEC419688A750@SG2PR06MB1165.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r6pje7me2lhs7nil"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <SG2PR06MB1165F16A63D6793DBEC419688A750@SG2PR06MB1165.apcprd06.prod.outlook.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Chris Brandt <Chris.Brandt@renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org


--r6pje7me2lhs7nil
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Chris,

> [<bf9921e7>] (tmio_mmc_dma_callback) from [<bf908e1b>] (rzadma_tasklet+0x=
23/0x98)

For SYS-DMAC, this is a callback called by the dmaengine core once the
DMA is completed. My guess is you call it directly from an interrupt
handler? It would be easier to talk over code here, I guess.

> Is it now a requirement that I have to register my DMA channel=20
> interrupts as devm_request_threaded_irq?
>=20
> Will that fix my issue?

I can't say yet if this alone will do. Likely not. Can you share the
code already? Isn't it SYS-DMAC compatible (sigh)?

Regards,

   Wolfram


--r6pje7me2lhs7nil
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlndLlUACgkQFA3kzBSg
KbZHAA//fovE1GKGxHsCFa/6/q0vW3LFfhvWo1k/opgy+pxTuAFDivb6kP4dep7r
Pvpqvb7qjpmBiKS2QCs9O5tVt73oLh2VNz7JCHzw78H7SLBY59SZyzi1SB/1NyCC
We7BPdObrDejOyVzoDT6M8wV5ewp3QbUF3SCLNFPpoJ26n8mfAorIbnjyMCZ1pGw
hlRFRAmsuxjOgTqZnVmEfXRvnAWGfGpuscwDvTqSMSRETE0v+0mWT9PmLqikZAmt
m/M1xsmYbv569d4+UnhgbqBHMdmWDUrrCsK9abP3DD+OO2bkg0cjEYf39/LWyHdR
/Y6EZKSav7rROizxLBD1diaw/5XvtBMgCBb2wmqMyPN8qUiv0B+KeSrNwUgQ3K37
AHJR16Bw6JrGorFcPkXX47UuFF6ZRPWQkdjteG1A4/CPyYQQHHfqJXqWK+w65ecb
XejK1d6KiRQJDWVisUQe2nCd/MWWEC5TUHFrj++tyPB75ExHiwqZNRNwRMncvA1C
C27SjlslDRv/qTfga5Sjw8VD0GJdL9x3x+HS6mILI5h7bRGNBFef72PE7dvRpviC
rPQGzjK7ylt2Rqm2qZEwNyIIJ3gl9IpiJYpqt4yLnRQ1rtGngV165VU2VaVY6hAr
12Zx9O9dhllWbkwOTwzBndOMXGhQE9jL0NRK5V8xJkKPaBVzNGY=
=Irx9
-----END PGP SIGNATURE-----

--r6pje7me2lhs7nil--
