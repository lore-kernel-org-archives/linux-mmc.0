From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] mmc: sdhi: use maximum width for the sdbuf register
Date: Thu, 10 Aug 2017 10:39:57 +0200
Message-ID: <20170810083957.GB2175@katana>
References: <20170809182926.669-1-wsa+renesas@sang-engineering.com>
 <20170810075309.GC16647@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170810075309.GC16647@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Biju Das <biju.das@bp.renesas.com>
List-Id: linux-mmc@vger.kernel.org


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2017 at 09:53:10AM +0200, Simon Horman wrote:
> On Wed, Aug 09, 2017 at 08:29:26PM +0200, Wolfram Sang wrote:
> > Make use of the 64 bit sdbuf width on Renesas R-Car Gen3. If the
> > registers are 8 byte apart, the width is also 64 bit. For all others,
> > the width is 32 bit, even if the registers are only 16 bit apart.
> >=20
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

Thanks!

> > Tested on a M3-W Salvator-X and H2 Lager (with both SDHI instances). On
> > the Lager, I could reproduce the problem with the old patch. It is gone=
 now!
>=20
> Do you think there is any value in widening the test-coverage of this
> change, f.e. to older SoCs?

Current mmc/next with this patch and the CBSY patch might be worth it,
I'd think. Mounting, copying and checksumming a file should do IMO.


--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmMG9wACgkQFA3kzBSg
KbZTmBAArfvKu62P+6gfiM8a62GAoB1c5vw6Mca9P1r+rPTdtiyO2ZOK0dZI6JBC
DtBHHH9V6ZLI4vBHefOuzNrFUPbp6VKUhOw00R+klV/ISALR+NJJyOnAZyhQDS8y
Ok9xmtH5tI6oxkwHW1Z/fF1osulIMqA3Gpm1als3w3rlG7WnKYu2i38RHwKaRvY1
uS5rCvPR8HwtHL1A1Hp25m5Gj0+a61849AXdyy6KxtirtVTEv8YpJbbJ+NbvKLj5
PLzBeqQprlJUSyqEqnx6zcjgF8fAFeLLcxwM0JG06ynFhPeRFxMJNcyMJxBkmsLI
RaC8+f2vjKNOTMcMLu6uLYzGH/sShHjj4Vro4mQj3fmZ+hbQf2doPSQsfsyJaWSL
M1Z5ZoW8re7zZ8Gt0SE0F0VaHuJGH3JSf0h53nH0rtP7MUDwKXkQhhm2w5Qix3yJ
rYNyHDTKDz7q/f+er5UxnG2SEabI4Qk7QfYW/hO7Mq3LUp0dBZ7pYjXqnPvK8EIk
4PGRuI8qaZw0LprWS9WxEMOqW5aVcf0cvanoWPPlj7yYv1Bp6G/8K93+mwGv/nnQ
5qaio2PK3XeJ5tBf3kvddG4skUSCZzxiXHzXe+Xn3xSomusZknbmSKj16JB6d6wY
qoSRH4Dbtc6ZpA8Wfv7DSNJ3k4IHyag9+unDQFlhjZqynL31WSs=
=5fvg
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--
