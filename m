From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCHv3 0/9] mmc: dw_mmc: clean the codes for dwmmc controller
Date: Thu, 17 Nov 2016 16:40:32 +0900
Message-ID: <20161117074041.8641-1-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:58231 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbcKQHky (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Nov 2016 02:40:54 -0500
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OGR01SAEZZO5X60@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 17 Nov 2016 16:40:42 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com, adrian.hunter@intel.com, Jaehoon Chung <jh80.chung@samsung.com>

This patchset is modified the some minor fixing and cleaning codes.

* Major changes
- Remove the unnecessary codes and use_stop_abort() by default.
- Remove the obsoleted property "supports-highspeed"
- Deprecated the "clock-freq-min-max" property. Instead, use "max-frequency"
- Minimum clock value is set to 100K by default.

Change in v3:
- Use the dwmmc private cookie enum.
- Add the reviewed-by and acked-by tags.

Change in v2:
- Applied patches relevant to dt files
- Use "deprecated" instead of removing about "clock-freq-min-max"
- Added Heiko's Tested-by tag

Jaehoon Chung (9):
  mmc: dw_mmc: display the real register value on debugfs
  mmc: dw_mmc: fix the debug message for checking card's present
  mmc: dw_mmc: change the DW_MCI_FREQ_MIN from 400K to 100K
  mmc: dw_mmc: use the hold register when send stop command
  mmc: dw_mmc: call the dw_mci_prep_stop_abort() by default
  mmc: dw_mmc: use the cookie's enum values for post/pre_req()
  mmc: dw_mmc: remove the unnecessary mmc_data structure
  mmc: dw_mmc: The "clock-freq-min-max" property was deprecated
  Documentation: synopsys-dw-mshc: remove the unused properties

 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |  8 +-
 drivers/mmc/host/dw_mmc.c                          | 88 +++++++++++-----------
 include/linux/mmc/dw_mmc.h                         |  6 ++
 3 files changed, 50 insertions(+), 52 deletions(-)

-- 
2.10.1

