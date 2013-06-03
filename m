From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 10/10] arm: add basic support for Rockchip RK3066a boards
Date: Mon, 03 Jun 2013 11:22:35 +0200
Message-ID: <9452845.qTGjLPCfXq@wuerfel>
References: <201306030055.15413.heiko@sntech.de> <5760087.7O4UgypAot@wuerfel>
 <201306031023.49364.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <201306031023.49364.heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Monday 03 June 2013 10:23:49 Heiko St=FCbner wrote:
> Am Montag, 3. Juni 2013, 04:15:46 schrieb Arnd Bergmann:
> > =

> > Can't you use
> > =

> > 	of_clk_init(NULL);
> > 	clocksource_of_init();
> > =

> > here and change the two drivers to provide the respective macros?
> =

> hmm, while this would make a lot of things easier I don't see right now h=
ow =

> this would work.
> =

> The dw_apb_timer clocksource does not have its own device node, but inste=
ad =

> uses two timer devices as clocksource and clockevent.
> =

> Hmm ... one idea would be to wrap them in the dt, like
> =

> 	clocksource {
> 		compatible =3D "snps,dw-apb-clocksource"
> =

> 		timer@2003a000 {
> 			compatible =3D "snps,dw-apb-timer-osc";
> 			reg =3D <0x2003a000 0x100>;
> 			interrupts =3D <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
> 			clocks =3D <&clk_gates1 1>, <&clk_gates7 8>;
> 			clock-names =3D "timer", "pclk";
> 		};
> =

> 		timer@2000e000 {
> 			compatible =3D "snps,dw-apb-timer-osc";
> 			reg =3D <0x2000e000 0x100>;
> 			interrupts =3D <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
> 			clocks =3D <&clk_gates1 2>, <&clk_gates7 9>;
> 			clock-names =3D "timer", "pclk";
> 		};
> 	};

Can't you just have multiple CLOCKSOURCE_OF_DECLARE() lines, one
for each of the nodes?
 =

> > > +DT_MACHINE_START(ROCKCHIP_DT, "Rockchip Cortex-A9 (Device Tree)")
> > > +       .map_io         =3D debug_ll_io_init,
> > > +       .init_machine   =3D rockchip_dt_init,
> > > +       .init_time      =3D rockchip_timer_init,
> > > +       .dt_compat      =3D rockchip_board_dt_compat,
> > > +MACHINE_END
> > =

> > The map_io line can already get removed.
> =

> Yesterday I did grep thru the linux-next I was using as base looking for =
the =

> debug_ll_io_init default I read about but was not able to find it ... mos=
t =

> likely my linux-next is a tad to old.

Yes, it only showed up in today's linux-next. I thought it was older.

	Arnd
