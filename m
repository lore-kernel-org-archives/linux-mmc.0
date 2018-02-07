From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 14/16] mmc: tmio: move TMIO_MASK_{READOP,WRITEOP}
 handling to correct place
Date: Wed, 7 Feb 2018 22:47:07 +0100
Message-ID: <20180207214707.6d32d27towuofyyu@ninjato>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
 <1516206496-16612-15-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uhgi7sjo6kbhlkoa"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1516206496-16612-15-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Magnusson <ulfalizer@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org


--uhgi7sjo6kbhlkoa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2018 at 01:28:14AM +0900, Masahiro Yamada wrote:
> As far as I tested the IP on UniPhier SoCs, TMIO_STAT_{RXRDY,TXRQ}
> are asserted for DMA mode as well as for PIO.  I need to disable the
> those IRQs in dma_ops->start hook, otherwise the DMA transfer fails
> with the following error message:
>   PIO IRQ in DMA mode!
>=20
> Renesas chips are the same cases since I see their dma_ops->start
> hooks explicitly clear TMIO_STAT_{RXRDY,TXRQ} (with nice comment!).
>=20
> If we do this sanity check in TMIO MMC core, RXRDY/TXRQ handling
> should be entirely moved to the core.  tmio_mmc_cmd_irq() will
> be a suitable place to disable them.
>=20
> The probe function sets TMIO_MASK_{READOP,WRITEOP} but this is odd.
>=20
>     /* Unmask the IRQs we want to know about */
>     if (!_host->chan_rx)
>             irq_mask |=3D TMIO_MASK_READOP;
>     if (!_host->chan_tx)
>             irq_mask |=3D TMIO_MASK_WRITEOP;
>=20
> At this point, _host->{chan_rx,chan_tx} are _always_ NULL because
> tmio_mmc_request_dma() is called after this code.  Consequently,
> TMIO_MASK_{READOP,WRITEOP} are set here whether DMA is used or not.
> Remove this pointless code.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

I need to stop reviewing here because I'd need the applied version for
checking. I hope Ulf can give me a base tomorrow.

Or Yamada-san, do you meanwhile have a git repo somewhere?


--uhgi7sjo6kbhlkoa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlp7c9cACgkQFA3kzBSg
KbYlKhAAsan0zSFN0R/z5buBHVHh9XipwQcaH19s1VWL61PaPkSz+OgxqKHZEGmu
hFcq5ZdhHEtkKBWJDcwEYLTXI9zJSaeJwlImq8svOw19Ql5cKokiepqT5S+UBfbE
c61hwL8vaD2gEt5V1prSoSbuGdRqM56CyWD5V2EYgpUQUjx8ok8GG6f5LYsj9yCS
vXf2cZuuFCclAYYu1wsyyW6U0xkxYu1Ll8cBPxuX7+PVXCCsWp5rjNV6jXbm7NJv
YkSJn/MChBfZ569txrhAZKjKzTa6zCfsocFQ1dvOvUkW5JOM/KNMSLmnKmzdLJIN
DcgXJbI1cNy5YUujk+lEtaZUjwlj3v8GXcX7vcse7BKtkex4I2NvPsAwZmHJr6Ol
l/MLKBd0gfQqwou/oLH1/xu/4OzA/WiNXnXqxrsxD2WBDZ70DOb+6BzPaQ8I/D1E
uN7QsIXQG/Qc3uAXl7PvbhlUSl5ZZ3zJck5dbP7Hmja/n7MIOGjqo4+A11viLFG3
is7006uJB8Nx01mAjmHwCIUc+k0+Pjm52sww0iOcqc9+7ZEkQf+9uxHNE/gNOVxz
ys7pQfbNl6qxpBsVMayaewdqAdJaic3qTx/WJ4QMfjsc17I5K6pN09GtFWr6c5Y2
AFRX8q0fsud0AoJjcQAbVUafLwEX1KcwklUPbeD/PAy6/0VW8Bs=
=ucR1
-----END PGP SIGNATURE-----

--uhgi7sjo6kbhlkoa--
