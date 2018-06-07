From: Manish Narani <manish.narani@xilinx.com>
Subject: [RFC PATCH 1/3] arm64: zynqmp: dt: Add support for setting SD tap delays
Date: Thu, 7 Jun 2018 17:41:38 +0530
Message-ID: <1528373500-24663-1-git-send-email-manish.narani@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, mdf@kernel.org, stefan.krsmanovic@aggios.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, adrian.hunter@intel.com, michal.simek@xilinx.com, ulf.hansson@linaro.org
Cc: Manish Narani <manish.narani@xilinx.com>
List-Id: linux-mmc@vger.kernel.org

This patch adds support for setting SD tap delays from Device Tree.
Earlier, these tap values were made static via macros in the driver.
So changing the tap values in the device tree makes the driver free
from handling different tap values inside it.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 40 ++++++++++++++++++++++++++++++=
++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/x=
ilinx/zynqmp.dtsi
index a091e6f..696aac8 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -491,6 +491,26 @@
                        interrupts =3D <0 48 4>;
                        reg =3D <0x0 0xff160000 0x0 0x1000>;
                        clock-names =3D "clk_xin", "clk_ahb";
+                       xlnx,itap_delay_sd_hsd =3D <0x15>;
+                       xlnx,otap_delay_sd_hsd =3D <0x5>;
+                       xlnx,itap_delay_sdr25 =3D <0x15>;
+                       xlnx,otap_delay_sdr25 =3D <0x5>;
+                       xlnx,itap_delay_sdr50 =3D <0>;
+                       xlnx,otap_delay_sdr50 =3D <0x3>;
+                       xlnx,itap_delay_sd_ddr50 =3D <0x3D>;
+                       xlnx,otap_delay_sd_ddr50 =3D <0x4>;
+                       xlnx,itap_delay_mmc_hsd =3D <0x15>;
+                       xlnx,otap_delay_mmc_hsd =3D <0x6>;
+                       xlnx,itap_delay_mmc_ddr50 =3D <0x12>;
+                       xlnx,otap_delay_mmc_ddr50 =3D <0x6>;
+                       xlnx,itap_delay_sdr104_b0 =3D <0>;
+                       xlnx,otap_delay_sdr104_b0 =3D <0x3>;
+                       xlnx,itap_delay_sdr104_b2 =3D <0>;
+                       xlnx,otap_delay_sdr104_b2 =3D <0x2>;
+                       xlnx,itap_delay_mmc_hs200_b0 =3D <0>;
+                       xlnx,otap_delay_mmc_hs200_b0 =3D <0x3>;
+                       xlnx,itap_delay_mmc_hs200_b2 =3D <0>;
+                       xlnx,otap_delay_mmc_hs200_b2 =3D <0x2>;
                };

                sdhci1: sdhci@ff170000 {
@@ -500,6 +520,26 @@
                        interrupts =3D <0 49 4>;
                        reg =3D <0x0 0xff170000 0x0 0x1000>;
                        clock-names =3D "clk_xin", "clk_ahb";
+                       xlnx,itap_delay_sd_hsd =3D <0x15>;
+                       xlnx,otap_delay_sd_hsd =3D <0x5>;
+                       xlnx,itap_delay_sdr25 =3D <0x15>;
+                       xlnx,otap_delay_sdr25 =3D <0x5>;
+                       xlnx,itap_delay_sdr50 =3D <0>;
+                       xlnx,otap_delay_sdr50 =3D <0x3>;
+                       xlnx,itap_delay_sd_ddr50 =3D <0x3D>;
+                       xlnx,otap_delay_sd_ddr50 =3D <0x4>;
+                       xlnx,itap_delay_mmc_hsd =3D <0x15>;
+                       xlnx,otap_delay_mmc_hsd =3D <0x6>;
+                       xlnx,itap_delay_mmc_ddr50 =3D <0x12>;
+                       xlnx,otap_delay_mmc_ddr50 =3D <0x6>;
+                       xlnx,itap_delay_sdr104_b0 =3D <0>;
+                       xlnx,otap_delay_sdr104_b0 =3D <0x3>;
+                       xlnx,itap_delay_sdr104_b2 =3D <0>;
+                       xlnx,otap_delay_sdr104_b2 =3D <0x2>;
+                       xlnx,itap_delay_mmc_hs200_b0 =3D <0>;
+                       xlnx,otap_delay_mmc_hs200_b0 =3D <0x3>;
+                       xlnx,itap_delay_mmc_hs200_b2 =3D <0>;
+                       xlnx,otap_delay_mmc_hs200_b2 =3D <0x2>;
                };

                smmu: smmu@fd800000 {
--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
