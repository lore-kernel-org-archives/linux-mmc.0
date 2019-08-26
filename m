From: Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH 0/5] a few fixes for sprd's sd host controller
Date: Mon, 26 Aug 2019 11:18:25 +0800
Message-ID: <20190826031830.30931-1-zhang.lyra@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>
List-Id: linux-mmc@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

With this patch-set, both sd card and mmc can be setup.  This patch-set was
verified on Unisoc's Whale2 and another mobile phone platform SC9863A.

Chunyan Zhang (5):
  mmc: sdhci-sprd: fixed incorrect clock divider
  mmc: sdhci: sprd: add get_ro hook function
  mmc: sdhci: sprd: add SDHCI_QUIRK2_PRESET_VALUE_BROKEN
  mms: sdhci: sprd: add SDHCI_QUIRK_BROKEN_CARD_DETECTION
  mmc: sdhci: sprd: clear the UHS-I modes read from registers

 drivers/mmc/host/sdhci-sprd.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

-- 
2.20.1
