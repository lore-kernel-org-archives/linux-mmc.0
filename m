Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225821468F7
	for <linux-mmc@vger.kernel.org>; Thu, 22 Feb 2024 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708612624; cv=none; b=Z8oqjxGgLwllETAy9FV4/CR4j0FAMi5SqcVlghPpaFF026U/qsoibUuHXmXay/V8UJ/LgmcBa+PU2VD5Td93jxAEuxJJcLMjbemsi5TQBqDPdefh5Tr79QYtblsOgR2PJM+kvbENijhcIdzwwBMeNeboP7GicCwBZAgKPYi4fbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708612624; c=relaxed/simple;
	bh=nnCZRUOxTkW/24cgMVpQ/hYl9AXZBZ1Low0m/4suuMY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ny7Je/axLxAS26h41dNbpjGTM9ji0N3AerHt5CpTwx6jWGPf8cUhrUik4FYWAERdm6u35UUA5wvDofSPxnBgtuPfvwNWsdspZX0YBmV9yIVTV0T/X4Lvi30hPFTDAIXMKiHJ37dOo8AjwOmBFpmqZbeLYTSFh9h0v0UIXHR3A3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibKmYX4a; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibKmYX4a"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e08a4c1323so275211b3a.0
        for <linux-mmc@vger.kernel.org>; Thu, 22 Feb 2024 06:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708612622; x=1709217422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4VL4evJUWBm0VSFFmnRRaLa0xGpccdpRt1MOof3PxjE=;
        b=ibKmYX4ahycquPaEThaDObf88Tc+/kT84gTjnGtmcDnwKYRqqG8E3BJbvm7xSIV0DG
         zL8a2JIEk4AxUfhWwMsWaApru/DKWC2m+Ee9EGTBCrQZc52DypPGDUVC8cet9gjpAtOH
         ONvjvy9jgdXJXpJ8mt0U/7KT039T0F/UaHg+MQpuq87q9t6LR1QFwQZhAbGTsbaen9jo
         lAawVfzMmDr8APH6Ye+iVC9zYrIbGuJRBOBNKgDtVnECDckMXJNMlup4svlbZVRqXx+N
         m4LaSojWZ0GXmvzUwr9yehTKlPulN+K2XDjSj9cYyFpgGtBuhLR5czIX9eSpbD2ivaqY
         apxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708612622; x=1709217422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4VL4evJUWBm0VSFFmnRRaLa0xGpccdpRt1MOof3PxjE=;
        b=UK/PoLMjwmsI58TfjUuJy9zsCzBjrDgU6dmS3SwcnJO+rptcIzt6nVO6pqOT10cxXQ
         tZdnKzUJtTfm/ZPgvt2J4XLdn2p7eW7311mc8HWzEkKitMJYmSqQohHNA7+v7Kjant99
         UjqjgAWVtWIVzDwof++i1JJRh24VoCvKnOPH+Aqi8q6HDw4QyfwzL9eDH791WUDVdX4X
         ADK2cPjsBFDFIS80FpqD44kubPb3fhIab/nHkuEUZhmSBJMnl3BVfCPmDdacHI3PdPW+
         yYDKQSoiM927nVKDOk6Mw7QpRIUAkkbAD/c2sVqKmvDMOQoMyNvnXCdEC2nqlSZ1JIGI
         UGxw==
X-Forwarded-Encrypted: i=1; AJvYcCVuzBQNWBEYUxoC+Hfp+hXEmCO2z12NWDYqf0qaLs7jkJA9lvRv5x6cnFeAWSHi6KHKj/hsUM++/zmogHIdYNRZhG2dD02+prwk
X-Gm-Message-State: AOJu0YzIDgIm9ietEU/GuCJw3Xs3G7re7e/O+yMDv+hPnSyD0euf/wpH
	gz9SfUbPgWaBVYDxCD1ak2Ma2NpLmGoaEgCOBpuRCS4tmoxQjsckgW/W/Tgy
X-Google-Smtp-Source: AGHT+IHSBdji4hjnwfYwNyLlqgaSNZLmE/V3QFINlzQaPZYHduFiddlbXIG84H0+dIdLw8jJfef4JA==
X-Received: by 2002:aa7:8a4c:0:b0:6e4:c85a:11e9 with SMTP id n12-20020aa78a4c000000b006e4c85a11e9mr2513586pfa.0.1708612622372;
        Thu, 22 Feb 2024 06:37:02 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:d30a:d617:c813:c70f])
        by smtp.gmail.com with ESMTPSA id q13-20020a056a00088d00b006e05c801748sm10956664pfj.199.2024.02.22.06.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 06:37:01 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: ulf.hansson@linaro.org
Cc: robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.or,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH] dt-bindings: mmc: fsl-imx-mmc: Document the required clocks
Date: Thu, 22 Feb 2024 11:36:56 -0300
Message-Id: <20240222143656.978759-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

The fsl-imx-mmc hardware needs two clocks to operate: ipg and per.

Document these required clocks.

This fixes the following schema warning:

imx27-apf27dev.dtb: mmc@10014000: Unevaluated properties are not allowed ('clock-names', 'clocks' were unexpected)
	from schema $id: http://devicetree.org/schemas/mmc/fsl-imx-mmc.yaml#

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 .../devicetree/bindings/mmc/fsl-imx-mmc.yaml         | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-mmc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-mmc.yaml
index 221f5bc047bd..7911316fbd6a 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-mmc.yaml
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-mmc.yaml
@@ -24,6 +24,14 @@ properties:
   reg:
     maxItems: 1
 
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: ipg
+      - const: per
+
   interrupts:
     maxItems: 1
 
@@ -34,6 +42,8 @@ properties:
     const: rx-tx
 
 required:
+  - clocks
+  - clock-names
   - compatible
   - reg
   - interrupts
@@ -46,6 +56,8 @@ examples:
         compatible = "fsl,imx27-mmc", "fsl,imx21-mmc";
         reg = <0x10014000 0x1000>;
         interrupts = <11>;
+        clocks = <&clks 29>, <&clks 60>;
+        clock-names = "ipg", "per";
         dmas = <&dma 7>;
         dma-names = "rx-tx";
         bus-width = <4>;
-- 
2.34.1

