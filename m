From: NeilBrown <neil@brown.name>
Subject: [PATCH 0/4] mtk-sd enhancement to support MT7621 - V2
Date: Sat, 04 May 2019 20:24:56 +1000
Message-ID: <155696540998.8632.5242582397805128125.stgit@noble.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, thirtythreeforty@gmail.com
List-Id: linux-mmc@vger.kernel.org

The MT7621 MIPS-based SOC contains an sdhci unit that is
much the same as the units supported by mtk-sd.c.

These patches enhance the driver so that I can use it on my MT7621
board (gnubee.org).

This series have been revised based on feedback from Chaotian.

Thanks,
NeilBrown

---

NeilBrown (4):
      mmc: mtk-sd: don't hard-code interrupt trigger type
      mmc: mtk-sd: add support for config found in mt7620 family SOCs.
      mmc: mtk-sd: enable internal card-detect logic.
      mmc: mtk-sd: select REGULATOR


 Documentation/devicetree/bindings/mmc/mtk-sd.txt |    1 
 drivers/mmc/host/Kconfig                         |    1 
 drivers/mmc/host/mtk-sd.c                        |   78 +++++++++++++++++++++-
 3 files changed, 75 insertions(+), 5 deletions(-)

--
Signature
