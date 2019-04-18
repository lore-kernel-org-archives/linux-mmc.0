From: <sean.wang@mediatek.com>
Subject: [PATCH v1 0/4] Add a couple of enhancements to btmtksdio
Date: Thu, 18 Apr 2019 17:07:58 +0800
Message-ID: <cover.1555577565.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: marcel@holtmann.org, johan.hedberg@gmail.com
Cc: ulf.hansson@linaro.org, linux-bluetooth@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

First three are all minor changes and the final one adds a runtime pm support to
enter a lower power state for decreasing power dissipation when there is idle
traffic in SDIO transport for a while.

Sean Wang (4):
  Bluetooth: btmtksdio: Drop newline with bt_dev logging macros
  Bluetooth: btmtksdio: Add a bit definition for CHLPCR
  Bluetooth: btmtksdio: Fix hdev->stat.byte_rx accumulation
  Bluetooth: btmtksdio: Add runtime PM support to SDIO based Bluetooth

 drivers/bluetooth/btmtksdio.c | 161 ++++++++++++++++++++++++++++++++--
 1 file changed, 153 insertions(+), 8 deletions(-)

-- 
2.18.0
