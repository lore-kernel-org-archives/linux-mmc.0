Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DE1319860;
	Sat, 11 Apr 2026 19:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775936613; cv=none; b=pAUab2QGGOkaUMvhMOWvWNYnS8+sVaboveg8jCqO2ju0EyLL3s1wkiBsDOlLD0eSPZsUcdllPByvJsxqe6UdLpfrIOfucQ/sBLlKiZuenfeF6moJAYvWaIRzUSYtPBle6k+Y153eyL9HdhrZ9Nf9CNsKX17vI8pkBcqFlUjK49w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775936613; c=relaxed/simple;
	bh=4CDtd48D4+FakVhspP6QEkGa6KDIzbl3i1BOjWab/54=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bU2KGtD5w3102tABW6vPvlxjJuQ6S8XyYKRZKrs9ytarY1+YXuWcYPEzLQiL48o/Mr5i7x/HyAnTvf5nScfNhVNdSTNOifbmKAcYAHvAf/UdSKGJWoIgL9f+TtLGOLPEafSKENKQCEHXXVuPMYFp637buP8HqoitON3KpGDHlrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=J1W19y5n; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="J1W19y5n"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id C4EC3264FD;
	Sat, 11 Apr 2026 21:43:29 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P5jBWUw7mKPY; Sat, 11 Apr 2026 21:43:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1775936609; bh=4CDtd48D4+FakVhspP6QEkGa6KDIzbl3i1BOjWab/54=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=J1W19y5nDv1Ii9sOFG8P9NbU2/nScF/np7Rz8a2NsCcQdyOHHAYu6zLx41GfPBZr2
	 y9EeSmgzl/IimSYWd2xd29ESy42MRqkSpO8eApCZNN+MZwAlsm+DX3UzBfPaX7qIUz
	 39BHQm7LftAhdE5J56SB4Ed8uyzlnyGVt3UxeCuGID+isvRSjaNwV9eVVYQfhLARiL
	 C6g6Nb3KDUHbQ1pGaiuRVFm90gvlqMYR9gSgmy13oRmPeRmtQoIy7nlFv8eHDU0wwq
	 nziM/YDEzB+4vrdR45VyiSK+qWhCl/hJW8Mpf+DF6LyHQpeyLHz37biYa464A5azZt
	 k3nNel5ix1Ugw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Sun, 12 Apr 2026 01:13:14 +0530
Subject: [PATCH 1/2] dt-bindings: mmc: dw-mshc-common: add option for
 configuring DMA threshold
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260412-dwmmc-dma-thr-v1-1-75a2f658eee3@disroot.org>
References: <20260412-dwmmc-dma-thr-v1-0-75a2f658eee3@disroot.org>
In-Reply-To: <20260412-dwmmc-dma-thr-v1-0-75a2f658eee3@disroot.org>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>

Some controllers, such as certain Exynos SDIO ones, are unable to
perform DMA transfers of small amount of bytes properly. Add a property
to configure the DMA transfer threshold.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 .../devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml          | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
index 6f11b2adf1036..1693277957a91 100644
--- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
+++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
@@ -57,6 +57,14 @@ properties:
       force fifo watermark setting accordingly.
     $ref: /schemas/types.yaml#/definitions/flag
 
+  dma-threshold-bytes:
+    description:
+      DMA transfer takes place only if the transfer size is equal to or greater
+      than the number of bytes defined by the threshold value. Some controllers are
+      unable to perform the DMA transfer properly with small amounts of data.
+      This option allows to configure the threshold up to a comfortable value.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
   dmas:
     maxItems: 1
 

-- 
2.53.0

