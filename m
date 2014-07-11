From: Georgi Djakov <gdjakov@mm-sol.com>
Subject: [PATCH 0/3] mmc: sdhci-msm: Minor fixes and cleanups
Date: Fri, 11 Jul 2014 20:48:10 +0300
Message-ID: <1405100893-32107-1-git-send-email-gdjakov@mm-sol.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Georgi Djakov <gdjakov@mm-sol.com>
List-Id: linux-mmc@vger.kernel.org

This patchset contains fixes in the documentation, cleanups
and enables COMPILE_TEST for better testing coverage.

Georgi Djakov (3):
  mmc: sdhci-msm: Fix the binding example
  mmc: sdhci-msm: Remove unnecessary header file inclusion
  mmc: sdhci-msm: Get COMPILE_TEST support

 .../devicetree/bindings/mmc/sdhci-msm.txt          |    8 ++++----
 drivers/mmc/host/Kconfig                           |    2 +-
 drivers/mmc/host/sdhci-msm.c                       |    1 -
 3 files changed, 5 insertions(+), 6 deletions(-)

-- 
1.7.9.5
