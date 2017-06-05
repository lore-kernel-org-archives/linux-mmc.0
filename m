From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 0/6] mmc: dw_mmc: remove the multiple slot concept
Date: Mon, 05 Jun 2017 13:41:29 +0900
Message-ID: <20170605044135.18304-1-jh80.chung@samsung.com>
References: <CGME20170605044137epcas1p4e7e2b74aa17ea7d7137da7b677bfb282@epcas1p4.samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:32918 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751306AbdFEElj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Jun 2017 00:41:39 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>

DWMMC IP is provided the multiple slot.
It's only used the one slot per an IP in mmc subsystem.
If we can consider only one slot, then dwmmc controller codes can be more simpler than now.
This patchset is the first step to remove the multiple slot.

In future work,
   - Remove the entire slot structure.
   - Move to slot's members into dwmci host.

Jaehoon Chung (6):
  mmc: dw_mmc: deprecated the "num-slots" property
  mmc: dw_mmc: remove the loop about finding slots
  mmc: dw_mmc: change the array of slots
  mmc: dw_mmc: remove the 'id' arguments about functions relevant to
    slot
  mmc: dw_mmc: use the 'slot' instead of 'cur_slot'
  mmc: dw_mmc: remove the unnecessary slot variable

 drivers/mmc/host/dw_mmc-exynos.c |   4 +-
 drivers/mmc/host/dw_mmc.c        | 165 +++++++++++++--------------------------
 drivers/mmc/host/dw_mmc.h        |   7 +-
 3 files changed, 57 insertions(+), 119 deletions(-)

-- 
2.10.2

