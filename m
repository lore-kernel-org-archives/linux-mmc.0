From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 01/10] clk: sunxi-ng: Add interface to query or
 configure MMC timing modes.
Date: Fri, 21 Jul 2017 09:18:10 +0200
Message-ID: <20170721071810.7nlwdzqno56cdax3@flea>
References: <20170720034452.15920-1-wens@csie.org>
 <20170720034452.15920-2-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bw7fne2kl3tq77jg"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:60415 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751889AbdGUHSW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Jul 2017 03:18:22 -0400
Content-Disposition: inline
In-Reply-To: <20170720034452.15920-2-wens@csie.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com


--bw7fne2kl3tq77jg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 20, 2017 at 11:44:43AM +0800, Chen-Yu Tsai wrote:
> Starting with the A83T SoC, Allwinner introduced a new timing mode for
> its MMC clocks. The new mode changes how the MMC controller sample and
> output clocks are delayed to match chip and board specifics. There are
> two controls for this, one on the CCU side controlling how the clocks
> behave, and one in the MMC controller controlling what inputs to take
> and how to route them.
>=20
> In the old mode, the MMC clock had 2 child clocks providing the output
> and sample clocks, which could be delayed by a number of clock cycles
> measured from the MMC clock's parent.
>=20
> With the new mode, the 2 delay clocks are no longer active. Instead,
> the delays and associated controls are moved into the MMC controller.
> The output of the MMC clock is also halved.
>=20
> The difference in how things are wired between the modes means that the
> clock controls and the MMC controls must match. To achieve this in a
> clear, explicit way, we introduce two functions for the MMC driver to
> use: one queries the hardware for the current mode set, and the other
> allows the MMC driver to request a mode.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/clk/sunxi-ng/Makefile         |  1 +
>  drivers/clk/sunxi-ng/ccu_common.h     |  5 +++
>  drivers/clk/sunxi-ng/ccu_mmc_timing.c | 73 +++++++++++++++++++++++++++++=
++++++
>  include/linux/clk/sunxi-ng.h          | 35 +++++++++++++++++
>  4 files changed, 114 insertions(+)
>  create mode 100644 drivers/clk/sunxi-ng/ccu_mmc_timing.c
>  create mode 100644 include/linux/clk/sunxi-ng.h
>=20
> diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
> index 0c45fa50283d..45a5910379a5 100644
> --- a/drivers/clk/sunxi-ng/Makefile
> +++ b/drivers/clk/sunxi-ng/Makefile
> @@ -1,5 +1,6 @@
>  # Common objects
>  lib-$(CONFIG_SUNXI_CCU)		+=3D ccu_common.o
> +lib-$(CONFIG_SUNXI_CCU)		+=3D ccu_mmc_timing.o
>  lib-$(CONFIG_SUNXI_CCU)		+=3D ccu_reset.o
> =20
>  # Base clock types
> diff --git a/drivers/clk/sunxi-ng/ccu_common.h b/drivers/clk/sunxi-ng/ccu=
_common.h
> index d6fdd7a789aa..1e2761c53f06 100644
> --- a/drivers/clk/sunxi-ng/ccu_common.h
> +++ b/drivers/clk/sunxi-ng/ccu_common.h
> @@ -23,6 +23,11 @@
>  #define CCU_FEATURE_FIXED_POSTDIV	BIT(3)
>  #define CCU_FEATURE_ALL_PREDIV		BIT(4)
>  #define CCU_FEATURE_LOCK_REG		BIT(5)
> +#define CCU_FEATURE_MMC_TIMING_SWITCH	BIT(6)
> +#define CCU_FEATURE_MMC_ALWAYS_NEW	BIT(7)

Didn't we agree on removing that flag?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--bw7fne2kl3tq77jg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZcaqyAAoJEBx+YmzsjxAgBlIQALAnz63aHM8pKvGhOOMBQE7d
VODFRaHWS+RdAQQ7FYQYqJuGNjqrRvvR+5tm2+IcLxc6bWXQb9YwH+NSzSDIdg6O
l+qv/yOBLcYTinIyEXafDi2hTcy6OsPaLdH5VSwcYXYqUHC3ZUruRNrDLrSrsF/O
IJjs+hNzO9YDXwdyQ+7vj5r9NBd8MKHWD83lu50FQISvLjBpZn54R25Z6zEia5FU
b0mzZwGlYiY966slY7mZ1SlOjDsryufEAt7Lz4KCfxVefYBEDdaqV05ybpVnaill
kvMl8LiKVOnANUX0ZmVfkyrMoLOmyYorH5NegTEEOvWrKDmiYKDNUrgPLfe3c6mc
VpZ8omqKprAagdoW1PfXP3hRPlJj/qT/jVF52pPJXYTVGtkBy1u8YlkXPwR3k+rM
LcG7bvbtvLsXHEMs146A/4a7KdpY5yOnFJlQ+codBd4rWetQptXH5CnKT9cAJ1mt
u8YkOyDedF+zquobEqRNcHH5c9ALG/11k4XYhtAhweq8vfuJcEJ7RSe8vDmEY84N
TChNVDhkO5GVCTMchfTx6KAwk/NOtwCKxDxQblnKHbFWJUzl3/E3jJYbAlM+1GCA
y9XYqaLMjeTJAJ4spi60c8o7yRLB1r+R8pqHkyXQvcGTJLWhYmiZLIC8cX4ytPnV
DSwlh7uPT8sCf6ADdRMw
=LWRs
-----END PGP SIGNATURE-----

--bw7fne2kl3tq77jg--
