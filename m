From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: mmc: mediatek: add 64G DRAM DMA support
Date: Mon, 23 Apr 2018 17:26:49 +0800
Message-ID: <1524475610-22079-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Phong LE <ple@baylibre.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Heiner Kallweit <hkallweit1@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>, yong mao <yong.mao@mediatek.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com
List-Id: linux-mmc@vger.kernel.org


Chaotian Jing (1):
  mmc: mediatek: add 64G DRAM DMA support

 drivers/mmc/host/mtk-sd.c | 44 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

-- 
1.8.1.1.dirty
