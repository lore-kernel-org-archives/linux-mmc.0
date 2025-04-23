Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CAA2701B8;
	Wed, 23 Apr 2025 10:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745405607; cv=none; b=afvjON/kmP5GF5ZPgagEWyj2V4X79tS+DJyYQsmqbEOG1sVxhRTupyonMNrUk+igfkTgoP7bR8wIJRsLQ8g4ilw8JzkAvpMcsRfcFV37ZIOLVICxZgn8lJekD7YyyJDvN4FlhhpMEtRLRv95eKf5c1ZHRk0wpsAj4LyXpVNiCYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745405607; c=relaxed/simple;
	bh=fLboZBG1ZwmejPbN3M6emYXVitcHQ3ne3IlzbxCC5oo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ualGtX6W5kYFvgjvWgveZ3ZtE8rYrmVsBkuwkKa8U6T8S7QqOCprwXVtncRQBNQVVrFSfo+u6lm5snfctxyjSLMOls0wd0z0q3dnHIDKNrjPyW7tYlyiLO+Fbfyj73ZE7ejjIoznpS3Cu9VpzEP3TIWe6GnY/2T5NA+R6DCl08Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9V0gWAi; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9V0gWAi"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22928d629faso59459785ad.3;
        Wed, 23 Apr 2025 03:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745405605; x=1746010405; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+ZwG3s3vUvO6gQRw3LruMXdYE3GMRGs7Yo4NjUx/T7A=;
        b=E9V0gWAiWzigsHgfZTdyo1XkhLqSpZG7ZQqqvfsMgOrKhdD3PusRPAk68Jha+l9FTw
         6JzC1TGwzBN6HWVyEiFs3bYTJ+k7SqjF9eu146r1tQyV5lqVRsf1NBQ51uEF6g+F0TIY
         KD+vQwsGiifFICTsR64QE4vZtYztq3LcHXz2CdQnj7GPt1x97dyPkEb00dAHYcTTyJww
         I+q7x6C1Uhcqk4Es2xYI1ksUQQkWB8rnd7X4/Mh92p+e1hPF64QJB5o8yD18ksakYoYn
         Vp1UO9LzM23eLluUVNn/3bKIRvw8hEOiyCHotubUTrBYkbRo/7Atpl1cl91Q/p53TD/H
         RmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745405605; x=1746010405;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ZwG3s3vUvO6gQRw3LruMXdYE3GMRGs7Yo4NjUx/T7A=;
        b=UEAciwUAtFJbahVEN5NqwoCZucwgmjzrjznnzfTL4FU7cHInGMRPi2kkV7spZ4aZIi
         sR4gS98IN/OpNO/BD4V6Vlmn7mday/k8AnjXWqXsRMlY0YTx+gNFCMqdJ8oyaXG0sGjC
         ClbLpTryPsjxsTBYXPP2fVZkltEUrZjv6ksVwCGs7InuuCCVPFpGPzTriyEhWQ74TIsE
         dycm1TzbiBFB2QC8tLd6Gm73Z1JvQcozTDsdRHs48bS0YHRM1BTGsUtxRxYLnGa6/lEV
         /oVxZeprHv+EqIN/tjQT/4VHLamgISXpgSRQ7l8V572IlC8cXXJ2R105gKhAmS+Dk6P+
         ANUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5sTiCdGmPEqC9zezIE/aRYKxMpaFnfD+FRuHlSVu6tcrP+M6fZ6jAehl68VSvFtzaU4YeBOnNrYa9@vger.kernel.org, AJvYcCX4GN0m58zs6l24rHa/oMmXlyJolDw+OiFXHJCrhOGgX2P/X9SYwL1nR3D7MJod0PZir/Fxe5pij+3LnUg4@vger.kernel.org
X-Gm-Message-State: AOJu0YzIx7T3Vlem/jBQpb5GIeQ5KYabreMR1I5tKngdcZ5spzz3aSGV
	W8NRntn+IBnsxuBcf9sy3hXvQqB2ppCP25V+BU2cvblsAKY5bQ/jQNIZGNTT01k=
X-Gm-Gg: ASbGncvbt5AcSMOKoGM/OgpJmRA+Q1ywXe/aVKsxdZW5C85w6UzcIE6CWX60MVp1hch
	ehcLhmLFjQi0A7frmxLThwTfP9hcw2b1Bx/nHhVAHZIDqHBjrUqCd0m5iGYjbQfoiK0+ijwe4CA
	XWPNSKp4cOFTB8SD2nW99eFTFfxDfeUo3cMCtaORbPVXTOTfpOerhO2YYHA5BZMbPjRuUYJs8Dn
	t0wjyCu1njAmaJlqX8j9OO4FHJABQ0CEWwfSzHap02pORTVbTsDXQ7FnI+95Wi0izJcgleCTWz7
	Q9+KqFVlPi1E6r2n/NrRcVI4DZ1L475tQ173KaBXJnj3olNY4fQk
X-Google-Smtp-Source: AGHT+IEKISYelMwnEjg0EUxWrOBCwdpPCz/ZbLGPVTCuADz1svOatBpN//3qfhR8Bvqd7inWW4hSNw==
X-Received: by 2002:a17:902:e5c9:b0:220:d601:a704 with SMTP id d9443c01a7336-22c5357f3a7mr234390515ad.18.1745405604690;
        Wed, 23 Apr 2025 03:53:24 -0700 (PDT)
Received: from NB-GIGA003.letovo.school ([5.194.95.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50ece2f8sm101397665ad.189.2025.04.23.03.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 03:53:24 -0700 (PDT)
From: Alexey Charkov <alchark@gmail.com>
Date: Wed, 23 Apr 2025 14:53:29 +0400
Subject: [PATCH v2] dt-bindings: mmc: vt8500-sdmmc: Convert to YAML
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-vt8500-sdmmc-binding-v2-1-ea4f17fd0638@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKjGCGgC/x3MQQ5AMBBA0avIrE0yihJXEQvaac1CSSsiEXfXW
 L7F/w8kjsIJhuKByJck2UOGKgsw6xw8o9hsUKRaalSN19m3RJjsthlcJFgJHqky2nDttO56yOk
 R2cn9b8fpfT/ZtpmSZgAAAA==
X-Change-ID: 20250423-vt8500-sdmmc-binding-01c6ce3f6678
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745405616; l=4063;
 i=alchark@gmail.com; s=20250416; h=from:subject:message-id;
 bh=fLboZBG1ZwmejPbN3M6emYXVitcHQ3ne3IlzbxCC5oo=;
 b=eALJciSHETGo03B6WBzqQr9YG5zkuVtczcaWHe3rPolewiPGd/N/2Ls7ngM7l7ozO94xj+j2E
 05Ze0OOJ3ZsCrEPJB7ahvhBJNlh4uKV27kx4J1fOd+RKOT3SN2Uxso5
X-Developer-Key: i=alchark@gmail.com; a=ed25519;
 pk=ltKbQzKLTJPiDgPtcHxdo+dzFthCCMtC3V9qf7+0rkc=

Rewrite the textual description for the WonderMedia SDMMC controller
as YAML schema, and switch the filename to follow the compatible
string.

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
Split the series from v1 into separate bindings patches so as not to
spam all the subsystems with unrelated changes, per Rob's suggestion

Changes in v2:
- described the sdon-inverted property in greater detail (thanks Rob)
- dropped the hunk that updates MAINTAINERS for easier merging - will
  be updated later in a single pass to cover all VT8500 related files

Link to v1: https://lore.kernel.org/all/20250416-wmt-updates-v1-3-f9af689cdfc2@gmail.com/
---
 .../devicetree/bindings/mmc/vt8500-sdmmc.txt       | 23 --------
 .../devicetree/bindings/mmc/wm,wm8505-sdhc.yaml    | 66 ++++++++++++++++++++++
 2 files changed, 66 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/vt8500-sdmmc.txt b/Documentation/devicetree/bindings/mmc/vt8500-sdmmc.txt
deleted file mode 100644
index d7fb6abb3eb8c87e698ca4f30270c949878f3cbf..0000000000000000000000000000000000000000
--- a/Documentation/devicetree/bindings/mmc/vt8500-sdmmc.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-* Wondermedia WM8505/WM8650 SD/MMC Host Controller
-
-This file documents differences between the core properties described
-by mmc.txt and the properties used by the wmt-sdmmc driver.
-
-Required properties:
-- compatible: Should be "wm,wm8505-sdhc".
-- interrupts: Two interrupts are required - regular irq and dma irq.
-
-Optional properties:
-- sdon-inverted: SD_ON bit is inverted on the controller
-
-Examples:
-
-sdhc@d800a000 {
-	compatible = "wm,wm8505-sdhc";
-	reg = <0xd800a000 0x1000>;
-	interrupts = <20 21>;
-	clocks = <&sdhc>;
-	bus-width = <4>;
-	sdon-inverted;
-};
-
diff --git a/Documentation/devicetree/bindings/mmc/wm,wm8505-sdhc.yaml b/Documentation/devicetree/bindings/mmc/wm,wm8505-sdhc.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..5b55174e908836866fbba42336db94cb03f9137b
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/wm,wm8505-sdhc.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/wm,wm8505-sdhc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: WonderMedia SoC SDHCI Controller
+
+maintainers:
+  - Alexey Charkov <alchark@gmail.com>
+
+allOf:
+  - $ref: mmc-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: wm,wm8505-sdhc
+      - items:
+          - const: wm,wm8650-sdhc
+          - const: wm,wm8505-sdhc
+      - items:
+          - const: wm,wm8750-sdhc
+          - const: wm,wm8505-sdhc
+      - items:
+          - const: wm,wm8850-sdhc
+          - const: wm,wm8505-sdhc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: SDMMC controller interrupt
+      - description: SDMMC controller DMA interrupt
+
+  sdon-inverted:
+    type: boolean
+    description: All chips before (not including) WM8505 rev. A2 treated their
+      "clock stop" bit (register offset 0x08 a.k.a. SDMMC_BUSMODE, bit 0x10)
+      as "set 1 to disable SD clock", while all the later versions treated it
+      as "set 0 to disable SD clock". Set this property for later versions of
+      wm,wm8505-sdhc. On wm,wm8650-sdhc and later this property is implied and
+      does not need to be set explicitly
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mmc@d800a000 {
+        compatible = "wm,wm8505-sdhc";
+        reg = <0xd800a000 0x1000>;
+        interrupts = <20>, <21>;
+        clocks = <&sdhc>;
+        bus-width = <4>;
+        sdon-inverted;
+    };

---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250423-vt8500-sdmmc-binding-01c6ce3f6678

Best regards,
-- 
Alexey Charkov <alchark@gmail.com>

