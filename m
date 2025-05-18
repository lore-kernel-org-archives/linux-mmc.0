Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801F11F4701
	for <linux-mmc@vger.kernel.org>; Sun, 18 May 2025 22:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747606060; cv=none; b=kTWZ6ZfcFq4VxqqzU19Qi+J0GH24HE7hVrYEDmtJ0MjFBoLRpPM2BHyiuIEeQB4Kyp3GpRNgupT7jLLU0O6glQoy/67pDzk4ZolGn7lHRbFKgJ2Xf0s/aDMdw8y9/rmsKmjm//gXG7UCj1/AoQ8x5V8xVbTZpuhbKfSbt2OnpW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747606060; c=relaxed/simple;
	bh=BM/558NIb/OQWzTPVj4yzIGBsEsv0oJQTjiJ9z3MSy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PfasoliUsHHcbxecrYmRTbmEddvLCunJmuZOTNhWo0efbQP1T2V/CzfVVts20UQCSXGCGyqCG0ZD160Gh+tj1o8kEwZLY2YCT9jNTy1yMgvPDPoZpGOWMT4bPq9bvF8vezSI0AFHg6QcSu6FpBD+UhHdJ4UJuPPq8TKdsc9Nb10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=crrVtVe1; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="crrVtVe1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1747606057; bh=JuYEKWBVukLDcGbYOqkONpNdiBoEcCXdcXXV5j7NdiE=;
 b=crrVtVe1lFeit85tleXMWUN2E12gYcD8eQUk8UozeUvoPRun+MW5+4dxwmstDK8WEJlrM13SH
 3pUMqB19fsmNpiZOw5xWZtnCeHP+BbWcs6rSzgzFzTd9mHN2/Z0j+vz8sLDOR4hk8D7qxUUnGrW
 Cyrwp24/Abcdg6W5Cbk/VAecTPXL91dLyOLHNOP9tkIUogkRJ7fwjJ/TPJL8mVwvHUhP9Y2XHAw
 hV358oTMq9pP51a4mZQrWaYSXH8wthTv9lpjodKfB6bYH3+JJF/ZrYTa4yiXUwYM5WfVl64AFKA
 2D9FVscMeFKR+NfWYagfnlKfbi1l7UtksTHC+MFf+pcA==
X-Forward-Email-ID: 682a5a2678cae75fbd8d46da
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.3
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
	Chukun Pan <amadeus@jmu.edu.cn>,
	linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jonas Karlman <jonas@kwiboo.se>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] dt-bindings: mmc: sdhci-of-dwcmhsc: Allow use of a power-domain
Date: Sun, 18 May 2025 22:06:52 +0000
Message-ID: <20250518220707.669515-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250518220707.669515-1-jonas@kwiboo.se>
References: <20250518220707.669515-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 7e856617a1f3 ("dt-bindings: mmc: Add support for rk3576
eMMC") limited use of power-domains to Rockchip RK3576.

Remove the power-domains: false to allow use of power-domains with more
controllers, e.g. with SDHCI on Rockchip RK3528.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
index 5fb347167004..f882219a0a26 100644
--- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
@@ -120,10 +120,6 @@ allOf:
       required:
         - power-domains
 
-    else:
-      properties:
-        power-domains: false
-
 unevaluatedProperties: false
 
 examples:
-- 
2.49.0

