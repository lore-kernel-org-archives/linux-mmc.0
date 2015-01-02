From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/4] mmc: core: Add support for MMC power sequences
Date: Fri,  2 Jan 2015 17:14:04 +0100
Message-ID: <1420215248-20650-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

This is yet another try to solve the issues of dealing with power sequences for
the MMC subsystem. The latest attempt, see link below, took a generic approach
by adding a new top level driver layer. That's was rejected by several reasons.
http://lwn.net/Articles/602855/

This time the approach is focused to fix the issues for MMC only.

To give a short background, SOCs may specify a specific MMC power sequence. To
successfully detect an (e)MMC/SD/SDIO card, that power sequence must be followed
while initializing the card.

To be able to handle these SOC specific power sequences, we add a MMC power
sequence interface, which helps the mmc core to deal with such.

A MMC power sequence provider then implements a set of callbacks from the above
mentioned interface. The provider has a corresponding DT compatibility string
and relies on CONFIG_OF to be set to find it's various resourses, like for
example a GPIO reset.

The mmc core will from mmc_of_parse() try find a "mmc-pwrseq" DT node and then
call the corresponding MMC power sequence provider's initialization function.


Ulf Hansson (4):
  mmc: core: Initial support for MMC power sequences
  mmc: pwrseq: Document DT bindings for the simple MMC power sequence
  mmc: pwrseq: Initial support for the simple MMC power sequence
    provider
  mmc: pwrseq_simple: Add support for a reset GPIO pin

 .../devicetree/bindings/mmc/mmc,pwrseq-simple.txt  |  23 +++++
 Documentation/devicetree/bindings/mmc/mmc.txt      |   5 +
 drivers/mmc/core/Makefile                          |   2 +-
 drivers/mmc/core/core.c                            |   7 ++
 drivers/mmc/core/host.c                            |   4 +-
 drivers/mmc/core/pwrseq.c                          | 109 +++++++++++++++++++++
 drivers/mmc/core/pwrseq.h                          |  42 ++++++++
 drivers/mmc/core/pwrseq_simple.c                   |  86 ++++++++++++++++
 include/linux/mmc/host.h                           |   2 +
 9 files changed, 278 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.txt
 create mode 100644 drivers/mmc/core/pwrseq.c
 create mode 100644 drivers/mmc/core/pwrseq.h
 create mode 100644 drivers/mmc/core/pwrseq_simple.c

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
