From: <sean.wang@mediatek.com>
Subject: [PATCH v1 1/2] mmc: add SDIO identifiers for MediaTek Bluetooth devices
Date: Fri, 8 Mar 2019 09:15:43 +0800
Message-ID: <97d7949c00bd78f8ec282fb9cd380ad161244616.1552007059.git.sean.wang@mediatek.com>
References: <cover.1552007058.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1552007058.git.sean.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: marcel@holtmann.org, johan.hedberg@gmail.com, ulf.hansson@linaro.org
Cc: linux-bluetooth@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

The SDIO identifier for MediaTek Bluetooth devices were defined in the
MediaTek Bluetooth driver. Moving the definitions in MMC header file
seems common sense.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 include/linux/mmc/sdio_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 4332199c71c2..d1a5d5df02f5 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -59,6 +59,8 @@
 #define SDIO_DEVICE_ID_MARVELL_8797_F0		0x9128
 #define SDIO_DEVICE_ID_MARVELL_8887WLAN	0x9134
 
+#define SDIO_VENDOR_ID_MEDIATEK			0x037a
+
 #define SDIO_VENDOR_ID_SIANO			0x039a
 #define SDIO_DEVICE_ID_SIANO_NOVA_B0		0x0201
 #define SDIO_DEVICE_ID_SIANO_NICE		0x0202
-- 
2.18.0
