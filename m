From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 00/11] omap_hsmmc: voltage switching and tuning
Date: Thu, 30 Jul 2015 13:16:23 +0530
Message-ID: <1438242394-25599-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, ulf.hansson@linaro.org, afenkart@gmail.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: nsekhar@ti.com, kishon@ti.com, mugunthanvnm@ti.com
List-Id: linux-mmc@vger.kernel.org

Patch series implements voltage switching and tuning for omap_hsmmc
driver.

Did basic read/write test in J6, J6 Eco, Beagle-x15, AM437x EVM,
Beaglebone black, OMAP5 uEVM and OMAP4 PANDA.

Balaji T K (2):
  mmc: host: omap_hsmmc: add voltage switch support for UHS SD card
  mmc: host: omap_hsmmc: add tuning support

Kishon Vijay Abraham I (8):
  mmc: host: omap_hsmmc: Support pbias and vmmc_aux to switch to 1.8v
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

 drivers/mmc/host/omap_hsmmc.c |  670 +++++++++++++++++++++++++++++++++--------
 1 file changed, 547 insertions(+), 123 deletions(-)

-- 
1.7.9.5
