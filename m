From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH V2 0/4] mmc: core: Add support for MMC power sequences
Date: Wed, 14 Jan 2015 14:02:06 +0100
Message-ID: <1421240530-7971-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:63151 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465AbbANNCT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Jan 2015 08:02:19 -0500
Received: by mail-wg0-f45.google.com with SMTP id y19so8780449wgg.4
        for <linux-mmc@vger.kernel.org>; Wed, 14 Jan 2015 05:02:17 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Alexandre Courbot <gnurou@gmail.com>, Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, Olof Johansson <olof@lixom.net>, Russell King <linux@arm.linux.org.uk>, Hans de Goede <hdegoede@redhat.com>, Doug Anderson <dianders@chromium.org>, NeilBrown <neilb@suse.de>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Ulf Hansson <ulf.hansson@linaro.org>

Changes in v2:
	Fixed comments from Russell King:
	- Renamed pwrseq callbacks and corresponding interface functions.
	- Move the call to the previous namned ->power_on() callback, to the
	  end of mmc_power_up() to get consistent behavior.


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

