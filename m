From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 1/2] mmc: tmio: move MFD variant reset to a platform
 hook
Date: Mon, 15 Oct 2018 00:27:58 +0200
Message-ID: <20181014222757.GB3260@kunai>
References: <1539143492-32605-1-git-send-email-yamada.masahiro@socionext.com>
 <1539143492-32605-2-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1539143492-32605-2-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 10, 2018 at 12:51:31PM +0900, Masahiro Yamada wrote:
> CTL_RESET_SDIO register is specific to the TMIO MFD (tmio_mmc.c).
>=20
> Add a new hook host->reset() for performing a platform-specific
> reset sequence, and move CTL_RESET_SDIO over there.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvDwu0ACgkQFA3kzBSg
KbYvRg//Totd877vkTn3Mh9wjkFzmgtSAs7oAKc/nrwI7QFKAnB+5tpfgsOedYN0
5+ZSsloJKrRS6cnceaZylnRcwL/3uPTpV97vfoiGQ+7QEJhyzY9GWahOCTte5f+j
XJNdxiH2S58JKlhZ1bJwRBg8CpqZTLVVOazUPoK7l835l2VxMwRQhJdyu778OVg/
1B/w+vmrcdevlRA+6B/EZ4918vvFVe1YkpaSb6Jy7AOZiueA1ypd0GcAxukuL1r4
FxUeC+Pzmj+TDdLDMEYXStXAGf6/3Gv435jLnFBRphwq90eiG/JgWEqB0JUe8SvX
MbUUV8P3FhzzW0SEBpToN+evn/2p7CjClU0Y6cg3shgO1q8ZIAzdjF5+P7ncOil+
ONvKvUaL0lIBIaWGgVEnHZzLMCg+1RzMXcRgB+fAjmnMNoy2/2kUNL9EqmJugT0n
cCSId+YwtL8BXzXPSs8SeapJwywBtg4RHWfOXhRbd/wBCj9ikLLi2+/GbJHCgtjp
hbMEQf7rNvzWKjbUuF1C3wX22VRfTbZdw/xHKjujncj/TuxCzs5zH9PhlrKOnCr0
J9dcMPEGQGL1frDPdEoez6m4fQeRWDl0M7XlCaKizrLDQ2OSKW5imwr2iSXHREQt
s8JXlOdbQCRksLchYJW5D/skI2v0yKlLs1k9iY7YLDhZ8c5QNec=
=9lsW
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--
