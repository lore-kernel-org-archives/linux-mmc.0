Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D853301718;
	Thu, 19 Mar 2026 14:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773929261; cv=none; b=oESEujy+6MQZ8EeYgzLmHvmmxLY6B2Q0HKm/IJPp4UsUfh4bXeSKBmTbLhPTd9mEBgUUFl8hcLyQ6yWbU33le5E7x8tI+Onev2rcM6OSekBj7KaPitL2imrVnaMsSQ8piGvLveyTJmsjSSj7aBXEQ8eW792eMeWikysTfJmN+5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773929261; c=relaxed/simple;
	bh=R108JaxFIhklAvq9VRB+xctTrTKodcsIFFZTurzB8so=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJivQeV2ZuAvGLoAIue04lg7PkyzF3mK1hWXi2rRfISZykzt0e97KEmtPFVHuNIKCHRV7iyJU2j7/aw/Dbior8CEtFfql7gR6/mBWer1yPhvo6gW9vCk0FJj9r/G/RNqJXBFfuWhMyuDHLHIfeg1HodMOtYMoK+n+59vIi91Kcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from duge-virtual-machine (unknown [183.192.222.244])
	by APP-03 (Coremail) with SMTP id rQCowABnieAaA7xpRC4mCw--.14810S5;
	Thu, 19 Mar 2026 22:07:26 +0800 (CST)
From: Jiayu Du <jiayu.riscv@isrc.iscas.ac.cn>
To: krzk@kernel.org,
	ulf.hansson@linaro.org,
	adrian.hunter@intel.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	gaohan@iscas.ac.cn,
	me@ziyao.cc,
	Jiayu Du <jiayu.riscv@isrc.iscas.ac.cn>,
	Junhui Liu <junhui.liu@pigmoral.tech>
Subject: [PATCH v5 3/3] riscv: dts: canaan: Add mmc nodes for K230
Date: Thu, 19 Mar 2026 22:07:05 +0800
Message-ID: <20260319140705.123502-4-jiayu.riscv@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319140705.123502-1-jiayu.riscv@isrc.iscas.ac.cn>
References: <20260319140705.123502-1-jiayu.riscv@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABnieAaA7xpRC4mCw--.14810S5
X-Coremail-Antispam: 1UD129KBjvJXoWxJw48Jw4UZw15uryUur13CFg_yoWrXFykp3
	9rCFZ3Kas2gr1S9ay2kry09rs3CF4kKr1FgwnIv347Kr4jqFWvkwn5Aw48XF1UXa1UA3y2
	g3yrJryI9r4qy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjTRM6wCDUUUU
X-CM-SenderInfo: 5mld534oul2uny6l223fol2u1dvotugofq/

Add MMC nodes to K230, including eMMC and SDIO. Enable HS200 eMMC
on the SoM and SDIO high-speed on the board.

Tested-by: Junhui Liu <junhui.liu@pigmoral.tech>
Signed-off-by: Jiayu Du <jiayu.riscv@isrc.iscas.ac.cn>
---
 .../boot/dts/canaan/k230-canmv-dshanpi.dts    | 57 +++++++++++++++++++
 .../dts/canaan/k230-canmv-module-dshanpi.dtsi |  7 +++
 arch/riscv/boot/dts/canaan/k230.dtsi          | 28 +++++++++
 3 files changed, 92 insertions(+)

diff --git a/arch/riscv/boot/dts/canaan/k230-canmv-dshanpi.dts b/arch/riscv/boot/dts/canaan/k230-canmv-dshanpi.dts
index 55197cfc25b4..21df4e01aca2 100644
--- a/arch/riscv/boot/dts/canaan/k230-canmv-dshanpi.dts
+++ b/arch/riscv/boot/dts/canaan/k230-canmv-dshanpi.dts
@@ -15,6 +15,8 @@ / {
 
 	aliases {
 		serial0 = &uart0;
+		mmc0 = &emmc;
+		mmc1 = &sdio;
 	};
 
 	chosen {
@@ -73,6 +75,61 @@ uart0-rxd-cfg {
 			input-schmitt-enable;
 		};
 	};
+
+	mmc1_pins: mmc1-pins {
+		mmc1-cmd-cfg {
+			pinmux = <K230_PINMUX(54, 2)>;
+			slew-rate = <0>;
+			drive-strength = <7>;
+			power-source = <K230_MSC_3V3>;
+			input-enable;
+			output-enable;
+			bias-pull-up;
+			input-schmitt-enable;
+		};
+
+		mmc1-clk-cfg {
+			pinmux = <K230_PINMUX(55, 2)>;
+			slew-rate = <0>;
+			drive-strength = <7>;
+			power-source = <K230_MSC_3V3>;
+			output-enable;
+			bias-disable;
+			input-schmitt-enable;
+		};
+
+		mmc1-data-cfg {
+			pinmux = <K230_PINMUX(56, 2)>, /* mmc1 data0 */
+				 <K230_PINMUX(57, 2)>, /* mmc1 data1 */
+				 <K230_PINMUX(58, 2)>, /* mmc1 data2 */
+				 <K230_PINMUX(59, 2)>; /* mmc1 data3 */
+			slew-rate = <0>;
+			drive-strength = <7>;
+			power-source = <K230_MSC_3V3>;
+			input-enable;
+			output-enable;
+			bias-pull-up;
+			input-schmitt-enable;
+		};
+	};
+};
+
+&emmc {
+	vmmc-supply = <&vdd_3v3>;
+	vqmmc-supply = <&vdd_1v8>;
+};
+
+&sdio {
+	bus-width = <4>;
+	max-frequency = <50000000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+	vmmc-supply = <&vdd_3v3>;
+	vqmmc-supply = <&vdd_3v3>;
+	broken-cd;
+	cap-sd-highspeed;
+	no-1-8-v;
+	status = "okay";
 };
 
 &uart0 {
diff --git a/arch/riscv/boot/dts/canaan/k230-canmv-module-dshanpi.dtsi b/arch/riscv/boot/dts/canaan/k230-canmv-module-dshanpi.dtsi
index 566665d39239..1db7569253fe 100644
--- a/arch/riscv/boot/dts/canaan/k230-canmv-module-dshanpi.dtsi
+++ b/arch/riscv/boot/dts/canaan/k230-canmv-module-dshanpi.dtsi
@@ -24,3 +24,10 @@ &sysclk {
 	clocks = <&osc24m>, <&timerx_pulse_in>;
 	clock-names = "osc24m", "timer-pulse-in";
 };
+
+&emmc {
+	bus-width = <8>;
+	max-frequency = <200000000>;
+	mmc-hs200-1_8v;
+	status = "okay";
+};
diff --git a/arch/riscv/boot/dts/canaan/k230.dtsi b/arch/riscv/boot/dts/canaan/k230.dtsi
index e1ec3e1f40a7..e3c6926dbadc 100644
--- a/arch/riscv/boot/dts/canaan/k230.dtsi
+++ b/arch/riscv/boot/dts/canaan/k230.dtsi
@@ -192,6 +192,34 @@ usb1: usb@91540000 {
 			status = "disabled";
 		};
 
+		emmc: mmc@91580000 {
+			compatible = "canaan,k230-emmc";
+			reg = <0x0 0x91580000 0x0 0x1000>;
+			clocks = <&sysclk K230_HS_SD0_CARD_GATE>,
+				 <&sysclk K230_HS_SD0_AHB_GATE>,
+				 <&sysclk K230_HS_SD0_AXI_GATE>,
+				 <&sysclk K230_HS_SD0_BASE_GATE>,
+				 <&sysclk K230_HS_SD0_TIMER_GATE>;
+			clock-names = "core", "bus", "axi", "block", "timer";
+			interrupts = <142 IRQ_TYPE_LEVEL_HIGH>;
+			canaan,usb-phy = <&usbphy>;
+			status = "disabled";
+		};
+
+		sdio: mmc@91581000 {
+			compatible = "canaan,k230-sdio";
+			reg = <0x0 0x91581000 0x0 0x1000>;
+			clocks = <&sysclk K230_HS_SD1_CARD_GATE>,
+				 <&sysclk K230_HS_SD1_AHB_GATE>,
+				 <&sysclk K230_HS_SD1_AXI_GATE>,
+				 <&sysclk K230_HS_SD1_BASE_GATE>,
+				 <&sysclk K230_HS_SD1_TIMER_GATE>;
+			clock-names = "core", "bus", "axi", "block", "timer";
+			interrupts = <144 IRQ_TYPE_LEVEL_HIGH>;
+			canaan,usb-phy = <&usbphy>;
+			status = "disabled";
+		};
+
 		usbphy: usb-phy@91585000 {
 			compatible = "canaan,k230-usb-phy";
 			reg = <0x0 0x91585000 0x0 0x400>;
-- 
2.53.0

