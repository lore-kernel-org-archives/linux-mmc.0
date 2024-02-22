Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE2343AC1;
	Thu, 22 Feb 2024 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708612758; cv=none; b=TgU72eDm7wX4vXnd+zYlT30r/KCR4OyFK2VXKe99uEoqcPdHtX65OZmNphZLL/1w9I+RDrv2qzmDEWOugiO9XFP4SXYxzf5DS1A0LMA4jgfMjq2CSfM1ju4YOHSiF/fvwFP4E2CGODytWRnmq56X3Zej8zlp3zBcZSFjyQEx3UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708612758; c=relaxed/simple;
	bh=wSOvlb03/D7krHVr7xUayF+tLqXr3NS/442O6IABCvo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bWSJKwCRBBAh4yBujw282VyfoQDx1e/f0XEtyocTIKxO5lOmBKgNJAAa786Q2VjL2GTYmHiJ/aW74G6H+Wny50ZoOnLJ0U2wYhJFf950B02MgEQkCui0ZfO3VyaEgst/4cLQqmEVyL7ya56r9cHIbC3TMDuKdRSxcbzqRQu+Se8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J79RmMG/; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J79RmMG/"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dbff00beceso8436985ad.1;
        Thu, 22 Feb 2024 06:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708612757; x=1709217557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g2KoF5bOnKbOW3thGz1lV4ex1ONuDNSa3Szl9tuUuXc=;
        b=J79RmMG/u8lrtunGsvNJL1JPjaUrGJqVY17vyFrxzwmSEQ6nrCvVW1v3WUFDyL5Coh
         hP7UyP06HB4Hlhfuor3y4y9HINKEmaw8/htkoqA/TFZzZS+qMzKXEoqMjgUqCDoGvy+p
         kuOToSxOK8YFqsfP/C+3oXS9nijqY8+lkGMuYjhx0T44UTweb6L/VSlo9xDnF6iqm7Ef
         8qEMsqZgwm7UmFdutxQC6cZ7C3wXMMIRCeCPhKtwrC4UU+1XHXvYxIcOdR0+D0uO6PVo
         4bt8hNwDWKpk6E1s5UWGujlW10JZ9xrWiYDFma9+BSBI3wR7iivEJe6URLP/2Oxuqb8i
         DyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708612757; x=1709217557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g2KoF5bOnKbOW3thGz1lV4ex1ONuDNSa3Szl9tuUuXc=;
        b=UQXZmDEFY+STSzzaMPz4clAVF+WXzmcJBqfRH0s7Eb3HiickCErCp6XwO1NwX1pSUl
         siOqaXe4xuYuFDPq/ma0RV2UvJRYCN/Wo8sNSMXuBTqujrY8aWevycBRJG+f/BAkWZ99
         z8MSrno3BQRzNbjrl7/Ti04QXWd0GSKlipMVBfu0AqGi70M6LWqO1SPfjyjjgaIaa0zE
         6QOLjlW4fHXVSpzIhzgTLwtJr0kQ/DG4whfA0u2AmAPKjKk8/VXGGRpvehgdEp7ZYErh
         X0vdutnwjbtMnficPAawN4wikCPdAb8t07x/QAkopOLcbrkWuyEOhC7yQWmqP237fprj
         BfTA==
X-Forwarded-Encrypted: i=1; AJvYcCVTWFrwVZDTAWOMFwx2/mYgSrbcgOfN90xa+30NMsxEbB/xzlzs5/8feNU3jZrtO48JPfy6XoFM+jgiJPZ8EpmbkFPVop7jUj7JU0KurGCJVENCeNMPVzTMOtQR8F0gKG7+gTzz/A==
X-Gm-Message-State: AOJu0YxmRWRxk6N0IMRidedrLRKV6uj2nnCLiklnCla9dteIUm5b4d6r
	IBzTqd59XA5prvmuUOMj7IJVuk3jVbu5zCxMyDi4ygzjJA4wLy53
X-Google-Smtp-Source: AGHT+IH1sJhJRoWPd50doMZ6u6RSmH7Z/WMd5p74xo+r0vH6cKfIhSqbrC8kbRe+Do7YDSOSLFv6mA==
X-Received: by 2002:a17:90a:3ee4:b0:298:b736:ecf7 with SMTP id k91-20020a17090a3ee400b00298b736ecf7mr16446798pjc.0.1708612756641;
        Thu, 22 Feb 2024 06:39:16 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:d30a:d617:c813:c70f])
        by smtp.gmail.com with ESMTPSA id lx14-20020a17090b4b0e00b00299f727f7a5sm5266839pjb.46.2024.02.22.06.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 06:39:16 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: ulf.hansson@linaro.org
Cc: robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2] dt-bindings: mmc: fsl-imx-mmc: Document the required clocks
Date: Thu, 22 Feb 2024 11:39:11 -0300
Message-Id: <20240222143911.979058-1-festevam@gmail.com>
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
Changes since v2:
- None. Just fixed a typo in the dt list.

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

