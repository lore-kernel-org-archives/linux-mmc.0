From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 00/15] omap_hsmmc: regulator usage cleanup and fixes
Date: Thu, 27 Aug 2015 14:43:52 +0530
Message-ID: <1440666847-12594-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46711 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982AbbH0JOR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Aug 2015 05:14:17 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, afenkart@gmail.com, tony@atomide.com, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
Cc: neilb@suse.de, kishon@ti.com

This patch series does the following
*) Uses devm_regulator_get_optional() for vmmc and then removes the
   CONFIG_REGULATOR check altogether.
*) return on -EPROBE_DEFER and any other fatal errors
*) enable/disable vmmc_aux regulator based on prior state

Changes from v2:
*) rebased to mmc -next branch
*) dropped using "mmc_of_parse_voltage" to get ocr_avail patch.

Changes from v1:
*) return on -EPROBE_DEFER and other fatal errors. (Don't return only
   if the return value is -ENODEV)
*) Remove the beagle x15 dts patch. It can be part of a different
   series.
*) Avoid using regulator_is_enabled for vqmmc since if the regulator
   is shared and the other users are not using regulator_is_enabled
   then there can be unbalanced regulator_enable/regulator_disable

I've pushed this patch series to
git://git.ti.com/linux-phy/linux-phy.git mmc_for-next

Please note the branch also has the pbias fixes [1].
[1] -> https://lkml.org/lkml/2015/7/27/358

This series is in preparation for implementing the voltage switch
sequence so that UHS cards can be supported.

Did basic read/write test in J6, J6 Eco, Beagle-x15, AM437x EVM,
Beaglebone black, OMAP5 uEVM, OMAP4 PANDA and OMAP3gle xm.

Kishon Vijay Abraham I (15):
  mmc: host: omap_hsmmc: use devm_regulator_get_optional() for vmmc
  mmc: host: omap_hsmmc: return on fatal errors from omap_hsmmc_reg_get
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
  mmc: host: omap_hsmmc: enable/disable vmmc_aux regulator based on
    previous state
  mmc: host: omap_hsmmc: use regulator_is_enabled to find pbias status
  mmc: host: omap_hsmmc: use ios->vdd for setting vmmc voltage
  mmc: host: omap_hsmmc: remove CONFIG_REGULATOR check

 drivers/mmc/host/omap_hsmmc.c |  326 +++++++++++++++++++++++++++--------------
 1 file changed, 212 insertions(+), 114 deletions(-)

-- 
1.7.9.5

