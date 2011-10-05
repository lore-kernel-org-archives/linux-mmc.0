From: Rajeshwari Shinde <rajeshwari.s@samsung.com>
Subject: [PATCH 0/3] ARM: SAMSUNG: Add support for sdhci clock lookup using
 generic names
Date: Wed, 05 Oct 2011 11:01:06 +0530
Message-ID: <1317792669-19925-1-git-send-email-rajeshwari.s@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: cjb@laptop.org, kgene.kim@samsung.com, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org
List-Id: linux-mmc@vger.kernel.org

This patchset adds support for sdhci controller clock lookup using
generic names. With this patchset, there will be no need to pass clock
names in sdhci platform data.

This patchset depends on two other patchsets:
mmc: sdhci-s3c: Remove 'clk_type' member from platform data
Add a common macro for creating struct clk_lookup entries

Rajeshwari Shinde (3):
  SDHCI: S3C: Use generic clock names for sdhci bus clock options
  ARM: SAMSUNG: Remove SDHCI bus clocks from platform data
  ARM: SAMSUNG: Add lookup of sdhci-s3c clocks using generic names

 arch/arm/mach-exynos4/Makefile             |    1 -
 arch/arm/mach-exynos4/clock.c              |   99 ++++++++++------
 arch/arm/mach-exynos4/setup-sdhci.c        |   22 ----
 arch/arm/mach-s3c2416/Makefile             |    1 -
 arch/arm/mach-s3c2416/clock.c              |   68 ++++++-----
 arch/arm/mach-s3c2416/setup-sdhci.c        |   24 ----
 arch/arm/mach-s3c64xx/Makefile             |    1 -
 arch/arm/mach-s3c64xx/clock.c              |  138 ++++++++++++++--------
 arch/arm/mach-s3c64xx/setup-sdhci.c        |   24 ----
 arch/arm/mach-s5pc100/Makefile             |    1 -
 arch/arm/mach-s5pc100/clock.c              |  141 ++++++++++++++--------
 arch/arm/mach-s5pc100/setup-sdhci.c        |   23 ----
 arch/arm/mach-s5pv210/Makefile             |    1 -
 arch/arm/mach-s5pv210/clock.c              |  177 ++++++++++++++++++----------
 arch/arm/mach-s5pv210/setup-sdhci.c        |   22 ----
 arch/arm/plat-samsung/include/plat/sdhci.h |   31 -----
 drivers/mmc/host/sdhci-s3c.c               |    6 +-
 17 files changed, 393 insertions(+), 387 deletions(-)
 delete mode 100644 arch/arm/mach-exynos4/setup-sdhci.c
 delete mode 100644 arch/arm/mach-s3c2416/setup-sdhci.c
 delete mode 100644 arch/arm/mach-s3c64xx/setup-sdhci.c
 delete mode 100644 arch/arm/mach-s5pc100/setup-sdhci.c
 delete mode 100644 arch/arm/mach-s5pv210/setup-sdhci.c
