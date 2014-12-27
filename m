From: Yi Sun <yi.y.sun@intel.com>
Subject: [RFC 0/2] mmc: UHS-II implementation
Date: Sat, 27 Dec 2014 17:27:57 +0800
Message-ID: <1419672479-30852-1-git-send-email-yi.y.sun@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:60967 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751200AbaL0JfR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 27 Dec 2014 04:35:17 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: yi.y.sun@intel.com

Hello,

UHS-II spec has been published for some time but it seems community does not implement this feature. With this feature, read/write performance can be improved much.

So, I submit these two patches which implement main functions of UHS-II for community review. Hope to get suggestions from community.

As the UHS-II test environment is not available yet, some functions may be not completed. I add some "TODO" in codes for next steps and some concerns. In next steps, the codes will be finished completely and verified on board supporting UHS-II. Then, the formal patches will be submitted.

The implementation bases on below specs:
1. SD 4.2 PHY
2. UHS-II Addendum 1.02
3. SDHC Spec 4.1

Yi Sun (2):
  mmc: core: support UHS-II in core stack.
  mmc: sdhci: support UHS-II in SDHCI host.

 drivers/mmc/core/Makefile     |    3 +-
 drivers/mmc/core/bus.c        |    5 +-
 drivers/mmc/core/core.c       |   89 +++-
 drivers/mmc/core/sd.c         |   15 +
 drivers/mmc/core/sd_ops.c     |   12 +
 drivers/mmc/core/uhs2.c       |  908 +++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/uhs2.h       |   26 ++
 drivers/mmc/host/Makefile     |    2 +-
 drivers/mmc/host/sdhci-pci.c  |    6 +
 drivers/mmc/host/sdhci-uhs2.c |  703 +++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h |   36 ++
 drivers/mmc/host/sdhci.c      |  259 ++++++++++--
 drivers/mmc/host/sdhci.h      |  313 +++++++++++++-
 include/linux/mmc/core.h      |    6 +
 include/linux/mmc/host.h      |   27 ++
 include/linux/mmc/sdhci.h     |    2 +
 include/linux/mmc/uhs2.h      |  274 +++++++++++++
 17 files changed, 2625 insertions(+), 61 deletions(-)
 create mode 100644 drivers/mmc/core/uhs2.c
 create mode 100644 drivers/mmc/core/uhs2.h
 create mode 100644 drivers/mmc/host/sdhci-uhs2.c
 create mode 100644 drivers/mmc/host/sdhci-uhs2.h
 create mode 100644 include/linux/mmc/uhs2.h

-- 
1.7.9.5

