From: <sean.wang@mediatek.com>
Subject: [PATCH v1 0/3] add module_sdio_driver and enable a few users
Date: Thu, 14 Mar 2019 05:01:57 +0800
Message-ID: <cover.1552510141.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: marcel@holtmann.org, johan.hedberg@gmail.com, ulf.hansson@linaro.org
Cc: linux-bluetooth@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add module_sdio_driver exactly like the function module_usb_drivear offers to
and enable a few users to eliminate a few lines of boilerplate code per SDIO
driver.

Sean Wang (3):
  mmc: sdio: Add helper macro for sdio_driver boilerplate
  Bluetooth: mediatek: Use module_sdio_driver helper
  Bluetooth: btsdio: Use module_sdio_driver helper

 drivers/bluetooth/btmtksdio.c | 15 +--------------
 drivers/bluetooth/btsdio.c    | 15 +--------------
 include/linux/mmc/sdio_func.h | 12 ++++++++++++
 3 files changed, 14 insertions(+), 28 deletions(-)

-- 
2.18.0
