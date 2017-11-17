From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 0/6] mmc: Handle platform_get_irq's error checking and return
Date: Sat, 18 Nov 2017 01:58:16 +0530
Message-ID: <1510950502-22565-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37958 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760158AbdKQU2e (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Nov 2017 15:28:34 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, carlo@caione.org, khilman@baylibre.com, ben-linux@fluff.org, adrian.hunter@intel.com, vireshk@kernel.org, maxime.ripard@free-electrons.com, wens@csie.org
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org

The platform_get_irq() function returns negative if an error occurs.
zero or positive number on success. platform_get_irq() error checking
for zero is not correct and and we must check its return value.

Arvind Yadav (6):
  [PATCH 1/6] mmc: meson-gx-mmc: Fix platform_get_irq's error checking
  [PATCH 2/6] mmc: s3cmci: Fix platform_get_irq's error checking
  [PATCH 3/6] mmc: sdhci-acpi: Handle return value of platform_get_irq
  [PATCH 4/6] mmc: sdhci-spear: Handle return value of platform_get_irq
  [PATCH 5/6] mmc: sh_mmcif: Handle return value of platform_get_irq
  [PATCH 6/6] mmc: sunxi-mmc: Handle return value of platform_get_irq

 drivers/mmc/host/meson-gx-mmc.c | 4 ++--
 drivers/mmc/host/s3cmci.c       | 4 ++--
 drivers/mmc/host/sdhci-acpi.c   | 4 ++++
 drivers/mmc/host/sdhci-spear.c  | 4 ++++
 drivers/mmc/host/sh_mmcif.c     | 2 +-
 drivers/mmc/host/sunxi-mmc.c    | 5 +++++
 6 files changed, 18 insertions(+), 5 deletions(-)

-- 
2.7.4

