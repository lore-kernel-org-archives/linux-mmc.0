From: "Steven J. Hill" <steven.hill@cavium.com>
Subject: [PATCH 0/4] MMC support for Octeon platforms.
Date: Mon, 24 Apr 2017 13:41:54 -0500
Message-ID: <1493059318-767-1-git-send-email-steven.hill@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2nam03on0042.outbound.protection.outlook.com ([104.47.42.42]:48489
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S972590AbdDXSoQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 24 Apr 2017 14:44:16 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: David Daney <david.daney@cavium.com>, Jan Glauber <jglauber@cavium.com>, linux-mmc@vger.kernel.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org

From: "Steven J. Hill" <Steven.Hill@cavium.com>

Enable MMC support on Octeon SoCs. Tested on EdgeRouter Pro,
SFF7000, and SFF7800 platforms. This should be applied on top
of the "Cavium MMC driver" patch series from Jan Glauber.

Steven J. Hill (3):
  mmc: cavium: Fix detection of block or byte addressing.
  mmc: cavium: Add MMC support for Octeon SOCs.
  MIPS: Octeon: cavium_octeon_defconfig: Enable Octeon MMC

Ulf Hansson (1):
  mmc: core: Export API to allow hosts to get the card address

 arch/mips/configs/cavium_octeon_defconfig |   5 +
 drivers/mmc/core/core.c                   |   6 +
 drivers/mmc/host/Kconfig                  |  10 +
 drivers/mmc/host/Makefile                 |   2 +
 drivers/mmc/host/cavium-octeon.c          | 351 ++++++++++++++++++++++++++++++
 drivers/mmc/host/cavium.c                 |   2 +-
 include/linux/mmc/card.h                  |   2 +
 7 files changed, 377 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mmc/host/cavium-octeon.c

-- 
2.1.4

