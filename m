From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH v6 0/9] mmc: dw_mmc: add support for device tree based
 instantiation
Date: Mon, 17 Sep 2012 23:46:34 +0530
Message-ID: <1347905803-22742-1-git-send-email-thomas.abraham@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: will.newton@imgtec.com, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, jh80.chung@samsung.com, tgih.jun@samsung.com, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

This series add device tree support for Synopsis Designware IP - Mobile Storage
Host Controller (MSHC). I had addressed all comments for the v5 version of this
patch series and had reposted only those patches that were modified. The version
number of those reposted patches was maintained as v5 as the changes did not
need any major rework.

This is mainly a repost of the v5 patches with all patches marked as v6. The
only new change in this series is adding a comment about bus_hz in platform
data structure of the driver as suggested by Seungwon Jeon.

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

 .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |   87 ++++++
 .../devicetree/bindings/mmc/synposis-dw-mshc.txt   |   79 +++++
 drivers/mmc/host/Kconfig                           |    9 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/dw_mmc-exynos.c                   |  253 ++++++++++++++++
 drivers/mmc/host/dw_mmc-pci.c                      |    2 +-
 drivers/mmc/host/dw_mmc-pltfm.c                    |   60 +++--
 drivers/mmc/host/dw_mmc-pltfm.h                    |   20 ++
 drivers/mmc/host/dw_mmc.c                          |  308 +++++++++++++++++---
 drivers/mmc/host/dw_mmc.h                          |   24 ++
 include/linux/mmc/dw_mmc.h                         |   15 +-
 11 files changed, 782 insertions(+), 76 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt
 create mode 100644 drivers/mmc/host/dw_mmc-exynos.c
 create mode 100644 drivers/mmc/host/dw_mmc-pltfm.h
