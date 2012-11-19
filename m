From: Abhilash Kesavan <a.kesavan@samsung.com>
Subject: [PATCH 0/4] Support for optional MMC PM capabilities
Date: Mon, 19 Nov 2012 10:26:17 +0530
Message-ID: <1353300981-24652-1-git-send-email-a.kesavan@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:18294 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785Ab2KSEv0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 18 Nov 2012 23:51:26 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MDP00E1BXGUS1J0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 19 Nov 2012 13:51:25 +0900 (KST)
Received: from localhost.localdomain ([107.108.73.92])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MDP00338XGFP3E0@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 19 Nov 2012 13:51:25 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org

This patchset adds optional PM properties to the core MMC bindings. It also
makes the appropriate changes in the sdhci platform and dw_mmc driver files.
Based on git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git : for-next.
Note: Patch 3 has only been compile tested.

Abhilash Kesavan (4):
  mmc: dt: Fix typo in filename
  mmc: dt: Add optional pm properties to core binding
  mmc: sdhci-pltfm: Support optional pm properties
  mmc: dw_mmc: Add sdio power bindings

 Documentation/devicetree/bindings/mmc/mmc.txt      |    4 ++++
 .../{synposis-dw-mshc.txt => synopsis-dw-mshc.txt} |    0
 drivers/mmc/host/dw_mmc.c                          |   20 +++++++++++++++++---
 drivers/mmc/host/sdhci-pltfm.c                     |    6 ++++++
 include/linux/mmc/dw_mmc.h                         |    1 +
 5 files changed, 28 insertions(+), 3 deletions(-)
 rename Documentation/devicetree/bindings/mmc/{synposis-dw-mshc.txt => synopsis-dw-mshc.txt} (100%)

