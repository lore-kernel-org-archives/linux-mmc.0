From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH v4 0/8] UHS-I support for sh_mobile_sdhi
Date: Tue, 30 Jun 2015 17:52:57 +0100
Message-ID: <1435683177.23818.60.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@lists.codethink.co.uk, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-mmc@vger.kernel.org

This series adds support for UHS-I in sh_mobile_sdhi, partly implemented
in tmio_mmc.  This does not yet include tuning for SDR-104, but SDR-50 now
works on the R8A7790 Lager board and another development board.

The pfc block needs to be reconfigured from 3.3V to 1.8V signalling on
the pins wired to the SD card.  This is supported by implementing the
pinconf power-source parameter.  I expect that several SH SoCs have this
capability, but I only have the R8A7790 data sheet so I only implemented
it for that one.

Changes since v3:
- Change pinconf power-source argument to millivolts instead of boolean
  for low voltage
- Rename pinctrl voltage operations accordingly
- Use io{read,write}32() instead of sh_pfc_{read,write}_raw_reg()
- Change tmio, sh_mobile_sdhi to adjust input clock frequency to match
  requested bus frequency more closely
- Replace SDHI assigned-clock{,-rate}s properties with max-frequency
- Reorder patch series to put all pinctrl changes first

Changes since v2:
- Implement the pinconf power-source parameter instead of separate
  functions for the low-voltage mode
- Adjust low-voltage mode setter function and device tree accordingly
- Add low-voltage mode getter function for R8A7790

Changes since v1:
- Reword commit message for "mmc: tmio: Add UHS-I mode support"
- Make sh_mobile_sdhi_start_signal_voltage_switch() succeed if asked
  to switch to 3.3V and the regulator or pinctrl or pinctrl state is
  missing
- Drop change to mmcif clock on Lager
- Correct original author for sdhi clock changes on Lager

Changes since the RFC:
- Replace the 'regulator' devices for signal voltage switching with
  pinctrl functions and states
- Drop 'mmc: sh_mobile_sdhi: Add actual clock rate support' as it's
  redundant
- Use a switch statement in sh_mobile_sdhi_start_signal_voltage_switch()
- Fix subject prefix for the DT changes

Ben.

Ben Hutchings (8):
  pinctrl: sh-pfc: Implement pinconf power-source param for voltage
    switching
  pinctrl: sh-pfc: r8a7790: Implement voltage switching for SDHI
  mmc: tmio, sh_mobile_sdhi: Pass tmio_mmc_host ptr to
    clk_{enable,disable} ops
  mmc: tmio, sh_mobile_sdhi: Add support for variable input clock
    frequency
  mmc: tmio: Add UHS-I mode support
  mmc: sh_mobile_sdhi: Add UHS-I mode support
  ARM: shmobile: r8a7790: Set maximum frequencies for SDHI clocks
  ARM: shmobile: lager: Enable UHS-I SDR-50

 .../bindings/pinctrl/renesas,pfc-pinctrl.txt       |   4 +-
 arch/arm/boot/dts/r8a7790-lager.dts                |  22 +++-
 arch/arm/boot/dts/r8a7790.dtsi                     |   4 +
 drivers/mmc/host/sh_mobile_sdhi.c                  | 126 +++++++++++++++++++--
 drivers/mmc/host/tmio_mmc.h                        |   9 +-
 drivers/mmc/host/tmio_mmc_pio.c                    |  56 ++++++---
 drivers/pinctrl/sh-pfc/core.c                      |   2 +-
 drivers/pinctrl/sh-pfc/core.h                      |   1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c               |  71 +++++++++++-
 drivers/pinctrl/sh-pfc/pinctrl.c                   |  44 ++++++-
 drivers/pinctrl/sh-pfc/sh_pfc.h                    |   5 +
 11 files changed, 313 insertions(+), 31 deletions(-)

-- 
2.1.4



