From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 03/11] clk: sunxi-ng: a83t: Support new timing mode for
 mmc2 clock
Date: Tue, 18 Jul 2017 16:47:58 +0200
Message-ID: <20170718144758.os7yy6saulb65gam@flea>
References: <20170714064302.20383-1-wens@csie.org>
 <20170714064302.20383-4-wens@csie.org>
 <20170717091402.3qb3fhdyhfbv6t66@flea>
 <CAGb2v67Ofdr9zL=o82F6-90meYZGaYtr_zy7y-OeBH30n1gERQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="d6rflvqdhkw7nwh6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGb2v67Ofdr9zL=o82F6-90meYZGaYtr_zy7y-OeBH30n1gERQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>
List-Id: linux-mmc@vger.kernel.org


--d6rflvqdhkw7nwh6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2017 at 06:12:35PM +0800, Chen-Yu Tsai wrote:
> On Mon, Jul 17, 2017 at 5:14 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi,
> >
> > On Fri, Jul 14, 2017 at 02:42:54PM +0800, Chen-Yu Tsai wrote:
> >> The MMC2 clock supports a new timing mode. When the new mode is active,
> >> the output clock rate is halved.
> >>
> >> This patch sets the feature flag for the new timing mode, and adds
> >> a pre-divider based on the mode bit.
> >>
> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >> ---
> >>  drivers/clk/sunxi-ng/ccu-sun8i-a83t.c | 38 ++++++++++++++++++++++++++=
+--------
> >>  1 file changed, 30 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c b/drivers/clk/sunxi=
-ng/ccu-sun8i-a83t.c
> >> index 947f9f6e05d2..ee6688e9b361 100644
> >> --- a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
> >> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
> >> @@ -418,14 +418,36 @@ static SUNXI_CCU_PHASE(mmc1_sample_clk, "mmc1-sa=
mple", "mmc1",
> >>  static SUNXI_CCU_PHASE(mmc1_output_clk, "mmc1-output", "mmc1",
> >>                      0x08c, 8, 3, 0);
> >>
> >> -/* TODO Support MMC2 clock's new timing mode. */
> >> -static SUNXI_CCU_MP_WITH_MUX_GATE(mmc2_clk, "mmc2", mod0_default_pare=
nts,
> >> -                               0x090,
> >> -                               0, 4,         /* M */
> >> -                               16, 2,        /* P */
> >> -                               24, 2,        /* mux */
> >> -                               BIT(31),      /* gate */
> >> -                               0);
> >> +/*
> >> + * MMC2 supports both old and new timing modes. When the new timing
> >> + * mode is active, the output clock rate is halved by two. Here we
> >> + * treat it as a variable pre-divider. Note that the pre-divider is
> >> + * _not_ included in the possible factors during a set clock rate
> >> + * operation. It is only read out.
> >> + */
> >> +static const struct ccu_mux_var_prediv mmc2_new_timing_predivs[] =3D {
> >> +     { .index =3D 0, .shift =3D 30, .width =3D 1 },
> >> +     { .index =3D 1, .shift =3D 30, .width =3D 1 },
> >> +};
> >> +static struct ccu_mp mmc2_clk =3D {
> >> +     .enable =3D BIT(31),
> >> +     .m      =3D _SUNXI_CCU_DIV(0, 4),
> >> +     .p      =3D _SUNXI_CCU_DIV(16, 2),
> >> +     .mux    =3D {
> >> +             .shift  =3D 24,
> >> +             .width  =3D 2,
> >> +             .var_predivs    =3D mmc2_new_timing_predivs,
> >> +             .n_var_predivs  =3D ARRAY_SIZE(mmc2_new_timing_predivs),
> >> +     },
> >> +     .common         =3D {
> >> +             .reg            =3D 0x090,
> >> +             .features       =3D CCU_FEATURE_MMC_TIMING_SWITCH,
> >> +             .hw.init        =3D CLK_HW_INIT_PARENTS("mmc2",
> >> +                                                   mod0_default_paren=
ts,
> >> +                                                   &ccu_mp_ops,
> >> +                                                   CLK_GET_RATE_NOCAC=
HE),
> >> +     },
> >> +};
> >
> > Treating the new bit seems a bit of a hack to me. It only works
> > because we're not evaluating the various pre-dividers during a
> > determine_rate (and set_rate), but it might change in the future, and
> > we will break all our eMMC controllers then.
> >
> > Since they're quite special, I was thinking about creating a new MMC
> > clock type? We're going to use it on a number of SoCs, and we'll be
> > able to model it properly, without crippling the regular and generic
> > MP clocks.
>=20
> Yes that should be doable. I could put them in the same file and
> reuse all the existing MP clocks stuff by wrapping them in new
> functions that check the timing mode bit.
>=20
> Would that work for you?

Yep, it does.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--d6rflvqdhkw7nwh6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZbh+eAAoJEBx+YmzsjxAgYzUQALmJsQfE5j1Lzlfzc+2qF+sL
J/ngdYRK5zhKPf/6txw7zWXSIWm9GAHmnett+4ZQMfvg7D2pr757FzlvzVM1syLw
V1kAy1GNIPc8SgzQLvwNCQq9pYLxyQLHW2iqFUuNKravbU5CILRkXAvgVVNKnftO
VAAVCLWPyYqpjsipzUJRqKBKEwQpZlTRpHaDpx8oV8vjDuV2fR8syDU+8qeR2fkN
1R0zpIXYMQIzxl7z0/+ibaST91iAVcQ/JK1RZXzL1s6UfDK+i4+NJ4POA202B2VE
GD0wk8c4BJ3Rxo1iPypD5nX+H9CSfQh+jlDX6xMONO83Qld6uahEp1acDnO6e0CJ
4xx4dxn3aYQ6N6GzyNNgjU/EEIPqhMSZbEdqw/5hvetebAYJ9uVa2r9OVWdHkcv9
tzpFVYNK+mI/5wcXWMuQNCa2SeyPr4X9WzKu1vidNT/8oTblND/wRRB1+wR+wNDM
lEJGAgFDhRkP6+loIsCPZ5h2SwVc8XKn35oS/2n4qEpM4DOTWyL04fR/J32ULc1C
LNsh66GiGCGD0QPH1RaKGgiHJKqlsnh5YoTbSrPPjsUkDXTVT/lnFE77HJ8qc+I9
ZDyIlcpCSyhTl2dTTh4PiIYp+qn9yuFwFWBy2fwKn/bv0PGgCsUWPGk2KcBuHWg5
IN5e4OGYLs1tqUYZ0X0w
=RUB8
-----END PGP SIGNATURE-----

--d6rflvqdhkw7nwh6--
