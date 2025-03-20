Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955C1226D18;
	Thu, 20 Mar 2025 21:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742506572; cv=none; b=gSziWDtygBdhQW3KLM6fEgPsvh0uJO1WERbHY4+fcNEQ+isniGxI+0NRGSrEFuhMFVrwICystmB4un/Qb/COhpvZbuSgVbktCTtxTZi1PHkqh9wmEmlbVeQSNmpPzDBeJ8jksTqqOYvQjngAcGUv1JEbkIT0R4gFVVsdSM7uV+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742506572; c=relaxed/simple;
	bh=H8AqflaZrnaY5u5MW00jxZ5DD3lLnvsNFAtE2yVcmKE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GpIWlvMgpQeFBIprlGe/+bYX7KKAQDC/Yh1iTZN9lJymhui56QtjIR9RanTYewrw/wZQHi2RtWzOctIJB61p3HAfJiDnk4UydF1u6cOI1/QEldmgHRdjyHvNwX2y1zuzRJhYnG0F1HKUBhMYyzYoHeRpQ5w63PumyxrLHAJdW9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KuOyvJIe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KuOyvJIe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95A0C4CEDD;
	Thu, 20 Mar 2025 21:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742506572;
	bh=H8AqflaZrnaY5u5MW00jxZ5DD3lLnvsNFAtE2yVcmKE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KuOyvJIeXjkbINKSIgugZBKWFsCE4C3tUmQ29zaH+LxKB7Rto5hkunR8yZCwL9icW
	 2/gZWuaEerxqT/VWj+LBJxaelle5+W1pcG7w1A3ahxn90BKsMMJ8P1IIwltI1jhgM6
	 +afuoAGvTO5jnriyyxlqHgs/2GBSZbhLOJ7/g6ydT0oh4vp9GMqTsWS6plXykX6z1G
	 nJd+KNlkEGZZTBeQD2eTjpQfjelOW6mhcJDD5RDi7rOiDcLdVUMuzYwMgeG6/P6/An
	 4DtB99451+OqaQltkTr97S0N+aZKk3jX45wAsZcHYAbULOboAnKlN7CEjVbIwxgYWb
	 HeU5z+jkz07CQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 20 Mar 2025 16:35:46 -0500
Subject: [PATCH 1/3] dt-bindings: mmc: marvell,xenon-sdhci: Allow
 "dma-coherent" and "iommus"
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-dt-marvell-mmc-v1-1-e51002ea0238@kernel.org>
References: <20250320-dt-marvell-mmc-v1-0-e51002ea0238@kernel.org>
In-Reply-To: <20250320-dt-marvell-mmc-v1-0-e51002ea0238@kernel.org>
To: Hu Ziji <huziji@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev

The Marvell xenon-sdhci block can be cache-coherent and needs the
"dma-coherent" property. It can also be behind an IOMMU and needs the
"iommus" property.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
index 3f48d8292d5b..259f465ea369 100644
--- a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
@@ -52,9 +52,14 @@ properties:
       - const: core
       - const: axi
 
+  dma-coherent: true
+
   interrupts:
     maxItems: 1
 
+  iommus:
+    maxItems: 1
+
   marvell,pad-type:
     $ref: /schemas/types.yaml#/definitions/string
     enum:

-- 
2.47.2

