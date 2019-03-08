From: <sean.wang@mediatek.com>
Subject: [PATCH v1 0/2] Bluetooth: mediatek: add support for MediaTek MT7663S and MT7668S SDIO devices
Date: Fri, 8 Mar 2019 09:15:42 +0800
Message-ID: <cover.1552007058.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: marcel@holtmann.org, johan.hedberg@gmail.com, ulf.hansson@linaro.org
Cc: linux-bluetooth@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

This adds the support of enabling MT7663S and MT7668S SDIO-based Bluetooth function.

patch 1: add MediaTek SDIO identifiers
patch 2: add support for MediaTek MT7663S and MT7668S SDIO devices

Sean Wang (2):
  mmc: add SDIO identifiers for MediaTek Bluetooth devices
  Bluetooth: mediatek: add support for MediaTek MT7663S and MT7668S SDIO
    devices

 drivers/bluetooth/Kconfig     |  11 +
 drivers/bluetooth/Makefile    |   1 +
 drivers/bluetooth/btmtksdio.c | 979 ++++++++++++++++++++++++++++++++++
 include/linux/mmc/sdio_ids.h  |   2 +
 4 files changed, 993 insertions(+)
 create mode 100644 drivers/bluetooth/btmtksdio.c

-- 
2.18.0
