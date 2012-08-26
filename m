From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH v4 0/9] mmc: dw_mmc: add support for device tree based
 instantiation
Date: Sun, 26 Aug 2012 17:21:58 +0530
Message-ID: <1345981927-26359-1-git-send-email-thomas.abraham@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:20616 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471Ab2HZLeN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Aug 2012 07:34:13 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, jh80.chung@samsung.com, tgih.jun@samsung.com, patches@linaro.org

This is the fourth version of the patch series that adds device tree support
for Synopsis Designware Mobile Storage Host Controller. In this version, the
significant change is the spliting of Exynos specific code into a seperate
file, as suggested by Seungwon Jeon <tgih.jun@samsung.com>. Spliting the
Exynos specific code into a seperate file did infact keeps the core driver
code clean, which otherwise was littered with Exynos specific code. I hope
the changes look sane, though. This has been tested only on smdk5250 board.

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

 .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |   79 ++++++
 .../devicetree/bindings/mmc/synposis-dw-mshc.txt   |   90 ++++++
 drivers/mmc/host/Kconfig                           |    9 +
 drivers/mmc/host/Makefile                          |    3 +-
 drivers/mmc/host/dw_mmc-exynos.c                   |  247 +++++++++++++++++
 drivers/mmc/host/dw_mmc-pci.c                      |    2 +-
 drivers/mmc/host/dw_mmc-pltfm.c                    |   62 +++--
 drivers/mmc/host/dw_mmc-pltfm.h                    |   20 ++
 drivers/mmc/host/dw_mmc.c                          |  287 ++++++++++++++++----
 drivers/mmc/host/dw_mmc.h                          |   22 ++
 include/linux/mmc/dw_mmc.h                         |   13 +-
 11 files changed, 757 insertions(+), 77 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt
 create mode 100644 drivers/mmc/host/dw_mmc-exynos.c
 create mode 100644 drivers/mmc/host/dw_mmc-pltfm.h

