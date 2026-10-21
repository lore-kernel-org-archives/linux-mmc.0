Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792599159;
	b=FelXYa7Cflmd+JbKcdfjcvoLc8uYcmH3ZvPpm9cC5PynRpc5QCZIt0SEzg2w1rCZOdEH
	 out7IFerre0u+Tv/yo5v5n1wDWnTR7kPnmumqM9Q4lT9++FfMBCotWDX+iaGyZAKhoYtK
	 k0sF2vSHAsW8j/MOxWK+MX0Lo+SVQoLBKd8CoNMHOkoeujQDTkyrVSUcKoeKjFxIZRAMT
	 +6eFf0ZQOpUhIMtj5fGhjbrAlY2jff5DZIxk3ott46NXzx0HKwXqpBV2clq+t0/PQKkK6
	 Kzgs4ovNN97F9+1azDsP5jgX3cnADHmDXGVLPydomy3KkRGUF+gmGN01QwI4tw37/ug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599159;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=9OhtDeWco/qHepZsdYaoSDfBdVEmkEvICiVjHgzAKVQ=;
	b=bVYkmCU5iaCK8NNWz26+JQK8cSC/a2Eeqv/UE0tDIPgzgnTumv3Iysv0T5ytQ+5K/2wG
	 1ld3OQSDrnsBBgOTmL9Z7JyyoKc9N8KcA5r71R0gcgHDlSOE2OtHi17dcHfZEtLBVZsg9
	 5mkqrddbgRRKJ6unMBVslamdsVzTOcAFiNL/mH5cMJJNV8rX98Jkq4g6v5N8qt15f4oVo
	 ocJ5nMGgYkm1dsKtJHlPq9CPGShXKB2Wi1k9K/EYSTMpbaVKd0Ke3GEqiLgv2BNbYr9dl
	 2h80aTDuO8Pc22cjYcL4Oh+B/uPIJRBS8fGw6FDsgXmXsYQ9IrwprYr9Qgm0pFTBh3g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CzkaX/53";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9080660A2639;
	Wed, 21 Oct 2026 16:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CzkaX/53
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792599159;
	b=BXdii8qVS0p4GaHWr72K07lh+W2iWmbJLdKMRsOjLUG4046A9333HkvypZ+FT+/jCPq9
	 L4GHDYKb7rmkyi2+I1OKl+7/OcskgrRwhDKi96RrAeWv1vzG/jYDEO5JzHdQht+mjvKPU
	 2FGFM/JRu0BuUQCi1F0AYW/BpiwmN+Uvdxs0tI2w0huTmzeHDXs41XgTj6su2Ctj1cpgT
	 wFQeT0RJJ9WsIsgICr4oIWD4Pd7cQ+YaaoWoLr2BrTux0CG1/cvOZum8FFNCrIMM6Yl8g
	 Rdavs85X6ZrNV9noMRQTgLfeIXRgBghOxC2Lh2yMzGSg9hFVnyCDEl803COdXu7gqPg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599159;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=9OhtDeWco/qHepZsdYaoSDfBdVEmkEvICiVjHgzAKVQ=;
	b=MBSphSDwZ/XvIwMqVeugBoPtPguRNqf5he2HKHVgMVskTMANsK6T7sNhBRxEwaXFuRnU
	 dHDcviebuCGCXO46bwu8pRtMU8hxZX707Kk87rIAZMpMSgx2trjcIhqC86F+c67pVzk6K
	 5i5B1Pyd/dzCXfP5Rz6TeURj+xdyGGjw+VHjWT/S5TmYUN6xdML+SSnw5a1u5VaKMRX8G
	 38bMVPJqBbnRk8vib23VJIA1xSONfvc0L5o2gvifoHFjTJtIoj90xirEhjgN3d/JoVc7k
	 VNeiqJ5VKGCf67vu/rSs6E1cFx/vbDpqgsGZC1FxcV0SC1GR35viJ4Dku1P39Mmfo9w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 44D091F000CB;
	Wed, 21 Oct 2026 16:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792599159;
	bh=9OhtDeWco/qHepZsdYaoSDfBdVEmkEvICiVjHgzAKVQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=CzkaX/536RR5KOhF4NfhQvSmZXufiBgO7UyIGJ7LXBIDH+dEFrlPhoIs8JZFDVP7h
	 aD7fdMqI9mPmRdpfoQe7On8fpOJGiJI25AxBP4c/s9qktiHOE5R/BbbdsTEZsESoSe
	 Hw1BTmH0CNyNACXr8LD+vc1uLaXy5pI0jar0T4jW4uLzGXWslsO9syazkqZyZEAlZf
	 IwV/FdYOwQdPCQVsAndZBfX9qg7lNyvDbxh4Bt10Hqn7CWniI5EJEm1zsjVuymuwxF
	 NteIHhYo2fKvlZ3eofppxrJ/KQkvVVDhcp2haTT//zKje/YjHSkTuQyVjwhZcW+TJu
	 hOG2mV6fYtBkA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 250A8433AF;
	Wed, 21 Oct 2026 16:12:23 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Thu, 22 Oct 2026 00:11:02 +0800
Subject: [PATCH 05/27] dt-bindings: pinctrl: rockchip: Add RK3572
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
Message-Id: <20261022-add-board-ok3572-c-v1-5-0b0fd85a31ee@qq.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792599138; l=808;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=7Cwg4wq5+C6jKGQLPpMc9LwBD2h7LAV97O69wvTBPj8=;
 b=EF4whsGfJl4BJ74dJFmiD0OLdXtnmpjaJdIa5SjqcpJ1E5QnilqIGFxGptEjeUZVlzPmMEbVw
 ox/BKH2IxLdDM2nkeGE4jgZCgSye/1RSrtxMlFnb3A+fVMODRy/G6Ux
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

Add the RK3572 pinctrl compatible.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
index 81747bb53056..cbecabd8e307 100644
--- a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
@@ -48,6 +48,7 @@ properties:
       - rockchip,rk3528-pinctrl
       - rockchip,rk3562-pinctrl
       - rockchip,rk3568-pinctrl
+      - rockchip,rk3572-pinctrl
       - rockchip,rk3576-pinctrl
       - rockchip,rk3588-pinctrl
       - rockchip,rv1103b-pinctrl

-- 
2.34.1


