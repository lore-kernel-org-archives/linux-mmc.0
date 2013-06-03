From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 08/10] clk: add basic Rockchip rk3066a clock support
Date: Sun, 2 Jun 2013 20:27:11 -0700
Message-ID: <20130603032711.GA3379@quad.lixom.net>
References: <201306030055.15413.heiko@sntech.de>
 <201306030100.31647.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:56970 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861Ab3FCD1M (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 2 Jun 2013 23:27:12 -0400
Received: by mail-pd0-f182.google.com with SMTP id g10so4997560pdj.13
        for <linux-mmc@vger.kernel.org>; Sun, 02 Jun 2013 20:27:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201306030100.31647.heiko@sntech.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mike Turquette <mturquette@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Linus Walleij <linus.walleij@linaro.org>, devicetree-discuss@lists.ozlabs.org, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>

On Mon, Jun 03, 2013 at 01:00:31AM +0200, Heiko St=FCbner wrote:
> This adds basic support for clocks on Rockchip rk3066 SoCs.
> The clock handling thru small dt nodes is heavily inspired by the
> sunxi clk code.
>=20
> The clock specifiers are named as "x-cortex-a9-x", because the clock
> semantics are the same thru the whole cortex-a9 series (rk30xx,
> rk3188, rk2928; but not the other rk29 SoCs, which are Cortex-A8 base=
d).

Hi,

I think you're better off naming them after the first SoC of that serie=
s.
Otherwise, if there's an A9-based platform in the future that is not
compatible, things will get complicated.

It's pretty common that we do this for other kinds of devices, so it se=
ems
appropriate for clock drivers too.


-Olof

