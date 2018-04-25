From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: mmc: mediatek: add 64G DRAM DMA support
Date: Wed, 25 Apr 2018 15:19:02 +0800
Message-ID: <1524640743-11732-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Phong LE <ple@baylibre.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Heiner Kallweit <hkallweit1@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>, yong mao <yong.mao@mediatek.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com
List-Id: linux-mmc@vger.kernel.org

Change vs V1:
	fix build warning of 32bit arch

Chaotian Jing (1):
  mmc: mediatek: add 64G DRAM DMA support

 drivers/mmc/host/mtk-sd.c | 56 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 49 insertions(+), 7 deletions(-)

-- 
1.8.1.1.dirty
