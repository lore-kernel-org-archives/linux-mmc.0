From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH v2 0/6] UHS-I support for sh_mobile_sdhi
Date: Wed, 10 Jun 2015 00:21:44 +0100
Message-ID: <1433892104.12074.49.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:34227 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbbFIXVt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Jun 2015 19:21:49 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>, linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@lists.codethink.co.uk, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This series adds support for UHS-I in sh_mobile_sdhi, partly implemented
in tmio_mmc.  This does not yet include tuning for SDR-104, but SDR-50 now
works on the R8A7790 Lager board and another development board.

The pfc block needs to be reconfigured from 3.3V to 1.8V signalling on
the pins wired to the SD card.  This is supported by adding separate
functions for 1.8V signalling in sh-pfc ("sdhi0_1v8" etc.).  I expect
that several SH SoCs have this capability, but I only have the R8A7790
data sheet so I only implemented it for that one.

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
  pinctrl: sh-pfc: Add set_mux operation to struct sh_pfc_function
  pinctrl: sh-pfc: r8a7790: Add separate functions for SDHI 1.8V
    operation
  mmc: sh_mobile_sdhi: Add UHS-I mode support
  ARM: shmobile: lager: Enable UHS-I SDR-50

Ian Molton (1):
  ARM: shmobile: lager: Set clock rates for SDHI

 arch/arm/boot/dts/r8a7790-lager.dts  | 24 +++++++++++--
 drivers/mmc/host/sh_mobile_sdhi.c    | 60 +++++++++++++++++++++++++++++++
 drivers/mmc/host/tmio_mmc.h          |  3 ++
 drivers/mmc/host/tmio_mmc_pio.c      | 31 ++++++++++++++++
 drivers/pinctrl/sh-pfc/core.c        |  2 +-
 drivers/pinctrl/sh-pfc/core.h        |  1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 70 +++++++++++++++++++++++++++++++++---
 drivers/pinctrl/sh-pfc/pinctrl.c     |  4 +++
 drivers/pinctrl/sh-pfc/sh_pfc.h      | 10 +++++-
 9 files changed, 197 insertions(+), 8 deletions(-)

-- 
2.1.4



