From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH v2 0/2] Move sdhci-s3c platform helper into driver
Date: Wed, 14 Sep 2011 12:39:16 +0530
Message-ID: <1315984158-29651-1-git-send-email-thomas.abraham@linaro.org>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: cjb@laptop.org, kgene.kim@samsung.com, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org
List-Id: linux-mmc@vger.kernel.org

Changes since v1:
- Rebased with 'for-next' branch of
  http://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
  (tested with commit id a08b7e19811181309da2306338027fe1d3f8001d at the
  tip of the for-next branch, not sure if there have been further
  commits after that).

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
