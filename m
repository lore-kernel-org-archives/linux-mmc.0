From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 0/4] mmc/sdhci: sdhci_set_bus_width() cleanup
Date: Wed, 09 Aug 2017 22:36:03 +0200
Message-ID: <cover.1502310654.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 78-11-180-123.static.ip.netia.com.pl ([78.11.180.123]:60468
        "EHLO rere.qmqm.pl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751958AbdHIUgG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Aug 2017 16:36:06 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ben Dooks <ben-linux@fluff.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org


Some SDHCI drivers are reimplementing sdhci_set_bus_width() just because
they support 8-bit bus but don't advertise full SDHCI 3.0 compliance.
This unnecessarily duplicates the function. Let's remove those duplicates.

Michał Mirosław (4):
  sdhci: key 8BITBUS bit off MMC_CAP_8_BIT_DATA
  mmc/sdhci-tegra: use generic sdhci_set_bus_width()
  mmc/sdhci-pci: use generic sdhci_set_bus_width()
  mmc/sdhci-s3c: use generic sdhci_set_bus_width()

 drivers/mmc/host/sdhci-pci-core.c | 30 +++---------------------------
 drivers/mmc/host/sdhci-s3c.c      | 34 +---------------------------------
 drivers/mmc/host/sdhci-tegra.c    | 23 ++---------------------
 drivers/mmc/host/sdhci.c          |  5 ++---
 4 files changed, 8 insertions(+), 84 deletions(-)

-- 
2.11.0

