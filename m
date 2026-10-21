Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792599179;
	b=HW4oofArLh32j7RgefGtGYhk9VqXA9tbz7KXk5GsFr/Aphj9l0quQnxakSCa+nwdCx5z
	 1GZis1awxOluu9JKZc0D6IW1Juo+RN3LpAlfUkY72uVfccfysqI9QrdbYZ8yN6Sdc7SCQ
	 X1/vZn7ROmHadBTDWhtnDPAk2nl/FfdH49kosonvFN5mgLDNHnktLjT9S5jo2EzBlgG1b
	 BBXqkM9PtH1ORv+Pymm+VeXZF/VjoPzrQYrGj+yS0Z6AMaimdyXi2iyb0ZdN51lnRgC89
	 nO6GRyZQjx7RPG1bxyz5hVI5CNRPPc/0SaCB9yiPq16Yn1upBowGJfVqLXJ6hDHLnEw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599179;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=mU+ZJ6bdJY00yNid6WD/x4CcVJmOkjk6bjWXStTXRjs=;
	b=vt29NXmCm57Zxs5Ya/2I9hvcfF1eLQ4KaU4vqlzot98ZJSCOsd5aBEGVq7aqqlWHUr+v
	 FNBH3Ru2cfeDMG34GwrkKUU7u8ZDNALivtzDwucMog8buG636gmzsB6xioYe+I/AQSRuI
	 H/Dw9vQdvyyqFPQxnfk2UaJGW24da34nFrlOv8awkpanXzbk5ngycQ6J7kPElg1ohtpzl
	 Xib9qYmixIVo+fqeR2E6BYQH8JLFvRTZSUe+vivXgRrY1/0qDsQTCBUnigwxGU9MKPPgy
	 tbSJDe+0QkW/6iS9Xcng61KSwgcipmiP5zBCD2rb7yBDXOx1Ud47llQy6YITJoNx0KQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CGVXLq7n;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD11B6072B36;
	Wed, 21 Oct 2026 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CGVXLq7n
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792599178;
	b=H2KBRH0jdeurfwmnClkpBcQfkuc0Nfk82p5OZtVJMZfDkVO2OednVVLZ2Ic/diN3jrGl
	 W5qlwbH91jqGjJdbPDgcO/A/9f82wTkAbJh/mIEZCG3URhzaVQbXZXrhGMVlrsqeYKxku
	 lNkvdi4M7m7yAXDFslzt9OK86UlawC+nJDdZU9nwLCnvNODkmnJuH5QD01YsWYcFIoRv5
	 HlC/gNKMzyc/7gy85YVzNNOk16mYx4tF+KStQ3EQwy0Z9H7l+Nb3IsZjPJw4+ib8/PdW7
	 y/3XSIpxcOL9F6O55qRVa/v2rWGzJ0nepJKnKLdJkZMzYyjWFyA3juDrHsB9MdegvSg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599178;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=mU+ZJ6bdJY00yNid6WD/x4CcVJmOkjk6bjWXStTXRjs=;
	b=vl05iI2h5ZebzxVPv0T4oWVcOHtZwGJgBzQyM/BEY7u+mzsQGKWKHiqjfbeGMspXQNHX
	 0wx0+3cHoQNyOG3mVSc8BuaX1w1klncXduHOkC6JIoCLpOwc5mF8i3m4nHH6r8BXXZaNR
	 wQdF/MqIQZy1DrU8EAjD/uCXzOLtVIa5o5vnlPZ5Z/FTzz3VI/IXRsUDE3dlXHZL4nJzT
	 65QxBcAMjyIO7ddvchjeMf3Z6vc1wf++3LEo5sdPqcvuHjhd2oNzc39tGXyjKUWrpjDbh
	 Dpb2JRfocz29R9JS/pONkRGJBlBWwIBBLMCFUIhAeSLMuURmpiF7Wq9rn20Rgnp3V2Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8CAB51F02818;
	Wed, 21 Oct 2026 16:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792599178;
	bh=mU+ZJ6bdJY00yNid6WD/x4CcVJmOkjk6bjWXStTXRjs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=CGVXLq7nJAoRsQ/8+RMQmWQo/PK5w0+pI88/4KV0ciqAzxHrad13lOXbNYOsHwMRB
	 rcXFQx5PYhndx6ocJM9RCX5RPJOvfoaHPkdniTlJxbOMjSieXVoDfbQsscywEEMMxY
	 b7s/q+bFNb69GHM82ACsJdnsXjFLOIOmjdm6+9G6FcwtXx91qCnfgMKFZ/fNsYFD53
	 DudBA4C92ctJoq+Tf00B2wUmUMGQEU/iUdu7xqVV5+oEWmJ31PloHu2qLcO4qSM3a3
	 0+rTYwGRAZS8kUqY/vWyt24pefw80dv0vg6Irpd4hW+WNG8mJypZe/cYExvNu8FQAU
	 BBO5SsyOAWtmg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id ED7544340D;
	Wed, 21 Oct 2026 16:12:23 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Thu, 22 Oct 2026 00:11:24 +0800
Subject: [PATCH 27/27] arm64: dts: rockchip: Add initial support for
 Forlinx OK3572-C
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261022-add-board-ok3572-c-v1-27-0b0fd85a31ee@qq.com>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
In-Reply-To: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Lee Jones <lee@kernel.org>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, Ulf Hansson <ulfh@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Wu <david.wu@rock-chips.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>
Cc: Cunhao Lu <1579567540@qq.com>, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 mfd@lists.linux.dev, linux-gpio@vger.kernel.org, netdev@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-mmc@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-phy@lists.infradead.org, 
 linux-usb@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792599138; l=17255;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=wegpf4+/6fWlUcMz3SbXhVxhPt+HaLtfWjEQb+t6S0E=;
 b=BjDqEW7HgjKW2N7CulXPP3bnJ7tJNOv/mL6Kzow0zBKY/GF9HQ+vqSejln/4VFAEgYy7alRP9
 4l1ujdyIQM/CoHGApHcbY/TFy4YZ7txPw6NT8BBVdZhqk5ayT86XoIz
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

Describe the OK3572-C carrier board and FET3572-C system-on-module.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 arch/arm64/boot/dts/rockchip/Makefile              |   1 +
 .../dts/rockchip/rk3572-forlinx-fet3572-c.dtsi     | 369 +++++++++++++++++++++
 .../boot/dts/rockchip/rk3572-forlinx-ok3572-c.dts  | 286 ++++++++++++++++
 3 files changed, 656 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index e7936a21c118..d028e9cccceb 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -168,6 +168,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-rock-3b.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5-display-vz.dtbo
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5-io-expander.dtbo
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3572-forlinx-ok3572-c.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-100ask-dshanpi-a1.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-anbernic-rg-vita-pro.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-armsom-cm5-io.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3572-forlinx-fet3572-c.dtsi b/arch/arm64/boot/dts/rockchip/rk3572-forlinx-fet3572-c.dtsi
new file mode 100644
index 000000000000..d9a662aef6ad
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3572-forlinx-fet3572-c.dtsi
@@ -0,0 +1,369 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2025 Forlinx Embedded Tech. Co., Ltd
+ * Copyright (c) 2026 Cunhao Lu <1579567540@qq.com>
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/rockchip.h>
+#include "rk3572.dtsi"
+#include "rk3572-opp.dtsi"
+
+/ {
+	compatible = "forlinx,fet3572-c", "rockchip,rk3572";
+
+	vcc5v0_sys_s5: regulator-vcc5v0-sys-s5 {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "vcc5v0_sys_s5";
+	};
+
+	vcc_ldo_s3: regulator-vcc-ldo-s3 {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-max-microvolt = <2100000>;
+		regulator-min-microvolt = <2100000>;
+		regulator-name = "vcc_ldo_s3";
+	};
+};
+
+&cpu_b0 {
+	cpu-supply = <&vdd_cpu_big_s0>;
+};
+
+&cpu_l0 {
+	cpu-supply = <&vdd_cpu_lit_s0>;
+};
+
+&cpu_l4 {
+	cpu-supply = <&vdd_cpu_lit_s0>;
+};
+
+&i2c0 {
+	clock-frequency = <400000>;
+
+	status = "okay";
+
+	rk806: pmic@23 {
+		compatible = "rockchip,rk806";
+		reg = <0x23>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA6 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-0 = <&pmic_int>;
+		pinctrl-names = "default";
+		system-power-controller;
+		vcc1-supply = <&vcc5v0_sys_s5>;
+		vcc2-supply = <&vcc5v0_sys_s5>;
+		vcc3-supply = <&vcc5v0_sys_s5>;
+		vcc4-supply = <&vcc5v0_sys_s5>;
+		vcc5-supply = <&vcc5v0_sys_s5>;
+		vcc6-supply = <&vcc5v0_sys_s5>;
+		vcc7-supply = <&vcc5v0_sys_s5>;
+		vcc8-supply = <&vcc5v0_sys_s5>;
+		vcc9-supply = <&vcc5v0_sys_s5>;
+		vcc10-supply = <&vcc5v0_sys_s5>;
+		vcc11-supply = <&vcc_ldo_s3>;
+		vcc12-supply = <&vcc5v0_sys_s5>;
+		vcc13-supply = <&vcc_ldo_s3>;
+		vcc14-supply = <&vcc_ldo_s3>;
+		vcca-supply = <&vcc5v0_sys_s5>;
+
+		regulators {
+			vdd_cpu_lit_s0: dcdc-reg1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-enable-ramp-delay = <400>;
+				regulator-max-microvolt = <950000>;
+				regulator-min-microvolt = <550000>;
+				regulator-name = "vdd_cpu_lit_s0";
+				regulator-ramp-delay = <12500>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_npu_s0: dcdc-reg2 {
+				regulator-boot-on;
+				regulator-enable-ramp-delay = <400>;
+				regulator-max-microvolt = <950000>;
+				regulator-min-microvolt = <550000>;
+				regulator-name = "vdd_npu_s0";
+				regulator-ramp-delay = <12500>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_cpu_big_s0: dcdc-reg3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <950000>;
+				regulator-min-microvolt = <550000>;
+				regulator-name = "vdd_cpu_big_s0";
+				regulator-ramp-delay = <12500>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <750000>;
+				};
+			};
+
+			vcc_3v3_s3: dcdc-reg4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <3300000>;
+				regulator-name = "vcc_3v3_s3";
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vdd_gpu_s0: dcdc-reg5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-enable-ramp-delay = <400>;
+				regulator-max-microvolt = <900000>;
+				regulator-min-microvolt = <550000>;
+				regulator-name = "vdd_gpu_s0";
+				regulator-ramp-delay = <12500>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vddq_ddr_s0: dcdc-reg6 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-name = "vddq_ddr_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_logic_s0: dcdc-reg7 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <800000>;
+				regulator-min-microvolt = <550000>;
+				regulator-name = "vdd_logic_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_1v8: dcdc-reg8 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1800000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-name = "vcc_1v8";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vdd2_ddr_s3: dcdc-reg9 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-name = "vdd2_ddr_s3";
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vdd_ddr_s0: dcdc-reg10 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <850000>;
+				regulator-min-microvolt = <750000>;
+				regulator-name = "vdd_ddr_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <800000>;
+				};
+			};
+
+			vdd_0v75_s3: nldo-reg1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <750000>;
+				regulator-min-microvolt = <750000>;
+				regulator-name = "vdd_0v75_s3";
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <750000>;
+				};
+			};
+
+			vdda_0v85_s0: nldo-reg2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <850000>;
+				regulator-min-microvolt = <850000>;
+				regulator-name = "vdd_0v85_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdda_hdmi_s0: nldo-reg3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <837500>;
+				regulator-min-microvolt = <837500>;
+				regulator-name = "vdda_hdmi_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdda_ddr_pll_s0: nldo-reg4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <850000>;
+				regulator-min-microvolt = <850000>;
+				regulator-name = "vdda_ddr_pll_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdda_0v75_s0: nldo-reg5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <750000>;
+				regulator-min-microvolt = <750000>;
+				regulator-name = "vdda_0v75_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_1v8_s3: pldo-reg1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1800000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-name = "vcc_1v8_s3";
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vccio_1v8_s0: pldo-reg2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1800000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-name = "vccio_1v8_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdda_1v2_s0: pldo-reg3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1200000>;
+				regulator-min-microvolt = <1200000>;
+				regulator-name = "vdda_1v2_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc3v3_sd_s0: pldo-reg4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <3300000>;
+				regulator-name = "vcc3v3_sd_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vccio_sd_s0: pldo-reg5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-name = "vccio_sd_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcca1v8_pldo6_s3: pldo-reg6 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1800000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-name = "vcca1v8_pldo6_s3";
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+		};
+	};
+};
+
+&pinctrl {
+	pmic {
+		pmic_int: pmic-int {
+			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+};
+
+&sdhci {
+	bus-width = <8>;
+	max-frequency = <200000000>;
+	mmc-hs400-1_8v;
+	mmc-hs400-enhanced-strobe;
+	no-sd;
+	no-sdio;
+	non-removable;
+	pinctrl-0 = <&emmc_rstnout_pins &emmc_bus8_pins &emmc_clk_pins
+		    &emmc_cmd_pins &emmc_strb_pins>;
+	pinctrl-names = "default";
+	vmmc-supply = <&vcc_3v3_s3>;
+	vqmmc-supply = <&vcc_1v8_s3>;
+
+	status = "okay";
+};
+
+&tsadc {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3572-forlinx-ok3572-c.dts b/arch/arm64/boot/dts/rockchip/rk3572-forlinx-ok3572-c.dts
new file mode 100644
index 000000000000..754fbce00162
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3572-forlinx-ok3572-c.dts
@@ -0,0 +1,286 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2025 Forlinx Embedded Tech. Co., Ltd
+ * Copyright (c) 2026 Cunhao Lu <1579567540@qq.com>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/usb/pd.h>
+#include "rk3572-forlinx-fet3572-c.dtsi"
+
+/ {
+	compatible = "forlinx,ok3572-c", "forlinx,fet3572-c", "rockchip,rk3572";
+	model = "Forlinx OK3572-C";
+
+	aliases {
+		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
+		mmc0 = &sdhci;
+		mmc1 = &sdmmc0;
+	};
+
+	chosen {
+		stdout-path = "serial0:1500000n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = <&work_led_gpio>;
+		pinctrl-names = "default";
+
+		led-0 {
+			function = LED_FUNCTION_STATUS;
+			gpios = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	vcc_usb_hub_1v2: regulator-usb-hub-1v2 {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-max-microvolt = <1200000>;
+		regulator-min-microvolt = <1200000>;
+		regulator-name = "vcc_usb_hub_1v2";
+		vin-supply = <&vcc5v0_sys_s5>;
+	};
+
+	vcc_usb_hub_3v3: regulator-usb-hub-3v3 {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "vcc_usb_hub_3v3";
+		vin-supply = <&vcc5v0_sys_s5>;
+	};
+
+	vbus5v0_typec: regulator-vbus5v0-typec {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio0 RK_PD1 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&usb_drd0_pwren>;
+		pinctrl-names = "default";
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "vbus5v0_typec";
+		vin-supply = <&vcc5v0_sys_s5>;
+	};
+
+	vcc5v0_usb3_host: regulator-vcc5v0-usb3-host {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "vcc5v0_usb3_host";
+		vin-supply = <&vcc5v0_sys_s5>;
+	};
+};
+
+&combphy1_psu {
+	status = "okay";
+};
+
+&gmac0 {
+	clock_in_out = "output";
+	phy-handle = <&rgmii0_phy>;
+	phy-mode = "rgmii-rxid"; /* Schematic adds a 2ns delay to RX_CLK */
+	phy-supply = <&vcc_3v3_s3>;
+	pinctrl-0 = <&eth0_miim_pins &eth0_tx_bus2_pins &eth0_rx_bus2_pins
+		    &eth0_rgmii_clk_pins &eth0_rgmii_bus_pins>;
+	pinctrl-names = "default";
+	tx_delay = <0x21>;
+
+	status = "okay";
+};
+
+&gmac1 {
+	clock_in_out = "output";
+	phy-handle = <&rgmii1_phy>;
+	phy-mode = "rgmii-rxid"; /* Schematic adds a 2ns delay to RX_CLK */
+	phy-supply = <&vcc_3v3_s3>;
+	pinctrl-0 = <&eth1m0_miim_pins &eth1m0_tx_bus2_pins &eth1m0_rx_bus2_pins
+		    &eth1m0_rgmii_clk_pins &eth1m0_rgmii_bus_pins>;
+	pinctrl-names = "default";
+	tx_delay = <0x20>;
+
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+
+	usb-typec@22 {
+		compatible = "fcs,fusb302";
+		reg = <0x22>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA5 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-0 = <&usbc0_int>;
+		pinctrl-names = "default";
+		vbus-supply = <&vbus5v0_typec>;
+
+		connector {
+			compatible = "usb-c-connector";
+			data-role = "dual";
+			label = "USB-C";
+			op-sink-microwatt = <1000000>;
+			power-role = "dual";
+			sink-pdos = <PDO_FIXED(5000, 1000, PDO_FIXED_USB_COMM)>;
+			source-pdos =
+				<PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			try-power-role = "sink";
+
+			port {
+				usbc0_role_sw: endpoint {
+					remote-endpoint =
+						<&usb_drd0_role_switch>;
+				};
+			};
+		};
+	};
+
+	gpio@23 {
+		compatible = "nxp,pcal6524";
+		reg = <0x23>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA0 IRQ_TYPE_EDGE_FALLING>;
+		pinctrl-0 = <&extio_int_gpio>;
+		pinctrl-names = "default";
+		vcc-supply = <&vcc_3v3_s3>;
+	};
+};
+
+&mdio0 {
+	rgmii0_phy: ethernet-phy@2 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <2>;
+		reset-assert-us = <20000>;
+		reset-deassert-us = <100000>;
+		reset-gpios = <&gpio3 RK_PC0 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&mdio1 {
+	rgmii1_phy: ethernet-phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+		reset-assert-us = <20000>;
+		reset-deassert-us = <100000>;
+		reset-gpios = <&gpio3 RK_PD5 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&pinctrl {
+	extio {
+		extio_int_gpio: extio-int {
+			rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	leds {
+		work_led_gpio: work-led {
+			rockchip,pins = <0 RK_PB4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	usb {
+		usb_drd0_pwren: usb-drd0-pwren {
+			rockchip,pins = <0 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		usbc0_int: usbc0-int {
+			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+};
+
+&sdmmc0 {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	disable-wp;
+	max-frequency = <200000000>;
+	no-mmc;
+	no-sdio;
+	pinctrl-0 = <&sdmmc0m0_bus4_pins &sdmmc0m0_clk_pins &sdmmc0m0_cmd_pins
+		    &sdmmc0m0_det_pins &sdmmc0_pwren_pins>;
+	sd-uhs-sdr104;
+	vmmc-supply = <&vcc3v3_sd_s0>;
+	vqmmc-supply = <&vccio_sd_s0>;
+
+	status = "okay";
+};
+
+&u2phy0 {
+	status = "okay";
+};
+
+&u2phy0_otg {
+	status = "okay";
+};
+
+&u2phy1 {
+	status = "okay";
+};
+
+&u2phy1_otg {
+	phy-supply = <&vcc5v0_usb3_host>;
+
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&usb_drd0_dwc3 {
+	dr_mode = "otg";
+	maximum-speed = "high-speed";
+	phys = <&u2phy0_otg>;
+	phy-names = "usb2-phy";
+	usb-role-switch;
+	snps,dis_u2_susphy_quirk;
+	snps,usb2-lpm-disable;
+
+	status = "okay";
+
+	port {
+		usb_drd0_role_switch: endpoint {
+			remote-endpoint = <&usbc0_role_sw>;
+		};
+	};
+};
+
+&usb_drd1_dwc3 {
+	#address-cells = <1>;
+	dr_mode = "host";
+	#size-cells = <0>;
+
+	status = "okay";
+
+	hub_2_0: hub@1 {
+		compatible = "usb4b4,6502", "usb4b4,6506";
+		reg = <1>;
+		peer-hub = <&hub_3_0>;
+		reset-gpios = <&gpio2 RK_PB0 GPIO_ACTIVE_LOW>;
+		vdd2-supply = <&vcc_usb_hub_3v3>;
+		vdd-supply = <&vcc_usb_hub_1v2>;
+	};
+
+	hub_3_0: hub@2 {
+		compatible = "usb4b4,6500", "usb4b4,6504";
+		reg = <2>;
+		peer-hub = <&hub_2_0>;
+		reset-gpios = <&gpio2 RK_PB0 GPIO_ACTIVE_LOW>;
+		vdd2-supply = <&vcc_usb_hub_3v3>;
+		vdd-supply = <&vcc_usb_hub_1v2>;
+	};
+};
+
+&wdt {
+	status = "okay";
+};

-- 
2.34.1


