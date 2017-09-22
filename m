From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC PATCH] mmc: tmio: check mmc_regulator_get_supply return
 value
Date: Fri, 22 Sep 2017 18:04:05 +0200
Message-ID: <20170922160405.wfpi4fyziz3sxtmh@katana>
References: <1506079337-12882-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <7e1bdda1-d790-0db2-540c-69fabe22850a@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jekopwxvvvlwokjg"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7e1bdda1-d790-0db2-540c-69fabe22850a@rock-chips.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Ulf Hansson <ulf.hansson@linaro.org>, Simon Horman <horms+renesas@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, kuninori.morimoto.gx@renesas.com, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--jekopwxvvvlwokjg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > However, there are side effects to it as the mmc devices will be enumer=
ated
> > in a different order (due to -EPROBE_DEFER), this means this patch woul=
d likely
> > break existing platforms.
>=20
> However this doesn't. The user daemon should never relies on the
> sequency of probing the mmc block part. We neither support to provide
> alias for the device id, nor guarantee the first probed controller get
> the first block id. Please use PARTUUID for rootfs, etc. So this
> shouldn't be a big deal.

That's exactly what I thought as well...

Thanks for the patch! Will test it the next days, but it looks good
already.


--jekopwxvvvlwokjg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnFNHEACgkQFA3kzBSg
KbZFig//f1anLbMK6oF12jSfwFotNeV8+B1bmjnRIWk7y8Up09CLb3uwpStiOE+1
gtHwdl2guAAIdKhiUyl7d4jp0ThtuUUn0Id1pNSrpnQd/PPXLyGcgkzr5xpY32kL
SIpgZy4QJNTfJdPmmDY5prPl6R9LFfy0lngGIDPU7Al9neADBUMmfJkhw3CE414w
cYphJUgGq4Kj3oWFGjyucPfcXWGTITatnDJhTYhcClCccowwzwAYZjqS0Ct0a5+T
sQ9wiW0KUqY7lct+6QzTtBTWzGFzWjNEyarjBjYJGqIz5//F8LSjQFeiJcJuDmtY
i9SUAToam/tFsc9Wj3MwdlUjtnSA/oHsCdu+s6BnTOsDEgZ7zgPo6gPLBrAiecXG
eq50EfKPb7B6DA2736kN5i9CVYwK7VKR+7wYkcOnNULVgKTnaRd0TOPRsE8HjKsi
MigvMcD1B4LxzZ/w6w5Sl3s4kWcBoRg0jpLjJVP24Ma3oYAwCqwGP+W9AyTrUWHc
fLmdNNP3vNcmLBlB7ncEIIHAXwCvcHgIo4AmKp396F6y35/rEIBm7TiCvPv1WrZm
JlhJ+kgf14gH6tsrcsl3CsOiMIQdNHTCV6fpF/gtxa339//pMNeyF9536AHZt0T5
mlKVdu851MXEDTq5y5fzIeoHopEhuT83LlipiqmTxNocTa1SrDs=
=T4+j
-----END PGP SIGNATURE-----

--jekopwxvvvlwokjg--
