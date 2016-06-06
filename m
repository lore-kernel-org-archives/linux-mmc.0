From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH] mmc: sunxi: Add support to the Allwinner A83T
Date: Mon, 6 Jun 2016 11:13:59 +0200
Message-ID: <20160606111359.2f5a391dfa7b1bfce2d82d70@free.fr>
References: <20160604100253.7141B2DE7D@muse.csie.ntu.edu.tw>
	<CAGb2v66JbDjOQdMGDnzsToiXK9ub91m0i4dbkoXtVf0MwURWOQ@mail.gmail.com>
Reply-To: moinejf-GANU6spQydw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCV6DL6LYMNBBWX52S5AKGQE2KXCWGI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CAGb2v66JbDjOQdMGDnzsToiXK9ub91m0i4dbkoXtVf0MwURWOQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Sun, 5 Jun 2016 20:58:42 +0800
Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org> wrote:

> > +static const struct sunxi_mmc_clk_delay sun8i_a83t_mmc_clk_delays[] =
=3D {
> > +       [SDXC_CLK_400K]         =3D { .output =3D 180, .sample =3D 180 =
},
> > +       [SDXC_CLK_25M]          =3D { .output =3D 180, .sample =3D  50 =
},
> > +       [SDXC_CLK_50M]          =3D { .output =3D  60, .sample =3D  50 =
},
>=20
> These 2 don't look right.
>=20
> > +       [SDXC_CLK_50M_DDR]      =3D { .output =3D  180, .sample =3D 90 =
},
> > +       [SDXC_CLK_50M_DDR_8BIT] =3D { .output =3D  180, .sample =3D 90 =
},
>=20
> Nor does this one. As explained in the comment from the clock driver:
>=20
>     We can only outphase the clocks by multiple of the PLL's period.
>=20
>     Since the MMC clock in only a divider, and the formula to get the
>     outphasing in degrees is deg =3D 360 * delta / period
>=20
> Now, for the fishy ones I mentioned, MMC clock =3D card clock (or card * =
2
> for DDR 8 bit), and parent clock is PLL6 @ 600 MHz. A step would be 15,
> 30 or 60 degrees. Thus you cannot get an outphasing of 50 degrees, or 90
> degrees for 50M DDR 8bit.
>=20
> Could you provide a link to the original driver? Or perhaps just the
> original delay values?
>=20
> The values do work better on my Cubietruck plus, giving a throughput
> of 36 MB/s read, instead of 17 MB/s with the original values. However
> that is still only half of what it should be capable of. I will test
> my BPI M3 tomorrow.

Hi,

Yes, you are right, my values are wrong. Please, forget about this patch.
I did not look far enough in the clock code.

Anyway, I had timeouts in accessing the MMC because the BPI-M3 legacy
u-boot sets the pll-periph rate to 1.2GHz.
Then, according to the comment in the BPI-M3 original driver
(https://github.com/BPI-SINOVOIP/BPI-M3-bsp/blob/master/linux-sunxi/drivers=
/mmc/host/sunxi-mci.c),
if "//in 1.2GHz pll_periph only [MMC_CLK-50M] is correct",
setting the clock delays to 6 and 7 would be, for us:

	[SDXC_CLK_50M]          =3D { .output =3D  90, .sample =3D  105 },

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
