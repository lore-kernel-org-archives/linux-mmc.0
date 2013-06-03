From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: arm: add basic support for Rockchip Cortex-A9 SoCs
Date: Mon, 03 Jun 2013 04:07:37 +0200
Message-ID: <2754292.oXzDNzH2Zs@wuerfel>
References: <201306030055.15413.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201306030055.15413.heiko@sntech.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Mike Turquette <mturquette@linaro.org>, Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Seungwon Jeon <tgih.jun@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <rob.herring@calxeda.com>, Jaehoon Chung <jh80.chung@samsung.com>, Grant Likely <grant.likely@linaro.org>, John Stultz <john.stultz@linaro.org>, Olof Johansson <olof@lixom.net>, Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Chris Ball <cjb@laptop.org>, devicetree-discuss@lists.ozlabs.org
List-Id: linux-mmc@vger.kernel.org

On Monday 03 June 2013 00:55:15 Heiko St=FCbner wrote:
> Prepare your eggs and tomatoes please, I got myself a second playground  .
> =

> As the title implies this series adds basic support for Rockchip's Cortex=
-A9
> SoCs, like the RK3066 used in many cheaper tablets.
> =

> On the periphal side it's very lightweight, as it seems someone from Rock=
chip
> was shopping in the DesignWare store.
> =

> This makes the pinctrl driver the biggest hunk in the series, but to get =
some
> bonus points I used the generic_irq implementation for the interrupt hand=
ling,
> based on Thomas' irqdomain support series.
> =

> Supported periphals are, the timers, uarts and mmc controllers, so intere=
sted
> parties will need a serial console for now.
> =

> Hopefully I didn't mess up to much =


Great stuff! I have a few small comments for later, but I'm basically fine
with it going in as-is.

Needs review from the clk and pinctrl maintainers of course.

	Arnd
