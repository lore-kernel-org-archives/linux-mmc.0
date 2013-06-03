From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH 10/10] arm: add basic support for Rockchip RK3066a boards
Date: Mon, 3 Jun 2013 11:46:57 +0200
Message-ID: <201306031146.57611.heiko@sntech.de>
References: <201306030055.15413.heiko@sntech.de> <201306031023.49364.heiko@sntech.de> <9452845.qTGjLPCfXq@wuerfel>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:44238 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753574Ab3FCJrK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 3 Jun 2013 05:47:10 -0400
In-Reply-To: <9452845.qTGjLPCfXq@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mike Turquette <mturquette@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Linus Walleij <linus.walleij@linaro.org>, devicetree-discuss@lists.ozlabs.org, Russell King <linux@arm.linux.org.uk>, Olof Johansson <olof@lixom.net>

Am Montag, 3. Juni 2013, 11:22:35 schrieb Arnd Bergmann:
> On Monday 03 June 2013 10:23:49 Heiko St=FCbner wrote:
> > Am Montag, 3. Juni 2013, 04:15:46 schrieb Arnd Bergmann:
> > > Can't you use
> > >=20
> > > 	of_clk_init(NULL);
> > > 	clocksource_of_init();
> > >=20
> > > here and change the two drivers to provide the respective macros?
> >=20
> > hmm, while this would make a lot of things easier I don't see right=
 now
> > how this would work.
> >=20
> > The dw_apb_timer clocksource does not have its own device node, but
> > instead uses two timer devices as clocksource and clockevent.
> >=20
> > Hmm ... one idea would be to wrap them in the dt, like
> >=20
> > 	clocksource {
> > =09
> > 		compatible =3D "snps,dw-apb-clocksource"
> > 	=09
> > 		timer@2003a000 {
> > 	=09
> > 			compatible =3D "snps,dw-apb-timer-osc";
> > 			reg =3D <0x2003a000 0x100>;
> > 			interrupts =3D <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
> > 			clocks =3D <&clk_gates1 1>, <&clk_gates7 8>;
> > 			clock-names =3D "timer", "pclk";
> > 	=09
> > 		};
> > 	=09
> > 		timer@2000e000 {
> > 	=09
> > 			compatible =3D "snps,dw-apb-timer-osc";
> > 			reg =3D <0x2000e000 0x100>;
> > 			interrupts =3D <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
> > 			clocks =3D <&clk_gates1 2>, <&clk_gates7 9>;
> > 			clock-names =3D "timer", "pclk";
> > 	=09
> > 		};
> > =09
> > 	};
>=20
> Can't you just have multiple CLOCKSOURCE_OF_DECLARE() lines, one
> for each of the nodes?

The timers are of the same type and the clocksource driver just grabs t=
he=20
first of them as clockevent and the second as clocksource, so I think t=
wo=20
CLOCKSOURCE_OF_DECLARE lines won't do.

But I just looked at clocksource_of_init a bit more closely, which does=
 a=20
for_each_matching_node_and_match over the nodes. So the init_func could=
 grab=20
the device for the clockevent on the first call and the clocksource whe=
n it=20
gets called for the second matching node.


> > > > +DT_MACHINE_START(ROCKCHIP_DT, "Rockchip Cortex-A9 (Device Tree=
)")
> > > > +       .map_io         =3D debug_ll_io_init,
> > > > +       .init_machine   =3D rockchip_dt_init,
> > > > +       .init_time      =3D rockchip_timer_init,
> > > > +       .dt_compat      =3D rockchip_board_dt_compat,
> > > > +MACHINE_END
> > >=20
> > > The map_io line can already get removed.
> >=20
> > Yesterday I did grep thru the linux-next I was using as base lookin=
g for
> > the debug_ll_io_init default I read about but was not able to find =
it
> > ... most likely my linux-next is a tad to old.
>=20
> Yes, it only showed up in today's linux-next. I thought it was older.
