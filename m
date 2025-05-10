Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BC02563;
	Sat, 10 May 2025 16:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746895366; cv=none; b=hf1UrJt0Opu0SAlZ7qxHgyZNs9hwlpCqaUVrCx6fq0SWTwuhUGT3bWbwgyimkFBKpMdI1sj8WEuhc7sqN9QgDKDScqJH1liHWtEgfobwybWFehvYz5xhp6XaHU4vVCNWwXzvM5iwQZcgBAy2yJnIswofYayPtgDV1ghQsNMi08M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746895366; c=relaxed/simple;
	bh=Y9UIkQJFf+OhvWRDpSN4BhfGFO+hTVtvuC3X0Xy4VAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Kx0PlQj6Np8Qfk4EU9mu8XVMyTp46wXNLvCm0BwxMLLU4agxSK6gTTlYg9zyawgCar6YNY6mPBN+fQeIkajtdlITSoA09k23rEZ6zIM9ac5WaHckk9uPHdWsDuqTa5y+pE0M+GOlUap4gAj8nEiP+aVivK74TOidNiz8CSMpyh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H54ZxD00; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H54ZxD00"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22e6344326dso32693655ad.1;
        Sat, 10 May 2025 09:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746895364; x=1747500164; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ERGJy7c3JjPSUvwDem/hK+Mphmj7ax8U1nvwn5S9i7A=;
        b=H54ZxD00jSwn1LbQLiHdrvipYtK5jhXeZF4exPeB50qJctpdD42/IRruBQP9l/gY9W
         KU3jmN+itqyZvBvHZ7XnTq6WyPgp/WfiMOS1nCQ0nVfE62v/gqf+L7JpjBOCu5ezfdkn
         D1Vug1s7drNx3TbLuZ42RzwXtCnFaaNhpbkxZutisNBvrdXYYc16A0oYGnbRkgzmdpfl
         L/+jGC03Sn6TdnvQZy030nhnt3pgvH0Ex7XwZWTddKFuN+5fMtXbuk6z0LeO8p+MJnU8
         O/qvYEkOsRnkSCT6DwWX+eWEMopEYMHTcAAG9MBZfrFvePdalItvhhW7kX8FVmd7KeKl
         0fhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746895364; x=1747500164;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ERGJy7c3JjPSUvwDem/hK+Mphmj7ax8U1nvwn5S9i7A=;
        b=qtZpVcvRLMRvELaZenC6lKlYzRUkN+Nhb7UPu0DZ9ElTejzxf5AKUgnXFzC0nn42aN
         6TxF0TPeuXudZx2mlY3Y0G6QjaMRBNgTVnKWHibGn/YQKcG/uvKiN0FRecWehz4TzyG7
         09EIFvVJjW8sAiZwdXa4mPBqNle5CWFHziYOCNx1UFbOcOs0H8ae9rQDGVHEqgdq010A
         NFixONkqECkNPSAdQWg46F+IUYCKOIPiQahrj2ArPzyLMwWGROTw6L8G43oykngjvDj7
         da1wGKzIwyDr31VBbqvsKoiX7ZhlU6hqr9YssiI2RVBKD2Z/foXdWvKLUxJ86KfS2ieC
         qsEw==
X-Forwarded-Encrypted: i=1; AJvYcCU7dxinKIJJlasqW0JxJwavr4Xl5wtBHNAbGWEl6AmyuP0ZtyQdWxlfXmuqq+YzJErrKaQufw2CBgAVgAwJ@vger.kernel.org, AJvYcCWiPP1nW+X6TkT89EbLoelfMb1flmv3wzmtuMv2U2oGhOHcCzzjYiIwGFz/yaLqQw5zbs3EEboNpZqR@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5zAlxTyZLXvk/fMkuJr1hPACwqDq8DaeaoWOXSVFIOFnxEpzx
	h9Kaz0SB6kDZLYjrrqurtML5BLf19fWgUtjQYLSrLcNtVdpvu3W9f79Lxg==
X-Gm-Gg: ASbGncvGJyBVowSWb73d0y3/HlXvcvq8uTVfUky7mHGF1M7TxpcXi4doz7QTRVcwLJm
	stL+SQZEVHKP2B6wUfzJQlFXfBd1OxhpxDKHFNh0tHMQ/KMjbgQ1pyngJ6si0IvGfpZyRKYC+Us
	oRnkW/aDTcAZIpp3BagU5dlMHll/WhdmOg6uT9MA/pE0K017paloGr2aaQ814HYWf/K206f0lOs
	pQdmf3ErPW+ny0YhdQPQAQos9Mhmcp2Viz0sE1Mlw/g0mwJpjULJdIa4o4ED4vPT2M/5R8dLeP0
	LUVQKsNHVQLexYNqg6yf4MaNuyiZjlFk1cffgUoO8Gw1kZMzgVcCpAw+KS6d/g==
X-Google-Smtp-Source: AGHT+IHh/rGDNcaDNb9KY94nQAqJXFTqLjA1Awf0Be7tz6pWSLfP5n/NRr0YqbOspVj4cY+q70izaA==
X-Received: by 2002:a17:903:1905:b0:22e:40d7:3718 with SMTP id d9443c01a7336-22fc917fd5amr93661405ad.47.1746895364235;
        Sat, 10 May 2025 09:42:44 -0700 (PDT)
Received: from Black-Pearl. ([136.185.237.194])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22fc8271f77sm34853695ad.126.2025.05.10.09.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 09:42:43 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Date: Sat, 10 May 2025 16:37:27 +0000
Subject: [PATCH] dt-bindings: mmc: ti-omap: convert text based binding to
 json schema
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250510-ti-omap-v1-1-588b0ccb1823@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMaAH2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDUwMj3ZJM3fzcxAJdQyMzU9O0RMuUJONUJaDqgqLUtMwKsEnRsbW1ABJ
 27whZAAAA
X-Change-ID: 20250502-ti-omap-12655fa9db3e
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Charan Pedumuru <charan.pedumuru@gmail.com>
X-Mailer: b4 0.14.2

Convert TI MMC host controller binding to YAML format. It's a
straight-forward conversion of the typical mmc host controller.

Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
---
 Documentation/devicetree/bindings/mmc/ti-omap.txt  | 26 ---------
 Documentation/devicetree/bindings/mmc/ti-omap.yaml | 61 ++++++++++++++++++++++
 2 files changed, 61 insertions(+), 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/ti-omap.txt b/Documentation/devicetree/bindings/mmc/ti-omap.txt
deleted file mode 100644
index 02fd31cf361d6ed893ec2f9eb8368b358ab2bae1..0000000000000000000000000000000000000000
--- a/Documentation/devicetree/bindings/mmc/ti-omap.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-* TI MMC host controller for OMAP1 and 2420
-
-The MMC Host Controller on TI OMAP1 and 2420 family provides
-an interface for MMC, SD, and SDIO types of memory cards.
-
-This file documents differences between the core properties described
-by mmc.txt and the properties used by the omap mmc driver.
-
-Note that this driver will not work with omap2430 or later omaps,
-please see the omap hsmmc driver for the current omaps.
-
-Required properties:
-- compatible: Must be "ti,omap2420-mmc", for OMAP2420 controllers
-- ti,hwmods: For 2420, must be "msdi<n>", where n is controller
-  instance starting 1
-
-Examples:
-
-	msdi1: mmc@4809c000 {
-		compatible = "ti,omap2420-mmc";
-		ti,hwmods = "msdi1";
-		reg = <0x4809c000 0x80>;
-		interrupts = <83>;
-		dmas = <&sdma 61 &sdma 62>;
-		dma-names = "tx", "rx";
-	};
diff --git a/Documentation/devicetree/bindings/mmc/ti-omap.yaml b/Documentation/devicetree/bindings/mmc/ti-omap.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..3660f54550e0ee46d3a7cfa3f531d95802f1e2fb
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/ti-omap.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/ti-omap.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI MMC host controller for OMAP1 and 2420
+
+description:
+  The MMC Host controller for TI OMAP1 and 2420 family provides
+  an interface for MMC, SD and SDIO types of memory cards.
+
+allOf:
+  - $ref: mmc-controller.yaml
+
+maintainers:
+  - Ulf Hansson <ulf.hansson@linaro.org>
+
+properties:
+  compatible:
+    const: ti,omap2420-mmc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  dmas:
+    maxItems: 2
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
+  ti,hwmods:
+    items:
+      pattern: "^msdi[0-9]+$"
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - dmas
+  - dma-names
+  - ti,hwmods
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mmc@4809c000 {
+        compatible = "ti,omap2420-mmc";
+        ti,hwmods = "msdi1";
+        reg = <0x4809c000 0x80>;
+        interrupts = <83>;
+        dmas = <&sdma 61 &sdma 62>;
+        dma-names = "tx", "rx";
+    };
+...

---
base-commit: 3e039dcc9c1320c0d33ddd51c372dcc91d3ea3c7
change-id: 20250502-ti-omap-12655fa9db3e

Best regards,
-- 
Charan Pedumuru <charan.pedumuru@gmail.com>

