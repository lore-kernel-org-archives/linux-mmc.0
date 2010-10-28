From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH v4 0/2] add support for the Marvell Dove SDHCI controller
Date: Thu, 28 Oct 2010 21:23:51 +0200
Message-ID: <cover.1288293593.git.mike@compulab.co.il>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:33481 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753322Ab0J1TYa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 28 Oct 2010 15:24:30 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Saeed Bishara <saeed@marvell.com>, linux-arm-kernel@lists.infradead.org, Mike Rapoport <mike@compulab.co.il>

These patches add support for the Marvell Dove SDHCI controller.

v4 changes:
* fix spelling in the commit message

v3 changes:
* finally remove unneeded includes from the driver

v2 changes:
* rename drivers/mmc/host/sdhci-mv.c to drivers/mmc/host/sdhci-dove.c and
update Kconfig and Makefile respectively
* add dependancy on ARCH_DOVE
* remove unneeded includes from the driver


Mike Rapoport (2):
  MMC: add support for the Marvell Dove SDHCI controller
  [ARM] Dove: rename SDHCI devices to "sdhci-dove"

 arch/arm/mach-dove/common.c    |    4 +-
 drivers/mmc/host/Kconfig       |   13 +++++++
 drivers/mmc/host/Makefile      |    1 +
 drivers/mmc/host/sdhci-dove.c  |   70 ++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pltfm.c |    3 ++
 drivers/mmc/host/sdhci-pltfm.h |    1 +
 6 files changed, 90 insertions(+), 2 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-dove.c

-- 
1.7.3.1

