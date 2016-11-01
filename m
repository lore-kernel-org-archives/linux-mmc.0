From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 2/3] mmc: tmio-mmc: add support for 32bit data port
Date: Tue, 1 Nov 2016 09:49:38 +0100
Message-ID: <20161101084938.GA1576@katana>
References: <20160912141507.6837-1-chris.brandt@renesas.com>
 <20160912141507.6837-3-chris.brandt@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:52989 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1168074AbcKAIt5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 1 Nov 2016 04:49:57 -0400
Content-Disposition: inline
In-Reply-To: <20160912141507.6837-3-chris.brandt@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Brandt <chris.brandt@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Mon, Sep 12, 2016 at 10:15:06AM -0400, Chris Brandt wrote:
> For the r7s72100 SOC, the DATA_PORT register was changed to 32-bits wide.
> Therefore a new flag has been created that will allow 32-bit reads/writes
> to the DATA_PORT register instead of 16-bit (because 16-bits accesses are
> not supported).
>=20
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>

Okay, I have a sketch how to add this feature to R-Car SoCs at a later
stage. This patch is fine with one minor nit which can be done now or I
can do it later when I add the R-Car support.

> + * Some controllers have a 32-bit wide data port register
> + */
> +#define TMIO_MMC_32BIT_DATA_PORT	(1 << 9)

Since R-Car Gen3 has 64 bit port, I'd suggest to use
TMIO_MMC_BIG_DATA_PORT or something. But as I said, I can also do this
later. So

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYGFchAAoJEBQN5MwUoCm2UvMQALIymU6qq6pXHb/9NTwnb4mp
gbPv4ggxF1fULDql025Aj/WTdGPH7Iaq5HGxcK3v8zBDYuPyJwrlSNbF8Pi6aofE
YzpKOiRl6Dit4cXvLAywLzUQarUQuPWFi1KF8UCXhfMRNP5nXVfHA/AtLWt1P7/v
KUAXuH6XEw7wc3+L94bXvncLrmK7Y29chqi83ZsyVN+r34nDKG0MaMnLcjssmQUa
6b2FyYYDtrztl8rpg2x1naJHsY/P44dY3sa9+Gq7SQDVdx9ovqIXDLri46ydtGuZ
/5MQD6srGzTnxA/8NvvPYItoPAgbfZXNDTWkRk3fkH1YXTisv0+XQ7Acs/QFazs4
cK2EHpU4BrWyYfl7moO2KemU3EAMr5zRkoPwMhJSduMeN8V33csPANsc/Wed0Zai
Qs7uQc4qawTfcaaZY2CM2ujTb6tjyLzCqLkB6DpKjO47proOExhx8WLouPGDVCjj
ThnjHp7i6aq5wPyFZ+rCa8TWgjZHXi8oThgVm/Jo6v5tgoUaTZDiHfXkY2x9iZqZ
4lgh/5h6ioRG+JAKOpaF3rM2+/Rp5/fo/Z1219N9fKYVnZOuJEap5Dv7uUm/uS6r
BABsu8ziSHIadT8GysoRO//FveXkT6lVKIbzXorL/H2/4wGNwPDUTFIarXumUv43
MydWgJwOpPP9o9fMsOeB
=ez1g
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
