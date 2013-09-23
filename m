From: Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>
Subject: [PATCH v2 0/4] ARCH_BCM rename
Date: Mon, 23 Sep 2013 10:20:32 -0700
Message-ID: <1379956836-5866-1-git-send-email-bcm@fixthebug.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: Domenico Andreoli <cavokz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Christian Daudt <csd-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alex Elder <alex.elder-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Rename ARCH_BCM to ARCH_BCM_MOBILE. Currently only the 
Broadcom mobile SoCs reside in the mach-bcm directory and are 
chosen by the ARCH_BCM config option.
 This patchset changes so that ARCH_BCM becomes a menu select
for Broadcom ARM SoCs. ARCH_BCM_MOBILE is created to signify 
the (multiplatform) Mobile SoCs.

Christian Daudt (4):
  rename ARCH_BCM to ARCH_BCM_MOBILE (mach-bcm)
  rename ARCH_BCM to ARCH_BCM_MOBILE (clocksource)
  rename ARCH_BCM to ARCH_BCM_MOBILE (mmc)
  rename ARCH_BCM to ARCH_BCM_MOBILE (dt)

 arch/arm/boot/dts/Makefile          |    4 ++--
 arch/arm/configs/bcm_defconfig      |    1 +
 arch/arm/configs/multi_v7_defconfig |    1 +
 arch/arm/mach-bcm/Kconfig           |   20 ++++++++++++++++++--
 arch/arm/mach-bcm/Makefile          |    2 +-
 drivers/clocksource/Makefile        |    2 +-
 drivers/mmc/host/Kconfig            |    2 +-
 7 files changed, 25 insertions(+), 7 deletions(-)

-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
