From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCHv2 00/10] mmc: dw_mmc: clean the codes for dwmmc controller
Date: Tue, 15 Nov 2016 19:12:22 +0900
Message-ID: <20161115101232.3854-1-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:51235 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941589AbcKOKMh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Nov 2016 05:12:37 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org, ulf.hansson@linaro.org, heiko@sntech.de, shawn.lin@rock-chips.com, robh+dt@kernel.org, Jaehoon Chung <jh80.chung@samsung.com>

This patchset is modified the some minor fixing and cleaning codes.

* Major changes
- Use the cookie enum values like sdhci controller.
- Remove the unnecessary codes and use_stop_abort() by default.
- Remove the obsoleted property "supports-highspeed"
- Deprecated the "clock-freq-min-max" property. Instead, use "max-frequency"
- Minimum clock value is set to 100K by default.

Change in v2:
- Applied patches relevant to dt files
- Use "deperecated" instead of removing about "clock-freq-min-max"
- Added Heiko's Tested-by tag

Jaehoon Chung (10):
  mmc: dw_mmc: display the real register value on debugfs
  mmc: dw_mmc: fix the debug message for checking card's present
  mmc: dw_mmc: change the DW_MCI_FREQ_MIN from 400K to 100K
  mmc: dw_mmc: use the hold register when send stop command
  mmc: dw_mmc: call the dw_mci_prep_stop_abort() by default
  mmc: core: move the cookie's enum values from sdhci.h to mmc.h
  mmc: dw_mmc: use the cookie's enum values for post/pre_req()
  mmc: dw_mmc: remove the unnecessary mmc_data structure
  mmc: dw_mmc: The "clock-freq-min-max" property was deprecated
  Documentation: synopsys-dw-mshc: remove the unused properties

 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |  8 +-
 drivers/mmc/host/dw_mmc.c                          | 88 +++++++++++-----------
 drivers/mmc/host/sdhci.h                           |  6 --
 include/linux/mmc/core.h                           |  6 ++
 4 files changed, 50 insertions(+), 58 deletions(-)

-- 
2.10.1

