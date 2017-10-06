From: Liming Sun <lsun@mellanox.com>
Subject: [PATCH 0/9] Enable dw-mmc multi-card support
Date: Fri,  6 Oct 2017 15:21:23 -0400
Message-ID: <cover.1507315433.git.lsun@mellanox.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:39994 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751639AbdJFTWD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Oct 2017 15:22:03 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Liming Sun <lsun@mellanox.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org

This series of commits enables the multi-card support for the dw-mmc
controller. It includes two parts as below.

The first part (patches 1-7) reverts the series of recent commits that
removed the multi-card support with comments saying there was no such
use case in the real world. Actually this feature is being used in
Mellanox Bluefield SoC and has been requested by customers.

The second part (patches 8-9) fixes the DesignWare multi-card support
according to the dw-mmc databook (synnopsys: DesignWare Cores Mobile
Storage Host Databook, 2.70a). It has changes to set the card number
into the CMD register to multiplex requests to different cards when
working in SD_MMC_CEATA mode, set the CTYPE / CLKENA / CDTHRCTL
registers properly according to the spec, and parse the per-card
configuration to match the Linux Documentation
(bindings/mmc/synopsys-dw-mshc.txt).

Liming Sun (9):
  Revert "Documentation: dw-mshc: deprecate num-slots"
  Revert "mmc: dw_mmc: remove the unnecessary slot variable"
  Revert "mmc: dw_mmc: use the 'slot' instead of 'cur_slot'"
  Revert "mmc: dw_mmc: remove the 'id' arguments about functions
    relevant to slot"
  Revert "mmc: dw_mmc: change the array of slots"
  Revert "mmc: dw_mmc: remove the loop about finding slots"
  Revert "mmc: dw_mmc: deprecated the "num-slots" property"
  mmc: dw_mmc: Support two SD_MMC_CE-ATA cards
  mmc: dw_mmc: Parse slot-specific configuration

 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |  16 +-
 drivers/mmc/host/dw_mmc-exynos.c                   |   4 +-
 drivers/mmc/host/dw_mmc.c                          | 277 ++++++++++++++++-----
 drivers/mmc/host/dw_mmc.h                          |  17 +-
 4 files changed, 236 insertions(+), 78 deletions(-)

-- 
1.8.3.1

