Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA1E16CD3F;
	Wed, 26 Jun 2024 09:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719395377; cv=none; b=JeVx8uPP5kDklRasLmqP2eMj4yW6srWJDJt478wrb5aTNRfWQHoKFtJid9j2Ix+xr9QD7zAH1Jz1ssT9lPKvd1Nv1cLT1d8aqDTg4FdDU/atX3xhULjFk4uaecyWVF16hYxX8Umpmlf7qs2ELbkmqpqKOlAePnRM2CwGYemNBuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719395377; c=relaxed/simple;
	bh=Vs/qlcIuOys/DBZdAlNjrBgPL42NJNU5OER9QoS34dg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oxtx2MMcvLM7XUhJyYCOxs9JFM6Gz4LeTyHCBJAdw6JUoq3yDxjpZc6YIwqEb5STOVbVqHO4WfndcUmnirv/M1DboMZU3Vrx2hqrPMcOPYA2TOd4BUTWwK4FSdyI2GuQgLk3b5fVAtlT90VT0pf+xwtu0LTsfUMeq1bTYZHnuyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ox1dyGyA; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ox1dyGyA"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f9cd92b146so50805215ad.3;
        Wed, 26 Jun 2024 02:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719395376; x=1720000176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+GuVF2kNwP7dpaSNdPfapL93zga/d4F8D+n/ifJ75U=;
        b=Ox1dyGyAnVO0gigqmAWP0fWqUw7mIrm+Hmr3a3WQX42GujuBkSHCkWbeyvyorbJLEI
         ERPMz4PAFKhbhMfOmHdAIM5ZVH1VES12Bld5Q10XZZ9I1TZf3KLGVWWRbKXq505r99+d
         RHXrYHXXAwqLFLuvu/MGrnZqTXXfdd2KAxWm7hPn2raIvNs1Qhne2wgH7W9Xb6yHiBLK
         juzFemQXU3UR/FcXI1naPLDNmjA9OhT6URdHmog0XitY6/azpQqCsXsdESdPwD8HmqPB
         zyN0Wde/f9VbhlXNMUQOnSxlrZgyjpcjT1uKElbb3rovmEWlFvPPsfHdNc7AG1Tgp6ff
         uyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719395376; x=1720000176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+GuVF2kNwP7dpaSNdPfapL93zga/d4F8D+n/ifJ75U=;
        b=L3G4UZ7kmjov/gVwNDKwmBxe2FMNFvrxKFx7XcBkwKMwuhv0Sy0s7smKQxQPSrx8Xp
         QFGo2lb4pvzCruOKVrlDOH/9f0v34VRqaX370VtxXNrHxtWomqBGrG1fLWtZqaKzDA3J
         CAEcg7WGev51k2AqDd6nA1bYDlpJaAlbQmdWvU8SxA2Q9kvgOMk3x07/L6i1TffEw8ya
         /sTU+oes8yidZev3QrjgHmVtcdBJU/Hn/5TgjwAtyrAhDfoqYWr07wlskHezHfv0hsVB
         peUjzN00d8pKrgVagrdZBUvWRP+pzbhQ1x50sbWuDqB8Wr57ELawuzyH6a40ZoFLuTMJ
         p+GA==
X-Forwarded-Encrypted: i=1; AJvYcCVpxKKCYfmNgXya9V2O0ldxd9sRHb1BMJVenRPd7bBpZc/gzdw8DTReRBupQ39AylcyyDbCyzPlevJYbVhPD3/38/3evscWUEmYJTvaQhZnTrKSW1rfmx/RYnaBmNmPButN/OgHEnxkQHKvCtQJ3knVLzssmhLFGcebcvkrvpoS1b5EEA==
X-Gm-Message-State: AOJu0YyPFsn7c5K6iOBcaI4tvI8IE3nb2QCHZORUWUSIvUPit1oxebGQ
	kt2HD8xdsAJODTLWZZhDRDAQOvDnlqVWM1WUTHUvkKqJtmJOQNT+
X-Google-Smtp-Source: AGHT+IHmhVPHR+5qLRqdHVBwSmCtA5LIo6N3PffQrMAMWD5uvvEt2Da2ZU+nSalje3F678s4B+oI7w==
X-Received: by 2002:a17:903:18d:b0:1f9:aa05:878f with SMTP id d9443c01a7336-1fa1c7f72fcmr139378035ad.0.1719395375523;
        Wed, 26 Jun 2024 02:49:35 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fa6aa7030bsm29726665ad.288.2024.06.26.02.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 02:49:35 -0700 (PDT)
From: Shan-Chun Hung <shanchun1218@gmail.com>
To: ulf.hansson@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	adrian.hunter@intel.com,
	p.zabel@pengutronix.de,
	pbrobinson@gmail.com,
	serghox@gmail.com,
	mcgrof@kernel.org,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	forbidden405@outlook.com,
	tmaimon77@gmail.com,
	andy.shevchenko@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ychuang3@nuvoton.com,
	schung@nuvoton.com,
	Shan-Chun Hung <shanchun1218@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: mmc: nuvoton,ma35d1-sdhci: Document MA35D1 SDHCI controller
Date: Wed, 26 Jun 2024 17:48:59 +0800
Message-Id: <20240626094900.581552-2-shanchun1218@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240626094900.581552-1-shanchun1218@gmail.com>
References: <20240626094900.581552-1-shanchun1218@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add binding for Nuvoton MA35D1 SDHCI controller.

Signed-off-by: Shan-Chun Hung <shanchun1218@gmail.com>
---
 .../bindings/mmc/nuvoton,ma35d1-sdhci.yaml    | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/nuvoton,ma35d1-sdhci.yaml

diff --git a/Documentation/devicetree/bindings/mmc/nuvoton,ma35d1-sdhci.yaml b/Documentation/devicetree/bindings/mmc/nuvoton,ma35d1-sdhci.yaml
new file mode 100644
index 000000000000..cf08cdcb58ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/nuvoton,ma35d1-sdhci.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/nuvoton,ma35d1-sdhci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton MA35D1 SD/SDIO/MMC Controller
+
+maintainers:
+  - Shan-Chun Hung <shanchun1218@gmail.com>
+
+allOf:
+  - $ref: sdhci-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,ma35d1-sdhci
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  pinctrl-names:
+    minItems: 1
+    items:
+      - const: default
+      - const: state_uhs
+
+  pinctrl-0:
+    description:
+      Should contain default/high speed pin ctrl.
+    maxItems: 1
+
+  pinctrl-1:
+    description:
+      Should contain uhs mode pin ctrl.
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  nuvoton,sys:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to access GCR (Global Control Register) registers.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - pinctrl-names
+  - pinctrl-0
+  - resets
+  - nuvoton,sys
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
+    #include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        mmc@40190000 {
+            compatible = "nuvoton,ma35d1-sdhci";
+            reg = <0x0 0x40190000 0x0 0x2000>;
+            interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&clk SDH1_GATE>;
+            pinctrl-names = "default", "state_uhs";
+            pinctrl-0 = <&pinctrl_sdhci1>;
+            pinctrl-1 = <&pinctrl_sdhci1_uhs>;
+            resets = <&sys MA35D1_RESET_SDH1>;
+            nuvoton,sys = <&sys>;
+            vqmmc-supply = <&sdhci1_vqmmc_regulator>;
+            bus-width = <8>;
+            max-frequency = <200000000>;
+            status = "disabled";
+        };
+    };
--
2.25.1
