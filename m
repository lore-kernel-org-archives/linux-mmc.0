Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3272E7637;
	Fri, 31 Oct 2025 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926317; cv=none; b=bfz0+1UVWmnMd0w7xkWaal+cPJkFoemnehRNxMWshOTYOK5WsLbIM1zBrW//JaFaVuUMvJkZBfX3Z2c/TbK36G8yIZbwPgZBiXp1X9TTO3sDb/0/yXtnYXyqnS/B1pe4s3pOOsak3ZL9aMXomFz9IEIqCQq9XN3DR40dzBXbjJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926317; c=relaxed/simple;
	bh=xNKlc7tVib9id/nLaOFp5eRTygy8Ayi18VAnakCYDc0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=advKfwm7wrGyYxAzDGKNrno2lzNtHZ9AY8E0Hjw1Ir1KEo4QxshAg+gC+4YPJxuTEDwtkp5lGrZ68Z6y9p7IHbjdSkN+xh1DhfsQoyKfgJRoxv4aJuIz+hw0tV/1NQ6g7ForSVsYLHzXVd2BsPJOySLXzOUvUhUyS0YAyct8QcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Op4rQqqh; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Op4rQqqh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761926308;
	bh=xNKlc7tVib9id/nLaOFp5eRTygy8Ayi18VAnakCYDc0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Op4rQqqhLqO6vHP+GJmbppGVEmm82TH2O7i5LKUSw23ba4usOLbyWVDRuRSGbu95A
	 rQHHZKRnbaJfQuXmJgdM8NmWtsAlN4mcK3MPTobX6OkrlErJbBo0W2+g72dSk9f3Wk
	 ca84S9n8JWEjvgcytZs4PaL1RFXEOTIAyU0hfnMIyZSdn+Hrd4EqFhKagO+Ms0P9Vj
	 Fa2qLsJNXPuZXVgZYIU8IPI5/r+r7oDh8cdM4t3GR5DHfhihw8ED/leAM37SefR62G
	 XiUjxedyKNEL9NvgakIChdLJJS65Xud9P3s++57y539NFKd36YmhKXdUiT1vkWz9Io
	 GfGrCdCz7ZlbA==
Received: from jupiter.universe (dyndsl-091-248-209-065.ewe-ip-backbone.de [91.248.209.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 656A717E0927;
	Fri, 31 Oct 2025 16:58:28 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 19E94480048; Fri, 31 Oct 2025 16:58:28 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Fri, 31 Oct 2025 16:58:24 +0100
Subject: [PATCH v2 2/2] arm64: dts: rockchip: add eMMC CQE support for
 rk3588
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-rockchip-emmc-cqe-support-v2-2-958171f5edad@collabora.com>
References: <20251031-rockchip-emmc-cqe-support-v2-0-958171f5edad@collabora.com>
In-Reply-To: <20251031-rockchip-emmc-cqe-support-v2-0-958171f5edad@collabora.com>
To: Adrian Hunter <adrian.hunter@intel.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=732;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=xNKlc7tVib9id/nLaOFp5eRTygy8Ayi18VAnakCYDc0=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGkE3KT10+HtdpKrdxfLysoy4gnBOE1GjWoYu
 LYlhRsIqdOu/4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJpBNykAAoJENju1/PI
 O/qaaIUP/ifdsUAblQx2If/fov/LVpkbn+AUYv5ebd1yFa9NryPkYFXcEbaXfL6eH0lr4cfbQim
 bdixaxdoVZPZ4/luJeVAsfviQvJ6lHTbexcTyZHIl2xMtt7QHMiAkyFrzrt1qV+Y+ASBHdC/vnR
 2bSsONhoggourjki7g+t0w0HoHqIK0fbtemdMV9MQIG187JQhn4eZv+vgK0HbYuE6gtiIEBvXez
 YZrYqz8stUlZ6sVEhzfueJTpd0p2mgLq0pyjSCU5JNYjHkVpcsTxVLWsKt37d/zvkAYL+/HuLrv
 0sw115tByn9dQw4bcyeJF3XLrGopUq7r8dagL9yaGBWO/7ouXFbi49F1eiBESanSrWshoes0IRT
 4DKZ34zxHzad0+jEoT5586tNG/lah2BJ9RsWhfqsVvu4rF3t93vm6wBGqiPeO0HIzi4N5qVkhjj
 Yll34PIcHUaFq3vcdAvL3Uym8++r6Np55wu4YIbL74/+RiPtI1iLvOISXYKmjLkc3KqvfP9PSel
 zGMWljbFVuniwbrvUATIAdYzKMiQqdnkCHu9V5qFCttxCXEI0tj+BDI2gayeuoMUw8ACTzflmsv
 24uFNQ80uuchDoJi9Smc3zSCIqtgX5Dp0TxFUZwKbadJZtGy8eizFvUIInzB3f7wVd9zhSfWZ/B
 yjGpJ/3IIPoYk/F5oE9U4YA==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

The RK3588 eMMC controller supports CQE, so add the missing
DT flag.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index e2500e31c434..2a7921793020 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -2181,6 +2181,7 @@ sdhci: mmc@fe2e0000 {
 			 <&cru SRST_A_EMMC>, <&cru SRST_B_EMMC>,
 			 <&cru SRST_T_EMMC>;
 		reset-names = "core", "bus", "axi", "block", "timer";
+		supports-cqe;
 		status = "disabled";
 	};
 

-- 
2.51.0

