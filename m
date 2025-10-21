Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBDC2459EA;
	Tue, 21 Oct 2025 22:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761085812; cv=none; b=OOtJY+EJiS3if638AIthcaN2rKmDT8hVvG21nGzW1AxNAl5ZUSXwWTZJJTAcup05MwFJxSqvq/DPH1JLqW0fQdp0uJDpVcgmlQWSmoRJ41fiDyezuLH1ac8Fh5gfdegyzvsaWBoqtiDjQESoo2zQ/VCnhkopd7zLOphcLMhRbxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761085812; c=relaxed/simple;
	bh=o8VSDj3y67VRcgqNWb54XjaaSFgafhxwtCnN/F+UMOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qrMeWUVRkP9YC8oMLVkqEQbyuXaOGh43T34aQZlZTx6Bg5k2oqKldS+ikkclxTFY26hr0Pvnt5AnK6ohb7O3S3kBZtHgQkjAAlaoOsqnlqM5ZWkcnWeF3g1U/FG0S6MmjVo+JyvM7SUZlW2XZEiS8jEAYVe9m4m+XyXJNS5EmJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=C10ZUdJk; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="C10ZUdJk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=JOqXWQaq3hbi4YpvtGsddkEQ1aOnP/muTiS+mWoANSs=; b=C10ZUdJkwWItkwiy4+X8dFPGeO
	tw1dN3wb13cdOYfLar3mdlKZRvIEzmqPCFHfuxM9Jrbn5GEAakXAWFSLa39RqHpe0OsUDFKFrhhWt
	7nfbZTZNAekNjVDYMrD/lcjpj2Ep9+Tsih4VTtrwPTxGI7ZGlYx99VUhAn4ZwWD1ItYtyTWMfiJkM
	+DAcUXidUhOoj957446vClWuKKwk81UQqWMYBZ75kA81kI/9bLJBmlLG5mFuAjVZVFpLNWnQcFdYn
	l6ARDgXBVM8Ap9ioAGhtSYO9xHimXc6eM6UBNAc0Flgp4TnI8KPCEwcwsHm1yVl8I1PZ0JtXpCva/
	e+IKJg+A==;
Received: from i53875b19.versanet.de ([83.135.91.25] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vBKrg-0006hP-N8; Wed, 22 Oct 2025 00:30:00 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: ulf.hansson@linaro.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mmc: rockchip-dw-mshc: Add compatible string for RK3506
Date: Wed, 22 Oct 2025 00:29:55 +0200
Message-ID: <20251021222955.193323-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dw-mshc controller in the RK3506 is compatible to the one first found
in the RK3288 SoC, so add the RK3506 to the variant list.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
index bf273115235b..acb9fb9a92cd 100644
--- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
@@ -38,6 +38,7 @@ properties:
               - rockchip,rk3328-dw-mshc
               - rockchip,rk3368-dw-mshc
               - rockchip,rk3399-dw-mshc
+              - rockchip,rk3506-dw-mshc
               - rockchip,rk3528-dw-mshc
               - rockchip,rk3562-dw-mshc
               - rockchip,rk3568-dw-mshc
-- 
2.47.2

