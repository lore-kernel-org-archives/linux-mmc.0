From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 10/10] arm: add basic support for Rockchip RK3066a boards
Date: Mon, 03 Jun 2013 04:15:46 +0200
Message-ID: <5760087.7O4UgypAot@wuerfel>
References: <201306030055.15413.heiko@sntech.de> <201306030102.20890.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:54198 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753050Ab3FCCPp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 2 Jun 2013 22:15:45 -0400
In-Reply-To: <201306030102.20890.heiko@sntech.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mike Turquette <mturquette@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Linus Walleij <linus.walleij@linaro.org>, devicetree-discuss@lists.ozlabs.org, Russell King <linux@arm.linux.org.uk>, Olof Johansson <olof@lixom.net>

On Monday 03 June 2013 01:02:20 Heiko St=FCbner wrote:
> index 0000000..094b37d
> --- /dev/null
> +++ b/arch/arm/mach-rockchip/rockchip.c

If all goes well, this file can be removed again in 3.11 since it's
all generic, but let's add it for now.

> +
> +static void __init rockchip_timer_init(void)
> +{
> +       rockchip_init_clocks();
> +       dw_apb_timer_init();
> +}

Can't you use=20

	of_clk_init(NULL);
	clocksource_of_init();

here and change the two drivers to provide the respective macros?

> +
> +static void __init rockchip_dt_init(void)
> +{
> +#ifdef CONFIG_CACHE_L2X0
> +       l2x0_of_init(0, ~0UL);
> +#endif
> +       of_platform_populate(NULL, of_default_bus_match_table, NULL, =
NULL);
> +}

We still need to find a common location to call l2x0_of_init.

> +
> +static const char * const rockchip_board_dt_compat[] =3D {
> +       "rockchip,rk2928", /* single core */
> +       "rockchip,rk30xx", /* dual cores */
> +       "rockchip,rk31xx", /* dual and quad cores */
> +       NULL,
> +};

Please use real numbers instead of wildcards: rockchip,rk3066
not rockchip,rk30xx.

> +DT_MACHINE_START(ROCKCHIP_DT, "Rockchip Cortex-A9 (Device Tree)")
> +       .map_io         =3D debug_ll_io_init,
> +       .init_machine   =3D rockchip_dt_init,
> +       .init_time      =3D rockchip_timer_init,
> +       .dt_compat      =3D rockchip_board_dt_compat,
> +MACHINE_END

The map_io line can already get removed.

What about SMP support? Still working on it?

	Arnd
