From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 0/6] UHS-I support for sh_mobile_sdhi
Date: Sun, 17 May 2015 01:27:39 +0100
Message-ID: <1431822459.4222.166.camel@xylophone.i.decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>, linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@lists.codethink.co.uk, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

This series adds support for UHS-I in sh_mobile_sdhi, partly implemented
in tmio_mmc.  This does not yet include tuning for SDR-104, but SDR-50 now
works on the R8A7790 Lager board and another development board.

The pfc block needs to be reconfigured from 3.3V to 1.8V signalling on
the pins wired to the SD card.  This is supported by adding separate
functions for 1.8V signalling in sh-pfc ("sdhi0_1v8" etc.).  I expect
that several SH SoCs have this capability, but I only have the R8A7790
data sheet so I only implemented it for that one.

Changes since the RFC:
- Replace the 'regulator' devices for signal voltage switching with
  pinctrl functions and states
- Drop 'mmc: sh_mobile_sdhi: Add actual clock rate support' as it's
  redundant
- Use a switch statement in sh_mobile_sdhi_start_signal_voltage_switch()
- Fix subject prefix for the DT changes

Ben.

Ben Dooks (1):
  ARM: shmobile: lager: Set sdhi and mmcif clock rates

Ben Hutchings (5):
  mmc: tmio: Add UHS-I mode support
  pinctrl: sh-pfc: Add set_mux operation to struct sh_pfc_function
  pinctrl: sh-pfc: r8a7790: Add separate functions for SDHI 1.8V
    operation
  mmc: sh_mobile_sdhi: Add UHS-I mode support
  ARM: shmobile: lager: Enable UHS-I SDR-50

 arch/arm/boot/dts/r8a7790-lager.dts  |   29 +++++++++++++-
 drivers/mmc/host/sh_mobile_sdhi.c    |   58 ++++++++++++++++++++++++++++
 drivers/mmc/host/tmio_mmc.h          |    3 ++
 drivers/mmc/host/tmio_mmc_pio.c      |   31 +++++++++++++++
 drivers/pinctrl/sh-pfc/core.c        |    2 +-
 drivers/pinctrl/sh-pfc/core.h        |    1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c |   70 ++++++++++++++++++++++++++++++++--
 drivers/pinctrl/sh-pfc/pinctrl.c     |    4 ++
 drivers/pinctrl/sh-pfc/sh_pfc.h      |   10 ++++-
 9 files changed, 200 insertions(+), 8 deletions(-)

-- 
1.7.10.4



