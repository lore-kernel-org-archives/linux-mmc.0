From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 00/17] omap_hsmmc: regulator usage cleanup and fixes
Date: Wed, 29 Jul 2015 16:39:30 +0530
Message-ID: <1438168187-1614-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, afenkart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: nsekhar-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

This patch series does the following
*) Uses devm_regulator_get_optional() for vmmc and then removes the
   CONFIG_REGULATOR check altogether.
*) return on -EPROBE_DEFER
*) enable/disable vmmc_aux regulator based on prior state

This series is in preparation for implementing the voltage switch
sequence so that UHS cards can be supported.

Did basic read/write test in J6, J6 Eco, Beagle-x15, AM437x EVM,
Beaglebone black, OMAP5 uEVM and OMAP4 PANDA.

Kishon Vijay Abraham I (16):
  mmc: host: omap_hsmmc: use devm_regulator_get_optional() for vmmc
  mmc: host: omap_hsmmc: return error from omap_hsmmc_reg_get on
    -EPROBE_DEFER
  mmc: host: omap_hsmmc: cleanup omap_hsmmc_reg_get()
  mmc: host: omap_hsmmc: use the ocrmask provided by the vmmc regulator
  mmc: host: omap_hsmmc: use mmc_host's vmmc and vqmmc
  mmc: host: omap_hsmmc: remove unnecessary pbias set_voltage
  mmc: host: omap_hsmmc: return error if any of the regulator APIs fail
  mmc: host: omap_hsmmc: add separate functions for enable/disable
    supply
  mmc: host: omap_hsmmc: add separate function to set pbias
  mmc: host: omap_hsmmc: avoid pbias regulator enable on power off
  mmc: host: omap_hsmmc: don't use ->set_power to set initial regulator
    state
  ARM: dts: am57xx-beagle-x15: Fix regulator populated in MMC1 dt node
  mmc: host: omap_hsmmc: enable/disable vmmc_aux regulator based on
    prior state
  mmc: host: omap_hsmmc: use regulator_is_enabled to find pbias status
  mmc: host: omap_hsmmc: use ios->vdd for setting vmmc voltage
  mmc: host: omap_hsmmc: remove CONFIG_REGULATOR check

Roger Quadros (1):
  mmc: host: omap_hsmmc: use "mmc_of_parse_voltage" to get ocr_avail

 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |    2 +
 arch/arm/boot/dts/am57xx-beagle-x15.dts            |    1 -
 drivers/mmc/host/omap_hsmmc.c                      |  333 +++++++++++++-------
 3 files changed, 216 insertions(+), 120 deletions(-)

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
