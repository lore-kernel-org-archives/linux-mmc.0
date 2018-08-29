From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC RFT PATCH 0/4] gpiolib: speed up GPIO array processing
Date: Wed, 29 Aug 2018 11:06:21 +0200
Message-ID: <CACRpkdbgY6VNP-K-c5ErQtmO7E83D6c=49TN5siF8VTNh_66Jg@mail.gmail.com>
References: <20180813223448.21316-1-jmkrzyszt@gmail.com> <20180820234341.5271-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180820234341.5271-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>, Peter Korsgaard <peter.korsgaard@barco.com>, Peter Rosin <peda@axentia.se>, Ulf Hansson <ulf.hansson@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, Dominik Brodowski <linux@dominikbrodowski.net>, kishon@ti.com, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald <pmeerw@pmeerw.net>, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Aug 21, 2018 at 1:42 AM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> This series is a follow up of the former "mtd: rawnand: ams-delta: Use
> gpio-omap accessors for data I/O" which already contained some changes
> to gpiolib.  Those previous attempts were commented by Borris Brezillon
> who suggested using GPIO API modified to accept bitmaps, and by Linus
> Walleij who suggested still more great ideas for further immprovement
> of the proposed API changes - thanks!
>
> The goal is to boost performans of get/set array functions while
> processing GPIO arrays which represent pins of a signle chip in
> hardware order.  If resulting performance is close to PIO, GPIO API
> can be used for data I/O without much loss of speed.

Hands down, this is a very pretty patch set. I'm a big fan already.

This is mainly because it fulfills the requirement for libraries
to be narrow and deep, which is what we want.
This refers to John Ousterhouts software design philosophy,
here is a great lecture if you haven't seen it already:
https://www.youtube.com/watch?v=bmSAYlu0NcY

Let's get this into v1 and get some testing and merge it for v4.20
ASAP so we get some proper testing before the v4.20 merge
window. It would be excellent if some of the current users of
the array API could provide tested-by's or at least ACKs.

For example ts-nbus.c must be a big benefactor.

Yours,
Linus Walleij
