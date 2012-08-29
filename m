From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH v5 0/9] mmc: dw_mmc: add support for device tree based
 instantiation
Date: Wed, 29 Aug 2012 16:18:06 +0530
Message-ID: <1346237295-7116-1-git-send-email-thomas.abraham@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:8287 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752641Ab2H2K37 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Aug 2012 06:29:59 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: will.newton@imgtec.com, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, jh80.chung@samsung.com, tgih.jun@samsung.com, patches@linaro.org

This is the fifth version of the patch series that adds device tree support
for Synopsis Designware Mobile Storage Host Controller. All the review comments
from the v4 version have been addressed and rebased on mmc-next branch. Since v4,
patches 6/9 and 9/9 have been modified. This has been tested on only smdk5250.

Thomas Abraham (9):
  mmc: dw_mmc: convert copy of struct device in struct dw_mci to a reference
  mmc: dw_mmc: Use devm_* functions in dw_mmc platform driver
  mmc: dw_mmc: allow probe to succeed even if one slot is initialized
  mmc: dw_mmc: lookup for optional biu and ciu clocks
  mmc: dw_mmc: add quirk to indicate missing write protect line
  mmc: dw_mmc: add device tree support
  mmc: dw_mmc: prepare functions in dw_mmc-pltfm for reuse
  mmc: dw_mmc: add support for implementation specific callbacks
  mmc: dw_mmc: add support for exynos specific implementation of dw-mshc

 .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |   85 ++++++
 .../devicetree/bindings/mmc/synposis-dw-mshc.txt   |   79 ++++++
 drivers/mmc/host/Kconfig                           |    9 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/dw_mmc-exynos.c                   |  243 ++++++++++++++++
 drivers/mmc/host/dw_mmc-pci.c                      |    2 +-
 drivers/mmc/host/dw_mmc-pltfm.c                    |   60 +++--
 drivers/mmc/host/dw_mmc-pltfm.h                    |   20 ++
 drivers/mmc/host/dw_mmc.c                          |  289 ++++++++++++++++----
 drivers/mmc/host/dw_mmc.h                          |   22 ++
 include/linux/mmc/dw_mmc.h                         |   13 +-
 11 files changed, 748 insertions(+), 75 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt
 create mode 100644 drivers/mmc/host/dw_mmc-exynos.c
 create mode 100644 drivers/mmc/host/dw_mmc-pltfm.h

