From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 00/11] omap_hsmmc: voltage switching and tuning
Date: Tue, 25 Aug 2015 14:35:31 +0530
Message-ID: <1440493542-26150-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48912 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755725AbbHYJFw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 25 Aug 2015 05:05:52 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, afenkart@gmail.com, tony@atomide.com, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
Cc: neilb@suse.de, kishon@ti.com

Patch series implements voltage switching and tuning for omap_hsmmc
driver.

Changes from v1:
*) rebased on top of [1]
*) Patch breaking omap3 beagle xm is fixed. (set clk rate patch was
   breaking beagle xm)

[1] -> https://lkml.org/lkml/2015/8/21/125

Did basic read/write test in J6, J6 Eco, Beagle-x15, AM437x EVM,
Beaglebone black, OMAP5 uEVM and OMAP4 PANDA, OMAP3 beagle xm.
Also performed PM suspend/resume test with OMAP3 beagle xm.

Balaji T K (2):
  mmc: host: omap_hsmmc: add voltage switch support for UHS SD card
  mmc: host: omap_hsmmc: add tuning support

Kishon Vijay Abraham I (8):
  mmc: host: omap_hsmmc: Support vmmc_aux to switch to 1.8v
  mmc: host: omap_hsmmc: separate setting voltage capabilities from bus
    power
  mmc: host: omap_hsmmc: program HCTL based on signal_voltage set by
    mmc core
  mmc: host: omap_hsmmc: set clk rate to the max frequency
  mmc: host: omap_hsmmc: set timing in the UHSMS field
  mmc: host: omap_hsmmc: Workaround for errata id i802
  mmc: host: omap_hsmmc: Allow io voltage switch even for fixed vdd
  mmc: host: omap_hsmmc: remove incorrect voltage switch sequence

Mugunthan V N (1):
  mmc: host: omap_hsmmc: add software timer when timeout greater than
    hardware capablility

 drivers/mmc/host/omap_hsmmc.c |  677 +++++++++++++++++++++++++++++++++--------
 1 file changed, 554 insertions(+), 123 deletions(-)

-- 
1.7.9.5

