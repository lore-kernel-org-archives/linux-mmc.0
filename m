Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792599162;
	b=uTmRyDYuXbLDRQjStITIYnVhTBVTArKPhS2kTlVKtYgoI2IkRn/rzW/b7FK8CSQSD9Z4
	 uIdHxj1o3h0rUI4K+IPD0RkbUYfWKG0ldvvu1jvwT8WtEsMGU8IJ53pxfc5Zm/LqtZ1mP
	 WRREfhnkhk9xSywyF2U9SklirtjGtJfmR5w4sEpJUU/OcdkHdD7xYTTb8hJHP3waeLwKO
	 WgPz0pZ2Y+/TQw7LoWqATa5lF0hBbznM4Zmz0tTfmBSFbjd2NeH4jU5FLMx21a5oWMg+y
	 9HWpW8+cTAa0z4CLScxWrPqJzMN6DleOGjBSttBl/pIJr3wgRWB+8XlcvFRVHoAYeLw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599162;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1LyLY75raFOWC8g1ja1YF1K6rlijG5R5FhPw46PdyQQ=;
	b=FS/dwn2HzK41/Ib0Z/JV3dOx+Ex2uMxyaTZQRiZYpvHquJDg3TdDmtmct0mLglF3JyDA
	 A7qe5S1LuxvlzXkufAzUpruZ2H3OdG3jHVUilbYbUT4iNKteAWzR6UrbQ3ya0md9fnqSH
	 QjTjqfzp5yjELoYNlUcuqVxvfg72imCpvphhPqkCeCi6OYzPEMqiskWBAkhXJB0eky39U
	 xmn0lrmPbDShYBLql2cklAGE2frOfcH7zRu4uemv/Ynh9S65b2ftP8CG9s5onzYhwcoGg
	 0FtytSZ+3gAw8Of7rjL6Rk+Qf6+ewMVh8Rse9jfW9jkzIK3Pa6fQ8URhAXZniPNLF9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="S0/pHd6L";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74363606B6E2;
	Wed, 21 Oct 2026 16:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S0/pHd6L
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792599162;
	b=AOXPO6PtaMhMh8uI/QslwGVp6VFKKCGp6obDm/HbPGBSvbz6wNw73UlIL7FwZpQpojJl
	 sL6buaSI6I3KAfqA0qjmWqEZFWdV3AtMfEB0O2TGECQnRVDPkqM8x2bWCtiZzRSnCO9gj
	 n2dXqSrShV+bOX6VYWC6xvwpYcxwzMFLKaji4Pyh2dRxATDcsBWQ9gMT28pywWuHr9K36
	 osLBiCfV7tW4bw5P2MUfIzhzds0wjmHsEWls4NqAtcBWW+gHQzH34rpN410vsz6ct1MPX
	 c4tIiNZeO8JOiuDdYC3uzxA2r9syfS/YisbEi1m+QqGCmZ4Q+V6Lx3cA+QihRkAMaLg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599162;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1LyLY75raFOWC8g1ja1YF1K6rlijG5R5FhPw46PdyQQ=;
	b=TqBu8DjSAkYajQx9xJ5kiAD7dajzs6V1fwISspjuh0HTjmC0NISUanDVaj0x6d6wlq7+
	 QKzGf9joUy9H67dZHWvc66A6hsEJifmhA/r1JxEWigBg7M6oz4a/lKe9LJ6rgMwAIJzXw
	 VePIzr9T6I4OC+2mM+dTrj019E/Vm0CcafKnHRiGgmVRaXRy9/mgqkzS42KlXaejNkCiR
	 aJd9qUe0wUn+J4GLSiruhlaucygfBT+EV2ypsCV1M9T40G8acdOX5nuD4vFZOOd02fVuf
	 ki5AfwiqVUHLmEMuGGf67xzENn8BUEimJ6O7d27taMJFW0LO362Gn4I8yVhtu6TbziQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id ED0081F0180A;
	Wed, 21 Oct 2026 16:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792599161;
	bh=1LyLY75raFOWC8g1ja1YF1K6rlijG5R5FhPw46PdyQQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=S0/pHd6LQFhhAiaaYoUlhn7+qfFJuwD5FLVCDl1QzU8cfoQHWkJeKGhfqXx7Al73D
	 YeR8o7k0sqSj8f07AEz0xNcGtvkaTKukulhLeTMuGl58muk4YxtkOvuBO48VeqDy4g
	 KnC0ct37qUB+rknjI5l2cg+CaIZIK14NBq5xvCxxXlbB7aR0KcqHalU38HsOEjQLMK
	 RNNS5SeFhQyrowAtNty8SGHZGHFLkMLDUTULRH7tEGRwPUzdvXFopdRirJ0vw8d/WI
	 1P9IzlPZbe+bc7w1ej/D930oaDbBJGijQcKiedLmVucDxrABQyck5IcVvO05OGSApU
	 bvFNxViY/hN3g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 909D8433E2;
	Wed, 21 Oct 2026 16:12:23 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Thu, 22 Oct 2026 00:11:14 +0800
Subject: [PATCH 17/27] thermal: rockchip: Add RK3572 support
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
Message-Id: <20261022-add-board-ok3572-c-v1-17-0b0fd85a31ee@qq.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792599138; l=1769;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=bsK0j/Qm4dk7H1oLoynYDwdzYp8Fxzpx4vhiNIJc70k=;
 b=zSifOOwVDgw+1IA6DzQ0rBwBBT12H+BJr7PpG/+IJVMwXpPRo1f/M3ZA9vr1XX6ULo4oCUoWO
 htWNcBJy35GB6shfe9XoMRDAnZ4oeBNwoMvR1t00Hfl/yQBkGRA3ggI
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

Support all five RK3572 thermal sensor channels.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 drivers/thermal/rockchip_thermal.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 08891608baa6..745aad53beba 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1303,6 +1303,31 @@ static const struct rockchip_tsadc_chip rk3568_tsadc_data = {
 	},
 };
 
+static const struct rockchip_tsadc_chip rk3572_tsadc_data = {
+	/* center, gpu_npu, ddr, little_core, big_core */
+	.chn_offset = 0,
+	.chn_num = 5,
+	.grf_required = false,
+	.tshut_mode = TSHUT_MODE_GPIO,
+	.tshut_polarity = TSHUT_LOW_ACTIVE,
+	.tshut_temp = 95000,
+	.initialize = rk_tsadcv8_initialize,
+	.irq_ack = rk_tsadcv4_irq_ack,
+	.control = rk_tsadcv4_control,
+	.get_temp = rk_tsadcv4_get_temp,
+	.set_alarm_temp = rk_tsadcv3_alarm_temp,
+	.set_tshut_temp = rk_tsadcv3_tshut_temp,
+	.set_tshut_mode = rk_tsadcv4_tshut_mode,
+	.get_trim_code = rk_tsadcv2_get_trim_code,
+	.trim_slope = 923,
+	.table = {
+		.id = rk3588_code_table,
+		.length = ARRAY_SIZE(rk3588_code_table),
+		.data_mask = TSADCV4_DATA_MASK,
+		.mode = ADC_INCREMENT,
+	},
+};
+
 static const struct rockchip_tsadc_chip rk3576_tsadc_data = {
 	/* top, big_core, little_core, ddr, npu, gpu */
 	.chn_offset = 0,
@@ -1388,6 +1413,9 @@ static const struct of_device_id of_rockchip_thermal_match[] = {
 		.data = (void *)&rk3568_tsadc_data,
 	},
 	{
+		.compatible = "rockchip,rk3572-tsadc",
+		.data = &rk3572_tsadc_data,
+	}, {
 		.compatible = "rockchip,rk3576-tsadc",
 		.data = (void *)&rk3576_tsadc_data,
 	},

-- 
2.34.1


