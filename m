From: Chunyan Zhang <zhang.chunyan@linaro.org>
Subject: [PATCH 0/3] mmc: add support for sdhci 4.0
Date: Tue, 20 Mar 2018 16:36:23 +0800
Message-ID: <1521534986-21907-1-git-send-email-zhang.chunyan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Billows Wu <billows.wu@spreadtrum.com>, Chunyan Zhang <zhang.lyra@gmail.com>
List-Id: linux-mmc@vger.kernel.org

>From the SD host controller version 4.0 on, SDHCI implementation either
is version 3 compatible or version 4 mode. This patch-set covers those
changes which are common for SDHCI 4.0 version, regardless of whether
they are used with SD or eMMC storage devices.

Chunyan Zhang (3):
  mmc: sdhci: add sd host v4 mode
  mmc: sdhci: made changes for System Address register of SDMA
  mmc: sdhci: add ADMA2 64-bit addressing support for V4 mode

 drivers/mmc/host/sdhci.c | 66 +++++++++++++++++++++++++++++++++++++-----------
 drivers/mmc/host/sdhci.h | 29 +++++++++++++++++----
 2 files changed, 75 insertions(+), 20 deletions(-)

-- 
2.7.4
