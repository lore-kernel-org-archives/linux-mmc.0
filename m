From: Ivan Mikhaylov <ivan@de.ibm.com>
Subject: [PATCH v1 2/2] 44x/fsp2: enable eMMC arasan for fsp2 platform
Date: Fri, 30 Jun 2017 14:53:31 +0300
Message-ID: <20170630115331.73869-3-ivan@de.ibm.com>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Alistair Popple <alistair@popple.id.au>, Matt Porter <mporter@kernel.crashing.org>, Adrian Hunter <adrian.hunter@intel.com>, Patrice Chotard <patrice.chotard@st.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: kernel@stlinux.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-mmc@vger.kernel.org

Add mmc0 changes for enabling arasan emmc and change
defconfig appropriately.

Signed-off-by: Ivan Mikhaylov <ivan@de.ibm.com>
---
 arch/powerpc/boot/dts/fsp2.dts          |   33 +++++++++++++++++-------------
 arch/powerpc/configs/44x/fsp2_defconfig |    2 +
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsp2.dts b/arch/powerpc/boot/dts/fsp2.dts
index 475953a..6a63026 100644
--- a/arch/powerpc/boot/dts/fsp2.dts
+++ b/arch/powerpc/boot/dts/fsp2.dts
@@ -52,6 +52,7 @@
 	clocks {
 		mmc_clk: mmc_clk {
 			compatible = "fixed-clock";
+			#clock-cells = <0>;
 			clock-frequency = <50000000>;
 			clock-output-names = "mmc_clk";
 		};
@@ -359,20 +360,6 @@
 		interrupts = <31 0x4 15 0x84>;
 	};
 
-	mmc0: sdhci@020c0000 {
-		compatible	= "st,sdhci-stih407", "st,sdhci";
-		status		= "disabled";
-		reg		= <0x020c0000 0x20000>;
-		reg-names	= "mmc";
-		interrupt-parent = <&UIC1_3>;
-		interrupts	= <21 0x4 22 0x4>;
-		interrupt-names	= "mmcirq";
-		pinctrl-names	= "default";
-		pinctrl-0	= <>;
-		clock-names	= "mmc";
-		clocks		= <&mmc_clk>;
-	};
-
 	plb6 {
 		compatible = "ibm,plb6";
 		#address-cells = <2>;
@@ -501,6 +488,24 @@
 					 /*RXDE*/  4 &UIC1_2 13 0x4>;
 		};
 
+		mmc0: sdhci@020c0000 {
+			compatible	= "st,sdhci-stih407", "st,sdhci";
+			reg		= <0x020c0000 0x20000>;
+			reg-names	= "mmc";
+			interrupts	= <21 0x4>;
+			interrupt-parent = <&UIC1_3>;
+			interrupt-names	= "mmcirq";
+			pinctrl-names	= "default";
+			pinctrl-0	= <>;
+			clock-names	= "mmc";
+			clocks		= <&mmc_clk>;
+			bus-width	= <4>;
+			non-removable;
+			sd-uhs-sdr50;
+			sd-uhs-sdr104;
+			sd-uhs-ddr50;
+		};
+
 		opb {
 			compatible = "ibm,opb";
 			#address-cells = <1>;
diff --git a/arch/powerpc/configs/44x/fsp2_defconfig b/arch/powerpc/configs/44x/fsp2_defconfig
index e8e6a69..935aabe 100644
--- a/arch/powerpc/configs/44x/fsp2_defconfig
+++ b/arch/powerpc/configs/44x/fsp2_defconfig
@@ -92,8 +92,10 @@ CONFIG_MMC_DEBUG=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_OF_ARASAN=y
+CONFIG_MMC_SDHCI_ST=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_M41T80=y
+CONFIG_RESET_CONTROLLER=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
-- 
1.7.1
