Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9581C22A7FC;
	Thu, 20 Mar 2025 21:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742506573; cv=none; b=XkN066eShC3H+fPVnTjycRZdJ6l6vKtaUS1FzjgZ61hLUAD3pMPIYZMpI+INA4AsBgaeCaQlie7Vj3iGwWTAkB2/2Y9KYJqzTEflVRUfmhkDaDcVfM+XDlPz6F4qbuV5XxSZg3zIZftrYS0ZtX+s8RTtOhrPk14JnvIOQXsnlgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742506573; c=relaxed/simple;
	bh=3So0h4DZDusrlIA9LF7epHH3a7pM9TCHj9InISpVgJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SXNoqpTQDWq01FQRmMXFppWV2JuelE9tGU+r6pRSQznrO/n4uBhOPFjK8iHghCzYFxbNRiUicgjJg/BuMUinJWkCaO5ihccgFfPD+7+uGAEurSR1r0yF8Vd/NRM4yy6MhTAA3jwsOH07a/0EUEQfM1l8ERP8mt0GIg22jTPByWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=at8RyIye; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="at8RyIye"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B14AC4CEE3;
	Thu, 20 Mar 2025 21:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742506573;
	bh=3So0h4DZDusrlIA9LF7epHH3a7pM9TCHj9InISpVgJg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=at8RyIyem5/gHQd2L/Wi4mPINhy2peQhygWJ1kOY5sGpsihd+kHWF91Z0tlJaTrSe
	 EMbyA0dqEZjAebOdryhmnMc8Df97K7okyFPZszazp1T66Kyjno4uNCGrMb1ReXByl8
	 gDDBQ3I+s/rpf7IFPnBf/eT/yxcPlBJZsG0X8+WRsN/Z7WrE1sGxDUK16950DPAKZx
	 S1ehodqopi0MKTLoTvn9/zziG8FqIq7nZw6bkt/FmI9G9GOMJCiq+OcdC9tedoW6Na
	 aXuQi9chzjzGX0oeF3W4vvlzIf2NRRRua91f6AuKGfHy/LbQ/3c2UvJV1W84QYtowS
	 GiykQ+PtGFXiw==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 20 Mar 2025 16:35:47 -0500
Subject: [PATCH 2/3] dt-bindings: mmc: marvell,xenon-sdhci: Add reference
 to sdhci-common.yaml
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-dt-marvell-mmc-v1-2-e51002ea0238@kernel.org>
References: <20250320-dt-marvell-mmc-v1-0-e51002ea0238@kernel.org>
In-Reply-To: <20250320-dt-marvell-mmc-v1-0-e51002ea0238@kernel.org>
To: Hu Ziji <huziji@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev

The Marvell xenon-sdhci block is an SDHCI and can use properties from
sdhci-common.yaml, so change the reference.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
index 259f465ea369..e7df7a2a0331 100644
--- a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
@@ -147,7 +147,7 @@ properties:
       This property provides the re-tuning counter.
 
 allOf:
-  - $ref: mmc-controller.yaml#
+  - $ref: sdhci-common.yaml#
   - if:
       properties:
         compatible:

-- 
2.47.2

