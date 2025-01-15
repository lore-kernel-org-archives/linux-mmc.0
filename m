Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342DA1DB131;
	Wed, 15 Jan 2025 07:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736926256; cv=none; b=aRD+PD4T+Q2ASL0cqPfxfiamEx+gN6GfKZtwuIA9m/zLXQyxsR8Hg2lH4i8A5eN2QqwtCXL23p/vOYW4rlEqtD4ZASGWC4ZA3ztjqwOH2g2UWL2TYFjb85L7e045AXScIjBQbwIdiOte70toXi/iXSxW7co2dsVpQyTpr+eSQKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736926256; c=relaxed/simple;
	bh=oM1EB4cFnYlynwFkhBiDIvbZjdcLGpZtouZSqXeghC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XAkwWZ6eNjWbM2ZT8j2eY8nqn0keHTbPAkXuaX0DZM5F+kXhs2HMFrmlGzRXCI5oL+Wn6PlnHavXx5ciC1LbyJBnbEhX6OulbJgCLLUuLU134fz6abUaPfA5lk1F1HW94Zii4nEU6qzvm1jY1AdbXj8WPFilSAbWUbG9vL0YjtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfM+ceYv; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfM+ceYv"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43622267b2eso65744215e9.0;
        Tue, 14 Jan 2025 23:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736926253; x=1737531053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8QiiE5a7XbqIEk5WkGXD7LJd07NSVV9giChXlOvXHt4=;
        b=HfM+ceYv6dWEbRXStD8wc4XSeUwpxV/HLz/qVBeSJTR3HOL2LC+05hlBRo+GjZycPG
         JgK5zUD33kMH7pZK5G8qokrUYKxL7oubfKuYyF6AfvDtllI82tIlltd8JcSMcSh3lqq1
         1Ov4qytFkPjiNtyUgvrw1VLUWqjusFcXpNW0RLb9CXkqNBH0EWzRtelwgGbV7mhE9s4p
         99d249z8QwkhV+BKhvz8JEawCs30rC04Qaz0WW+YmKwfeHpXB6cCBKE4a4F8qlQUaYrB
         CZ0fQsYhkxakIQRb7v8YsZKJ/oQrIIVcNajgZhIrQWRa6ouS/qXVOF4hZWEgeylZsrL9
         52Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736926253; x=1737531053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8QiiE5a7XbqIEk5WkGXD7LJd07NSVV9giChXlOvXHt4=;
        b=WKgLb/t9bRYb5ilG57Ahaqb+KsxmnodHLioRdD3hN20LGpCcWAX5WXlRqU1KBcQGGl
         Xe3D7rvr+YkqDw1nkmZsliUVtvzMVgorK/90PaQY0Gprz4btR/tT3qau5tSR8BuuXwRm
         UL7ZAMY0NEjXnqiznnyzKNTV7X27LQ1HOU1VTLSxZ4rdZHjRRY3CKxNCXonwbNFznT/R
         3Eqst2jvxgemURDU53YzrmH4dcn1o6SvqC0KMDHmmcDleucd9UhKXxpZ29Wwq9B21vvB
         AC/bn5agZSaOaUAlIw1aabjrNgpbrYIlyd5l8J0PSppB5NzUJBgdRBmKW3SfivykuwNq
         1uXg==
X-Forwarded-Encrypted: i=1; AJvYcCV+4YDPkE8IoXvpEuUm24TIXWAZP16k5H5eRPJwO5MK8uYEnXDi1KbnFTMfdJUJ50aedttxG+xFB5ti@vger.kernel.org, AJvYcCVP/4rFtjE2HNAA27akQEJYqpcNhZt5VhB2fKSFvMFDKGphgcPIZ/OaqgXMojqvswpGuOAtHgHd3/9/@vger.kernel.org, AJvYcCVtxyMqbMtvHebQqyObISTWt8+3+pV/4bbpoBvy4s6+WWvEJInzZ6h/TwHuRXZnsQwrjVmChvSaP8MGXhIK@vger.kernel.org
X-Gm-Message-State: AOJu0YycWa2vZ92vq1rJENy1EvKIGBNX5NQkakT3WDbFvHdZB3Pgkz7p
	q+wu3shqPbIvMd1fbaRf6HjwXSS2ZUOAcwivJyREQ6Ixo3Wt4HHC
X-Gm-Gg: ASbGncu0cA0BuaBNsdPOHJWvvUxKOd8v+8URO928phOCBv8Mg9Z/qJJa3Eu9HUmC7X6
	usqmaqixvLZ5reFvD2LYa7yfBochKYRNR/8cBhdBo5g1dxi3WMtL4RfC+3ya9DrkRABAuAeGw6q
	YGALUAKFAuiPBK7YJL/BZQ1EbppRWFyp8+kN0Xb9IKdvRU+t3fJ9l58agSi82JKw5vB8DpanB5m
	3IFOd3vPd/8ylFs4f7lty4yHvfqpPXlmSUKsmb/GeLp236+r7bo8ISCmFP35aecNvrYcvumqsK6
	Vkiij9xtB+yEMAOFG4bF5KYKuA==
X-Google-Smtp-Source: AGHT+IHVUwzQK1q+khSi8wZdNztGEsXhavyh8wvmq9P54ulqNuTuBzPt7kEEZDwFltEEBqAclFXm0g==
X-Received: by 2002:a05:600c:a0a:b0:434:ff30:a159 with SMTP id 5b1f17b1804b1-436e255ded6mr270508535e9.0.1736926253029;
        Tue, 14 Jan 2025 23:30:53 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-437c7499932sm13313065e9.7.2025.01.14.23.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 23:30:52 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Chaotian Jing <chaotian.jing@mediatek.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Wenbin Mei <wenbin.mei@mediatek.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	upstream@airoha.com
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 1/2] dt-bindings: mmc: mtk-sd: Add eMMC for AN7581
Date: Wed, 15 Jan 2025 08:29:50 +0100
Message-ID: <20250115073026.31552-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document eMMC compatible for AN7581. This eMMC controller doesn't have
regulator exposed to the system and have a single clock only for source
clock and only default pintctrl.

Rework the schema to permit these new requirements and make supply
optional only for airoha,an7581-mmc compatible.

Also provide an example for airoha,an7581-mmc.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
This depends on patch merged in clk-next 
bfe257f9780d8f77045a7da6ec959ee0659d2f98

 .../devicetree/bindings/mmc/mtk-sd.yaml       | 64 +++++++++++++++++--
 1 file changed, 58 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
index f86ebd81f5a5..6dad5455b369 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
@@ -27,6 +27,7 @@ properties:
           - mediatek,mt8183-mmc
           - mediatek,mt8196-mmc
           - mediatek,mt8516-mmc
+          - airoha,an7581-mmc
       - items:
           - const: mediatek,mt7623-mmc
           - const: mediatek,mt2701-mmc
@@ -48,11 +49,11 @@ properties:
   clocks:
     description:
       Should contain phandle for the clock feeding the MMC controller.
-    minItems: 2
+    minItems: 1
     maxItems: 7
 
   clock-names:
-    minItems: 2
+    minItems: 1
     maxItems: 7
 
   interrupts:
@@ -72,7 +73,7 @@ properties:
       Should at least contain default and state_uhs. To support SDIO in-band wakeup, dat1 pin
       will be switched between GPIO mode and SDIO DAT1 mode, state_eint is mandatory in this
       scenario.
-    minItems: 2
+    minItems: 1
     items:
       - const: default
       - const: state_uhs
@@ -170,9 +171,6 @@ required:
   - clock-names
   - pinctrl-names
   - pinctrl-0
-  - pinctrl-1
-  - vmmc-supply
-  - vqmmc-supply
 
 allOf:
   - $ref: mmc-controller.yaml#
@@ -335,6 +333,40 @@ allOf:
             - const: axi_cg
             - const: ahb_cg
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: airoha,an7581-mmc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: source clock
+
+        clock-names:
+          items:
+            - const: source
+
+        pinctrl-names:
+          items:
+            - const: default
+    else:
+      properties:
+        clocks:
+          minItems: 2
+
+        clock-names:
+          minItems: 2
+
+        pinctrl-names:
+          minItems: 2
+
+      required:
+        - pinctrl-1
+        - vmmc-supply
+        - vqmmc-supply
+
 unevaluatedProperties: false
 
 examples:
@@ -389,5 +421,25 @@ examples:
         vqmmc-supply = <&mt6397_vgp3_reg>;
         mmc-pwrseq = <&wifi_pwrseq>;
     };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/en7523-clk.h>
+    mmc@1fa0e000 {
+        compatible = "airoha,an7581-mmc";
+        reg = <0x1fa0e000 0x1000>,
+              <0x1fa0c000 0x60>;
+        clocks = <&scuclk EN7581_CLK_EMMC>;
+        clock-names = "source";
+        interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&mmc_pins>;
+        bus-width = <4>;
+        max-frequency = <52000000>;
+        disable-wp;
+        cap-mmc-highspeed;
+        non-removable;
+
+    };
 
 ...
-- 
2.45.2

