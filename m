Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BFB1CBEB9;
	Sat,  1 Mar 2025 10:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740825828; cv=none; b=hdH9PaY4IWf9K9Ndncq5jPEGIYZzzR/n7EzDmNMtPJBRR9OoOQWKmEstxbAZ4C4Xy58kBB4UkjHOBwhPtnIeBIRNQzs7g+NngyHUUk778juZ98iZE9WHnxE+V0sNEfsa8IiAdOZ9my3VTUlr1ufWYmXTaLj7mRwb01fNLpuP9uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740825828; c=relaxed/simple;
	bh=b7EbBDCtbwDBTCFmgFj8wrNPICeYFLhWlDWP8XBGTec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SuVnapwFjibsHOTdaxngJ9uLt0csQf5oFia7N6d4K6oMAO5AbqkDE5rZ7JpTUq84qRRsLYO5OSzlXL7WlkBwe+2Y2VhDkhKKUAytTg3Q2gPqWjowOKHDNnupZj8GXRI7EbetjF3RReoYlXwIix8VZzoEgQiZFdLvRGAOqHiAqTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=fbg4aZte; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="fbg4aZte"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id CAC2525DBB;
	Sat,  1 Mar 2025 11:43:44 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1ni52fxJz4eH; Sat,  1 Mar 2025 11:43:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1740825824; bh=b7EbBDCtbwDBTCFmgFj8wrNPICeYFLhWlDWP8XBGTec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fbg4aZteoWIk1PerzubZjJTAQZ3pb5oTYB3WN36lEuux86x28ez/s6uBAeb1sWuXM
	 Di4rO7n9STt6wc2/yXaSHdQsvLqu8V+B9oupqqqp33wqTquKleC/pWAn4MhCGjpcpX
	 aPMPMMIkgJ2aSu0CWEINX+Jy8mbKYs2r0k88rqt6DqXSq9CH7wJfElqUmXjrTvDe/O
	 Rt7EKSZn+CG0WRJhLGl/HRfbfzOlk55c5sIHF04aig4AqzSd/dDxipfCDC700lL2bW
	 nhV4GnlH4rnAXD2m5pvRDMWSjCDh79Nd5/q0f8YoRvr7dLTh6TKL2+eY/+e3mWkWWD
	 dZ0RtcNiL8ORg==
From: Yao Zi <ziyao@disroot.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Frank Wang <frank.wang@rock-chips.com>,
	Shresth Prasad <shresthprasad7@gmail.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Jonas Karlman <jonas@kwiboo.se>
Cc: linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH 3/8] dt-bindings: mmc: rockchip-dw-mshc: Add compatible string for RK3528
Date: Sat,  1 Mar 2025 10:42:45 +0000
Message-ID: <20250301104250.36295-4-ziyao@disroot.org>
In-Reply-To: <20250301104250.36295-1-ziyao@disroot.org>
References: <20250301104250.36295-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add RK3528 compatible string for SD/SDIO interface.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
index 06df1269f247..ea0feb733e32 100644
--- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
@@ -38,6 +38,7 @@ properties:
               - rockchip,rk3328-dw-mshc
               - rockchip,rk3368-dw-mshc
               - rockchip,rk3399-dw-mshc
+              - rockchip,rk3528-dw-mshc
               - rockchip,rk3568-dw-mshc
               - rockchip,rk3588-dw-mshc
               - rockchip,rv1108-dw-mshc
-- 
2.48.1

