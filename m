From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v7 4/4] gpiolib: Implement fast processing path in get/set array
Date: Thu, 20 Sep 2018 08:49:04 -0700
Message-ID: <CACRpkdZD+kFsyvSKBm1JpCOd1is_TBRJGx3Yvd=kshoH5iPhXA@mail.gmail.com>
References: <20180831225616.29221-1-jmkrzyszt@gmail.com> <20180902120144.6855-1-jmkrzyszt@gmail.com>
 <CGME20180920101151eucas1p221f5a1715b8556bb9d99bf08fe09ce6f@eucas1p2.samsung.com>
 <20180902120144.6855-5-jmkrzyszt@gmail.com> <20180920101151eucas1p221f5a1715b8556bb9d99bf08fe09ce6f~WE-_cEf4l0754207542eucas1p27@eucas1p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180920101151eucas1p221f5a1715b8556bb9d99bf08fe09ce6f~WE-_cEf4l0754207542eucas1p27@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Janusz Krzysztofik <jmkrzyszt@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>, Peter Korsgaard <peter.korsgaard@barco.com>, Peter Rosin <peda@axentia.se>, Ulf Hansson <ulf.hansson@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, Dominik Brodowski <linux@dominikbrodowski.net>, Greg KH <gregkh@linuxfoundation.org>, kishon@ti.com, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald <pmeerw@pmeerw.net>, Jiri Slaby <jslaby@suse.com>, Willy Tarreau <w@1wt.eu>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Sep 20, 2018 at 3:11 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:

> I've just noticed that this patch landed in today's linux-next. Sadly it
> breaks booting of Exynos5250-based Samsung Snow Chromebook (ARM 32bit,
> device-tree source arch/arm/boot/dts/exynos5250-snow.dts).

Thanks for testing on this platform!

> Booting hangs after detecting MMC cards. Reverting this patch fixes the
> boot. I will try later to add some debugs and investigate it further what
> really happens when booting hangs.

How typical. I hope we can fix it, because this should mean speedups
for your platform.

Yours,
Linus Walleij
