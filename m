Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD29E407585
	for <linux-mmc@vger.kernel.org>; Mon,  2 Mar 2026 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772464433; cv=none; b=XWIvLKnfxF6s8BM7Ju1JMrQDaGl9lq1bxFgdQdvXxjjx0xbrUsH+amFzISjhXm/gVkv7x6NlEQkg3+RbFVxLkjpUWnq+wv0rjn7AULP4viOp7DML76gAiDc/15bttUciMYrWqIEbiH1Hub09nPvDMyEUPimBB7iM6uIQmtZYSM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772464433; c=relaxed/simple;
	bh=exV6OpyIj+E7YmJqvnw7Yw8GsUS9yk0uhliZbbcVwO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PGOARgoDb0VnCvXGINJZxu8AlLajSLJMnAEovy4vvtvrdvRFRntAHS2VwlxI79mKKfV/oHEXOlqOxbDGKEfhdWb2UGs7539uXt2yBPFLQJOetiDn+5miwuXXNXzY9Bun2C0nvBGNO2gHRkcnMu6kfxrmSIT32MKjWPixL6HqQrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CG8Vx7ww; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CG8Vx7ww"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4837584120eso33053535e9.1
        for <linux-mmc@vger.kernel.org>; Mon, 02 Mar 2026 07:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772464430; x=1773069230; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qgPMIovbEThLlPPQFVARziyNrmjJuegOTMLHImP/d90=;
        b=CG8Vx7ww0tXxRO7Eg/G6HV03WTXtaN9QMABtsVS26AWARofAao4UUhC9ltY19dHQIH
         DvhQMPMZ9GjJu3qsUIhgfojTansCm/71TOICBwsVbtlbHnPkQOX8wgLekjxdxY40yZQX
         BvHStAslMMGXd4vvnDSShPz5MeUcFHT9L7+URLl4lorLMmM0RepmqboWkrtW6qHws170
         hoJV6YiEufyhIL9Yd4rV8od079o5/G7ziDf1HEpXSGpaDGDEIOgcsJH63mi6Qm7VK5lr
         TA+LBpNdnzEL8PSKvyfFN0yt9WR7bME4b1ti3rgP0uR8AJ84olBRXfYs0aOd9UMT6ArS
         ot0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772464430; x=1773069230;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qgPMIovbEThLlPPQFVARziyNrmjJuegOTMLHImP/d90=;
        b=TCuOGk1h1vyHz2I7RmhCOefH+vN3A1uAdo9qkooJBf2V0p75TOYtqFcUdeOZmpjt1T
         HbRsA32eHD8VaagIilGvFBUTYkNNKRuPNKdI+FvUvKfbbG5OmY3+cEOht10rVy9ln66k
         FFMrK1s5Ifyy3eMtN/oJ7/jKA+6huIx4eBc0bzCs7Sf5RHWx0NQActkFh9AAc2NbIkTJ
         SVYyPaNXTWwYG5OJZoIfUvVEmqUNTsneHXlSllnQcLen6pf5IAy9iDv3gQgk2947anBH
         7DtZnSUd4maAgyMRpsI0hMaBElJNVElTTbV96UQeAtJxusi+xtjA9JYum1//k+26qTjK
         fB4A==
X-Forwarded-Encrypted: i=1; AJvYcCWfbolIQAY4vz5CUYqyGzjQZSiBY1Cz9yBk2+umw2NIrUuoB/2WHpfg7MSEMU+HV/+YJKmHosogq0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaFkWluzjhi+7jH/kREiaef12Mz25oKH9Hla9ZA4TB9dkFQ5ja
	RVgXt+zmXJFHlPrJnY45knOrxEKJP0Sm4cw3N+slcNgHSOM5ftZV709U
X-Gm-Gg: ATEYQzwAhSUU8g1/HXXG0+afKCYGqWtIP8ww2XEUDPBi4ZhWS/XpI2qNlIx/1CiA1H7
	304QPQHYZgwyvtOJmQydLqmgeb7fRCec6jDC6NlRAaLyIS5TozP6Fpazzq0R51EMLL6HVgD2AlA
	FcYAWD0ZAlRtubvjwwDP7V0xi7dwvdoClLvu7XOMRDh6J569POM68AFMEwEUZVPMweKQ6SlokHa
	z++SZLuZWmnYu2JhJUp3Fe2N8YwS0z1NsWkSeFRRnjYk9PpQ+vu2lgx3usDhpFxap7JgBVmwoPu
	bTheHDkkORlEprjAx98DZSrxihyZOD3Esu3JHLUvNCbVU2Te7HoyRyTYYu70nNaR1L+yBBMtwkw
	4uF7ukwAvr16FIP2mgZL9lSgvRHYzFw56CBgfmHpa+umBZBd8PhXzGwE02kPutIGYANBHjG8P8e
	3zMZ+zymo5/MBFFsk5qL0J/9B1a3zv+YG0/Vyxv1ownjU3prpcjr0Quxz3psTCzqUthQ==
X-Received: by 2002:a05:600c:37c6:b0:483:96d8:9f75 with SMTP id 5b1f17b1804b1-483c9bc5b89mr218710175e9.28.1772464429956;
        Mon, 02 Mar 2026 07:13:49 -0800 (PST)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.235.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd70e692sm437240265e9.7.2026.03.02.07.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 07:13:49 -0800 (PST)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 02 Mar 2026 16:13:22 +0100
Subject: [PATCH 01/10] dt-bindings: mmc: spacemit,sdhci: add AIB voltage
 switching registers
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-orangepi-sd-card-uhs-v1-1-89c219973c0c@gmail.com>
References: <20260302-orangepi-sd-card-uhs-v1-0-89c219973c0c@gmail.com>
In-Reply-To: <20260302-orangepi-sd-card-uhs-v1-0-89c219973c0c@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Iker Pedrosa <ikerpedrosam@gmail.com>
X-Mailer: b4 0.14.2

Add SpacemiT K1 AIB register properties for UHS voltage switching
support:

- spacemit,aib-mmc1-io-reg: AIB MMC1 IO register address for voltage
  switching
- spacemit,apbc-asfar-reg: APBC ASFAR register address for AIB access
- spacemit,apbc-assar-reg: APBC ASSAR register address for AIB access

These properties enable the driver to perform voltage switching between
3.3V and 1.8V required for UHS SD card modes.

Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml b/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
index 13d9382058fbc1c12be1024d1c550f04a825673c..4d6590aa8262009b6e5697a04b45cf3736c0fa42 100644
--- a/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
@@ -32,6 +32,18 @@ properties:
       - const: core
       - const: io
 
+  spacemit,aib-mmc1-io-reg:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: AIB MMC1 IO register address for voltage switching
+
+  spacemit,apbc-asfar-reg:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: APBC ASFAR register address for AIB access
+
+  spacemit,apbc-assar-reg:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: APBC ASSAR register address for AIB access
+
 required:
   - compatible
   - reg
@@ -50,4 +62,7 @@ examples:
       interrupt-parent = <&plic>;
       clocks = <&clk_apmu 10>, <&clk_apmu 13>;
       clock-names = "core", "io";
+      spacemit,aib-mmc1-io-reg = <0xd401e81c>;
+      spacemit,apbc-asfar-reg = <0xd4015050>;
+      spacemit,apbc-assar-reg = <0xd4015054>;
     };

-- 
2.53.0

