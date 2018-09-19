From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v8 0/4] gpiolib: speed up GPIO array processing
Date: Wed, 19 Sep 2018 11:08:57 -0700
Message-ID: <CACRpkdbdYmsFD3XOVLWjoGsPSU4UnTKtkYm5VQxGmoeQZewWZA@mail.gmail.com>
References: <20180902120144.6855-1-jmkrzyszt@gmail.com> <20180905215008.1649-1-jmkrzyszt@gmail.com>
 <CACRpkdbAG1N0v-BrXruf5088L0x3XwSHbFTWOFxjHQWx0LKz5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CACRpkdbAG1N0v-BrXruf5088L0x3XwSHbFTWOFxjHQWx0LKz5g@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>, Peter Korsgaard <peter.korsgaard@barco.com>, Peter Rosin <peda@axentia.se>, Ulf Hansson <ulf.hansson@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, Dominik Brodowski <linux@dominikbrodowski.net>, Greg KH <gregkh@linuxfoundation.org>, kishon@ti.com, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald <pmeerw@pmeerw.net>, Jiri Slaby <jslaby@suse.com>, Willy Tarreau <w@1wt.eu>, Geert Uytterhoeven <geert@linux-m68k.org>, Sebastien Bourdelin <sebastien.bourdelin@savoirf>
List-Id: linux-mmc@vger.kernel.org

On Thu, Sep 13, 2018 at 2:22 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Sep 5, 2018 at 11:49 PM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
>
> > The goal is to boost performance of get/set array functions while
> > processing GPIO arrays which represent pins of a signle chip in
> > hardware order.  If resulting performance is close to PIO, GPIO API
> > can be used for data I/O without much loss of speed.
>
> I applied the v8 to an immutable branch and pushed to kernelorg
> so the build servers can churn it a bit, and if it works fine
> then we can merge this into the devel branch and also set up
> that as something other subsystems can pull in if they need it.
>
> I'm really excited to merge this!

The branch built with no problems, and now I merged this into
devel. If that also builds fine, I will let it hit linux-next so we can
stabilize it for v4.20.

Yours,
Linus Walleij
