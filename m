From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH 0/2] Move sdhci-s3c platform helper into driver
Date: Fri, 02 Sep 2011 20:48:20 +0530
Message-ID: <1314976702-19284-1-git-send-email-thomas.abraham@linaro.org>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: cjb@laptop.org, kgene.kim@samsung.com, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org
List-Id: linux-mmc@vger.kernel.org

The platform helper that sets up the default sdhci-s3c controller
configuration can be removed and moved into the sdhci-s3c driver.
This platform helper is removed for s3c2416, s3c64xx, s5pc100,
s5pv210 and Exynos4 platforms.

Since the platform helper function pointer was being passed in the
platform data of sdhci-s3c driver, the removal of this pointer from
the platform data is step closer to complete device tree support for
sdhci-s3c driver.

This patchset has been tested on the following platforms.
SMDK2416, SMDK6410, SMDKC100, SMDKV210 and SMDKV310.

Thomas Abraham (2):
  mmc: sdhci-s3c: add default controller configuration
  arm: samsung: remove sdhci default configuration setup platform helper

 arch/arm/mach-exynos4/setup-sdhci.c        |   47 -----------------------
 arch/arm/mach-s3c2416/setup-sdhci.c        |   37 ------------------
 arch/arm/mach-s3c64xx/setup-sdhci.c        |   48 -----------------------
 arch/arm/mach-s5pc100/setup-sdhci.c        |   42 --------------------
 arch/arm/mach-s5pv210/setup-sdhci.c        |   41 --------------------
 arch/arm/plat-samsung/dev-hsmmc.c          |    2 -
 arch/arm/plat-samsung/dev-hsmmc1.c         |    2 -
 arch/arm/plat-samsung/dev-hsmmc2.c         |    2 -
 arch/arm/plat-samsung/dev-hsmmc3.c         |    2 -
 arch/arm/plat-samsung/include/plat/sdhci.h |   57 ----------------------------
 drivers/mmc/host/sdhci-s3c.c               |   28 ++++++++-----
 11 files changed, 17 insertions(+), 291 deletions(-)
