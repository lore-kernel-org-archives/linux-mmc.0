From: Dong Aisheng <aisheng.dong@freescale.com>
Subject: [PATCH 0/5] dts: imx: fix sd card gpio polarity specified in device
 tree
Date: Thu, 18 Jun 2015 01:33:33 +0800
Message-ID: <1434562418-24090-1-git-send-email-aisheng.dong@freescale.com>
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
To: linux-mmc@vger.kernel.org
Cc: fabio.estevam@freescale.com, marex@denx.de, ulf.hansson@linaro.org, s.trumtrar@pengutronix.de, smoch@web.de, linux-arm-kernel@lists.infradead.org, robertcnelson@gmail.com, s.hauer@pengutronix.de, chris@printf.net, rabeeh@solid-run.com, troy.kisky@boundarydevices.com, lisovy@gmail.com, hs@denx.de, gwenhael.goavec-merou@armadeus.com, p.zabel@pengutronix.de, rmk+kernel@arm.linux.org.uk, shawn.guo@linaro.org, b29396@freescale.com, tharvey@gateworks.com, LW@KARO-electronics.de, ipaton0@gmail.com
List-Id: linux-mmc@vger.kernel.org

Commit 8d86e4f mmc: sdhci-esdhc-imx: Call mmc_of_parse()
serious break the sd card detect/write protect function
since a lot of GPIO flags of cd-gpios/wp-gpios are wrongly set
in devicetree.
Before commit 8d86e4f, we do not use GPIO flags passed from
devicetree. But after it, GPIO flags specfied in dt becomes valid
and will affect the normal cd/wp function.

This patch series fixes all wrongly set GPIO flags in devicetree.

Because the eSDHC/uSDHC host driver only supports
MMC_CAP2_RO_ACTIVE_HIGH and no MMC_CAP2_CD_ACTIVE_HIGH,
so i changed the dts accordingly.

It is supposed to not cause any function break since all boards
affected work well before commit 8d86e4f with this type of CAPs.

However, i still CCed each board maintainer affected by this change,
Please help review and let me know if any wrong change.

The series is based on shawn/for-next tree.

Fixes: 8d86e4fcccf6 ("mmc: sdhci-esdhc-imx: Call mmc_of_parse()")

Dong Aisheng (5):
  dts: imx51: fix sd card gpio polarity specified in device tree
  dts: imx53: fix sd card gpio polarity specified in device tree
  dts: imx6: fix sd card gpio polarity specified in device tree
  dts: imx25: fix sd card gpio polarity specified in device tree
  dts: imx7: fix sd card gpio polarity specified in device tree

 arch/arm/boot/dts/imx25-pdk.dts              |  4 ++--
 arch/arm/boot/dts/imx51-apf51dev.dts         |  2 +-
 arch/arm/boot/dts/imx53-ard.dts              |  4 ++--
 arch/arm/boot/dts/imx53-m53evk.dts           |  4 ++--
 arch/arm/boot/dts/imx53-qsb-common.dtsi      |  4 ++--
 arch/arm/boot/dts/imx53-smd.dts              |  4 ++--
 arch/arm/boot/dts/imx53-tqma53.dtsi          |  4 ++--
 arch/arm/boot/dts/imx53-tx53.dtsi            |  4 ++--
 arch/arm/boot/dts/imx53-voipac-bsb.dts       |  4 ++--
 arch/arm/boot/dts/imx6dl-riotboard.dts       |  8 ++++----
 arch/arm/boot/dts/imx6q-arm2.dts             |  5 +++--
 arch/arm/boot/dts/imx6q-gk802.dts            |  3 ++-
 arch/arm/boot/dts/imx6q-tbs2910.dts          |  4 ++--
 arch/arm/boot/dts/imx6qdl-aristainetos.dtsi  |  4 ++--
 arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi |  4 ++--
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi       |  2 +-
 arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi |  4 +++-
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi        |  2 +-
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi        |  2 +-
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi        |  2 +-
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi  |  2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi    |  4 ++--
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi |  8 ++++----
 arch/arm/boot/dts/imx6qdl-rex.dtsi           |  4 ++--
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi     |  4 ++--
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi     |  6 +++---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi       |  8 ++++----
 arch/arm/boot/dts/imx6qdl-tx6.dtsi           |  4 ++--
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi     |  6 ++++--
 arch/arm/boot/dts/imx6sl-evk.dts             | 10 +++++-----
 arch/arm/boot/dts/imx6sx-sabreauto.dts       |  4 ++--
 arch/arm/boot/dts/imx6sx-sdb.dtsi            |  4 ++--
 arch/arm/boot/dts/imx7d-sdb.dts              |  4 ++--
 33 files changed, 74 insertions(+), 68 deletions(-)

-- 
1.9.1
