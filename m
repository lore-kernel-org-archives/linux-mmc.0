From: Manish Narani <manish.narani@xilinx.com>
Subject: [RFC PATCH 2/3] dt: bindings: Add SD tap value properties details
Date: Thu, 7 Jun 2018 17:41:39 +0530
Message-ID: <1528373500-24663-2-git-send-email-manish.narani@xilinx.com>
References: <1528373500-24663-1-git-send-email-manish.narani@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528373500-24663-1-git-send-email-manish.narani@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, mdf@kernel.org, stefan.krsmanovic@aggios.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, adrian.hunter@intel.com, michal.simek@xilinx.com, ulf.hansson@linaro.org
Cc: Manish Narani <manish.narani@xilinx.com>
List-Id: linux-mmc@vger.kernel.org

This patch adds details of SD tap value properties in device tree.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 .../devicetree/bindings/mmc/arasan,sdhci.txt       | 26 ++++++++++++++++++=
++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Docum=
entation/devicetree/bindings/mmc/arasan,sdhci.txt
index 60481bf..0e08877 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -15,6 +15,8 @@ Required Properties:
     - "arasan,sdhci-5.1": generic Arasan SDHCI 5.1 PHY
     - "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1": rk3399 eMMC PHY
       For this device it is strongly suggested to include arasan,soc-ctl-s=
yscon.
+    - "xlnx,zynqmp-8.9a": Xilinx ZynqMP Arasan SDHCI 8.9a PHY
+      For this device it is strongly suggested to include arasan,soc-ctl-s=
yscon.
   - reg: From mmc bindings: Register location and length.
   - clocks: From clock bindings: Handles to clock inputs.
   - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_a=
hb"
@@ -26,6 +28,30 @@ Required Properties for "arasan,sdhci-5.1":
   - phys: From PHY bindings: Phandle for the Generic PHY for arasan.
   - phy-names:  MUST be "phy_arasan".

+Required Properties for "xlnx,zynqmp-8.9a":
+  - xlnx,mio_bank: The value will be 0/1/2 depending on MIO bank selection=
.
+  - xlnx,device_id: Unique Id of the device, value will be 0/1.
+  - xlnx,itap_delay_sd_hsd: Input Tap Delay for SD HS.
+  - xlnx,itap_delay_sdr25: Input Tap Delay for SDR25.
+  - xlnx,itap_delay_sdr50: Input Tap Delay for SDR50.
+  - xlnx,itap_delay_sdr104_b0: Input Tap Delay for SDR104.
+  - xlnx,itap_delay_sdr104_b2: Input Tap Delay for SDR104.
+  - xlnx,itap_delay_sd_ddr50: Input Tap Delay for SD DDR50.
+  - xlnx,itap_delay_mmc_hsd: Input Tap Delay for MMC HS.
+  - xlnx,itap_delay_mmc_ddr50: Input Tap Delay for MMC DDR50.
+  - xlnx,itap_delay_mmc_hs200_b0: Input Tap Delay for MMC HS200.
+  - xlnx,itap_delay_mmc_hs200_b2: Input Tap Delay for MMC HS200.
+  - xlnx,otap_delay_sd_hsd: Output Tap Delay for SD HS.
+  - xlnx,otap_delay_sdr25: Output Tap Delay for SDR25.
+  - xlnx,otap_delay_sdr50: Output Tap Delay for SDR50.
+  - xlnx,otap_delay_sdr104_b0: Output Tap Delay for SDR104.
+  - xlnx,otap_delay_sdr104_b2: Output Tap Delay for SDR104.
+  - xlnx,otap_delay_sd_ddr50: Output Tap Delay for DDR50.
+  - xlnx,otap_delay_mmc_hsd: Output Tap Delay for MMC HS.
+  - xlnx,otap_delay_mmc_ddr50: Output Tap Delay for MMC DDR50.
+  - xlnx,otap_delay_mmc_hs200_b0: Output Tap Delay for MMC HS200.
+  - xlnx,otap_delay_mmc_hs200_b2: Output Tap Delay for MMC HS200.
+
 Optional Properties:
   - arasan,soc-ctl-syscon: A phandle to a syscon device (see ../mfd/syscon=
.txt)
     used to access core corecfg registers.  Offsets of registers in this
--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
