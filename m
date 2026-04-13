Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3053A3E7E
	for <linux-mmc@vger.kernel.org>; Mon, 13 Apr 2026 08:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776067356; cv=none; b=hETK9lRvD5u1ISsfINKjNQ4Be+0GUJBC04u7Gwr4sTSRvvNI1pefZMTa33ugkx5gsccSDmwBNXgqAttQGu8Wa/CpGBtv3LLO8lp7OSIGXS8brJZun1wNv6tvjz9xpTlKaxLS6GMMQAPRkOkJBj+zw0i1zB/ur4rQhKd9NNvjFjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776067356; c=relaxed/simple;
	bh=VLqXlHYEYj6QD9rr227aPs6s/WneA13bYBUQMaGOG6g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gKGrq6QU4TyfAMn/SHoz0x3tXNi8oaWBvb9vag0bWn5J7+lEwm4Ekb+GpljY9vmQqB1aDuU8lHJZM3Yfmh6o3xKUZyUZ6Jm/32RnXVCvSOXUU1w/vvORYMH9NsdAF3GaKWlB1WXtwPGoEl9Sr7+njGd1wL86H68sMk9voo712Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8wo875l; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8wo875l"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a2c3dfb4a1so4357117e87.2
        for <linux-mmc@vger.kernel.org>; Mon, 13 Apr 2026 01:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776067353; x=1776672153; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=luHrHS8xuRmiKOe/fYmQbUMhMu1rL/RwOqTb1rEgANA=;
        b=C8wo875laIK9HY9D6ybCEu5xIZxBN2w2JJgBWQUkFWaMrxdsRQZJxY+WHUQgGraqZi
         Z8nofw8GFontuUpm+LHEq90Er+6etBcFV2QoamyA8JynPPQ+gQPmObketRgUOCNOn2HS
         B/+E8iORZXjEBY3A7yWmsND8/KFbGN0JjEHEEqDyrBBekmMqIXtyksGsuvMZUVpFQ3j5
         BaLh1Bi05BiiECCq/kBllzmWhnDd70/desQz81Iq4Hv3Mxim6EICD9eTxacYIjKFzyT7
         pxRealufinfuV1XAcGynzfYXmRrKY1bUpy7QLsAiziMGfneBdRu/8i+8tprACCnXUlLI
         tpZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776067353; x=1776672153;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=luHrHS8xuRmiKOe/fYmQbUMhMu1rL/RwOqTb1rEgANA=;
        b=XYbGFwc1qU6DxjW9IbOl5cTkUEKihSC2DAA7XuFawX8UpRvJ75nKjoERTkEchJLRFO
         SADYZE+MWVGm2SN3uWcgjCghsxHDF/A9o4hF7Lh2aoI3XP4eq3LBl/wxYzVS+hxcN/Wy
         clIldtHdYB31GBlY+p0hdcyF4EcALdlSgm8eLqtY4ZsvT/QzTmOmx5Ywl3XhCtedqCVR
         9qqWGKXEwVCRl7iCDl7zoxjUyBvLoJ7X9f1wPW7w+U0zGL/zluSUyhRAPOvVpkk4+nmB
         J/tpYbIli0zV6FHcEQnDQ88fpv9sWgS6jmM32sUxYuwGOwCgwwL5XmiJOLpL2TCyVy78
         3pSw==
X-Forwarded-Encrypted: i=1; AFNElJ9MzNf64hOEfymmUcdjio9d9VvX+aacb1EkmU37e2X/ubsvS9HiW8lzDax2Sji12CW6/ywgZa9CUlk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1f2lBI+shr3pk2P7w695I2CxKj2ToymTGhizMfwChj5Fc5Kxk
	MMFnyT2gZAJ1MCvtn9IXSIrXuCeE5lKpwASbtBmPMFhWQaNAQTeV2MaA
X-Gm-Gg: AeBDieuGADlXdxKYXIJ2Lw5QoI7zimdu52/Ij8n4wK9mRi0DoUoOo0pRtlPCJpnY53H
	EyKRvlPuB1i7jFlRU18AfCelAvH6o2J+KG4P6gcFktaIaWOhw5cZS0pQ/GwJHSxsKD7N3CHMZW5
	NtQSWBCVO5hPlaWO1lC5QE/uuw5PKyyBwlNw2+9gE8bfQi0xkzOiZQQ+u3s6uokblZ/hSyra7ow
	ik2lWCLLmjB+9M38GGMxYaeCYfTBdxb3g4S8ar2R0J9YbcZxWKpXrWs/SQzOGn2tYFQEKEhhBTx
	q0i39LHDH5F5PeQW2SNMK7//SGMufEt+gtzu8aZAxdnWz+3nwLumcyzMi7qhHVb/xzPpwApCuAc
	+LEAxhPTgw866pF2Igs0s+AN65lQe5WTObkMmCPwPT7G03gAvU/Q5KXdOmaHT5plBZtMhBFLdt9
	5y/oW0xIK+4HNi82INw6SrClRH9suaIg6xPEBfspE44KJJmcnx3IAjLeGQotgPHgtq
X-Received: by 2002:a05:6512:1395:b0:5a3:7528:528c with SMTP id 2adb3069b0e04-5a3efb5620amr4070325e87.40.1776067352455;
        Mon, 13 Apr 2026 01:02:32 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.239.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c981sm32155932f8f.33.2026.04.13.01.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 01:02:31 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 13 Apr 2026 10:02:10 +0200
Subject: [PATCH v8 1/9] dt-bindings: mmc: spacemit,sdhci: add pinctrl
 support for voltage switching
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-orangepi-sd-card-uhs-v8-1-c21c40ec16d0@gmail.com>
References: <20260413-orangepi-sd-card-uhs-v8-0-c21c40ec16d0@gmail.com>
In-Reply-To: <20260413-orangepi-sd-card-uhs-v8-0-c21c40ec16d0@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@kernel.org>
Cc: Troy Mitchell <troy.mitchell@linux.dev>, 
 Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Iker Pedrosa <ikerpedrosam@gmail.com>
X-Mailer: b4 0.14.3

Document pinctrl properties to support voltage-dependent pin
configuration switching for UHS-I SD card modes.

Add optional pinctrl-names property with two states:
- "default": For 3.3V operation with standard drive strength
- "state_uhs": For 1.8V operation with optimized drive strength

These pinctrl states allow the SDHCI driver to coordinate voltage
switching with pin configuration changes, ensuring proper signal
integrity during UHS-I mode transitions.

Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml b/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
index 9a055d963a7f..34d202af909f 100644
--- a/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
@@ -44,6 +44,18 @@ properties:
       - const: axi
       - const: sdh
 
+  pinctrl-names:
+    minItems: 1
+    items:
+      - const: default
+      - const: uhs
+
+  pinctrl-0:
+    description: Default pinctrl state for 3.3V operation
+
+  pinctrl-1:
+    description: Optional pinctrl state for 1.8V UHS operation with "uhs" name
+
 required:
   - compatible
   - reg
@@ -62,4 +74,7 @@ examples:
       interrupt-parent = <&plic>;
       clocks = <&clk_apmu 10>, <&clk_apmu 13>;
       clock-names = "core", "io";
+      pinctrl-names = "default", "uhs";
+      pinctrl-0 = <&sdhci_default_cfg>;
+      pinctrl-1 = <&sdhci_uhs_cfg>;
     };

-- 
2.53.0

