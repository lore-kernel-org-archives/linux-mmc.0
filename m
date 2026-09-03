Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3532A376A13
	for <linux-mmc@vger.kernel.org>; Thu,  3 Sep 2026 22:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788476370; cv=none; b=p6AJ96ku4e6ZMKgmvYJ22r1o8sgWmhmfvr67XgugPLZRrcXoNHdpS8HKFu3xbkqRNca5I6WzR5DO+nfoJd58vKhTUPgzxwf88gvY5q9vtSpKrPkIqOoVtCSgM/52iB8eCyC6z/bbgCApcCi6esv/6FhjwuhPgoIvU3EovepRffQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788476370; c=relaxed/simple;
	bh=7IyaqAJGrLFMzdCPym0vCbn9/e7JQnUZdtNSrU1p8VM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nPJxNpkp6230f63H5V2/LqhkpAKxGbrC68jTf53jdDGFk8zlwNjJW7APDWVrMxy+z412z03aVKBhFhxJIqsz8K63oxLNX0BTH0EcHad8xZFkp/sq9HdQTJJ/be5ND9hBCpxGOB4BTIglINlhGsK6qx31ACHtoddbAQt4uBbSm9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49b8eeb3ff2so3759985e9.2
        for <linux-mmc@vger.kernel.org>; Thu, 03 Sep 2026 15:59:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788476366; x=1789081166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SYr0H8H+3w2Nj4aKKiG0KJqnlsCXDI1Lpa8vdufXlPs=;
        b=I4Lo68msA5RgoZXNa+XRDCRzg12ua/8o6ZZOtRhXl1BhKAImSLuhYULLkMsSjqfx3F
         vkKDH9EtQf7bqAGBLrhW81HITtvFDJisd4cDVSUdk6HOhHwq9FU988PhLIBECdLKxjEH
         BcWW74wJYHIDkk7ZP6jWQEwXMo3W2KpXEIyrqiWCHxggq1f9pmmHD+wSQ9WX/rdiat9r
         dRvNpjMn/kMdSTESpueOfGanJLI0mAXm91ctmDi9Qtm6oobWsromFg6gTDNrqR8DRA7g
         9dM3/fwGvWpK0KoNSwUV3dFUPeGA93SQHYKufHB7zGeL0GSdVommPOxiyrpgf7t8jdlm
         b5cQ==
X-Forwarded-Encrypted: i=1; AKwUvBz4G+VY0JYxR2afMiAC4YgCqSkfEIDshgQESzAF/iqo3oP5Zxkhi6leG2ABdKDAwCPa3oT3596Suy0=@vger.kernel.org
X-Gm-Message-State: AFuF++mS2Dlo+dZG/Lw2f7qn3PxBSUKk3Rii+50iAAbj1vAEEkpfM350
	ovZdovxdSbPgeqlHIEdqPPeBVp68TkP2JdfoANzdvszRWZ4MEcIwJxrFDtm6aVXhK8I=
X-Gm-Gg: AYBFou0MYNcxxjvPS0tc9SSf8mFZPC9Xp/Q05+ZrSMcNjPNVKRNa03XN4/AOlP2Pfij
	N5u2pPP7TzB2T/cPvsi081pQT6a95O73Tjfv6cnWaMkevEKAFDfFWwixN29WNIO+WkmmmFWBKrA
	5lh9IpurqeIsVepYgkr2yLpgNUIro3p/ZE9D+NevfLwRPXUKj7MM2xCcz7h9rHFAtw656AGkTSY
	S0jG3KkMKdnmMgQiHe4TXYMYrtqJK6c3lRAwMie3rn5YpkD8yzm/SNnsoWjFlw7jIuE9PZiGQVS
	E9fbuPBvG3fjMbpxvowh4+2WMj8wciYBkhiAGgQX+E7zPWir7Vl44R/HVl46d11FeMk4NgTIPzU
	YpRUbUZJ3gVMy9jvkzbZGlinzT8E38mA0V1WPEEgJ/gSsaHcYBzPVjq7bEMg0sfCNQSwU1+Bfrb
	Tu4ogPtMpUPutkjK71GyDTYbpVTwyAaHWGzHzWi5XNu/b7DCH4KfgaMlUtZivB6WwhK9Po1ygU5
	yVG4o8ZJHlKx9ePSqMUcLZWzg==
X-Received: by 2002:a05:6000:2010:b0:485:8a47:5b92 with SMTP id ffacd0b85a97d-4858a475dadmr290268f8f.47.1788476365986;
        Thu, 03 Sep 2026 15:59:25 -0700 (PDT)
Received: from threads.localdomain ([84.68.179.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885c5bbdsm1686142f8f.36.2026.09.03.15.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 15:59:24 -0700 (PDT)
From: Lucas Tanure <tanure@linux.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Brian Masney <bmasney+clk@redhat.com>,
	Chuan Liu <chuan.liu@amlogic.com>,
	Jian Hu <jian.hu@amlogic.com>,
	Ronald Claveau <linux-kernel-dev@aliel.fr>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claude Fable 5 <noreply@anthropic.com>
Subject: [PATCH 1/4] dt-bindings: mmc: amlogic,meson-gx-mmc: document the T7 pipeline clock
Date: Thu,  3 Sep 2026 23:59:18 +0100
Message-ID: <20260903225921.2290441-2-tanure@linux.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903225921.2290441-1-tanure@linux.com>
References: <20260903225921.2290441-1-tanure@linux.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SD/eMMC controllers of the T7 SoC are physically far from the
NIC_MATRIX bus fabric, so the hardware design inserts a pipeline stage
in the middle of the bus path to help timing closure. This stage is fed
by its own gate clock and, when that clock is disabled, a controller
that starts a DMA transfer can never complete it.

Allow a fourth clock entry, named "pipeline", and require it for the
amlogic,t7-mmc compatible. The other controllers of this family keep
the existing three clocks.

Assisted-by: Claude Fable 5 <noreply@anthropic.com>
Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 .../bindings/mmc/amlogic,meson-gx-mmc.yaml    | 29 ++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
index 976f36de2091..12342b1d78e5 100644
--- a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
+++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
@@ -15,6 +15,23 @@ maintainers:
 
 allOf:
   - $ref: mmc-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: amlogic,t7-mmc
+    then:
+      properties:
+        clocks:
+          minItems: 4
+        clock-names:
+          minItems: 4
+    else:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          maxItems: 3
 
 properties:
   compatible:
@@ -38,13 +55,23 @@ properties:
       - description: card detect
 
   clocks:
-    maxItems: 3
+    minItems: 3
+    items:
+      - description: core clock
+      - description: clock input 0 of the internal mux
+      - description: clock input 1 of the internal mux
+      - description:
+          clock of the pipeline stage inserted in the bus path between
+          the controller and the DRAM. Without it, the controller cannot
+          complete DMA transfers.
 
   clock-names:
+    minItems: 3
     items:
       - const: core
       - const: clkin0
       - const: clkin1
+      - const: pipeline
 
   resets:
     maxItems: 1
-- 
2.55.0

