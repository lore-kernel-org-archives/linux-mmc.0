Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0E01D8A0B;
	Sat,  1 Mar 2025 10:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740825820; cv=none; b=Vce/aoOoiU2lYFmZMv6xoneULKWMFzABdLPsU6Ju5b/rT8mZ+zQJhogxA774+/Y98EGweuGGRcL3Rks+73pCHsJOKFNzWpjL/e58vdYaV+FwLwL0fN4ghZUih/AVD3MgKYDCxaZuZV8usJyb/WDkgXUAUY8Y6HSFf+Ic1KjA8W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740825820; c=relaxed/simple;
	bh=IcxoBNMF866xo6B/pUEpfJhgIiq85yQkiPhUYjcLSRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ayb6mXu7VlDLkxHHsQAWfxcFux6K/QcuaYKycPWMfmOVnlLzrOp2l4CcyT2UX2myc1rkWIMeqGm7zPfCIecdWfAR1S3aar9dmRgUJm5maO12XLKEE8/uegVIQL+wOjuykIb5wGR1pDVa2qgNkmnmJFcd7u9lKE2CTxYRwgX7BCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=hoFZ7TZg; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="hoFZ7TZg"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 5D34A25DBB;
	Sat,  1 Mar 2025 11:43:37 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m4hbEaM-UyVA; Sat,  1 Mar 2025 11:43:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1740825816; bh=IcxoBNMF866xo6B/pUEpfJhgIiq85yQkiPhUYjcLSRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hoFZ7TZghC1eDtUuv1kanXee1IlKgZYG9RzjcQosospzlwi/nBsgFwbcx2Cb9Kfa8
	 6fEPDf5ErFx5EoJgM6Pcw9OvS0PDlvuGoI3iUgINjn0hfTc2GGX1WSmihcmNgp2pIQ
	 vw6Iyqcdb0DITFJr4sZZFC9ECPB0eMYvxxa0PI5eQrtV+5CDh7m0gl04HNuOWxrS6L
	 Sk9/WAG1V/AsSpfdgZlk3/XUfRTYs0kVu8jkCrc83uShORJoBDH9MYzGii/c+4+xtk
	 6t9n9StLL0rOBc/fSQMrAkpdk7o+exCN9X3V60TPDEu9hlW3/J889yWrFcPVXLXgcu
	 eqDQZG+xCCjxg==
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
Subject: [PATCH 2/8] dt-bindings: soc: rockchip: Add RK3528 VPU GRF syscon
Date: Sat,  1 Mar 2025 10:42:44 +0000
Message-ID: <20250301104250.36295-3-ziyao@disroot.org>
In-Reply-To: <20250301104250.36295-1-ziyao@disroot.org>
References: <20250301104250.36295-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible string for VPU GRF found on RK3528 SoC.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 7936be79159e..d43c3f7e74fa 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -16,6 +16,7 @@ properties:
           - enum:
               - rockchip,rk3288-sgrf
               - rockchip,rk3528-vo-grf
+              - rockchip,rk3528-vpu-grf
               - rockchip,rk3566-pipe-grf
               - rockchip,rk3568-pcie3-phy-grf
               - rockchip,rk3568-pipe-grf
-- 
2.48.1

