From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 01/10] clocksource: dw_apb_timer_of: use the clocksource
 as sched clock if necessary
Date: Tue, 4 Jun 2013 08:34:44 +0200
Message-ID: <CACRpkdYAvUQ+aymJm1Fw1bE1aGdO7RUqLR9byvoT7ECTk4tkpw@mail.gmail.com>
References: <201306030055.15413.heiko@sntech.de>
	<201306030056.03522.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201306030056.03522.heiko@sntech.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mike Turquette <mturquette@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
List-Id: linux-mmc@vger.kernel.org

On Mon, Jun 3, 2013 at 12:56 AM, Heiko St=FCbner <heiko@sntech.de> wrot=
e:

> Currently the dw_apb_timer always expects a separate special timer to=
 be
> availbable for the sched_clock. Some devices using dw_apb_timers do n=
ot
> have the sptimer but can use the clocksource as sched_clock.
> Therefore this patch adds using the clocksource timer as
> a fallback if no usable sched timer is found.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Is this really what the patch does? I mean "ass the clocksourse as
fallback", it seems more like that is controlled from the device tree,
this looks more like some more careful handling of the device tree
input making the sched_timer optional, it doesn't really "add"
anything, does it?

Yours,
Linus Walleij
