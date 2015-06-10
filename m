From: Haibo Chen <haibo.chen@freescale.com>
Subject: [PATCH 0/6] mmc: imx: a few fixes and new feature add
Date: Wed, 10 Jun 2015 16:50:38 +0800
Message-ID: <1433926244-29244-1-git-send-email-haibo.chen@freescale.com>
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
Cc: aisheng.dong@freescale.com, ulf.hansson@linaro.org, haibo.chen@freescale.com, chris@printf.net, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Patch 1 add imx7d support, and also HS400 mode support.
Patch 2 add tuning-step, which can be get from dts.
Patch 3 add eMMC5.0 support for imx7d in dts.
Patch 4~6 small fixes.

Haibo Chen (6):
  mmc: sdhci-esdhc-imx: add imx7d support and support HS400
  mmc: sdhci-esdhc-imx: add tuning-step seting support
  ARM: dts: imx7d-sdb: add eMMC5.0 support
  mmc: sdhci-esdhc-imx: config watermater levles and burst lengths
  mmc: sdhci-esdhc-imx: set back the burst_length_enable bit to 1
  mmc: sdhci-esdhc-imx: add compatible string in binding doc

 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |  1 +
 arch/arm/boot/dts/imx7d-sdb.dts                    | 13 +++
 drivers/mmc/host/sdhci-esdhc-imx.c                 | 97 +++++++++++++++++++++-
 include/linux/platform_data/mmc-esdhc-imx.h        |  1 +
 4 files changed, 111 insertions(+), 1 deletion(-)

-- 
1.9.1
