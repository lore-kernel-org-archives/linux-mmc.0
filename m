From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] gpiolib: Fix missing updates of bitmap index
Date: Mon, 24 Sep 2018 10:11:23 +0200
Message-ID: <CACRpkdZ-pcy=pBKaLUPOZ5jf2bsp2X2u6QCLCWJ1H_XdNY9wtw@mail.gmail.com>
References: <2785169.v6aIfS3K2k@z50> <20180923235336.22148-1-jmkrzyszt@gmail.com>
 <20180923235336.22148-2-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180923235336.22148-2-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>, Peter Korsgaard <peter.korsgaard@barco.com>, Peter Rosin <peda@axentia.se>, Ulf Hansson <ulf.hansson@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, Dominik Brodowski <linux@dominikbrodowski.net>, Greg KH <gregkh@linuxfoundation.org>, kishon@ti.com, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald <pmeerw@pmeerw.net>, Jiri Slaby <jslaby@suse.com>, Willy Tarreau <w@1wt.eu>, Geert Uytterhoeven <geert@linux-m68k.org>, Sebastien Bourdelin <sebastien.bourdelin@savoirf>
List-Id: linux-mmc@vger.kernel.org

On Mon, Sep 24, 2018 at 1:52 AM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> In new code introduced by commit b17566a6b08b ("gpiolib: Implement fast
> processing path in get/set array"), bitmap index is not updated with
> next found zero bit position as it should while skipping over pins
> already processed via fast bitmap path, possibly resulting in an
> infinite loop.  Fix it.
>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Patch applied!

Thanks for working on getting this into shape!

Yours,
Linus Walleij
