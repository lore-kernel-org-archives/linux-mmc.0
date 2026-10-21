Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792599154;
	b=UEZyRHPSrNsHRoEKpADf0EEdtM8u6vBhlePOP14kjV22pyf83ZkQvTyvuPZxlNryoeWJ
	 0vfSSTHkOp2Ec1xhDCHuErVHrPqdn3R4XboOgzb7Gb97WscPxFMBxrNEG9XgHPGwTTlsq
	 fST7M98kYDw+Jz1UWpTk3fC2tnVw6ipj0K+FThTE9bnoUNJ/GkEHOuoYcHGY1Dvk5lKHL
	 tioG6lGjBKheJFqwZksnl8hXA7bgiGCzTfprYYLjofJ3/iqTt1HCkrhMj+n5GN6KH40Fl
	 FXZ7tZOQMnIADiqX9fM4J1wYDnwwk+Ej+uYJj49QZpvJnpzUwxQ2NiqRKp0/iBiEbLg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599154;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wNZNoSNZLuTYE1knJMqvBH+8vSrJt0a6jTPt/IHTyTE=;
	b=zwbUl2lOMXgB0dChxWKgCcvHIBe8CbzAGBwWrstcF94EpWKm4pfTwl3JdyWIGseLp8A+
	 O/wJp/Ei6BDe6HE5SMJav3rJE1+f/XOy3pswOrPqgy4HfrQhYg06vDIZ49kWJzol2RMad
	 mBKt5K6mti86R6IF3yTd5aiqnp5gJrAcdpFjgFwdnvOuae+h1g8ar5TX9rNdPXnwoSHP+
	 68oAdeuSlnKN78SdAf9RZEgPtZTpfKvD18edpRk5WIvbAeVYXu8GQrpDHWkOzHmnM2iee
	 CqvSq+PMNRlbPgCV5KsdWbN0w9cSxZhOKdnokqd3D3yg5lTaIRN1IDih+UWv/OMJ+iQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eISUM7LD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC55606A336;
	Wed, 21 Oct 2026 16:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eISUM7LD
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792599153;
	b=yHUpXidIYvDvGULFrckOMffNTUBnME1UUdU+U2bw/v4V+t/QBctprH2vkHpJt94IIukF
	 Mabzr4kBqJ4tNBov0jQhe27X3Wjmqub9n05qOvwDLAJDGsQv1wv5ExlXXbk69vALR8qqM
	 0ppkl7WFdrinCewQ3PkpWq3Y8uYLsz1PwXp5htezgXuyVYizq1hXUj0LkDkev1MuYUSJS
	 ejT117bySOSPFQ41dmFocSXmjXn9+8Zyskx4cH5jEM5R+P9/2Ib8pUjq80/orDdfgU3cT
	 ASpfdun5UBmegWK+m3ie/tV/Ib4nIgNpnxAywk4n8mMaWvl5AHaHkdYb1C8+qn3qbAw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599153;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wNZNoSNZLuTYE1knJMqvBH+8vSrJt0a6jTPt/IHTyTE=;
	b=EbgHSkaaEFX7CmpXS+9kPzPusG3Ye+UVbnRdRJmtRWSeXZ/ZBwzWI9ZIJV4ZiSvbnAaH
	 H00dUYuqQKZKwa0Fw0HM2bwLO23S/bxB+7qCGT7kKyoWlagyYqGRN0OPyX/9yrIlMrsdS
	 Ln6lo1naStwsRSTvkfE8E2KiKkXAcDlLHX3RYTGpyQfH/Q5VnSgcf493HniBY+LteIm4D
	 spNBj1wJFeZpSeBpSg06bSv5gPncG5MzhRpOMkCBErr1sssQZ+SLTaku7+/yzgVOkztwg
	 ruLuW5pXrDphOw62mCmelAIZyoe2AEHkKx15AsMBh8E00K7+3rnjalBk6OSG9SQXaqA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3D21A1F01807;
	Wed, 21 Oct 2026 16:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792599153;
	bh=wNZNoSNZLuTYE1knJMqvBH+8vSrJt0a6jTPt/IHTyTE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=eISUM7LD00GpK803nQOh/yXzQNR4XPEZxBkD0HUGr+M7mAQgcZ/xLsUmMSsHYXxuR
	 k+Qwy7J9xesnaEGdrHcZUErFWWwasZUAnVmLEfYmr7UB4LP0KVO4chOoFuFrgWyKVN
	 gGe6josURShApzh30aAIXvukiFG/jrBt8JmvGt1fStkkYElJL0iFkImY4H6qG4Psk6
	 fA/YGWiU39Jv1H2saYsL6hlygVor1y5L9I/pco7I0TrkrQVl/pWDo4EcGnUP6XwXor
	 12b/sn6Eo8Xkpr/UnOuJPGQ/7R8zNV0gbn1WTnzUSLgSU7VHsrxxjdXKmZj5+XNNpc
	 xTxFfyinvLw5Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2DE10433B3;
	Wed, 21 Oct 2026 16:12:23 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Thu, 22 Oct 2026 00:11:03 +0800
Subject: [PATCH 06/27] dt-bindings: gpio: rockchip: Add RK3572 GPIO banks
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
Message-Id: <20261022-add-board-ok3572-c-v1-6-0b0fd85a31ee@qq.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792599138; l=1558;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=71XPLp2LqTx5hu9SnpsYS2dYxBCGTBCIH6TDOlt/UTY=;
 b=gUcs6i+rCmZW4P9eCpq1UvpoUfHiUAfwTjBWYCyFUWqqTSAST4oT5QX3mhKaRqGm/lrSXDu3E
 4i0YyfNKdCEChy+pHpiyrYy/UwckAdQWmSXhXFS1hCFyRwPMSN4yzQY
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

RK3572 GPIO banks have four parent interrupts and a separate debounce
clock.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 .../bindings/gpio/rockchip,gpio-bank.yaml          | 24 +++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml b/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
index 774e9c7de606..8655854ac0a3 100644
--- a/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
+++ b/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
@@ -14,12 +14,14 @@ properties:
     enum:
       - rockchip,gpio-bank
       - rockchip,rk3188-gpio-bank0
+      - rockchip,rk3572-gpio-bank
 
   reg:
     maxItems: 1
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    maxItems: 4
 
   clocks:
     minItems: 1
@@ -51,6 +53,26 @@ properties:
       of this bank, on SoCs such as the RV1106 where each GPIO bank has
       its own IOC block.
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          const: rockchip,rk3572-gpio-bank
+    then:
+      properties:
+        interrupts:
+          items:
+            - description: GPIO group 0
+            - description: GPIO group 1
+            - description: GPIO group 2
+            - description: GPIO group 3
+        clocks:
+          minItems: 2
+    else:
+      properties:
+        interrupts:
+          maxItems: 1
+
 patternProperties:
   "^.+-hog(-[0-9]+)?$":
     type: object

-- 
2.34.1


