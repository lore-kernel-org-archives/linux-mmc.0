Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF5C224AFA
	for <linux-mmc@vger.kernel.org>; Sun, 24 May 2026 10:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779617148; cv=none; b=dtLbuP8C9xCX2cPlOC3Pn1LSWpkM1NO4/6w6v9pUwbWhfVUi6aGOn9VNVRibVetOgQ0Vq8Gx4ETV7tG9t5tX9QpNURbxeFU6i5uBgiBZrmy3cKoBwHx54EMPwVzlspjrBsvUThDRUdZgHLerMg4sXBkH8JFbOFi23EV+ovOiAE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779617148; c=relaxed/simple;
	bh=9MINshz/LEbXujdxotdsISpTbiSUKUf1Tpokgn6FbL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JdK2DHYYzerNJBeHfzTch4sUUidOqZ20rvHmsoHR6HYAOfcayZybEHFS0p5bxziRIjrzZCWTgjLdvuQAOtLGWeNG5aGHkoZkv/of4/+Nnu4X3L/5MfAg1p01m3zX1rMThDQ+WK0FyYgswJrJ0EgKehvuvATJjBE/nhybFsBTcQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sBjyS+1s; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sBjyS+1s"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8367df48711so3787197b3a.1
        for <linux-mmc@vger.kernel.org>; Sun, 24 May 2026 03:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779617146; x=1780221946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4tLLA+8SHNhTOyQgp6ziI7VKscBLCsIGvV+rneCO51w=;
        b=sBjyS+1sBI7+v+vPlL0TTx6F8Vn02cUCt7GDEQ0tdK1+XVI/NlAhXOTDLlZV+plT7c
         jFbV2HKQNl66/qsjpcNNwsLnxl3h94xb9pvxYNHoFDtz58uTf8nkvYkeGSCnBgNasAyD
         bdiyFBHHYzRs33dbUSR7yfn5YM8a2zYanknH4r99lZEos42e1JQAYkK4tOETESDrjJlM
         46JRadqbfa3a0ALhaucoYuVF5pDJ7OTFqIymMLITbx0A4JeA031Pwd02yyI5P6KWOJ4S
         EhN6hOr0a232hzPQs90u0Ls8dBLLhwOHxJv8c3TdCX8wImBPlWNTiVtj/I0OfEwRW+ME
         dL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779617146; x=1780221946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tLLA+8SHNhTOyQgp6ziI7VKscBLCsIGvV+rneCO51w=;
        b=R/H//fpgt88O1n9GL69FarezemDjaUj8Rw+qflqnW6WCh9pZa4tZYW+zW7xoMxwjtp
         GjyG4bWSvInlaEtmAW5FWaIXnZUVYXCtzwk39xMk68ter91a9JywSS1LF9FEPVuzlWF2
         uZnciUX6pLrKMQHPFDkzBPf8x9biTVFi6AMOLe4C2ntB0BLOizea1wsh1CRtNXuFumL9
         yCY+opVZGuGjcyGBbzvwER3N4sRoKfIfwk4pbvdqE0DBSZxfMSaUh4v0khqBfUV5dSwF
         nPJ7tj/rJENfpII+G1ZYdEACag05mVnlttgguNUHboUfHmKwn9vEwL7rrY8a8HWO6fPq
         CU0g==
X-Gm-Message-State: AOJu0YxFXl9knAPwEhGeVs9/rftJunujvCiZsh/UGlPlbXGKZ/eVoIaX
	UUu735XEqEbqnrWsxH+vH8ehXx/zbjIMtU0mXDEbeotOvDuAfEc5uhjN
X-Gm-Gg: Acq92OEEWYO63zSms6JmTpplYUvdYBadbk4BQVZmu2QtwsAxa0+tIwGFbxDXcxsyGda
	1gRV43lt2a/rBSvhbUTXjHM/6NNIorRQEZNZb73Ha0ImddBIdV5EbG48k1eihbkDCHQSHs7bnpy
	yyjHfZ1igHnU23vdBPjkN4TQYdx8hbLy+pmIaCYpNzQItmVJxyA8uozeFY2RFklCOuW0GMwAX2O
	Abj1eqUNQNC0DpDsO+k/yRGYn9IAR5AvZIjDW/oHKqkFM4QNzmFs3HmAZ/LZb/twK/9w/Fo7Gs5
	YmcgBaKELEQikVM1CCcevGu4J+UwqYLOSUx/c7OX4KcnrIfVWDDXvr6Ycd1ux85oJdPcjfbEZ0K
	QR/I1K0cBTLOXGOFJW85j9ZddZ+NUUPCu/xiDp/6fXAEETao7ISqQutbsRLRYaaZTn1ZkHKbpfO
	Rs6+Z9OaY3phmm3jZZHOIb748/TBn2aiinAAGD4R+3afDzYGstkmRifAkKLGpi0zw2zG7eWWwJt
	usi1w==
X-Received: by 2002:a05:6a00:410a:b0:838:af72:fb35 with SMTP id d2e1a72fcca58-8415f2d9298mr9404154b3a.10.1779617146010;
        Sun, 24 May 2026 03:05:46 -0700 (PDT)
Received: from Ubuntu.. ([49.37.169.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ac99b0sm6425195b3a.4.2026.05.24.03.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 03:05:45 -0700 (PDT)
From: Manish Baing <manishbaing2789@gmail.com>
To: ulfh@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	kblaiech@nvidia.com
Cc: linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	manishbaing2789@gmail.com
Subject: [PATCH] dt-bindings: mmc: mellanox,bluefield-dw-mshc: Convert DT schema
Date: Sun, 24 May 2026 09:46:16 +0000
Message-ID: <20260524094616.106660-1-manishbaing2789@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Mellanox BlueField SoC extensions for the Synopsys
Designware Mobile Storage Host Controller from text format
to YAML schema.

Signed-off-by: Manish Baing <manishbaing2789@gmail.com>
---
 .../bindings/mmc/bluefield-dw-mshc.txt        | 29 -----------
 .../mmc/mellanox,bluefield-dw-mshc.yaml       | 49 +++++++++++++++++++
 2 files changed, 49 insertions(+), 29 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/bluefield-dw-mshc.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/mellanox,bluefield-dw-mshc.yaml

diff --git a/Documentation/devicetree/bindings/mmc/bluefield-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/bluefield-dw-mshc.txt
deleted file mode 100644
index b0f0999ea1a9..000000000000
--- a/Documentation/devicetree/bindings/mmc/bluefield-dw-mshc.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-* Mellanox Bluefield SoC specific extensions to the Synopsys Designware
-  Mobile Storage Host Controller
-
-Read synopsys-dw-mshc.txt for more details
-
-The Synopsys designware mobile storage host controller is used to interface
-a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
-differences between the core Synopsys dw mshc controller properties described
-by synopsys-dw-mshc.txt and the properties used by the Mellanox Bluefield SoC
-specific extensions to the Synopsys Designware Mobile Storage Host Controller.
-
-Required Properties:
-
-* compatible: should be one of the following.
-  - "mellanox,bluefield-dw-mshc": for controllers with Mellanox Bluefield SoC
-    specific extensions.
-
-Example:
-
-	/* Mellanox Bluefield SoC MMC */
-	mmc@6008000 {
-		compatible = "mellanox,bluefield-dw-mshc";
-		reg = <0x6008000 0x400>;
-		interrupts = <32>;
-		fifo-depth = <0x100>;
-		clock-frequency = <24000000>;
-		bus-width = <8>;
-		cap-mmc-highspeed;
-	};
diff --git a/Documentation/devicetree/bindings/mmc/mellanox,bluefield-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/mellanox,bluefield-dw-mshc.yaml
new file mode 100644
index 000000000000..32d50e45ddb8
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/mellanox,bluefield-dw-mshc.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/mellanox,bluefield-dw-mshc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mellanox BlueField SoC extensions for Synopsys DesignWare MSHC
+
+maintainers:
+  - Khalil Blaiech <kblaiech@nvidia.com>
+
+description:
+  The Synopsys Designware Mobile Storage Host Controller (MSHC) on Mellanox
+  BlueField SoCs is used to interface with storage media such as eMMC or
+  SD/MMC cards. This binding documents the BlueField-specific extensions
+  and the differences from the core Synopsys DW MSHC schema.
+
+allOf:
+  - $ref: synopsys-dw-mshc-common.yaml#
+
+properties:
+  compatible:
+    const: mellanox,bluefield-dw-mshc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    /* Mellanox BlueField SoC MMC */
+    mmc@2804000 {
+        compatible = "mellanox,bluefield-dw-mshc";
+        reg = <0x6008000 0x400>;
+        interrupts = <32>;
+        fifo-depth = <0x100>;
+        clock-frequency = <24000000>;
+        bus-width = <8>;
+        cap-mmc-highspeed;
+    };
-- 
2.43.0

