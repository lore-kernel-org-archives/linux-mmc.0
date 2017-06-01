From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 0/7] dra7: Fixes for MMC devicetree node
Date: Thu, 1 Jun 2017 20:03:54 +0530
Message-ID: <20170601143401.16852-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:61316 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdFAOew (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Jun 2017 10:34:52 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, nsekhar@ti.com
Cc: Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, kishon@ti.com

There are the set of fixes that were sent initially as part
of [1].

These are mostly fixes w.r.t populating regulators in
mmc dt node. It was working before because the regulators
connecting to the IO lines are always on regulators. This will
break once we add UHS support where voltage has to be changed
dynamically.

Performed enumeration testing on dra72-evm-revc, dra72-evm,
dra7-evm, am572x-evm, am571x-idk and am572x-idk.

This is a preparation series for adding UHS mode support in
the above mentioned platforms.

[1] -> https://lkml.org/lkml/2017/5/19/196

Kishon Vijay Abraham I (5):
  ARM: dts: dra72-evm-common: Correct vmmc-supply for mmc2
  ARM: dts: dra72-evm: Add vmmc_aux supply to mmc1
  ARM: dts: dra72-evm-revc: Add vmmc_aux supply to mmc1
  ARM: dts: am57xx-beagle-x15-revb1: Fix supply name used for MMC1 IO
    lines
  ARM: dts: dra7: Add "max-frequency" property to MMC dt nodes

Ravikumar Kattekola (1):
  ARM: dts: dra7-evm: Correct the vmmc-supply for mmc2

Sekhar Nori (1):
  ARM: OMAP2+: Add pdata-quirks for MMC/SD on DRA74x EVM

 arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts |  2 +-
 arch/arm/boot/dts/dra7-evm.dts                | 10 ++++++++-
 arch/arm/boot/dts/dra7.dtsi                   |  5 +++++
 arch/arm/boot/dts/dra71-evm.dts               | 14 ++++++++++++
 arch/arm/boot/dts/dra72-evm-common.dtsi       |  2 --
 arch/arm/boot/dts/dra72-evm-revc.dts          | 18 ++++++++++++++++
 arch/arm/boot/dts/dra72-evm.dts               | 18 ++++++++++++++++
 arch/arm/mach-omap2/pdata-quirks.c            | 31 +++++++++++++++++++++++++++
 include/linux/platform_data/hsmmc-omap.h      |  3 +++
 9 files changed, 99 insertions(+), 4 deletions(-)

-- 
2.11.0

