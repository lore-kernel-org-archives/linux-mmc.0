From: Manish Narani <manish.narani@xilinx.com>
Subject: [RFC PATCH v2 0/4] Add support for SD Tap Delay setting for ZynqMP
Date: Thu, 20 Sep 2018 15:00:41 +0530
Message-ID: <1537435845-6682-1-git-send-email-manish.narani@xilinx.com>
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
To: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com, adrian.hunter@intel.com, manish.narani@xilinx.com, amit.kucheria@linaro.org, sudeep.holla@arm.com, leoyang.li@nxp.com, jollys@xilinx.com, rajanv@xilinx.com
Cc: devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

This series of patches are created On top of the
below series of patches.
1. https://lkml.org/lkml/2018/8/3/687 
2. https://lkml.org/lkml/2018/9/18/1034

As the ZynqMP Firmware Driver is not yet merged, sending RFC to make
modifications before sending the final patches.

Changes in v2:
- s/_/-/ in the property name
- Changed order of the patches : DT binding change -> driver change -> DT change

Manish Narani (4):
  dt: bindings: Add SD tap value properties details for
    'xlnx,zynqmp-8.9a'
  firmware: xilinx: Add macros and API for SD tap delays
  sdhci: arasan: Add support to read and set tap delays from DT for
    ZynqMP
  arm64: zynqmp: Add 'xlnx,mio-bank' property in SDHCI node

 .../devicetree/bindings/mmc/arasan,sdhci.txt       |  19 ++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |   2 +
 drivers/firmware/xilinx/Makefile                   |   1 +
 drivers/firmware/xilinx/zynqmp-tap-delays.c        |  39 ++++
 drivers/mmc/host/sdhci-of-arasan.c                 | 215 +++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h               |  33 +++-
 6 files changed, 308 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/xilinx/zynqmp-tap-delays.c

-- 
2.1.1
