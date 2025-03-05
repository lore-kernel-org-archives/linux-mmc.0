Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D7725484C;
	Wed,  5 Mar 2025 19:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741203778; cv=none; b=usmB9EDMxVl2bvxrxKjUF2sIbJDCCg+DVDeWuqpxT7igWJg7oZNPp+kBVWEFYXccJFaQx6AiKgOtcbkDTdkBcCLaOLiwHRLBgqOwQx3MPjPXL9e0q6vWoYT+yvazYAvhLSsKT7M/CebRKxs8jMV1XV+ZHutCmgLh+oKhHSpSW2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741203778; c=relaxed/simple;
	bh=0w6AH/+Pjx6GOhW5OHJloAK6RQNG/idzAG52ka4prcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJDXbgT+l+2pDAfCgmfLmrelGrilF+ik0Txc7kAzpKfxXnA0m4Js8L/MHs/MZGAIKVwyQwtZZocG6pfdGXgDEv87OG0BeCb/Rc5Q3Z1Qe5+CEW5v3MF+07vyL7OVkggQR6IFTTvaBEh4F5oOB12kp+uQ53mxc6BXhpPY7ZpwoTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=CCUvCB8b; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="CCUvCB8b"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 1448C2027D;
	Wed,  5 Mar 2025 20:42:55 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V19E6CI3sk-W; Wed,  5 Mar 2025 20:42:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1741203774; bh=0w6AH/+Pjx6GOhW5OHJloAK6RQNG/idzAG52ka4prcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CCUvCB8bjEPGJ4g2iFe1OWJh9DezYCD6hGDi7qqBtroOh4r2us2NHXo/AwvxH1J0C
	 K4UNLv8h9Y0lQfENnRpz2wEC8hrgfhORvPyjZQSJBxi7pSpM1VqHYY+sGA/l7cOVS9
	 RHwdSVr97y3tv+y6lY3g16M5U2cLwfQDz6N+9nm4lT2lfA7vb9+nMcTgZzw4OJ0HN7
	 +iezGH+9E3MazcetypMtqGhNpo1lP7VUZzwmO4Cacl2jMqvCrOwFXFsmyeFRkiD+Wo
	 46UpOqMgK8sYe2IMYOBW8CDeYUC68165Wgh7PLgGtiICPRVS/oV+9vsKNZ3tHTJ/ko
	 5EXgzxDJlWGyQ==
From: Yao Zi <ziyao@disroot.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Shresth Prasad <shresthprasad7@gmail.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Chukun Pan <amadeus@jmu.edu.cn>
Cc: linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH v2 1/8] dt-bindings: soc: rockchip: Add RK3528 VO GRF syscon
Date: Wed,  5 Mar 2025 19:42:10 +0000
Message-ID: <20250305194217.47052-2-ziyao@disroot.org>
In-Reply-To: <20250305194217.47052-1-ziyao@disroot.org>
References: <20250305194217.47052-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible string for VO GRF found on RK3528 SoC.

Signed-off-by: Yao Zi <ziyao@disroot.org>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index b4ed4cb555bd..98a0670359f6 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -16,6 +16,7 @@ properties:
           - enum:
               - rockchip,rk3288-sgrf
               - rockchip,rk3528-ioc-grf
+              - rockchip,rk3528-vo-grf
               - rockchip,rk3566-pipe-grf
               - rockchip,rk3568-pcie3-phy-grf
               - rockchip,rk3568-pipe-grf
-- 
2.48.1

