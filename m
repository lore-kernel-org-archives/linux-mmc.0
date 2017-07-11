From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFT] mmc: tmio: fix CMD12 (STOP) handling
Date: Tue, 11 Jul 2017 17:00:13 +0200
Message-ID: <20170711150013.GB6264@katana>
References: <20170703192823.8116-1-wsa+renesas@sang-engineering.com>
 <CAPDyKFqkGj-ywGciKqxxg6PnPDP3N1G+H-snnimhQPhVDJAFQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:41580 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755995AbdGKPAQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 11 Jul 2017 11:00:16 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFqkGj-ywGciKqxxg6PnPDP3N1G+H-snnimhQPhVDJAFQA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Jan =?utf-8?Q?Kl=C3=B6tzke?= <jan.kloetzke@technisat.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>, Kouei Abe <kouei.abe.cp@renesas.com>


--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2017 at 04:43:28PM +0200, Ulf Hansson wrote:
> On 3 July 2017 at 21:28, Wolfram Sang <wsa+renesas@sang-engineering.com> =
wrote:
> > I always anticipated this code to be not correct, but now I had a test
> > case to prove it. According to all documentation I have, setting the
> > TMIO_STOP_STP bit ever only worked during block transfers. This bit is
> > like manually enforcing an autocmd12 during a so far seamless transfer.
> > It does NOT work when the block transfer had errors. It also does NOT
> > work with any other cmd except block commands. For all those, CMD12 has
> > to be treated like any other command. So, basically, we could use this
> > bit only for mrq->data->stop cmds. But for these, we happily use the
> > autocmd12 feature using the TMIO_STOP_SEC bit. As a result, the above
> > bit is not useful for us and we need to treat CMD12 as a regular cmd
> > always. Just remove the special handling code. Note that the BSP
> > recognized this issue as well yet had a more cautious solution to the
> > problem [1]. Which is understandable but makes CMD12 handling even more
> > complicated.
> >
> > Checked with a Renesas Salvator-X/M3-W which needed to send CMD12 when
> > retuning one of my SD cards.
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas-bsp.g=
it/commit/?id=3D2838a2ff8ca776f6d18b7fbbe75f3df8dd64183a
> >
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> Thanks, applied for next!
>=20
> Should we add a stable tag?

Thanks! I'd like to wait until it gets further testing when it becomes
upstream.


--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllk5/kACgkQFA3kzBSg
KbZmzA//WO00KIVqlDp5tvSzy4iGFK22EPnCgVx/gO1L//gy2f4YHZHI+ZQjn1pd
c0/iI+8+aau9r/QUs2UsynZyZmD+j/criJYfTojLPJm3Q89krt0a1u+I5pM3q6Bo
mULoG6KQMsSjBioezw0kyb9SbpD/C/ft1x8ZlEMPl29Mjteoh51pxvHbQvr9hAnR
59mQ541v3HcAN/t+AAKthLOgZVEJBmw4bDibwBRzD3/+rGzHs8j39knV5n5wg/g6
MohMG4TyROAKfcseJNbymW8IT01/3kxXUliH9naGHABlZlQBdjzt8tbpexfwt/J9
8PeO70GlRLebh1Yg3V3UJR68J/QZuMSC2WOd7EQqSj8FAWuEx3rLP+b8hdvXpha4
Pukuemz3yu1Gc/hYTdMyXQjtuQbcrBqJfyI50AL/xya4WglFV3htr5yzjALZafAU
rXRnkxWJGwchRWi4JH+2fCLC7/XKE7FxbpGA6lQz8D1PjbE18L/BMyIjSR241Fjr
glNemro6vfLFMAVf5X5gakwgsuzZUW6LRgYXRb1XQ3mKieJNHnvCXt952dI0+qq7
9J8O66/aV4vGHP2hsB82SPYkV5l/UKaynkB23hA44Jm+0sMFRLBPyoiqSRq3iv5p
3Xft/SWWbqQykFy9SCYCSVE8ElYdnuLuNstIDNAI1yr8evx08ug=
=I7iG
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--
