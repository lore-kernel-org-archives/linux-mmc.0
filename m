Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792599145;
	b=ZK8G26qvR1GHRZyg3vbvsAx7yw4ILA7u0tI7lV22/NLF+uj+JYst9w8mRmbWcgx//2SC
	 9my+poIhW5oAuuDBgLXxCNLWScpbHD05JGcUVb7dQnMde/APUlL22OmNWpcPtz/c9szED
	 rfYtqkGfZ3dM7gKj2EDcxWq1hOuuEj3GrdfZ+cbeHQPSMuwxJmJJuMpaxbBRV+d3lfHw4
	 G6xgeORRqep7otUzF8DCQ1QVFWdjAKJqHvbygkq202PtJfCrYPMQxG78Ej442BMKG3SYM
	 hVen/2O92qB0dyE7HFAs7XwBqwO34cgYzrpqpdMNZcsItSRomgve7qCeamR8irgqf+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599145;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fTncLPPGPohuW14GIbjnE8CrQrINNX7MPVns5vfiTYo=;
	b=UGcqgr3N6NQ+kgwn+cn6YoUvH1z6uvVJvPOBvVffZsX9lUSVaSxkG0FrbpzfefK7LY1M
	 XaTfcQ8/tC1gYHJq8Izfm1WD7eNTFIovjC4QEmytwxJ9Ko/FAmZVzVwH9rDXm5+91X8Kl
	 qGM2eJTW7v+Dgp8ySn0aTCDm2N8ix/3GS2146JGYzP0OV0zSMSmYJXg9U6/XbFl8sS0u1
	 JUpVW1Vo5OJnF/8+N+B/nTelPCWlzVJ73aBh7q8Bxfd0uprK1L+aoNM5DNS93EBJjCbvi
	 RuE/DitOycEATt67IWtGjwaX1z//oKeJDU7KSYp9g/oHrlokoQ8DtxUoPOY8V+njwTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GbM25pCy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919BA606A31A;
	Wed, 21 Oct 2026 16:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GbM25pCy
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792599145;
	b=LQ0EICoRZgfCRuKvWr0wxaXOSDZEYM+PXIXF80+DNrhcwyPU7l12aWHcnLDldnyGC8X0
	 i4KTO1XhTYzppo1eR97Uypcr9JoMJ7Akn3oTO2u25V0zpuaxcWvUlGuJV5PZWtsJrsYxh
	 bskDj7IqlY98ybGvDTag0NceCYZmqlv9RqYX9dlKmroDbgQvBKbpgyMHJ6Ruvg+Qq7Q5V
	 wzwY2/w8psXHHqhOuCMjtbT6L+JVgWNkHHzBPtrvVV7XpD5OrJko7rUxvAb49ES8IG/bX
	 3nvl9TlO2sGwrGRsPCD3quwYJblE5lxXq7DAYymaV6rD3ue4TWvRH1lHMHxQQeGCMmQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599145;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fTncLPPGPohuW14GIbjnE8CrQrINNX7MPVns5vfiTYo=;
	b=EwnDrTJyDyhCK4Ilb1B3Do5Ml/ERFLygFuev1UGbwOztKDJLVGjg0ylGjJTVdGp9U3lK
	 YmvzlGv/yOTrwlq0ABuJsvYO+38flXbudqnnyDtzGJPYA/sD/x9C+v/ABNVksAK5k79Ky
	 AjBL3hOKGdWK1b+ubnBkTWBfVD/m33byye437xmHB1IwQV/HXRKGwCLg9w2kbRHuBywh1
	 lxlZgY2P8yxHs5Dt4gnRWWq0ITUZgFaKWLXFyg69TkBTo+noZ7HS9cKLwjIi0lonUm26a
	 WikNFUmmorRfK5mBDzf51WO2RrKqFlBRtoSud82QyC+8/AdIafbmbMlUv25h06ADQ0A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9B0951F000C7;
	Wed, 21 Oct 2026 16:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792599145;
	bh=fTncLPPGPohuW14GIbjnE8CrQrINNX7MPVns5vfiTYo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=GbM25pCyczVVDhDkqlfpjE/ZcN24CXRb/ZRW9jQmEApF1BJEUnnsftgy5R3QcYfM1
	 Qm/upuFABF/xm85fUYY7ZxyplONQwCAd6YZUinx9h8yRUvWGiZHZ5U8nLO4XeI2OGM
	 O3MxtmAECitcSLHHSkPdrNqdoKVQInic/080SqaHG52wO955BeDEpqpnkk9CcfBCXk
	 y4DBXzkC+HK0aT0Rlh5ExTOh6e41uvMZzN7+cYB6UcrbQKSJlB+ze25SnUh1MYrnXs
	 ovO1YDPKGJB5rdPD2C46/xDPJrxZ6ZNcsU7saEjlDDi8DrpFnknH6UTJ1dBieR6RNx
	 GamN9yLiVYyXQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0A5A0433A3;
	Wed, 21 Oct 2026 16:12:23 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Thu, 22 Oct 2026 00:10:59 +0800
Subject: [PATCH 02/27] dt-bindings: power: rockchip: Add RK3572 power
 domains
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
Message-Id: <20261022-add-board-ok3572-c-v1-2-0b0fd85a31ee@qq.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792599138; l=2586;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=XCHXnkhL1K3pqwpZtcnxnK6WkRaV98m9UCg4zRZwm8s=;
 b=MnXYmtt0bh6snlWCojGt8+2eWEY2VDGVIaBGezscAHOMFj3U56kvvBOcA3fufVOxsrbS2Efql
 GOt1v4997hoC5Ss8sbADnheAa9c6n1i1wCUJNZAPpb2L9gi3GrIigbO
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

Define the RK3572 power-domain IDs and require the system GRF used to
check firewall status.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 .../bindings/power/rockchip,power-controller.yaml  | 17 ++++++++++++
 .../power/rockchip,rk3572-power-controller.h       | 30 ++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
index b41db576f95de..f8afb0fabe809 100644
--- a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
@@ -43,6 +43,7 @@ properties:
       - rockchip,rk3528-power-controller
       - rockchip,rk3562-power-controller
       - rockchip,rk3568-power-controller
+      - rockchip,rk3572-power-controller
       - rockchip,rk3576-power-controller
       - rockchip,rk3588-power-controller
       - rockchip,rv1126-power-controller
@@ -57,6 +58,22 @@ properties:
   "#size-cells":
     const: 0
 
+  rockchip,grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: System GRF with firewall readiness status.
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          const: rockchip,rk3572-power-controller
+    then:
+      required:
+        - rockchip,grf
+    else:
+      properties:
+        rockchip,grf: false
+
 required:
   - compatible
   - "#power-domain-cells"
diff --git a/include/dt-bindings/power/rockchip,rk3572-power-controller.h b/include/dt-bindings/power/rockchip,rk3572-power-controller.h
new file mode 100644
index 0000000000000..c2316fa859df9
--- /dev/null
+++ b/include/dt-bindings/power/rockchip,rk3572-power-controller.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (c) 2026 Rockchip Electronics Co., Ltd.
+ * Author: Finley Xiao <finley.xiao@rock-chips.com>
+ */
+
+#ifndef __DT_BINDINGS_POWER_RK3572_POWER_CONTROLLER_H__
+#define __DT_BINDINGS_POWER_RK3572_POWER_CONTROLLER_H__
+
+/* VD_NPU */
+#define RK3572_PD_NPU		0
+
+/* VD_GPU */
+#define RK3572_PD_GPU		1
+
+/* VD_LOGIC */
+#define RK3572_PD_NVM0		2
+#define RK3572_PD_NVM1		3
+#define RK3572_PD_DSMC		4
+#define RK3572_PD_PHP		5
+#define RK3572_PD_AUDIO		6
+#define RK3572_PD_IMG		7
+#define RK3572_PD_VDEC		8
+#define RK3572_PD_VI		9
+#define RK3572_PD_VENC		10
+#define RK3572_PD_VO		11
+#define RK3572_PD_VOP		12
+#define RK3572_PD_VOP_PRE	13
+
+#endif

-- 
2.34.1


