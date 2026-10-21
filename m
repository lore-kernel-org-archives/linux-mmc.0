Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792599165;
	b=q/b9bl2Urm4KWLkS0DZdvZJF9uNTIoBZ4pLhDtdZOl5vPCj2xgY0meQ6DnxMM19gSQOU
	 8/DRiwDB63LAH9ht5VzAaXcA+bAVTMn1pZCFM9d6142jVVmOwxjJxNORap7UxMq0aA3mc
	 SZ7qRPdSDIaz/eLv0UEJJDMjacbZ/RMPV1mVenrxF+g4KaEXJ91TGk4rc1U+4IQIe7Uws
	 WjZVpaGy1eG+JOogEfAH+mbsYLc024Wzhr2nFjEuXBYilJkNjfm9WsbvhGnoKrQrQfE1d
	 AgkEwlu3X4oQscpHOEhm2ASTReA/IeZT6Mn2lmxuXQYqd9JSQIniCNXTbJVQKi2EHkw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599165;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NVcTs4+R4D4TM8lWcbqJP0vpXUWnEu+1cmq0y1Lvtx8=;
	b=WfduW9RLTEj1/wDuhovySlv6fiR3+g22oPjBig/RI0iPzslGS7GJ8Wo99o9+4lTenMNq
	 hOnK4wNMyA56PGCwFnJjtP58g2nBqQixyDoa+1r+eRaYCnUnNwoeNv+7vSONisHE7IK2J
	 lxekjsRSaBvwvpac0tW2d3bmUfbCbleB39ipJ0dXg1k+n00CDsDFXFk2F66/qUUXnO1Nt
	 6lBRPyjiUbBZ//IR3Gmus1wGuEOCePSyrgqjhsw49YW5UoSq4t3QeeEo8UqCwTC8JmRGX
	 TghOSRTEbfOG1Jb3D9tabxoPzuACMc6yJBiainjtHIodmdF8iec+o8dlMC/v1NwkQfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IAWzOiIa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D15606CD5C;
	Wed, 21 Oct 2026 16:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IAWzOiIa
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792599164;
	b=Rb8753MISmDkCgTw+GH2r56fENSIZ0v5w9TsMkm4jaXtvafubJPyeJRtsYdgqT8Pokji
	 Cp02NtJIr6vDl6y9teDPqOw6DEb8KY96XasmQVYF0FTaFs3eFH0lE3Logw63n7KjLqkou
	 2uDqa5RBZme4UivKcmTsquwlfI8sZ7Umk6egotMrJ5bw5Z+lDbwMfZme1KwvOGNjE4C1c
	 9J0Tf9ajIt8Ef0FJg4Kni77aTapsjsqndgzoM6JTfqyd1YVqqvES8DZW8ciKQb0mN7EDV
	 lInyG03LIqs6B1U2NuHJiZhZXSbsOE+tub8yGvgJ99CxLUucYgbm9uS8tmWh14ScZzg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599164;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NVcTs4+R4D4TM8lWcbqJP0vpXUWnEu+1cmq0y1Lvtx8=;
	b=HCsqrLLVDKtsZP2B5dqvo3ijeD5sko2/W6zTB88a0+qgGl6cvM1dm2/LTjZ5tRpBWAWQ
	 FYJaV3DXkW+WT2NIyDklxIDMiGNcFNl4UkwqKvhxMzlLcF0JOzW6FNbyOEI9jXqTvevi8
	 YGAyJ0kUvCCxsZBWBe3IFFPK4nIqwdushFnfH546jVWKu4UH/yGbqml4JLHL71ka6FHVT
	 +5lYzXnnf3CST60oWt11j4aQUCltoOGUdlyw9iji2jFa24+lpg18CBQY9+wew+MqVLJ+8
	 F1sz5qOXHQD3Z605NotnU/4ohYqfm+8YdFLPnF8X1JksapjzMOiJ7X41QQdVnjyU6lA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id F2B9B1F01804;
	Wed, 21 Oct 2026 16:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792599164;
	bh=NVcTs4+R4D4TM8lWcbqJP0vpXUWnEu+1cmq0y1Lvtx8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=IAWzOiIaXju7EtxNgpjhbvjT7PRlgcxkcdYtAM3VQvVYTpnEvd/Iwzb9DzrLVLO4u
	 SgPDSbFT0PflzZweDNPvOqFOE/nBd+3MXZLfyF5DR0RMUB6xGOFtPTN3ed+mMVY31P
	 uIWKSVOL2lmbliEoIz6DNb2VOz5XAiegUgO8dzWExl3PjfgxbhUP2nzCc+VFAxvLIV
	 uaS1h36QsJVqsUxBEfIJPQcKXQqWRlK+t6oVeMx9dGH9ynS6thv/uKJvJcxTtFKDPb
	 Y5Kfc07aDtxJVh0EoV2NdpqAPeHbLntbDY97sQOKVDIf5oidjYDtA8+bTXKVf5miAH
	 UomnMqTPhU42A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AB47A433EF;
	Wed, 21 Oct 2026 16:12:23 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Thu, 22 Oct 2026 00:11:17 +0800
Subject: [PATCH 20/27] dt-bindings: usb: rockchip: Add RK3572 DWC3
 controller
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
Message-Id: <20261022-add-board-ok3572-c-v1-20-0b0fd85a31ee@qq.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792599138; l=2999;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=iT5BkLeeMmmjRIQeuSIycaI/UXplV+prYKUmY7Ulxps=;
 b=v53jOqW6R2n7fnmg8g19Yw7h4T0AjT02bVfEk5sahYgQzXvZmOvgxh+pYAmDqwo1QrriCFURL
 PtaQ5zJEYipCdDZabXmFfxXkC5DXvBCRrr4RHaHwP9Kab8NEfd0cZhV
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

Describe the PHP GRF register used to configure the DWC3 PIPE port before
controller discovery.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 .../bindings/usb/rockchip,rk3572-dwc3.yaml         | 100 +++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/rockchip,rk3572-dwc3.yaml b/Documentation/devicetree/bindings/usb/rockchip,rk3572-dwc3.yaml
new file mode 100644
index 000000000000..47ff5e16dce6
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/rockchip,rk3572-dwc3.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/rockchip,rk3572-dwc3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip RK3572 DWC3 USB controller
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+  - Cunhao Lu <1579567540@qq.com>
+
+allOf:
+  - $ref: snps,dwc3-common.yaml#
+
+properties:
+  compatible:
+    const: rockchip,rk3572-dwc3
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  dma-coherent: true
+
+  clocks:
+    minItems: 3
+    maxItems: 3
+
+  clock-names:
+    items:
+      - const: ref_clk
+      - const: suspend_clk
+      - const: bus_clk
+
+  phys:
+    minItems: 1
+    items:
+      - description: USB2 PHY
+      - description: USB3 PHY
+
+  phy-names:
+    minItems: 1
+    items:
+      - const: usb2-phy
+      - const: usb3-phy
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  rockchip,grf:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      PHP GRF and the controller's PIPE configuration register offset.
+    items:
+      - items:
+          - description: PHP GRF phandle
+          - enum: [0x14, 0x34]
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - phys
+  - phy-names
+  - power-domains
+  - resets
+  - rockchip,grf
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rockchip,rk3572-cru.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/phy/phy.h>
+    #include <dt-bindings/power/rockchip,rk3572-power-controller.h>
+    #include <dt-bindings/reset/rockchip,rk3572-cru.h>
+
+    usb@24400000 {
+        compatible = "rockchip,rk3572-dwc3";
+        reg = <0x24400000 0x400000>;
+        interrupts = <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&cru CLK_REF_USB3OTG1>, <&cru CLK_SUSPEND_USB3OTG1>,
+                 <&cru ACLK_USB3OTG1>;
+        clock-names = "ref_clk", "suspend_clk", "bus_clk";
+        phys = <&u2phy1_otg>, <&combphy1 PHY_TYPE_USB3>;
+        phy-names = "usb2-phy", "usb3-phy";
+        power-domains = <&power RK3572_PD_PHP>;
+        resets = <&cru SRST_ARESETN_USB3OTG1>;
+        rockchip,grf = <&php_grf 0x34>;
+        dr_mode = "host";
+    };

-- 
2.34.1


