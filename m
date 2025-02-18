Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882011F5835;
	Tue, 18 Feb 2025 18:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739904527; cv=none; b=hl80ltao/Ed1i6qfWXQgad+ZGSgmNNJRJxZhLO+yIda8So8hAzDmloY1dbHrvUI5oC4JQdArs/jIF6iKhye5SmHCE1o+CVBp24hEYHnRedFa/ngSpt2Iai2MhCSlnmReK1KBtLfMMmsleOqGaoq/VPk0xSUevSpFfQSer8m+k6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739904527; c=relaxed/simple;
	bh=Wftp7MvsLHIwZb3fOvJ0W49HFyWbpQRWeey9OqYXAME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f/1nVsS0ZIX1PY9DTFVoPss3b7ZGvqXa8Q+LzI7JYg3J0+XEm3mrQl4Z9ghHEWfQo6Mk/X7N0IH3KBFoNIl243ENZItVbqaFT2yUZev8Txye5hE8xRcbxL/2v9GrzbJChciOQKNibTbaGZwc5FKS31IRBHQ9WSPESDxae2rKdY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=OfYLH2/6; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="OfYLH2/6"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id B904525FA1;
	Tue, 18 Feb 2025 19:48:37 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eNog1CxFu2AY; Tue, 18 Feb 2025 19:48:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1739904517; bh=Wftp7MvsLHIwZb3fOvJ0W49HFyWbpQRWeey9OqYXAME=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OfYLH2/6RVtJyn5DA4KOqwNwpkm4900+aC1aXIhRfVmz5bdi1Qg5fac8G8oIRrvgV
	 hDImMkouqWxyWqPNLUwKCkJB+3JKiccxAku1GkT1unH6/TmwR3Ijo0WO7ZIut0ClPQ
	 WGkZlw/RtZsK+eVbEvPKPY6I3SIkkdlidyRij3/l02++B2KlaTCr3ONdSeqyWY0/WF
	 1EehaOdrHLE9SGjnul/pfF8rnflbinJrPukRkoQVrWww51NGNiRM/SB9kELI3drSB2
	 IlmEHeGCLyE5UfGkE6P9/ezr7OsAy2x/nJC7xZrNBscQBpdjKM4vSfhNHKHBiHANFO
	 SjxQDnDjb7fZw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Wed, 19 Feb 2025 00:17:47 +0530
Subject: [PATCH v2 1/3] dt-bindings: mmc: samsung,exynos-dw-mshc: add
 exynos7870 support
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-exynos7870-mmc-v2-1-b4255a3e39ed@disroot.org>
References: <20250219-exynos7870-mmc-v2-0-b4255a3e39ed@disroot.org>
In-Reply-To: <20250219-exynos7870-mmc-v2-0-b4255a3e39ed@disroot.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739904507; l=1075;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=Wftp7MvsLHIwZb3fOvJ0W49HFyWbpQRWeey9OqYXAME=;
 b=9tuGtTjedvLmLgkheSktSM8qsQuCnfnX2opXXbt1t35cYbJZPqOH3FWv+RHB665dj07x7NA2v
 1oJIaOeZuJtDzpu2PGXZ1NXySiSP7Vksn/GQodZFORqV7MErTJJQofH
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=

Document the compatibles for Exynos7870's DW MMC driver, for both
non-SMU and SMU variants.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
index ef2d1d7c92fc8ad7456379bde498badf7b3201c8..e8bd49d46794ee19e994860564a1612bc9d6e642 100644
--- a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
@@ -24,6 +24,8 @@ properties:
           - samsung,exynos5420-dw-mshc-smu
           - samsung,exynos7-dw-mshc
           - samsung,exynos7-dw-mshc-smu
+          - samsung,exynos7870-dw-mshc
+          - samsung,exynos7870-dw-mshc-smu
       - items:
           - enum:
               - samsung,exynos5433-dw-mshc-smu

-- 
2.48.1

