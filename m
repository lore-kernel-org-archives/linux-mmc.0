From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH v2 0/9] r8a7790: add UHS-I (SDR50) support to Lager
Date: Fri,  1 Apr 2016 17:44:30 +0200
Message-ID: <1459525479-20842-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org, Ben Hutchings <ben.hutchings@codethink.co.uk>
List-Id: linux-mmc@vger.kernel.org

So, here is v2 of the series adding SDR50 support to the Renesas Lager board.
Change since v1:

* rebased to renesas-drivers based on v4.6-rc1
* dropped pinctrl patch which was already picked up
* directly populate start_signal_voltage_switch() in mmc_ops
  instead of using a wrapper function
* use generic DT pinctrl bindings instead of vendor specific ones
  (e.g. "groups" instead of "renesas,groups")

The RFC series worked fine with my Transcend card, but failed to switch
voltages on a SanDisk and Samsung card. This bug hunting resulted in patches
4-6 newly added: The clock really has to be disabled on ios->clock == 0,
setting frequency to 0Hz doesn't work. I wonder if this isn't true for some
more controllers? Is this known already?

My "copy-large-files-around"-setup showed now 30MB/s while it had 19MB/s
without SDR50. Frankly, I hoped for a little more, but let's start with this
initial support and do the tuning incrementally I'd say.

Patches 1-7 should go via Ulf. After those patches went in, Simon can take 8+9
to tie it all together.

Please comment, test, apply...

Thanks,

   Wolfram


Ben Hutchings (3):
  mmc: tmio, sh_mobile_sdhi: Pass tmio_mmc_host ptr to
    clk_{enable,disable} ops
  mmc: tmio, sh_mobile_sdhi: Add support for variable input clock
    frequency
  ARM: shmobile: r8a7790: Set maximum frequencies for SDHI clocks

Wolfram Sang (6):
  mmc: tmio: Add UHS-I mode support
  mmc: tmio: always start clock after frequency calculation
  mmc: tmio: stop clock when 0Hz is requested
  mmc: host: add note that set_ios needs to handle 0Hz properly
  mmc: sh_mobile_sdhi: Add UHS-I mode support
  ARM: shmobile: r8a7790: lager: Enable UHS-I SDR-50

 Documentation/devicetree/bindings/mmc/tmio_mmc.txt |   3 +
 arch/arm/boot/dts/r8a7790-lager.dts                |  22 +++-
 arch/arm/boot/dts/r8a7790.dtsi                     |   4 +
 drivers/mmc/host/sh_mobile_sdhi.c                  | 116 +++++++++++++++++++--
 drivers/mmc/host/tmio_mmc.h                        |   8 +-
 drivers/mmc/host/tmio_mmc_pio.c                    | 102 +++++++++---------
 include/linux/mmc/host.h                           |  31 ++++--
 include/linux/mmc/tmio.h                           |   2 +
 8 files changed, 218 insertions(+), 70 deletions(-)

-- 
2.7.0
