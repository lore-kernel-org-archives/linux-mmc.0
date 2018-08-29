From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 0/6] mmc: tmio: refactor TMIO core a bit and add
 UniPhier SD/eMMC controller support
Date: Wed, 29 Aug 2018 10:27:09 +0200
Message-ID: <20180829082708.2li4opnruodugo36@ninjato>
References: <1534999460-15111-1-git-send-email-yamada.masahiro@socionext.com>
 <CAPDyKFore4GkGyMn-4VA-2h1MbNp9sQ0Szif+Mjj5qtM-7autw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cebslwlmy6zsog4x"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFore4GkGyMn-4VA-2h1MbNp9sQ0Szif+Mjj5qtM-7autw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Jassi Brar <jaswinder.singh@linaro.org>, DTML <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org


--cebslwlmy6zsog4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 23, 2018 at 12:43:31PM +0200, Ulf Hansson wrote:
> On 23 August 2018 at 06:44, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > Add UniPhier SD/eMMC controller support.
> >
> > As a preparation, I changed tmio_mmc_set_clock() to a platform hook.
> > The clock rate setting is platform-specific, and UniPhier variants
> > will add another way.  I thought it would be better to split this
> > to a hook to avoid a mess.
> >
> > V3 is rebase on top of Linus' tree.
>=20
> I have queued patch 1 -> 4, waiting for further reviews for patch 5 and 6.

I have re-tested patches 1-4 as applied to mmc/next and it all works
fine. For those

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Now, going to check patches 5+6...

> > I dropped 6/7 because Renesas added more quirks
> > in the current MW.

Totally fine. We need to cleanup HS400 support more, then we can try the
simplification you did for tmio_mmc.c, too. Thanks!


--cebslwlmy6zsog4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluGWNgACgkQFA3kzBSg
KbZx3w//Wl0REQpw7bHVLUNFsr+rZYLXxVh2tOiagstUyLIo0LEbSWgT8v1wD2FM
f/fAVq0/YABZRHJdF8T8yq7nsHicxhkbEmQEmrAfpYOL6HOCm9U3YiMZXuKx+NFZ
mex9FRk3VyqPKDeKoYNvMoFSVkQeWwAB1WqKxgym0AmbggLK/mg2ehNQHrMYMCVE
p1u6rTNEkx48nDvmsO/zOU6Nm9y7A59+dBjLz94Fzm85+Xq2daSKiOysERXEgep/
plj22wcdeIoFMSZTl6hrB6n9wAhQeAferpvJQ74sE3Zd9QTcAujylS4SxGC62F2p
Pz3rO7Dm31xuI/3jwm4UnPqXqEooeO7N90NoX8oeaTOpITLCHst9o7u2dbL8EYUL
epQCGH/4eLarrYm89bQ2VxOz6ELoiRajVpeZo2naThKFT3YILRNc666C3YpfEbDj
a/cBh3j9MiqkkjsfMuFXrPhSoA5/Z0LvEbQ6tI0N383NIgqGif2w5uKudvOl+tdL
s4seGwFYFAs+SA55IeabRMKIB0SGlzEIjIJEyCb4mfA3gyrs83xdUHqVDYvULCGu
/YRqwFZLltX27jxvgO4TrTH2Ad37BM2i8thINpSsgp5tyz42ZPiZalhghlnxhsYD
unrToWX16xTd6yf/vQTtopZ7lbCbPQTNuILCXxENBRA9rYM6YKU=
=7Y8v
-----END PGP SIGNATURE-----

--cebslwlmy6zsog4x--
