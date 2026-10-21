Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792599162;
	b=QjJcQxP7cbw1hwOktb8r2+LaTNPYLgcpjbvIBSjGanPIin9gJyLG4fJYYZpfB/eXIDKp
	 fRwkQbdU12c/Nkx7fRPc9+u0GdAAztAcElddDWCqJ3HOBO19/pruTP5ZiJ89UYyhyxMCz
	 43C8rc1vbnwPeatGI2mzLlElm17wVws828SPUsuUVoLh4poBJsIQ6I4Hxu9cKVoBUHPRS
	 4Z1GYW6SdhHtq5KaGgOWBkt31d3VB2uast97qcDdDuqmuy1QgiNRKP357BYzSyK0CpyV1
	 iiJKA7Dwmiz+ad3wpKINUAX2iTTv33a8e7yAg9YR0ODj2Opb45EVC61jsCRkVgYF85A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599162;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=LP8P98vzBMv+Zob0ozcgR6w6Rai6LO0a+epncRMX6Ww=;
	b=1DnbafDMjfoGKg0S8TiGHA/FcUkS0dswM7yXugkPHs7bc7ITnz/JVaHolYw5PSFO6PGo
	 10+GTHx6zyCVMxGAYJ74MaSv/X2TtNuFprBNJb37cXAJzaHBW2sRQkBkRowOkP/Ov9NsT
	 YaX2fBryackZh2T+A4qxMKoYARUxetWzsNp8pI+YQJ+GNdSJ81JWf9mlUrCEmEULbwgtK
	 gfHqwnEJTH9R+sgECIBc6oECnbseGS5quVfOy3dCUzfbR4dz1D/rXeExfs5limVVHXvHp
	 S7KzZU1HvkRxQlvvL2zOITrZRtAHruqm+B32fe1zuK2fvBv+5HM+NacfgPPkG4rwAjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=epttRTa+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB5A60A3802;
	Wed, 21 Oct 2026 16:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=epttRTa+
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792599161;
	b=JorBuyBlW1euBntLPTQOqS+U7eXgpC6EvYKr/kep3jo9wYPZTtVLe2AOoAQWFxkuYh6x
	 G3gzkPyg1BsuzK+h40qNJ1nRJtVNe6HRGlPDfzXvSCJOhTlA7RkeZzUoLfsSS73H6Db4H
	 DYkMlV7F9/6cH/6sqTXrhNO0P+OnQZkg2m2D+vZwDDRrHDOz6c3DYxSxyAPwAck2UuTAi
	 2p4tYtfLDvdDv39OWJJMMtIMQhLlpBbuUKbw6N2uQnQzk99zF8q/NxeqkWXZSZ66WQJ4B
	 PatO3V/O6bH/swKlKUuRGEwh16i+ho//lNJ/jXPu04aTFb0LKOcb0NJ1yarA57ROPZg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599161;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=LP8P98vzBMv+Zob0ozcgR6w6Rai6LO0a+epncRMX6Ww=;
	b=Uw0Ss7gnKM+bqRFKM0YZUB63yMgW1jcGI8eAHt3LWkQjAjD/ZFO9FLm5IYEYC6FuQzRL
	 t8q1Ng3Ae1i+QsCEYmjuDKrjp3uVOSNE3flgeKQpsIRiifIjC0P9IEaKxI6rNPiomq95h
	 hTqQDWi3SFCfdLoxDmh++6dJ2NWG3fPi8yoXATgXCWzR6VT60OVbjCLPvvRerJSnEMBSo
	 VoT/Y9H//2OiO4AW7jISKXD28yoTmvx2AR/JOXYxe3hHNbLf6xkBhxhP+DGcQXhOr57sb
	 T6ZqfmQmDPBbjK6+LAUguR8kucfxbRZ5UI+YRVKBnZZNN8mcRHSCedpAxYfB6+oEdfw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 58F541F01579;
	Wed, 21 Oct 2026 16:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792599161;
	bh=LP8P98vzBMv+Zob0ozcgR6w6Rai6LO0a+epncRMX6Ww=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=epttRTa+N7d/V+IJbb8+jb38Az/i+bQb6j6VwN5EijVD8VEUQK5m4TrqkRd1kZLuq
	 WmeTrNEj7RtLPr6xnX7qhHkzxwLHO7Yfvf/rg0fOqR4CW3QAxXAbNhQq3t9/sn+XtW
	 i7JsD5aS69f8b28Rxd+Beb/CFSIgST1NXFaXMN21QuLBGx6UmlNqy4H/FYg6YkFhXe
	 PRjmYqTngpp8HoWoXIXO47fYGWweSDrQHOsT0/eqvIOuAxjFzGtEPjjPV6v2uYBDnf
	 WrgHHW8Scl9ujlYri729m2GlymqDxwd4ktsORGzsEY1notiDQB9kEI2APCDARzPa32
	 W+3H98DHvRn6A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A1C60433EA;
	Wed, 21 Oct 2026 16:12:23 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Thu, 22 Oct 2026 00:11:16 +0800
Subject: [PATCH 19/27] dt-bindings: phy: rockchip-naneng-combphy: Add
 RK3572
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
Message-Id: <20261022-add-board-ok3572-c-v1-19-0b0fd85a31ee@qq.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792599138; l=1724;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=muiYAjJWpuGEfEfEQInT266/4Hkdo7WfF6Hfmvodf7s=;
 b=u7xQH47HEEiJM7iDR4aUZxkboJprU6o0pJOV6oty4ocqWDZfMFbkOdNHDe8oGSvbC/+NyCe3z
 4GwHAc8JPQ9AktBEBSAVKjrBjaxuP3xF3LMKiGHLmOiMTTbBta/pmfh
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

The RK3572 combo PHY uses two input clocks and one reset.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 .../bindings/phy/phy-rockchip-naneng-combphy.yaml  | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
index 379b08bd9e97a..80cee3f8874d9 100644
--- a/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
@@ -15,6 +15,7 @@ properties:
       - rockchip,rk3528-naneng-combphy
       - rockchip,rk3562-naneng-combphy
       - rockchip,rk3568-naneng-combphy
+      - rockchip,rk3572-naneng-combphy
       - rockchip,rk3576-naneng-combphy
       - rockchip,rk3588-naneng-combphy
 
@@ -22,12 +23,14 @@ properties:
     maxItems: 1
 
   clocks:
+    minItems: 2
     items:
       - description: reference clock
       - description: apb clock
       - description: pipe clock
 
   clock-names:
+    minItems: 2
     items:
       - const: ref
       - const: apb
@@ -94,6 +97,26 @@ required:
   - "#phy-cells"
 
 allOf:
+  - if:
+      properties:
+        compatible:
+          const: rockchip,rk3572-naneng-combphy
+    then:
+      properties:
+        clocks:
+          maxItems: 2
+        clock-names:
+          maxItems: 2
+        resets:
+          maxItems: 1
+        reset-names:
+          maxItems: 1
+    else:
+      properties:
+        clocks:
+          minItems: 3
+        clock-names:
+          minItems: 3
   - if:
       properties:
         compatible:

-- 
2.34.1


