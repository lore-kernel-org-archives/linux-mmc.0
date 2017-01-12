From: Yong Mao <yong.mao@mediatek.com>
Subject: [PATCH 0/2] Use data tune for CMD line tune
Date: Thu, 12 Jan 2017 18:04:48 +0800
Message-ID: <1484215490-7494-1-git-send-email-yong.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com, Javier Martinez Canillas <javier@osg.samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Douglas Anderson <dianders@chromium.org>, yong mao <yong.mao@mediatek.com>, linux-kernel@vger.kernel.org, Chunfeng Yun <chunfeng.yun@mediatek.com>, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Philipp Zabel <p.zabel@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthias Brugger <matthias.bgg@gmail.com>, linux-mmc@vger.kernel.org, Eddie Huang <eddie.huang@mediatek.com>, Chaotian Jing <chaotian.jing@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

CMD response CRC error may cause cannot boot up
Change to use data tune for CMD line
Separate cmd internal delay for HS200/HS400 mode

yong mao (2):
  mmc: mediatek: Use data tune for CMD line tune
  mmc: dt-bindings: update Mediatek MMC bindings

 Documentation/devicetree/bindings/mmc/mtk-sd.txt |   6 +
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts      |   3 +
 drivers/mmc/host/mtk-sd.c                        | 169 ++++++++++++++++++++---
 3 files changed, 155 insertions(+), 23 deletions(-)

-- 
1.8.1.1
