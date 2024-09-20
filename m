Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E01F52F9E
	for <linux-mmc@vger.kernel.org>; Fri, 20 Sep 2024 08:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726821493; cv=none; b=XzPLCJFgXsDTlLM93SdohiXW6Kh9eyzdeKRC3HHLg7tuMFiMGb/4/1q1/3zAUZAXg1NwB7J7q+5CZJNyaF+NqYL9Gct4e7XChrvf4sGj61XKOCG5WK0AJb8tysKK0R4q7Vd7mSrjQ7mI/opZJpldqiolKTtpo50bdjxH8x+0MzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726821493; c=relaxed/simple;
	bh=kNCAWhKmcmtpyB2uacECJO/JKXg8Fz3C8WIqjPA3amY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D/bh+qf3Z2BD62XnG2kU0lIP/LciUrMNIH/G97dk80nUaeVlg9US5d5I6gYEWvSq0IQyP4m9VPqahnuvO/CodC6n52jEEDk65D0tlEZ921SVlo2IeaKWhd/MkWtGt4TJo4ODPSj7OxsfEW6CbmBA8IB+QVWmduwUnE8hl+WBZP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WDuMlKIo; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WDuMlKIo"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42e748f78d6so14349745e9.0
        for <linux-mmc@vger.kernel.org>; Fri, 20 Sep 2024 01:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726821489; x=1727426289; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=50X9LprKoNeeESL+1kpHxKrSynXSTK2sGLyRt4LI2AY=;
        b=WDuMlKIo/uAzlaK5KBGFz+ie2zx/ju3DwhMIlUMsyyU1ps3ApD4pFk50bA4Cvd5gGM
         OoMwkuSp4MXxYyfD/QoLWsbdNSmJ792E4xGK1pdhQlUIpv4qeBLM+TG3mzrApCAZIi+A
         Muw8Biy4GKv9p6t/22iHzqPFOhxqEL5vI8YoFvOKs3a3XBb4EbBmYCnOIv5GAWGDvLCM
         Klc9dew80Ze4xTI8DlBgyCjbWh7nPc4oMLXqO2nxhhYDBYKUouXZqpZFD1fFZ8U9mSDw
         XJy5B+od/c1J7fjbIXKA25ZRMO/fWfvBgUVaAW6MkmkmA+O+9BnvIRZdx3DSxejo2SWU
         7YuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726821489; x=1727426289;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50X9LprKoNeeESL+1kpHxKrSynXSTK2sGLyRt4LI2AY=;
        b=fWw4S7VPTMTDKTCxDxdG/PFB0lr880j92AiQrh+k5FCh1eQm1J2H4Jrsg4syWDY1V9
         cFWPsCgMRpGld+BSpS4qn/RJ4Z74ZdF80WMXFyIFCgxw/twMNjQEvqw32y4jWInsmEQ4
         vu6i2HaqDr3ram0G6ssDUnw3x0KDPxJBQ/OB7TFGSpPLrG0pwpdQpV8HAy8XSet40L3h
         Gny8UDrWE5uqV63yHSKronv/wd7+mogfsGvREw9RTRR2L9XOMEUsdiXygVUJbzICqEkg
         SO6dDsD+2JJIHzqkmOrSlW56OgUR+5JD+UphpYnCRJH6jfjnPemuPwEkc8VK0tGMlewk
         BmZw==
X-Gm-Message-State: AOJu0Yy1te8qFGTCdey2uzmMm4cxBzacmK58UyY55bKC3N6PUcRv4A1q
	JK1Pmd4AqQu4f6BKay3liZNu7P99Ro5AgmhP2HdmTdcVKXTqTI/RCTCVlqqVDgc=
X-Google-Smtp-Source: AGHT+IF0N3nJ0v0xMCJWoXiR1L2taB/SeE+T/bQehDWKai9p6z1i/Ea7/Tq7rP7fxtkgVZzA+A6MjQ==
X-Received: by 2002:a05:600c:4f81:b0:426:6eac:8314 with SMTP id 5b1f17b1804b1-42e7c15b3b3mr11936645e9.1.1726821489528;
        Fri, 20 Sep 2024 01:38:09 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7540e2c1sm43099165e9.2.2024.09.20.01.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 01:38:09 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 20 Sep 2024 10:38:04 +0200
Subject: [PATCH v2 2/3] dt-bindings: mmc: document mmc-slot
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v2-2-5aa8bdfe01af@linaro.org>
References: <20240920-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v2-0-5aa8bdfe01af@linaro.org>
In-Reply-To: <20240920-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v2-0-5aa8bdfe01af@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1400;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=kNCAWhKmcmtpyB2uacECJO/JKXg8Fz3C8WIqjPA3amY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm7TRuv0TNIP3Dfopqh/6/jNdlr+f2fiJ+hNO2E2xl
 JMCDBbGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZu00bgAKCRB33NvayMhJ0QvMD/
 4if1rpppxeuzEJQ/h4qKYR491G86sLv9/x5vaqFt7TYk8916m05notBJpCcIVuJY1a1Pj0NdbOctq7
 IektA8ey9J9E2Yk9+6ZdIV0ApMO93QnYE2e3JCKngTKF87AU7c7r19fLbZBDV6+b1Nzw8mICKKfHDA
 SYyC/eWFn2UM1x7wWL1RnwGhYxDdgkIY3U+7X0Nl54ySgYxhDMDP75nvsK6lMkbX/AnHv8EnyERYSS
 ZwdkxvuxjYarBz0zxaHX0/s/GeFFZJZQGVZ0rENXSt62Gto0C1tOVCfoQWLVj7Pu+9IVyBZXgc4kTj
 4mkTJrUoMwiVg0CvQRhX+1wqEaztErQzFQqbIBZDtUfK7tmE9JDK37QpABpJqaN37u+b71T01UzMjx
 E6C8QzpOJMY7lbc7utY0Oz3FuhZhhUNi4MgBIlkrtaRirck9CuR1GwR4A0/wanM506YMOkCGAulW6K
 Qmj1GtydIWT4nmNwzO3a8LDSMHbZJRMtUnZYa233jms4jPGGyLHCiKYuZoOPyMSwvKSDB++qOuqm7I
 jQBZlA//mggE5gQOontemh4/hyqBaSuBKbARQgzIJKf4i2TpUOMDHxPbco6wRf37PeIY79ckFKAZkn
 MuujdtIppczEYhmT9h9gxclS7u8Sa6ie87RX/O8arYmALxf/Wf3+jjKmeRXQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Document the mmc-slot, which is a subnode of a multi-slot
MMC controlle, each slot is represented as a full MMC controller,
the top node handling all the shared resources and slot mux.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/mmc/mmc-slot.yaml          | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-slot.yaml b/Documentation/devicetree/bindings/mmc/mmc-slot.yaml
new file mode 100644
index 000000000000..c30eda4fd2a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/mmc-slot.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/mmc-slot.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MMC/SD/SDIO slot of a multi-slot controller
+
+maintainers:
+  - Ulf Hansson <ulf.hansson@linaro.org>
+
+allOf:
+  - $ref: mmc-controller.yaml
+
+properties:
+  compatible:
+    const: mmc-slot
+
+  reg:
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
+    mmc-controller {
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

