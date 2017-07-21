From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 06/10] mmc: sunxi: Add support for A83T eMMC (MMC2)
Date: Fri, 21 Jul 2017 09:21:41 +0200
Message-ID: <20170721072141.uxvp7c6c5s64akdp@flea>
References: <20170720034452.15920-1-wens@csie.org>
 <20170720034452.15920-7-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wmny666cvwncqeiy"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:60608 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751995AbdGUHVw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Jul 2017 03:21:52 -0400
Content-Disposition: inline
In-Reply-To: <20170720034452.15920-7-wens@csie.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com


--wmny666cvwncqeiy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2017 at 11:44:48AM +0800, Chen-Yu Tsai wrote:
> The third MMC controller (MMC2) on the Allwinner A83T SoC is slightly
> different. It supports a wider 8-bit bus, has a dedicated controllable
> reset pin for eMMC, and a "new timing mode" which is supposed to deliver
> better signals and thus better performance.
>=20
> Add a compatible for this one to use the new timing mode not found in the
> other controllers.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Acked-by: Rob Herring <robh@kernel.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--wmny666cvwncqeiy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZcauFAAoJEBx+YmzsjxAgcf0P/0We3BnYu0uVelHU1TBqvhLs
D+O+G/ugJ6mI93Mqc+rrlGlHKXcpi96og+Rh4W7ZxuI5/2kK1+ScHalyYjLWDQuD
I2bi8sfWb3fJCColFhgTfet/mIZaNewqcz1N/ziJnUpZdqYapWeewNHdNbnXXWsQ
NK0jq9YHcgMJQF0Fn1pp2gOAdVpOA7jBfX2YPRNY+8rDvI+48mh3GB/OrHM7l033
r+7ZFvRdqhCge7wRQAQMN3+Pm/2zXA+VcQc+sjrHGLIIJq0kpJXOJpP7kpQj9zF7
eqItmU8q2ArqcfNNBbGsF7iMGTLY1L6hY0gt7suA2iQMFdjmbdwhsvMqclGvOw/+
NtHz7dreoV17T8QII2AOZ+9S4z9gp7Bed+sDS475d4g81aqSQYJchSoA/YA3fDb/
LoONePc2a9Wk/apOGxQk/QjZ7GFdiutQ05k3ZlnrO3t5YZOa+FZTplerXoBSSEH6
NRi+G2ddlDijOASRdJ5j6TLZpLGc9cvVmqDN6f5b9rkT6cAEU7B+WJvvAG4JtbOz
zdaF3rtCRREIfhIB5lUPeZZF215CzsdMuy8/fhzCV4U+/kWx9NUt1wOuFfh9BRmQ
oeALELdzj8uRbUES2sLl5s6o3JbpsMBEzKcP1IhTMn2pCtFPKv43Q7L9WqZ8JAcz
+uKcftQ1X4d2qIrYDO+/
=nDLZ
-----END PGP SIGNATURE-----

--wmny666cvwncqeiy--
