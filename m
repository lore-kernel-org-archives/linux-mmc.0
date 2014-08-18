From: Simon Baatz <gmbnomis@gmail.com>
Subject: Re: [PATCH 3/4] mmc: host: switch OF parser to use gpio descriptors
Date: Mon, 18 Aug 2014 21:46:55 +0200
Message-ID: <20140818194655.GA2565@schnuecks.de>
References: <1407864355-21545-1-git-send-email-linus.walleij@linaro.org>
 <1407864355-21545-3-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1407864355-21545-3-git-send-email-linus.walleij@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-gpio@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

On Tue, Aug 12, 2014 at 07:25:54PM +0200, Linus Walleij wrote:
> This switches the central MMC OF parser to use gpio descriptors
> instead of grabbing GPIOs explicitly from the device tree.
> This strips out an unecessary use of the integer-based GPIO
> API that we want to get rid of, cuts down on code as the
> gpio descriptor code will handle active low flags.
> 
> As it is in no way a bug not to supply CD/WP GPIOs the messages
> about them not being specified have been depromoted from
> dev_err() to dev_dbg().

I think the intention of the current code is to issue an
error if a valid GPIO was specified but could not be obtained.  It
should not issue an error just because the CD/WP GPIOs are not
specified.

This patch changes this behaviour. If the GPIO is specified
explicitly but cannot be obtained for some reason, the driver's probe
calling mmc_of_parse() will probably be successful.  Since debug
level messages are usually not enabled, the problem with the GPIO may
not even be visible in the logs.  For example, if I specify the same
GPIO for CD and WP in the DTS:

[    2.093442] kirkwood-pinctrl f1010000.pin-controller: request pin
44 (PIN44) for mvebu-gpio:44
[    2.093459] mvsdio f1090000.mvsdio: Got CD GPIO
[    2.118734] mv643xx_eth_port mv643xx_eth_port.0 eth0: port 0 with
MAC address 00:50:43:c3:55:55

One can only infer from the missing "Got WP GPIO" that something went
wrong.  Previously, the driver would not even load:

...
[    1.973402] mvsdio f1090000.mvsdio: Failed to request WP GPIO: -16!
[    1.979831] mvsdio: probe of f1090000.mvsdio failed with error -16

One can argue whether the current behaviour is too strict (and we did
that in the past, leading to the current code), but issuing only a
debug message when allocating an explicitly requested resource fails
is too tolerant, IMHO.


- Simon
