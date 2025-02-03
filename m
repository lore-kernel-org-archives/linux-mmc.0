Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF7320CCEB;
	Mon,  3 Feb 2025 20:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738614885; cv=none; b=et49pNCEJBUhbEc0l48a3SA64mUFfSoQNLrxR0vTHgwyVHbwTvd3xvTphRptmzxss9E1N3hSdORbi5tG9ISsTlOZANGZWJlCCgrVxb2jqV5XX80/7QmePmyGM3oxNx6QaXp5klXt2ARyIFgUowFKl0/N0HdJk/8oc/NIYpwD3yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738614885; c=relaxed/simple;
	bh=IQoBWYmg2Nz0pgK788epXwCnifq76itrILRkaT5HgW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DOVllgfrgp6Age5z3BM/nqTDedR5t0wFvwp+uCZQ4ShtL/5AIab8Lixajd9h0dZYIqLeZLTVoAU/MoDry4h8owefPMjyRWfyN/l/aLcnm8SUOvuuI6G7fA8KFsuxv3Z6uwRCDkcFNC2or69ExeMAs6zyyI5RlGAtxKPHDFRKUC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=CH12uHBi; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="CH12uHBi"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id A8DC025C96;
	Mon,  3 Feb 2025 21:34:42 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XoNBqqeAzUrZ; Mon,  3 Feb 2025 21:34:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1738614882; bh=IQoBWYmg2Nz0pgK788epXwCnifq76itrILRkaT5HgW8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CH12uHBiU3qdj0vVnjrghq0YRk6ejbpmfZaSVRHFEAH8xhsrMKnZRdPLlV+jTWfBV
	 plGt0WBDMALwJTdZN+e3O9t0MI8JPdekRna9Hf/3zRpz8vj5szqYtiaOCg3Oi13HkK
	 1l61iedZG9dnWr90/0UIVoQSex5RwsT2sAWPVVLXrDnSt+JTN4oiCy5P6ub4iZ2xGI
	 rDbds7YEFp8NqFZ5UKm9djEcNVQ0whiKqfX3Dzdm2Th2LMFKR6eiAgRpJzNI4IeXVW
	 oTeHWHicRf9CpGhUklmh1YIsASSCS6ekmtc+qxSN+HIo/uhwt1rjkO3OQgVLFzVNNV
	 w6qGz4LH26AVA==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Tue, 04 Feb 2025 02:04:16 +0530
Subject: [PATCH 1/3] dt-bindings: mmc: samsung,exynos-dw-mshc: add
 exynos7870 support
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-exynos7870-mmc-v1-1-c87cfc72be4a@disroot.org>
References: <20250204-exynos7870-mmc-v1-0-c87cfc72be4a@disroot.org>
In-Reply-To: <20250204-exynos7870-mmc-v1-0-c87cfc72be4a@disroot.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Sergey Lisov <sleirsgoevy@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738614863; l=1008;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=IQoBWYmg2Nz0pgK788epXwCnifq76itrILRkaT5HgW8=;
 b=KFz1iYVIYBoju+EX3ocQgeo++tOiPJqXolP09EnxjUk4JSP6rU9aAUyiDKQ7R4vL1dHX08f+X
 fjNYbWUhrksAqbrtTqdmwPcV2duzRn112Xj2e1ubgVoL+n2P+ZWIThk
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=

Document the compatibles for Exynos7870's DW MMC driver, for both
non-SMU and SMU variants.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
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

