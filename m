Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DAB24DCEB;
	Tue, 20 Jan 2026 01:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768873738; cv=none; b=D0u0BNgO6Wr+iG/H7GVLfIXScr4ak0pRCj74OV842MF7JpZaloeUJU3nrZBrAeQsleEg9b8ydtA2uU+ifvE6j7Vq9+1t0rx3ej0c7xhc4ACa2s9Cjd/lHLK0Dgdv0loxcYKsCf40LtRMIfzsVXtM93hG3M1YxSGmSAxc2iOvNKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768873738; c=relaxed/simple;
	bh=/ZlnKnKx7utqc5wND/d2GRMNuYYpxYnoMehK3GUY9hQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yt7TU136db/nq3GY7fLJ1/QLGnoL451EGivVQB8mvMJMDeEw0z4vWhTOtWywXSa55CHV+sOki+QOtyg5MfWwGo8pviEzkRs2F700FKQVZszmmltqc8/tmHe2ZP+TMFwlRFXc0w6Akg9Y6Emn1OukuSeyqK0pT2CWX/UCDoOyY/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEEJuJlj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEEJuJlj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B110BC19424;
	Tue, 20 Jan 2026 01:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768873737;
	bh=/ZlnKnKx7utqc5wND/d2GRMNuYYpxYnoMehK3GUY9hQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jEEJuJljiPATumdLNELfSGh7SGdYUJPcXbVE72c0SE+CmKNtyUkkUcwSSI/xF8p8J
	 nIQlT/T/JDUB+L+uusoha0kDwwf2R8Dw4MR+sX+NwKkVeRFi2jt9ZPEtZ2fk198SXJ
	 +7hodq5wcKqUa8qP4OjlULgqBhRU00zCvGqvxdQFk/tFeHClxFByruqorCUCAxLeng
	 tCufp3bTckdf6sPsdwrhN7e5Vn1GReYH3WGkLMtIeLn0UWh3qpToDfeYCpR1/SDHHA
	 585R1tsBEZjSctmvOMO6THZYJvMLDIe/rvapAvmRvgVonendHKK3sKYH0KdbeVb5P7
	 WLwlZ47KalCcw==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Mon, 19 Jan 2026 19:48:22 -0600
Subject: [PATCH v2 01/10] dt-bindings: mtd: brcm,brcmnand: Drop
 "brcm,brcmnand" compatible for iProc
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-dt-mtd-partitions-v2-1-77ebb958a312@kernel.org>
References: <20260119-dt-mtd-partitions-v2-0-77ebb958a312@kernel.org>
In-Reply-To: <20260119-dt-mtd-partitions-v2-0-77ebb958a312@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Brian Norris <computersforpeace@gmail.com>, 
 Kamal Dasu <kdasu.kdev@gmail.com>, 
 William Zhang <william.zhang@broadcom.com>, Nick Terrell <terrelln@fb.com>, 
 David Sterba <dsterba@suse.com>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Simon Glass <sjg@chromium.org>, Linus Walleij <linusw@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@kernel.org>, 
 Hauke Mehrtens <hauke@hauke-m.de>
Cc: linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15-dev

Some users of "brcm,nand-iproc" include "brcm,brcmnand" and some don't.
The "brcm,brcmnand" compatible is not useful for iProc systems as
there's a separate driver for iProc. So drop it as a fallback.

Reviewed-by: William Zhang <william.zhang@broadcom.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
index 064e840aeaa1..3105f8e6cbd6 100644
--- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
+++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
@@ -66,7 +66,6 @@ properties:
         items:
           - const: brcm,nand-iproc
           - const: brcm,brcmnand-v6.1
-          - const: brcm,brcmnand
       - description: BCM63168 SoC-specific NAND controller
         items:
           - const: brcm,nand-bcm63168

-- 
2.51.0

