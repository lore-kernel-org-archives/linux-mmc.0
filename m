From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/7] pinctrl: mediatek: emulate GPIO interrupt on
 both-edges
Date: Tue, 10 Feb 2015 09:40:21 +0100
Message-ID: <20150210084021.GM10842@pengutronix.de>
References: <1422339332-27498-1-git-send-email-chaotian.jing@mediatek.com>
 <1422339332-27498-2-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52490 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753637AbbBJIkt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Feb 2015 03:40:49 -0500
Content-Disposition: inline
In-Reply-To: <1422339332-27498-2-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, James Liao <jamesjj.liao@mediatek.com>, srv_heupstream@mediatek.com, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, Hongzhou Yang <hongzhou.yang@mediatek.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-mmc@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, "Joe.C" <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, bin.zhang@mediatek.com, linux-arm-kernel@lists.infradead.org

Hello,

On Tue, Jan 27, 2015 at 02:15:26PM +0800, Chaotian Jing wrote:
> From: Yingjoe Chen <yingjoe.chen@mediatek.com>
>=20
> MTK EINT does not support generating interrupt on both edges.
> Emulate this by changing edge polarity while enable irq,
> set types and interrupt handling. This follows an example of
> drivers/gpio/gpio-mxc.c.
>=20
> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  drivers/pinctrl/mediatek/pinctrl-mt8135.c     |  3 ++
>  drivers/pinctrl/mediatek/pinctrl-mt8173.c     |  3 ++
>  drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 76 +++++++++++++++++=
++++++++--
>  drivers/pinctrl/mediatek/pinctrl-mtk-common.h |  4 ++
>  4 files changed, 83 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8135.c b/drivers/pinc=
trl/mediatek/pinctrl-mt8135.c
> index b6ee2b2..1296d6d 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mt8135.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mt8135.c
> @@ -325,6 +325,9 @@ static const struct mtk_pinctrl_devdata mt8135_pi=
nctrl_data =3D {
>  		.sens      =3D 0x140,
>  		.sens_set  =3D 0x180,
>  		.sens_clr  =3D 0x1c0,
> +		.soft      =3D 0x200,
> +		.soft_set  =3D 0x240,
> +		.soft_clr  =3D 0x280,
>  		.pol       =3D 0x300,
>  		.pol_set   =3D 0x340,
>  		.pol_clr   =3D 0x380,
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8173.c b/drivers/pinc=
trl/mediatek/pinctrl-mt8173.c
> index 444d88d..717000e 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mt8173.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mt8173.c
> @@ -278,6 +278,9 @@ static const struct mtk_pinctrl_devdata mt8173_pi=
nctrl_data =3D {
>  		.sens      =3D 0x140,
>  		.sens_set  =3D 0x180,
>  		.sens_clr  =3D 0x1c0,
> +		.soft      =3D 0x200,
> +		.soft_set  =3D 0x240,
> +		.soft_clr  =3D 0x280,
>  		.pol       =3D 0x300,
>  		.pol_set   =3D 0x340,
>  		.pol_clr   =3D 0x380,
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/=
pinctrl/mediatek/pinctrl-mtk-common.c
> index 109a882..820ce9e 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> @@ -792,6 +792,32 @@ static unsigned int mtk_eint_get_mask(struct mtk=
_pinctrl *pctl,
>  	return !!(readl(reg) & bit);
>  }
> =20
> +static int mtk_eint_flip_edge(struct mtk_pinctrl *pctl, int hwirq)
> +{
> +	int start_level, curr_level;
> +	unsigned int reg_offset;
> +	const struct mtk_eint_offsets *eint_offsets =3D &(pctl->devdata->ei=
nt_offsets);
> +	u32 mask =3D 1 << (hwirq & 0x1f);
> +	u32 port =3D (hwirq >> 5) & eint_offsets->port_mask;
> +	void __iomem *reg =3D pctl->eint_reg_base + (port << 2);
> +	const struct mtk_desc_pin *pin;
> +
> +	pin =3D mtk_find_pin_by_eint_num(pctl, hwirq);
> +	curr_level =3D mtk_gpio_get(pctl->chip, pin->pin.number);
> +	do {
> +		start_level =3D curr_level;
> +		if (start_level)
> +			reg_offset =3D eint_offsets->pol_clr;
> +		else
> +			reg_offset =3D eint_offsets->pol_set;
> +		writel(mask, reg + reg_offset);
> +
> +		curr_level =3D mtk_gpio_get(pctl->chip, pin->pin.number);
> +	} while (start_level !=3D curr_level);
> +
> +	return start_level;
> +}
> +
>  static void mtk_eint_mask(struct irq_data *d)
>  {
>  	struct mtk_pinctrl *pctl =3D irq_data_get_irq_chip_data(d);
> @@ -814,6 +840,9 @@ static void mtk_eint_unmask(struct irq_data *d)
>  			eint_offsets->mask_clr);
> =20
>  	writel(mask, reg);
> +
> +	if (pctl->eint_dual_edges[d->hwirq])
> +		mtk_eint_flip_edge(pctl, d->hwirq);
>  }
=46rom looking at the code it seems to me that there is a bug. Consider
the following to happen:

	pin changes level, say high to low, triggers irq

	irq is masked by writel(mask, reg) in mtk_eint_mask

	mtk_eint_flip_edge gets curr_level =3D low

	pin goes up

	writel(mask, reg + eint_offsets->pol_set);

	oh, pin is high, so: writel(mask, reg + eint_offsets->pol_clr

So now you trigger the irq the next time when the pin goes down again.
But that means to missed to trigger on the "pin goes up" in the above
list, right?

Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
