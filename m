Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792599149;
	b=lFE0OW68hW9eQzkP8e+QlaqnJrGzwjrG3nCrVNIUhQCWfoZC17jB/kFlErqQCtZmjnoV
	 4+O+hipbzeCqj6gQsH39gmphFs9nQgmOdEaxQYRz6GCTpC29+k4eaBDrc02byTQP9NkyP
	 ZC9fTuhU2AduILMLIBn4UeIjjYTWQeEtMWCuhy3I6UAa3hxbzkqPLuYPjbbD/krfqaq1n
	 FDmbOfmDkrImZvjFPT2F4P4QTWhh/zsOS95PsB5NhjRV+EqQczmSNpfiBskeqLAfVi3S8
	 Y5ZYdjVUB9yVmt08vMrjwArL1IVAwZ3w36rt6v62jB95pHCrSilDUM9Q71jlnEDoZMQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599149;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7wLxM6Jx2TxijdJOdPWYIEJcNEz65qnh7+8neQqm6rA=;
	b=lI/+VPONOzhvYdgxatxwaLYx8Js+8PZB8LV8nmit7ib6wNs5NZPfBHz8xPR6O3WNvGa/
	 aXc36xe4wClYBjM1OGmP+5GzBncioBoFmtFAzQfH6Qn6L0hhixdumz+VvURmA4aHTcBDq
	 SECuEjWM2EmbHg8WpQ4XPVbM9+xd5yGIvzFIok7cVn9iXEG749Iq+F/BUo364CjDqBTXy
	 HTk0NbywC7HFvIy42UiUkC7XY6+W1G8vn0zzaXTyLZ1NFvUaeel88gasEat1UnNmB7uOs
	 4X5+n89RO5uRTY+76NNDKsOlMHfr3T8EgftrSejzJNZFout39TVuuDq72/C86JUD/og==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BpT0otQS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4058660A260B;
	Wed, 21 Oct 2026 16:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BpT0otQS
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792599149;
	b=GuN1o3nvBeEVT6Io36FckXhgnsm7/uxId0FKN5FwnSjbGUCJQVXNI9kRfUWN5NNfwRGF
	 dXOCXjLpSHvBfFdSuzE+gKxrYS/QPerZkSidmvWSZ+xSl2CyczbwIde6hhdK6BjPpGKh/
	 gtbMkdVPQFIxQzZmB9TJAj8hE0n35i+5oKUXSTO7WsoLD9LTM5aOSFcZBZ7YpwkvH2GFm
	 9TvKN3KFdYvromhfJUQ/t+Nnj0lfma1X6fWL4/zPkMaT/dF9X/hEHeXsym6Z26V10d/sr
	 6jd55c3L8hrhLisgDYQs6VV54OKFOjIahTO8yKyVvzpP7eEv17ig54Fr7Vkk3u5U5Ww==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599149;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7wLxM6Jx2TxijdJOdPWYIEJcNEz65qnh7+8neQqm6rA=;
	b=zm5MaTEXtoa+k97qjAvrq23OFNAZSVFbYJ59Qpq0K6IKMdeAQfVis98Vvrs632PhrvU3
	 CndxVO4LH7V+k00aLzsOy7SLlPzSnaJM0cQEGt3+EV/1u89/Mwx8DOj4B021uA95GyW5n
	 xZDBvNR7nQ3ZlBCQ0gWGNMHp5B8+n4Lzaric4uefY8YX23J5oJLhndQSO3TATyYIDfJjY
	 uPBNWhilj8ts24t5/y2B4rptGat3gfs/URFWvk8cYrJdgFvTKKSvM1JSxYnwlSGrCPuWb
	 Szfxv7+gJzZB/jRlGP1Sx2/u5iWbL/ehZq2VhJEu4m5WsJAnVZYqrHazngD0+WJ+0Xw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C4F9F1F0157C;
	Wed, 21 Oct 2026 16:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792599149;
	bh=7wLxM6Jx2TxijdJOdPWYIEJcNEz65qnh7+8neQqm6rA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=BpT0otQSQU5NsP4AKQplZc+7ZokSgjnFC6RdJaP6nOLFD7LF7CM7jZtM612uust77
	 KNTi5qhHtHVPZzplJwuONt8B3LXYyMXtk9DF3g9WlChvyC5uq00RB944LsILtKyk+x
	 60XgfdXFwre5Z+z2YxkxJgn5TrW5m0+wG+lgH43DUykjWPZ8tJeQ71wlWjLZcKdxhq
	 cDbfmnVVC/vBxOpG5JQ23kesYaRkQ/0yWmhMjC41CmlEHyi7uscPs9i2jkbeliYpW1
	 2ReH1WJ3n8pjIMvjYFElAcvx08I5H1+gn61G1UHWruc7sTJ2rJG1YVJPvLjzc324Wk
	 hZ7EGadnmBLyQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1CB9E433AB;
	Wed, 21 Oct 2026 16:12:23 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Thu, 22 Oct 2026 00:11:01 +0800
Subject: [PATCH 04/27] dt-bindings: mfd: syscon: Add RK3572 QoS register
 compatible
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
Message-Id: <20261022-add-board-ok3572-c-v1-4-0b0fd85a31ee@qq.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792599138; l=787;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=uFfiJe79UHoJUmZUfddULOE/yY4AM8aRwf1OA9QQsAw=;
 b=PQlvImamcct9qYzOV3A6Za7RjEIj1sPanPiyKUAgVT8qOcZLZshqI9eYCroTYs9FppadblViO
 vNmeEdVoB8IAPJdBQj2d2OT1inwdeWPYAeSge7dK06aGkCZlOaxcUEQ
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

Add rockchip,rk3572-qos to the syscon compatible list.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 945a168b613d..b3c96e1de74f 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -118,6 +118,7 @@ properties:
               - rockchip,rk3528-qos
               - rockchip,rk3562-qos
               - rockchip,rk3568-qos
+              - rockchip,rk3572-qos
               - rockchip,rk3576-qos
               - rockchip,rk3588-qos
               - rockchip,rv1126-qos

-- 
2.34.1


