From: Rob Herring <robherring2@gmail.com>
Subject: Re: [RFC] dw_apb_timer_of: use clocksource_of_init
Date: Mon, 03 Jun 2013 07:27:25 -0500
Message-ID: <51AC8BAD.4020607@gmail.com>
References: <201306030055.15413.heiko@sntech.de> <201306031146.57611.heiko@sntech.de> <1822564.TIKVDZSzqK@wuerfel> <201306031415.29411.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:42408 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753564Ab3FCM1b (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Jun 2013 08:27:31 -0400
In-Reply-To: <201306031415.29411.heiko@sntech.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>
Cc: Arnd Bergmann <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mike Turquette <mturquette@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, devicetree-discuss@lists.ozlabs.org, Russell King <linux@arm.linux.org.uk>, Olof Johansson <olof@lixom.net>

On 06/03/2013 07:15 AM, Heiko St=FCbner wrote:
> dw_apb_timer_init used to search the devicetree for matching timer
> devices, making calls to it from board files necessary.
>=20
> Change the dw_apb_timer_init to work with CLOCKSOURCE_OF_DECLARE.
> With this change the function gets called once for each timer node
> and tracks these number of calls to attach clockevent and clocksource
> devices to the nodes.
>=20
> Also convert all previous users of dw_apb_timer_init to use
> clocksource_of_init.
>=20
> Tested on the upcoming rk3066 code.
>=20
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Acked-by: Rob Herring <rob.herring@calxeda.com>

But 1 comment:

> @@ -88,7 +88,7 @@ DT_MACHINE_START(PICOXCELL, "Picochip picoXcell")
>  	.map_io		=3D picoxcell_map_io,
>  	.nr_irqs	=3D NR_IRQS_LEGACY,
>  	.init_irq	=3D irqchip_init,
> -	.init_time	=3D dw_apb_timer_init,
> +	.init_time	=3D clocksource_of_init,

clocksource_of_init is the default now, so you can just remove this and
the one in socfpga.

Same for irqchip_init BTW, but that's another patch.

Rob

