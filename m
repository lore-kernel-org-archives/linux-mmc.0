Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96711D54EE
	for <linux-mmc@vger.kernel.org>; Mon,  7 Oct 2024 14:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728309827; cv=none; b=HkD5Cn9lmJ2GfFPQNx2s+v0DgI+yfW4P3HnuGC9e35iF+6HM7pgH0k0yn3BiUoubgbQVR807P5sAwCtmOZO0XFxLiM9ylwkxM/sCRkGJqQSIoRBe1sXZXvRwIZjJZ21YJDfynoFUQX5wg+CJ40lbXfHxpzWxOKfbit/r6+jygcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728309827; c=relaxed/simple;
	bh=SmXwbLj1U8rjBh2iS+iEiicfCOuWdXkKgQjKYKtfHqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UnI+sGQNFbAkB1UOGRi/u0H+HSiMwoxwaagFFlhHKVjeS9f2O0DdVnBGLYboi3bPQQoAi5NlIx8yalvVGxu+YY1v/bL/0PqSTFutTGZLpm7Rv7zGqRBewT2XpFMVrgu/UYd7Ju7AJCUfVwhVdDB/5aucErOeCJercodFC+0cylE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jpATgP1V; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jpATgP1V"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37cdbdbbb1cso2141179f8f.3
        for <linux-mmc@vger.kernel.org>; Mon, 07 Oct 2024 07:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728309823; x=1728914623; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jVr2IsS8iU7XXkbiI5A6nAOUFZD6qR/TZqOX7q9TN0o=;
        b=jpATgP1V6eKcmeL/V1bH459yYdflTMIQWPoi8z/dLRpHvIRrq9AAniWS2rDvygappd
         FVl6cFPBl9pyAfsycEPbT1VjJ1A4MQQHggF8EQ5Vi76BFnUPyc/1KSRq2sZsH7X02z1v
         hlsJ/wHhn20lAovkv7SmhH5GRPCmmaX6UaebiHmCtspcWXekYx/DaRdrVt8Bitw3TgyS
         RbQjHebPwppscwzjr197BSNvLizjUQS+zrmFE4fKqNVJoiGUbpAYcbQtjSJpA4ojC8ci
         3wx48ZcehhZTf3Nj+3tK1meGBirXkLGiix58691KhgpXPrQzQGF6bOGbn8TljwqHe+5P
         Pohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728309823; x=1728914623;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jVr2IsS8iU7XXkbiI5A6nAOUFZD6qR/TZqOX7q9TN0o=;
        b=JNKQut6YYfWeB7wLdofN2jT7r9ekskLgCESWpL4qbG6mcvXFKYzvaoNgsQqVW188MR
         /U7gldDawfHmB33ouHFCOcYHhU6vAnlhoB+vs4jOiDk917s4yycLaeoVKF3SUqmgY7eC
         lYM8CZfJex12uJIvmF0IqZw3ud3L88AJkAy2GxrnUwiQ7zEE1DarOzKGFZYmUq2oYDGv
         GX4F4m1Ej/uwgK24JRx/YbWT6Pj08zFE5ECCNu+UImJGLH8u+EU2PzkjmSUXUpaiRplP
         5LFp2ud8icmk+nck16dwwAI/VrnS0HZxyQe/SLsjUnvgwaSA++0ljVm+1roSGlun46l9
         Kvpg==
X-Gm-Message-State: AOJu0YyUtDIndqbzvZzUFmTsgcHIAd6iuM+3+cFS4mBCgBaY2fqaMrDC
	JrjfeoLXLdyJyhWgwmza5CwMH3BBDWJCBkadzBNLYPO0mJZFMawSkvTulDn7skQ=
X-Google-Smtp-Source: AGHT+IGlBNXL6jiOlms/arATbqvK6hhh2vVVMJy1TrndVcuPBAQGVFEaobZODYSQL1Q19P8IilBrzQ==
X-Received: by 2002:adf:e502:0:b0:37c:d2d2:7f67 with SMTP id ffacd0b85a97d-37d0e74b62cmr5560682f8f.30.1728309822881;
        Mon, 07 Oct 2024 07:03:42 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1688a486sm5857022f8f.0.2024.10.07.07.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 07:03:42 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 07 Oct 2024 16:03:38 +0200
Subject: [PATCH v3 2/3] dt-bindings: mmc: document mmc-slot
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v3-2-ad4eb22c2a8d@linaro.org>
References: <20241007-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v3-0-ad4eb22c2a8d@linaro.org>
In-Reply-To: <20241007-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v3-0-ad4eb22c2a8d@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1648;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=SmXwbLj1U8rjBh2iS+iEiicfCOuWdXkKgQjKYKtfHqM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnA+o7cZJhIrF6hF8cjd399Jc/9d5nYl5wIUhGC5sT
 0WLyFyWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZwPqOwAKCRB33NvayMhJ0Tc8D/
 45ev6BkuUccE2pSpmdlc0jNfrqmQszhJwQW2uiW7nwQORHrKMvj7awhcYSKNmaGfHH/KiXVbB4z1Uc
 fc8UwsNPWT0OKhb0f97u0paen4NF8WYBpotA9k7fbj6imzErUCbv+mlgKyPpHjBDOJc/RLhDNTklBE
 ASp0MaFM15Z37P21YmDl1MmsMxcKwQ7qsfu/0ImeHgS6oKtb3HLb1KXVXeP5NPdzAeu/BodBxMC+BG
 MXIpNCYXbOJ9Gs6A/BUOcarerc9lKXTbeJ/TB/TtgD/7J0/DWPNoj5WYqDLR643fkSW0unqnWg/AEF
 rWpgGsVsGyW7G6L82j4kOuQ4leeOZC/Yzn8oz3/6G3cRTQvkLw8dEt/YMR7XGdsO/2oLdi8yIlbSrK
 uATBmu9aC+UJuR32inVQTU3kt34qXNSmFs4i1yaZSfZJ1ifxNEl1ReJz+xo2XaiA/m7hMExLPF0SPz
 gDkPNE5fta0G+7exL8XuKSVFdusT7zWHUZQWKkyjWVWLHFWxugKbNs6gevKcLKMf7dKnNiUDmWiWuX
 xSKO3C7SYT3r8Yzk3EmzWD3ajdb90rArZGftMMFTp+aJs8WeGzZXWZjNK7gqWmJAunh/9l87mEdJWZ
 eRr/RmnsRy58Lut4z2c8XY4fijiRNQtuFXmXupLBedVx+X2VTvgt4zM6wwAQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Document the mmc-slot, which is a subnode of a multi-slot
MMC controller, each slot is represented as a full MMC controller,
the top node handling all the shared resources and slot mux.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/mmc/mmc-slot.yaml          | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-slot.yaml b/Documentation/devicetree/bindings/mmc/mmc-slot.yaml
new file mode 100644
index 000000000000..1f0667828063
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/mmc-slot.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/mmc-slot.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MMC slot properties
+
+maintainers:
+  - Ulf Hansson <ulf.hansson@linaro.org>
+
+description:
+  These properties defines slot properties for MMC controlers that
+  have multiple slots or ports provided by the same controller and
+  sharing the same resources.
+
+$ref: mmc-controller-common.yaml#
+
+properties:
+  $nodename:
+    pattern: "^slot(@.*)?$"
+
+  compatible:
+    const: mmc-slot
+
+  reg:
+    description:
+      the slot (or "port") ID
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mmc {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      slot@0 {
+        compatible = "mmc-slot";
+        reg = <0>;
+        bus-width = <4>;
+      };
+    };
+
+...

-- 
2.34.1

