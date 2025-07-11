Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4262EE293
	for <linux-mmc@vger.kernel.org>; Fri, 11 Jul 2025 15:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248559; cv=none; b=P6mzEToxMg3Ild8X2NOf9IB599muCcgK3520V0uX36Wb7UeCV9TGda+h0Cm1tloEvpLWFzn4L8DxythMmfjfIx4qcedrxPFEMFrqQs6N9M7jZS38sYdhM3JYw2vAXXp8St/7NvZVXn4qGXVsLYm0B487imO2jjzQcL69NB60cHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248559; c=relaxed/simple;
	bh=BAc/sjOJ52MzyENBcYQWdmAAONlg0iiGCQeVh9n0u0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NzdbRSELMWIQKg5vRb9scEQdvdgKV/pfI6crX9oRZCZdwXJ3YBdSM86eaPuCK08lBeprsUb/hqe8alJ9ZfRO78TujzvLaH2Cz35m5E6dRyM9VcqZDHyWTRfaK5JejTbqNM+dae3/rJ+hfaMOWNtqwmE/ZNjVQ4dqUMqOGmHStbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fjhXEZej; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fjhXEZej"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7490cb9a892so1465700b3a.0
        for <linux-mmc@vger.kernel.org>; Fri, 11 Jul 2025 08:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1752248557; x=1752853357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NH82M7Wpg8q915gzukGl/UR0qvoygGIK5SM365nsKWY=;
        b=fjhXEZejfbdArU7rLAYnHOzEQglV939ytD/F+dk5J8EtPNZqNNOS6ivd9O/jxpvqxM
         P+LHrkhNl/h7uayPdxIF1t1OvH+g+JEVvGcbhN3fpqbPfJ1YXCr3OqjzKZtFNVFks+Y8
         OruUNRnEP+vkN9/9h9m7sTkYqlmjk75bBYQjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752248557; x=1752853357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NH82M7Wpg8q915gzukGl/UR0qvoygGIK5SM365nsKWY=;
        b=qEK/pc0wyC8w7y6JCHeRrWUGwVVxazm+z5VRwiGPhZcHyfBikTGP0uXsBh34vOaP7i
         4UZT0+4CXtdBTMT11DoqGogIye38ZJqZaxVlwzU1USoAD+kldbv8nJKqe2tBniiZ7DZx
         4IrLBFtM3Kg0qj7n8Cdq93MwMwgCpZEg/A2nxHnTTN704M0HelvLBJvQhnzHXPUXaX+X
         49RCcWKwD3wAWxStILqO4MaYBNcX54gw61oNkWTvvq1XDeUhXidP4yjGgfh8OLAPDUnq
         IAYdKO6BUakJy8+FWn2JuwVCuzRxex/RIjLbrvkXIUb6yi7XDg630NjG6ja5DBmM74ZR
         rxhw==
X-Forwarded-Encrypted: i=1; AJvYcCUDtLQUVdxzdxCMdIBVjUt26FARFgcd93NEFxlt+23StMQcJp/f3+A4la8erzBC7T5Gel7REMTLAr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdoszWmObeQI2qr8UHAZmW4z6vcr7kcdRTirAfBjpsR7DC4AWE
	vOklDukApBskWeevhWc3nEGJDrsUO0vml6E2kO13F+G3qXXgFVEZX8LPmPJEEYQP5A==
X-Gm-Gg: ASbGncu2If4VGUL95K1KsgerBIZQ91+50lnkr78RRkg5+BP89FIp10GIpPMO55Po3kn
	UKNNe94dgbKKFBN+TtI8m+5IQ5oK1EmM2N4EBMe436fGDGDxAY/wKgtbAf7SyeG1MXuAVDDeASl
	/C0eAZIF2Eirgak8UlkbatSyNQ0pYUEdLBOv+aEGtbVbzXejhvPRVmdstSaceLlC9wN5Df13Hcy
	8sst6hhV7R2Rfk5d3YQa5lt6/EKcDK32WYtXHUclS5BZ/mmWx91TNyuN/H3tvy0JTmHFFckH4YZ
	ZKd0mpAnWI7RP+MkcgbDBAZcYVvo4OmoM70/dEkqaoRJKzeotLb/VESqiHlsIv+YX6i7OmBRp3B
	tyBdyVqBB1hMX6raZVyG7sWoGJ+3zh3Rcbe6odGlasnV+Bl9im0BRGlHYXQ==
X-Google-Smtp-Source: AGHT+IGikmpmpoiahS6C039EIM4FWOINmFiK6nKg81tKKKY6N2Q8zXv85yrb97AEzFO3cAhGLIqJ9g==
X-Received: by 2002:a05:6a21:48b:b0:22f:8484:5ac2 with SMTP id adf61e73a8af0-23120df88c2mr6194764637.38.1752248557400;
        Fri, 11 Jul 2025 08:42:37 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd5ccesm5762420b3a.27.2025.07.11.08.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 08:42:36 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: andersson@kernel.org,
	baolin.wang@linux.alibaba.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	florian.fainelli@broadcom.com,
	ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	kamal.dasu@broadcom.com,
	linux-remoteproc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	Kamal Dasu <kdasu@broadcom.com>
Subject: [PATCH 1/4] dt-bindings: brcmstb-hwspinlock: support for hwspinlock
Date: Fri, 11 Jul 2025 11:42:18 -0400
Message-Id: <20250711154221.928164-3-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711154221.928164-1-kamal.dasu@broadcom.com>
References: <20250711154221.928164-1-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kamal Dasu <kdasu@broadcom.com>

Adding brcmstb_hwspinlock bindings.

Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 .../hwlock/brcm,brcmstb-hwspinlock.yaml       | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwlock/brcm,brcmstb-hwspinlock.yaml

diff --git a/Documentation/devicetree/bindings/hwlock/brcm,brcmstb-hwspinlock.yaml b/Documentation/devicetree/bindings/hwlock/brcm,brcmstb-hwspinlock.yaml
new file mode 100644
index 000000000000..b49ead166b1e
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwlock/brcm,brcmstb-hwspinlock.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwlock/brcm,brcmstb-hwspinlock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom settop Hardware Spinlock
+
+maintainers:
+  - Kamal Dasu <kamal.dasu@broadcom.com>
+
+properties:
+  "#hwlock-cells":
+    const: 1
+
+  compatible:
+    const: brcm,brcmstb-hwspinlock
+
+  reg:
+    maxItems: 1
+
+required:
+  - "#hwlock-cells"
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    hwspinlock@8404038 {
+        compatible = "brcm,brcmstb-hwspinlock";
+        #hwlock-cells = <1>;
+        reg = <0x8404038 0x40>;
+    };
+
-- 
2.34.1

