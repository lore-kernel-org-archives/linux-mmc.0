From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 0/2] gpiolib: Fix issues introduced by fast bitmap processing
 path
Date: Mon, 24 Sep 2018 01:53:34 +0200
Message-ID: <20180923235336.22148-1-jmkrzyszt@gmail.com>
References: <2785169.v6aIfS3K2k@z50>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <2785169.v6aIfS3K2k@z50>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>, linux-doc@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Peter Rosin <peda@axentia.se>, netdev@vger.kernel.org, linux-i2c@vger.kernel.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Marek Szyprowski <m.szyprowski@samsung.com>, devel@driverdev.osuosl.org, Florian Fainelli <f.fainelli@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, linux-iio@vger.kernel.org, Peter Korsgaard <peter.korsgaard@barco.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Michael Hennerich <Michael.Hennerich@analog.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-gpio@vger.
List-Id: linux-mmc@vger.kernel.org


While investigating possible reasons of GPIO fast bitmap processing
related boot hang on Samsung Snow Chromebook, reported by Marek
Szyprowski (thanks!), I've discovered one coding bug, addressed by
PATCH 1/2 of this series, and one potential regression introduced at
design level of the solution, hopefully fixed by PATCH 2/2.  See
commit messages for details.

Janusz Krzysztofik (2):
      gpiolib: Fix missing updates of bitmap index
      gpiolib: Fix array members of same chip processed separately

The fixes should resolve the boot hang observed by Marek, however the
second change excludes that particular case from fast bitmap processing
and restores the old behaviour.  Hence, it is possible still another
issue which have had an influence on that boot hang exists in the code.
In order to fully verify the fix, it would have to be tested on a
platform where an array of GPIO descriptors is used which starts from
at least two consecutive pins of one GPIO chip in hardware order,
starting ftom 0, followed by one or more pins belonging to other
chip(s).

In order to verify if separate calls to .set() chip callback for each
pin instead of one call to .set_multiple() is actually the reason of
boot hang on Samsung Snow Chromebook, the affected driver -
drivers/mmc/core/pwrseq_simple.c - would have to be temporarily
modified for testing purposes so it calls gpiod_set_value() for each
pin instead of gpiod_set_array_value() for all of them.  If that would
also result in boot hang, we could be sure the issue was really the
one addressed by the second fix.  Marek, could you please try to
perform such test?

Thanks,
Janusz


diffstat:
 Documentation/driver-api/gpio/board.rst |   19 +++++++++----
 drivers/gpio/gpiolib.c                  |   46 +++++++++++++++++++++-----------
 2 files changed, 45 insertions(+), 20 deletions(-)
