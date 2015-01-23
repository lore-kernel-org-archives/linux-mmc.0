From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v2 0/7]  Fixes and improvements for SDHCI on Armada 38x
Date: Fri, 23 Jan 2015 11:56:27 +0100
Message-ID: <1422010594-1735-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:49623 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755075AbbAWK4v (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Jan 2015 05:56:51 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org

Hi,

this series brings fixes and improvements for the SDHCI controller of
the Armada 38x SoCs.

The main change for this second version was to put back the authorship
on patch 2 and 4 from Marcin as I ported them a 3.10 kernel.

The first two patches are fixes and should be also applied on the
stable branch (I added stable in copy for this).

The first one removes the SDR50 and DDR50 mode timing from the
capabilities of the controller because the current implementation
doesn't support it.

The second one fix controller's caps according to the limitation of
the hardware.

The third one extends the Device Tree binding of the Armada 38x. It
allows using the SDIO3 configuration register.

The forth patch adds the support of this new register in the
driver. Thanks to this one, specific clock adjustments can be done in
order to support the SDR50 and DDR50 modes timing.

The fifth patch is device tree clean-up.

The sixth patch update the SDHCI node on Armada 38x in order to use
the new register and then to be able to support the SDR50 and DDR50
modes timing.

Finally, the seventh patch add the description of SDHCI for the Armada
388 RD board which was missing.

Patches 1 to 4 should be merged through the mmc tree and patches 5 to
7 should be merged through mvebu and then arm-soc.

Patch 4 depend on patch 2.
Patch 2 depend on patch 1.
And patch 1 depend on commit aa8165f91442 "mmc: sdhci-pxav3: do the
mbus window configuration after enabling clocks" which have been
merged.

But as all this patch should be merged through the same tree it would
not be a problem

The patches 5 to 7 depend on the patches already merged in mvebu.

As they are fixes, patches 1 and 2 should be merged in 3.18-rc or at
least in 3.19 and then they will be part of 3.18.1. For the other
patches it would be nice if they could be part of 3.19.

Thanks,

Gregory

Changelog:

- Put back Marcin as author of patch 2 and 3
- Removed MMC_CAP_1_8V_DDR in the probe function

Gregory CLEMENT (5):
  mmc: sdhci-pxav3: Fix SDR50 and DDR50 capabilities for the Armada 38x
    flavor
  mmc: sdhci-pxav3: Extend binding with SDIO3 conf reg for the Armada
    38x
  ARM: mvebu: Use macros for interrupt flags on Armada 38x sdhci node
  ARM: mvebu: Update the SDHCI node on Armada 38x
  ARM: mvebu: Add Device Tree description of SDHCI for Armada 388 RD

Marcin Wojtas (2):
  mmc: sdhci-pxav3: Fix Armada 38x controller's caps according to
    erratum ERR-7878951
  mmc: sdhci-pxav3: Modify clock settings for the SDR50 and DDR50 modes

 .../devicetree/bindings/mmc/sdhci-pxa.txt          | 15 ++--
 arch/arm/boot/dts/armada-388-rd.dts                | 10 +++
 arch/arm/boot/dts/armada-38x.dtsi                  |  7 +-
 drivers/mmc/host/sdhci-pxav3.c                     | 82 +++++++++++++++++++++-
 4 files changed, 105 insertions(+), 9 deletions(-)

-- 
2.1.0

