Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9560C1BD007
	for <linux-mmc@vger.kernel.org>; Thu, 28 Nov 2024 15:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732807014; cv=none; b=piFtspAD+q4S4zj1tuL/aI9iiOyEJg/N5tnOlvsHiw7f5R5h/Zcx/1gJ8WygPT3o/tBH+yk7aNdIfCrlXCAmPiCKfDQRC4CiN0PGDhdB1KuQGs8i1p8BZ3NfzYIB6VJSANoy85k1reg2+wtSzIsZOaKnXxD5dRng3R4W5ZZaFa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732807014; c=relaxed/simple;
	bh=KH6tn61/Aofb7L+ocHnF34SBttJAGs8D9xM5t0ckYwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N3aqIxdrLsLdQ6nSEyq59wZl3siG53BvfSJEItVfsHEMkcjU0+DpyoNa1gLs2kPj2BJX2ZOqEa4GiJUFLJLyPUnnQffAL4Ya5XHx/gFbQgtiM+5ScHUPjG2uw8QFp2vMB1D12ITaNva4mw2k03z+VWmgzmwN0AdSAlbKoBLjNSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XJovoJqM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XJovoJqM"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4349f160d62so8357395e9.2
        for <linux-mmc@vger.kernel.org>; Thu, 28 Nov 2024 07:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732807011; x=1733411811; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S5Q6Qv7Q+7NO9XRjvZFVeABmFoVh33eCRfYHhRmvlpw=;
        b=XJovoJqMCr0OOC5a7cmVFcs96NJJtNSPf1f28StK7+zWHsDkFihP3wPTiJz2tQ4Gj+
         pzfYoTa+pF4Sg6xJeytNb1yEX4ioJ1QP2zeQmAHVBtTO5CN00f7DjGVsQUv8oPYIgo83
         zoz0uM5eMnR3RvPHdrTXkwU2YbmGJL5bymAMwCCocOP/OeVITsIPON3zg99xK0Tf1HgH
         1+JJ3Lg2NgdfqVg0LQQYm6edWgTo1k9/dQIbCH76k81fjOlK1VAjOfbtmSNNzTlq/Rew
         xNrfBPM6U1xXDs8CJ2/ANgwQskKC7Goz6d4Oj5fR+xmn6Ce33MZVu0FOfcDZTIcQYvng
         toHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732807011; x=1733411811;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5Q6Qv7Q+7NO9XRjvZFVeABmFoVh33eCRfYHhRmvlpw=;
        b=BbC+r3CuOqLGPvV1he12mqSnZbbVm5KlD4HmbtJE1v/g78ltEM+GbCXtV5gHyQb4y/
         znvj0IVaAZ0f/LsLByVzHLfSYz7BbJRUfG+RPJ+5D0ruCzKN7pOyQWg5z12Fa/kjIjS9
         5pNS9aVLdVfyimrfd8Eu778PhEYaz126WYd8DF5Nz3lXcGXhbeuapyOW1tHnvSXDErB7
         3Oyrp1mpIP+ESQBbESt159Sm1xyM10AuHF8qzSZyvl0Zy83ncRzqJZybJK/EIyT4WR1Z
         75jp7UFTjIzqWxBeBZaqgo5zC1gaRx+EmeyLS1WYZXjeIrWGLK9Eb0alAeKjdtyk/1+q
         PouA==
X-Gm-Message-State: AOJu0YyeJ6iF8rrwYEc6iL2cla/I1v9RtMD9Ut1h4igs8PH8vGfTNVV+
	Y/qoktOh3PldFyJpgrpo5M22E2G5N/XCbXCjqu+RSYOQdtRKidPTpoGmk1lEO28=
X-Gm-Gg: ASbGnct7SfalxtsLpn/H6mCiRqtVZsy7qlINpnbIDJyKjrsV+yBsS5Ui+gjvRbfh1jQ
	ggTdLwUzcODLnPXCb9ifYzURq/ja+kHDG7WhbUIhhYC031LDEis+827UzTLamDTeAZsNWQaRodL
	G619z8e4tIxsrQUvabljBXn19kmenHEun88rfg91n1TKuGCxF1v83Cg56mj9yo8RlTXRUfL3IlA
	NoRIJN97fOxBxfByqgle3pviSXoKZuEIR4gixSI4jPwjprXNQtbUUqXlZHFYSvtS5gvmAk=
X-Google-Smtp-Source: AGHT+IF0iJc1B5czbddvWTBnzzA/XHuEcHL2hR6LyPDDF8y2Tqjitcp7kVj8ES42GYzv1qAY3kVKlg==
X-Received: by 2002:a05:600c:3b29:b0:431:57d2:d7b4 with SMTP id 5b1f17b1804b1-434a9de3be9mr60030445e9.26.1732807010910;
        Thu, 28 Nov 2024 07:16:50 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e4fe1sm55867025e9.38.2024.11.28.07.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 07:16:50 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 28 Nov 2024 16:16:44 +0100
Subject: [PATCH v4 4/5] dt-bindings: mmc: document mmc-slot
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241128-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v4-4-11d9f9200a59@linaro.org>
References: <20241128-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v4-0-11d9f9200a59@linaro.org>
In-Reply-To: <20241128-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v4-0-11d9f9200a59@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Maxime Ripard <mripard@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1754;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=KH6tn61/Aofb7L+ocHnF34SBttJAGs8D9xM5t0ckYwk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnSIlcZZ0QyhefaYAilsotWqcLqgfPkSKK9P1RiHTk
 FklhojiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ0iJXAAKCRB33NvayMhJ0QNtD/
 wJTQlrjKH0PY65pp1YvHE/K8ab0MOAghsuUJS/CYKI6D2Ee2EewIuUP5zLVsm1tq2+EUEOrJBqIlLM
 xgxNnGjNR2QEnoZfWeNFEEACal3ui9bkPZi7c2/CSi4KUw5SAT9ycCwBaNCH2JVbX+ubMcQJo6XQW2
 IoqziEgnTD32MkJP+gFanL4SoBxlVE0sGU3QiDu3scymKJ9CCFANE0EOsuBmNS5RIR0h4CEuFSsBPd
 cKefbWZxv97HOPZPXeGrVt5CIkqZ1R+Ajel9T8zVeQ12NZ86wXD6ytuxe1LVXq0pNiQWZ7pvk/zH6m
 SBIZe9BM6HH1ggbkmp77J6HTXaFZxP4C2HjNPXsWg5Mzx8X4jF8318t+BkiRcaBmDxWAc55M9FAS7h
 B3I/6SO7VdKxmRjJc2HKqMDiMpk28uXgaManIKOkN8gzmJtp7QZgYgTTRuO4wasH3yifooaU7AEUpL
 lo71weRzjMjo7d3Ev8mUidV+EvTIgqsbGxAMqmfoZvQROyUkcFMLMFvGmVWMznw35s+2k1yh4zxq8y
 h5JdkysR9IUT/SlbHfkuFR70LYpUIEROx4wThdLGqLVbfKf/2Ci9iuiiWlMOtthQcz60C8+m+Kg5qs
 OOD2zGlhE0zLGIpNpIlTBCYvq2DwHZlzV71aErT//1OaZGZHMJFbMGvvIomQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Document the mmc-slot, which is a subnode of a multi-slot
MMC controller, each slot is represented as a full MMC controller,
the top node handling all the shared resources and slot mux.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/mmc/mmc-slot.yaml          | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-slot.yaml b/Documentation/devicetree/bindings/mmc/mmc-slot.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..1f066782806341a9f72460edd8e6454ce22f4320
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

