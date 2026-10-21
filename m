Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792599165;
	b=oj+0AH77hZFGQhzXcQ96jVUVe94jbyGKFxhDhkU7GufRNxZZA7flo37di1qbkO35LJwh
	 k3VOu7WkiWjqWHdoFChqPJ2Fv26MTjd7RhZaV3ocN8VlN3knTssd+5DtpPy7dB09WlSAU
	 PlWrRDA4w5bpqwI/5Heuq1H9SRcBqd6sr/Z/KADlarOzQoYq0QgpxNnoTvhm8sauf0mFU
	 FsOosd8/DGjZA8ZSpQzRlKOoCYnJyNCh7d56W3ThUncbEfAptw+Z53negpgRXp/E2hgml
	 YuYW6mObL9DpBz1UVE+HTtcBbZ/sbdLARGswyMzwDrTUm7/w7K2C2qnZozam8qjDHDg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599165;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=T34yhw+q6rir5R3L28MrGG/qV2i0GHvwBSrR7IUn5Mg=;
	b=ZBRbsk9ogmWMAKnchS6PmZ8WlP15clUBraOUqPQOXFbkZFu1U92kPiGkBUQwr8LXM8KT
	 lU6sobrH06ufYFWRmEuhHPLqOp7bpOmVayi6Nc7XRFZa4Kw/mLsGCmimkUbxF/U9c4Pa9
	 Z4gqyLLszRbF6wgwoJ7RphXI4OR2rdRV7PohzpmBrDpksF6zjfEsOJg0dl7w+GoTpRfb0
	 fT/2aw+9Qm9p98LLy6uisjTEi6bxP1XnB2qh8hrjNnSNKJ2iL6ifWpeIP7tfiIqmCwwgw
	 HK/87PcM/VJ7Eon/FLamQA8z2qRjt0f8MxBPWe0IW0ahABlkI3XZIy+HwsmQRNtNXQA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cb850ebu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3DA606CD61;
	Wed, 21 Oct 2026 16:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cb850ebu
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792599165;
	b=1BBcMy4BjLlP1rfVN1cPpkArxi9JOsUs/6mDahWMBdlyq/DGz3Qcb3+dlBgChZ8mdwdo
	 PNiE1H1pEVU1zfYz4zPV1gWuFZTtbAivMvAZ+Q5bsyPbgNw8qXO3NKXMlk6ovOq+L0qwx
	 XKM5aVgVfTuqLyI59VLRNgRDQs99JgBSG3kJiRkfDJWuUn1b4spl7VO2bLJ/KkQwHzEAD
	 l5h4Jtn/F+Hxv86ggY+r6E0WGogCzuyEBuAbRSYHpFFnMqXRBluo9GWVLf0qsviKsaaQt
	 VwKqJOFqoEbD+f79IzEa4NVQQ9cNhabsE1sGWdK8hvlEaiPYDk3qIUwd0z2nH9af/cw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599165;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=T34yhw+q6rir5R3L28MrGG/qV2i0GHvwBSrR7IUn5Mg=;
	b=OKli12zMLTo9V7JBs0VkFFgizO/2Ph+BrbSq4+HMwgA0247XCMl8fFsM7as+e/tN7Jni
	 j5ymgPcrCcY415bpXn6BPzABxDB2QU2jNpQ5nfXCEtx75TpxXQtDvCmNPVvzuP7320qi2
	 Rx8SFw8nyQCC10yVltDCopi59vt8D/m66xrcUVz1xpEH8j0sYumTeVGzxpw7fzbx4eMI/
	 sMVxtBVB4LGSufH1A3Re8FaNO++nbwaX6yTE6qaDaTKrlQdmiDWU8pJlwVPC4px5X7lJ/
	 xFPAoAm68UmXqm2oHw6v6tOqv8g0nNMWl5Yo01Nql/ByADABuoQybownesX2HYEdPTw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 56E391F0180B;
	Wed, 21 Oct 2026 16:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792599165;
	bh=T34yhw+q6rir5R3L28MrGG/qV2i0GHvwBSrR7IUn5Mg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=cb850ebulGWpodc8GR9sz+rAXz8/DVgA/OH6bGub9CIxwEGK6AcM+X4F08FzEGBj2
	 cKrv+ZkQPYC/sQOqO+fMleN0k+tyt5XnhTfN/2g7WFNVgNcaXm6gaxytLXw6alnnxm
	 rJbZIQFiJYrCa7usvBtIxWSobX+DRvVWGrOoBhJU6xna8ifK83TokEaW2C9ZxLwon3
	 ZNtPTaka9RKjpt29DuHeg5n/tG2Xzs2WDX3U5EovT6Zd2In02hnQXVFk2p+oLLaMk8
	 Iq4F0Gpr6M8CdFXDcmp0VWsXpDropU8mq5PwjPoJdOUlgYH4IYraZIKIoRgfi5tgQS
	 oD9he9HMGFL2A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 98F48433E6;
	Wed, 21 Oct 2026 16:12:23 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Thu, 22 Oct 2026 00:11:15 +0800
Subject: [PATCH 18/27] dt-bindings: phy: rockchip-inno-usb2: Add RK3572
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
Message-Id: <20261022-add-board-ok3572-c-v1-18-0b0fd85a31ee@qq.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792599138; l=1216;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=tyofWfbav37+Vx71DGiRjN5QHlO0pDuivMsV2h/GBMY=;
 b=X7DW0svhCUiecPW44r1x/QO9bMQOLqT/ZPKNZt8JawdDT4dWqYtCPC4SG8L7jE/A3RULTp5B0
 V8GymDNGFVHAiQI3zM4SZ4tDEJ+Vk5JN2nsFMXSDqoZwT5Rqo9Idjng
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

Add the RK3572 USB2 PHY compatible.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 .../devicetree/bindings/phy/rockchip,inno-usb2phy.yaml     | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
index f50fc69fbbe49..9bb9295c332c3 100644
--- a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
+++ b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
@@ -23,6 +23,7 @@ properties:
       - rockchip,rk3528-usb2phy
       - rockchip,rk3562-usb2phy
       - rockchip,rk3568-usb2phy
+      - rockchip,rk3572-usb2phy
       - rockchip,rk3576-usb2phy
       - rockchip,rk3588-usb2phy
       - rockchip,rv1108-usb2phy
@@ -253,6 +254,19 @@ allOf:
         clock-names:
           minItems: 3
 
+  - if:
+      properties:
+        compatible:
+          const: rockchip,rk3572-usb2phy
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          minItems: 2
+          maxItems: 2
+
 additionalProperties: false
 
 examples:

-- 
2.34.1


