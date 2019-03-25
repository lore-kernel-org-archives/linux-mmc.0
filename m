From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] MAINTAINERS: Add section for MediaTek MMC/SD/SDIO driver
Date: Mon, 25 Mar 2019 13:24:42 +0100
Message-ID: <20190325122442.30644-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Cc: Chaotian Jing <chaotian.jing@mediatek.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e5a5d263f29..b43e563b4c95 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9775,6 +9775,12 @@ F:	drivers/media/platform/mtk-vpu/
 F:	Documentation/devicetree/bindings/media/mediatek-vcodec.txt
 F:	Documentation/devicetree/bindings/media/mediatek-vpu.txt
 
+MEDIATEK MMC/SD/SDIO DRIVER
+M:	Chaotian Jing <chaotian.jing@mediatek.com>
+S:	Maintained
+F:	drivers/mmc/host/mtk-sd.c
+F:	Documentation/devicetree/bindings/mmc/mtk-sd.txt
+
 MEDIATEK MT76 WIRELESS LAN DRIVER
 M:	Felix Fietkau <nbd@nbd.name>
 M:	Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
-- 
2.17.1
