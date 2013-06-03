From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 10/10] arm: add basic support for Rockchip RK3066a boards
Date: Mon, 03 Jun 2013 12:26:49 +0200
Message-ID: <1822564.TIKVDZSzqK@wuerfel>
References: <201306030055.15413.heiko@sntech.de> <9452845.qTGjLPCfXq@wuerfel> <201306031146.57611.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:49554 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753271Ab3FCK0h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Jun 2013 06:26:37 -0400
In-Reply-To: <201306031146.57611.heiko@sntech.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mike Turquette <mturquette@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Linus Walleij <linus.walleij@linaro.org>, devicetree-discuss@lists.ozlabs.org, Russell King <linux@arm.linux.org.uk>, Olof Johansson <olof@lixom.net>

On Monday 03 June 2013 11:46:57 Heiko St=FCbner wrote:
>=20
> The timers are of the same type and the clocksource driver just grabs=
 the=20
> first of them as clockevent and the second as clocksource, so I think=
 two=20
> CLOCKSOURCE_OF_DECLARE lines won't do.

Ok, got it. I was confused by the fact that the existing two sets of
"compatible" strings have separate sets of strings:

static const struct of_device_id sptimer_ids[] __initconst =3D {
        { .compatible =3D "picochip,pc3x2-rtc" },
        { .compatible =3D "snps,dw-apb-timer-sp" },
        { /* Sentinel */ },
};

static const struct of_device_id osctimer_ids[] __initconst =3D {
        { .compatible =3D "picochip,pc3x2-timer" },
        { .compatible =3D "snps,dw-apb-timer-osc" },
        {},
};

and thought they were for clocksource and clockevent respectively,
which is wrong.

> But I just looked at clocksource_of_init a bit more closely, which do=
es a=20
> for_each_matching_node_and_match over the nodes. So the init_func cou=
ld grab=20
> the device for the clockevent on the first call and the clocksource w=
hen it=20
> gets called for the second matching node.

Yes, I think that should work. You just have to be careful about callin=
g
init_sched_clock() only once.

	Arnd
