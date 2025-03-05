Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A85253F1C;
	Wed,  5 Mar 2025 19:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741203785; cv=none; b=C93liXNXqElNEqa9NThlcW6M/gTbCKj05ErL+tlQ4NExQGb//PN3kkmL94yX8dwdR5Kevxo6SpxsCV7tk0mwvPUDLIyartFYd+cJLyOWiuKFPLzeO9T5HnfSi/JSNjt/dnVW4T6vLWC1xqlqBVmDIhHkHD6F5xZT1CnVrYWRGRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741203785; c=relaxed/simple;
	bh=jLhEuZAavYZV64SFD7Jfb/eazJpNnOasV/OkFoMIEWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QP1+B2jhvKA8JrAz9sGxNXVFa5WNqZ8U3UKaNJciUZ5c9p5djkBpGM4OWOFT51q8pHb7wOY2d8Xoxldch/drqWIFBH4FdKTDhPLQpQJekkGjFrzEerO9ezOPwXkUTt0YkL5+FH7Oskxt4gMKRTJ9VTTTStr+GrbVW8cw+c5J7OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=aAjF6t+0; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="aAjF6t+0"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id ED2F722BBD;
	Wed,  5 Mar 2025 20:43:01 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YaINrH71oD8d; Wed,  5 Mar 2025 20:43:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1741203781; bh=jLhEuZAavYZV64SFD7Jfb/eazJpNnOasV/OkFoMIEWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aAjF6t+0Mp+5Ac154kaRZFoQrjsS69VITdRo4WfV+DCM4Fz+tSTt4TZjoaJGRn6VW
	 6QLLpQ+s1MYkgi1Jyg10u0iLF+FNgX/Yt9L7VdA6zrZQuUEs+quulYovz0VR7VEOlP
	 o6KoZ73Qv1EDBA30kC3Q8Gwm98SDcBxTU00jF5552jFx+CPZQtjeI97LtuG9hVyzT7
	 QueAM9tNEAZDlZyL8HqTy8sJrVwbmVaNnAS04sJ1W/MKCxAm8Di4rDN2jx0OEfzKMk
	 xz+AfnwLuC1hruI+XDJVCrsurE0UXAMNwFP7G3eywEkwU79UK0wXDNwAIb93+il0xv
	 hOthnnI/LWZTg==
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
Subject: [PATCH v2 2/8] dt-bindings: soc: rockchip: Add RK3528 VPU GRF syscon
Date: Wed,  5 Mar 2025 19:42:11 +0000
Message-ID: <20250305194217.47052-3-ziyao@disroot.org>
In-Reply-To: <20250305194217.47052-1-ziyao@disroot.org>
References: <20250305194217.47052-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible string for VPU GRF found on RK3528 SoC.

Signed-off-by: Yao Zi <ziyao@disroot.org>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 98a0670359f6..2f61c1b95fea 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -17,6 +17,7 @@ properties:
               - rockchip,rk3288-sgrf
               - rockchip,rk3528-ioc-grf
               - rockchip,rk3528-vo-grf
+              - rockchip,rk3528-vpu-grf
               - rockchip,rk3566-pipe-grf
               - rockchip,rk3568-pcie3-phy-grf
               - rockchip,rk3568-pipe-grf
-- 
2.48.1

