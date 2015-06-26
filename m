From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH v3 0/6] UHS-I support for sh_mobile_sdhi
Date: Fri, 26 Jun 2015 16:21:56 +0100
Message-ID: <1435332116.23818.7.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
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

Ben Hutchings (5):
  mmc: tmio: Add UHS-I mode support
  pinctrl: sh-pfc: Add low-voltage pinconf parameter
  pinctrl: sh-pfc: r8a7790: Implement voltage switching for SDHI
  mmc: sh_mobile_sdhi: Add UHS-I mode support
  ARM: shmobile: lager: Enable UHS-I SDR-50

Ian Molton (1):
  ARM: shmobile: lager: Set clock rates for SDHI

 .../bindings/pinctrl/renesas,pfc-pinctrl.txt       |  6 +-
 arch/arm/boot/dts/r8a7790-lager.dts                | 28 ++++++++-
 drivers/mmc/host/sh_mobile_sdhi.c                  | 60 +++++++++++++++++++
 drivers/mmc/host/tmio_mmc.h                        |  3 +
 drivers/mmc/host/tmio_mmc_pio.c                    | 31 ++++++++++
 drivers/pinctrl/sh-pfc/core.c                      |  2 +-
 drivers/pinctrl/sh-pfc/core.h                      |  1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c               | 67 +++++++++++++++++++++-
 drivers/pinctrl/sh-pfc/pinctrl.c                   | 57 +++++++++++++++---
 drivers/pinctrl/sh-pfc/sh_pfc.h                    | 11 ++++
 10 files changed, 252 insertions(+), 14 deletions(-)

-- 
2.1.4



