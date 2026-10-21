Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792599157;
	b=3Wumli7jGGdKgzwFs0FsmWfbtuHpNL/jGChEPHhOOuPgw2Erw0RsTQEfBvTEsQs1Uxxs
	 AJVIl07FeoGtINtDWQ74+tNyVfd1VdsBMX7jxwvKe7hg9QljLfEwmemLSNnIx5oc7MZFA
	 r3XwtNh+gXbJ/kQxByHud/dAXrqLU2h9zJcXcAttIGQEIqLpmmyjgYOzOqqTP/4NvrBb6
	 YamYFEupjs4btguqXrPI7Bz2UpEnYyY9gRgAD5/fJrC5epZ9NO2ymR6mgytm709aQSvWe
	 MqI+8UoEox/7DHQNMuJkPPnHySGVD3fhXtfBu+uCHsoM/7X43DnGSeWCc/lxsHMG+kQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599157;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=HkfHwPyLmt0lyg8sxRRrXUSzNOY48bkzXVEumriQRkI=;
	b=CVn308IXYk4FE8v22xqcepWGDRJnSIw3DdcUQg88C2wDH7Z3im+JWllGr34Q54U/ZdGg
	 a9/PynM7CftoL40+QcXPw3xSW3+ULwJap+a8fyNYgMPRK9SAfL7+1yz2E/3lAzWHN5wVv
	 fTUUWcF8IbLhGFLugbVgUdEHCBCxT7ij3P0BQoDaTc6cJiE8pXTtw06Vex4qg/br4Af8R
	 gYSy9Tj3e3OWwSafM2KI6uxdKHxNHMP7TNguDcfpC3RRZut/J7vtBigLXZWMnk81DF7n/
	 KrpOgnm6G9werNOPKFbcHSVf2E/2K6WY8wujVmLCDQzg0BWd+liY/R/OzaRa7KPwLBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=feOiJJ7C;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BCC606A325;
	Wed, 21 Oct 2026 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=feOiJJ7C
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792599156;
	b=V1AKN+hUQEhmgjm0wYRZG7snHlVnxQE5pSI9FKW/TCzF6Khr+f87coE8Cnu62Pk+YXg6
	 7D0z7PRFyAENaBXH0VVC2/ik/WPhY2u8d2GyCNDI8PnrgH9AX+/XJ7+SwM0R2aZXAvfVH
	 iI1qtdQ4stieYTvxCUvMKICbFwuKH4dTt29u+S9VUt0kQiugyK7oMLmq/PLNt7UOqQISk
	 Anx7T+y82ExaUVALX/4q4As2GZ5I/oCpwzaaHHECVGWAkSo4c2fzZwC08Iq4Xg7QvvNpb
	 DPqPw/qXSFFWzUsbM05SpzzbiQUz2ACeIaIvHE9EIKo1CfE6icTgI9q0Kfpn7yfmVLQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599156;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=HkfHwPyLmt0lyg8sxRRrXUSzNOY48bkzXVEumriQRkI=;
	b=dqDoS20fyPrd52S0C2OV53JBdMUqJw2XPA/xwDMXM6xQQdLHaUwx1/g9aJUEMTnrWlix
	 QcmfDa2+laMmZZseOzGUDVDzmHoREArw7bmm3vwuDBuKF5veKNuCbUCPw2yRsRg8d6A3w
	 z9l9VClgsX/1Ob5n36CxLgk5+q8rn3XY6AilUjhJEXxON2c7gGYMDN2dhnfyvN/oSagvo
	 UZjwupfOqtp4ApVR8ZUOoCjo2pcG2Gf0vm9K9P8zau+t7Dizrp6kZskgzrZSbR/ykFGZk
	 EXHkbIbn2xuNnjjN3TF3OMazrorhLoE+NnfADuQEeosIKpTpIpMJeFLU8M2qI5CcvqQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 033081F01579;
	Wed, 21 Oct 2026 16:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792599156;
	bh=HkfHwPyLmt0lyg8sxRRrXUSzNOY48bkzXVEumriQRkI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=feOiJJ7CaEdz4v99fj7u0fDU4oEE8dM0UXT+qfqynL8DOF0iF3/EezTvUrBd/EC/l
	 jpANYZh5G45vk99pDDJlpoOE9B6g558+gs2u4nkqDOOE3+rPDt6TbG4Js0zAx4qgfW
	 rwwP6YBENPZ5c54O/ryZEhsp0Fhpt2sVyzNVnV5E9kDSOvy1kjv9pLygRtACtPPwkx
	 Gh3CAp5Wiqk4QisanjuQhlpLyKWZvxxel7urfaHoWxqOcKLObXmeBGLnMsX7VR5Lik
	 97qvwQNcZKh1/bUk10BHvZ5b0KSUke0/k9FcNa4ivBOP1A2pXBaWJDZ+TrFY2RrsH0
	 g+3F02DYhYQcA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 64558433CD;
	Wed, 21 Oct 2026 16:12:23 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Thu, 22 Oct 2026 00:11:09 +0800
Subject: [PATCH 12/27] dt-bindings: serial: snps-dw-apb-uart: Add RK3572
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
Message-Id: <20261022-add-board-ok3572-c-v1-12-0b0fd85a31ee@qq.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792599138; l=863;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=D1FXViPVwujIOTT9x4HkdtazDzg/Nd0v50dhD62lfCw=;
 b=bXyhxcCQAaxGkzUkidwaNd9WBOseIQ1bn1C/gLwHjeftMUjLXEIu+l0mtI8wNJbpQezhprCb9
 eiCgnJoV0jgBq1kJsV9P1ps6h5idPRU5RDnkGRCmnonnKH3T6X+xldJ
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

Add the RK3572 UART compatible using the Synopsys fallback.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 664305de4986..4567f8e76c9f 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -70,6 +70,7 @@ properties:
               - rockchip,rk3528-uart
               - rockchip,rk3562-uart
               - rockchip,rk3568-uart
+              - rockchip,rk3572-uart
               - rockchip,rk3576-uart
               - rockchip,rk3588-uart
               - rockchip,rv1103b-uart

-- 
2.34.1


