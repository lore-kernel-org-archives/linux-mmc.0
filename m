From: Rajeshwari Shinde <rajeshwari.s@samsung.com>
Subject: [PATCH V3 0/3] ARM: SAMSUNG: Add support for sdhci clock lookup using
 generic names
Date: Wed, 12 Oct 2011 15:13:04 +0530
Message-ID: <1318412587-29987-1-git-send-email-rajeshwari.s@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:24230 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114Ab1JLJqr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Oct 2011 05:46:47 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: cjb@laptop.org, kgene.kim@samsung.com, linux-arm-kernel@lists.infradead.org

This patchset adds support for sdhci controller clock lookup using
generic names. With this patchset, there will be no need to pass clock
names in sdhci platform data.

This patchset depends on the patchset:
Add a common macro for creating struct clk_lookup entries.
mmc: sdhci-s3c: add default controller configuration.

V2 Changes:
- Added HCLK instance for HSMMC instance 1 as suggested by Heiko.
- Rebased on UART clkdev patches. So these patches should be applied
  after UART clkdev patches are applied.

V3 Changes:
- Removed double registration of hsmmc1 hclk from s3c2416 as suggested by
  Heiko

Rajeshwari Shinde (3):
  SDHCI: S3C: Use generic clock names for sdhci bus clock options
  ARM: SAMSUNG: Remove SDHCI bus clocks from platform data
  ARM: SAMSUNG: Add lookup of sdhci-s3c clocks using generic names

 arch/arm/mach-exynos4/Makefile             |    1 -
 arch/arm/mach-exynos4/clock.c              |   88 +++++++++------
 arch/arm/mach-exynos4/setup-sdhci.c        |   22 ----
 arch/arm/mach-s3c2416/Makefile             |    1 -
 arch/arm/mach-s3c2416/clock.c              |   68 ++++++-----
 arch/arm/mach-s3c2416/setup-sdhci.c        |   24 ----
 arch/arm/mach-s3c64xx/Makefile             |    1 -
 arch/arm/mach-s3c64xx/clock.c              |  126 +++++++++++++--------
 arch/arm/mach-s3c64xx/setup-sdhci.c        |   24 ----
 arch/arm/mach-s5pc100/Makefile             |    1 -
 arch/arm/mach-s5pc100/clock.c              |  130 +++++++++++++---------
 arch/arm/mach-s5pc100/setup-sdhci.c        |   23 ----
 arch/arm/mach-s5pv210/Makefile             |    1 -
 arch/arm/mach-s5pv210/clock.c              |  167 +++++++++++++++++-----------
 arch/arm/mach-s5pv210/setup-sdhci.c        |   22 ----
 arch/arm/plat-s3c24xx/s3c2443-clock.c      |   15 ++-
 arch/arm/plat-samsung/include/plat/sdhci.h |   31 -----
 drivers/mmc/host/sdhci-s3c.c               |    6 +-
 18 files changed, 361 insertions(+), 390 deletions(-)
 delete mode 100644 arch/arm/mach-exynos4/setup-sdhci.c
 delete mode 100644 arch/arm/mach-s3c2416/setup-sdhci.c
 delete mode 100644 arch/arm/mach-s3c64xx/setup-sdhci.c
 delete mode 100644 arch/arm/mach-s5pc100/setup-sdhci.c
 delete mode 100644 arch/arm/mach-s5pv210/setup-sdhci.c

-- 
1.7.4.4

