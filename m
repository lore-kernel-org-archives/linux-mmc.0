From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH v2 0/2] add support for the Marvell Dove SDHCI controller
Date: Wed, 27 Oct 2010 13:21:57 +0200
Message-ID: <cover.1288178148.git.mike@compulab.co.il>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:49737 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756335Ab0J0LWf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Oct 2010 07:22:35 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, Saeed Bishara <saeed@marvell.com>, Mike Rapoport <mike@compulab.co.il>

These patches add support for the Marvell Dove SDHCI controller.

v2 changes:
* rename drivers/mmc/host/sdhci-mv.c to drivers/mmc/host/sdhci-dove.c and
update Kconfig and Makefile respectively
* add dependancy on ARCH_DOVE
* remove unneeded includes from the driver

Mike Rapoport (2):
  MMC: add support for the Marvell Dove SDHCI controller
  [ARM] Dove: rename SDCHI devices to "sdhci-dove"

 arch/arm/mach-dove/common.c    |    4 +-
 drivers/mmc/host/Kconfig       |   13 +++++++
 drivers/mmc/host/Makefile      |    1 +
 drivers/mmc/host/sdhci-dove.c  |   72 ++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pltfm.c |    3 ++
 drivers/mmc/host/sdhci-pltfm.h |    1 +
 6 files changed, 92 insertions(+), 2 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-dove.c

-- 
1.7.3.1

