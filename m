From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: fix some host driver defect
Date: Thu, 30 Jun 2016 10:00:57 +0800
Message-ID: <1467252061-3791-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>, Douglas Anderson <dianders@chromium.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>, Daniel Kurtz <djkurtz@chromium.org>, Wei-Ning Huang <wnhuang@chromium.org>
List-Id: linux-mmc@vger.kernel.org


Chaotian Jing (4):
  mmc: mediatek: do not tune data for HS400 mode
  mmc: mediatek: fix CRC error when calling mmc_select_hs400()
  mmc: mediatek: fix CMD21/CMD19 timeout issue
  mmc: mediatek: perfer to use rise edge latching

 drivers/mmc/host/mtk-sd.c | 70 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 56 insertions(+), 14 deletions(-)

-- 
1.8.1.1.dirty
