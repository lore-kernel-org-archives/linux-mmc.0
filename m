Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BDD25A2A1
	for <linux-mmc@vger.kernel.org>; Wed,  5 Mar 2025 21:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741210889; cv=none; b=LZSPBqU0zrq5vkXfFqgwvVebcfQIC6eWX97E8IOGR4Pl6AexiYN7KBKN3kknA7OojkGgBhrwzwcuDY14EJ8ToO4Q3kAb9f+krFuSgAb5hGd7bwL/6YVLIonpHirs+vKyaaVQn/B6ZRdgbdWMLia/NfH+12aRRLR2BFM7MLnfllg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741210889; c=relaxed/simple;
	bh=IkqiM9dGSMy8o7VuoFNkOFxHZdKBWtRBUnXF6L2l71Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EcL054ZScn0Kdzpf4pMuCXLtDH7nbWQMfuX9LD7MAlIUnp07BH6q68toXhAn9/77KMmieQX0eavU8IOuTkiIZuoVIlchr8O8Krvrdae9ZUG4Ea6GkrFWhG1Lzl7n9iB+bLd1dEwMeL30v98yaOpTVYTqqv4HJIfWVZuyRO90pJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=FwEPApcf; arc=none smtp.client-ip=121.127.44.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="FwEPApcf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1741210881; bh=rOf+f345+63izWPFL8o6h0GXKY2TapgX/yd88UAmCB8=;
 b=FwEPApcfO6Ci3t4AV3GOZnHjkwDBL4/V1Ua09cEn5Gi2BR5cEoqwjR/FhTiLXc5qVny7O2rNp
 TvjBFlrQ4WTdPPCBn4+3mwEcCmOxp+ytwVD6pGvfLhb+5w7g7PxyoBlL0BetFKdtTeuk/z+zQ+B
 HHwnHKyHcw7DBhrD97rkm0Gr+n4xcKf31sDt/chwPH0MQBq/Fa8V2owlMRgj+K0HdZl29pds4Jz
 yspUG/g40XYLIFAz8yisFdrSNQ1IkuQNs4wYqj6SnrJE/CCuVul2qe6ipOiIj+tHC0toedpQk4A
 tfVGOcpknMB9PY5TmsUKBtgpCsm/GGHMh2sroA854opA==
X-Forward-Email-ID: 67c8c4fd88fb7bbab4530f45
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.59
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>,
	linux-rockchip@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 1/3] dt-bindings: mmc: sdhci-of-dwcmhsc: Add compatible string for RK3528
Date: Wed,  5 Mar 2025 21:41:02 +0000
Message-ID: <20250305214108.1327208-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305214108.1327208-1-jonas@kwiboo.se>
References: <20250305214108.1327208-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SDHCI controller in Rockchip RK3528 is similar to the one included
in RK3588.

Add compatible string for the SDHCI controller in RK3528.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
index c3d5e0230af1..fb2115e805f5 100644
--- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
@@ -14,7 +14,9 @@ properties:
   compatible:
     oneOf:
       - items:
-          - const: rockchip,rk3576-dwcmshc
+          - enum:
+              - rockchip,rk3528-dwcmshc
+              - rockchip,rk3576-dwcmshc
           - const: rockchip,rk3588-dwcmshc
       - enum:
           - rockchip,rk3568-dwcmshc
-- 
2.48.1

