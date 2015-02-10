From: Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 1/7] pinctrl: mediatek: emulate GPIO interrupt on
 both-edges
Date: Tue, 10 Feb 2015 17:22:41 +0800
Message-ID: <1423560161.24705.15.camel@mtksdaap41>
References: <1422339332-27498-1-git-send-email-chaotian.jing@mediatek.com>
	 <1422339332-27498-2-git-send-email-chaotian.jing@mediatek.com>
	 <20150210084021.GM10842@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150210084021.GM10842-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, James Liao <jamesjj.liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hongzhou Yang <hongzhou.yang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, bin.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Tue, 2015-02-10 at 09:40 +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Tue, Jan 27, 2015 at 02:15:26PM +0800, Chaotian Jing wrote:
> > From: Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> >=20
> > MTK EINT does not support generating interrupt on both edges.
> > Emulate this by changing edge polarity while enable irq,
> > set types and interrupt handling. This follows an example of
> > drivers/gpio/gpio-mxc.c.
<...>
> > +static int mtk_eint_flip_edge(struct mtk_pinctrl *pctl, int hwirq)
> > +{
> > +	int start_level, curr_level;
> > +	unsigned int reg_offset;
> > +	const struct mtk_eint_offsets *eint_offsets =3D &(pctl->devdata->=
eint_offsets);
> > +	u32 mask =3D 1 << (hwirq & 0x1f);
> > +	u32 port =3D (hwirq >> 5) & eint_offsets->port_mask;
> > +	void __iomem *reg =3D pctl->eint_reg_base + (port << 2);
> > +	const struct mtk_desc_pin *pin;
> > +
> > +	pin =3D mtk_find_pin_by_eint_num(pctl, hwirq);
> > +	curr_level =3D mtk_gpio_get(pctl->chip, pin->pin.number);
> > +	do {
> > +		start_level =3D curr_level;
> > +		if (start_level)
> > +			reg_offset =3D eint_offsets->pol_clr;
> > +		else
> > +			reg_offset =3D eint_offsets->pol_set;
> > +		writel(mask, reg + reg_offset);
> > +
> > +		curr_level =3D mtk_gpio_get(pctl->chip, pin->pin.number);
> > +	} while (start_level !=3D curr_level);
> > +
> > +	return start_level;
> > +}
> > +
> >  static void mtk_eint_mask(struct irq_data *d)
> >  {
> >  	struct mtk_pinctrl *pctl =3D irq_data_get_irq_chip_data(d);
> > @@ -814,6 +840,9 @@ static void mtk_eint_unmask(struct irq_data *d)
> >  			eint_offsets->mask_clr);
> > =20
> >  	writel(mask, reg);
> > +
> > +	if (pctl->eint_dual_edges[d->hwirq])
> > +		mtk_eint_flip_edge(pctl, d->hwirq);
> >  }
> From looking at the code it seems to me that there is a bug. Consider
> the following to happen:
>=20
> 	pin changes level, say high to low, triggers irq
>=20
> 	irq is masked by writel(mask, reg) in mtk_eint_mask
>=20
> 	mtk_eint_flip_edge gets curr_level =3D low
>=20
> 	pin goes up
>=20
> 	writel(mask, reg + eint_offsets->pol_set);
>=20
> 	oh, pin is high, so: writel(mask, reg + eint_offsets->pol_clr
>=20
> So now you trigger the irq the next time when the pin goes down again=
=2E
> But that means to missed to trigger on the "pin goes up" in the above
> list, right?

Hi Uwe,

Yes, this could be a problem when irq happen. So I fix/workaround this
in mtk_eint_irq_handler() using soft-irq. When this bit is set, eint
will trigger the same interrupt again.
=20
+			if (dual_edges) {
+				curr_level =3D mtk_eint_flip_edge(pctl, index);
+
+				/* If level changed, we might lost one edge
+				   interrupt, raised it through soft-irq */
+				if (start_level !=3D curr_level)
+					writel(BIT(offset), reg -
+						eint_offsets->stat +
+						eint_offsets->soft_set);
+			}

Joe.C


--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
