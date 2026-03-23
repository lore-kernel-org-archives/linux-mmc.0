Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC203DA5D8
	for <linux-mmc@vger.kernel.org>; Mon, 23 Mar 2026 19:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774295080; cv=none; b=iI/quaJ17E/0jBVuokcT8KbfmMU9Wkf4vVpkZD5n5mukbThsHJqH/LDUF6fXXh2uunKihPBIkT+UYQlhrkTCIimJKy9mShQ90joYKI0LT2pF8xbZPaRg9P6hAXSBHHV9XzwAH7sTa9E0hzMBW5X6BE8m6bPQ+P1Zpz8nIf639b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774295080; c=relaxed/simple;
	bh=hc563ooZYaVkY6EJtofqVXCRUiOYyE1BTDEGjhK6NTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NNiOImBYLbSI0qLKfimHdvvdQd/46UEF0Gu3/5qY4ZTFBZw4oBIqhb8cd7an2l48eKcP5J00YSJzBEz2lnH7rQ4WSkGfh0S6ws5wwriuQgeNW8ccVXCsRixOJJ8qWpfXk88s138f+zuGbVQyVlS7+1rccHMQ/i4t9SStnpBxYZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmK4hkgJ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmK4hkgJ"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c739d32b72cso3228358a12.2
        for <linux-mmc@vger.kernel.org>; Mon, 23 Mar 2026 12:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774295078; x=1774899878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SRRIBaQ3cZUqzx3gb0MYjn+zdBeG7CtGKHxi5Gkpn4Y=;
        b=HmK4hkgJm3Jwjt+uHYnX1qTDVWhsa7GtHUvOlXO1Qox+TqAZSetxsTfwoA6c9BbEZ1
         eC0bgCR8bKnogxYNlJRCkxumAJjVhcD5zbj5i0XCwW935+qgW3JCb5LWSy1KpU2/QR0+
         1kyKPsKDuUaMf7jA3rL3jwENlnKlk99qzxoaebsw37+afoTgCEUQv3xTdA7k4Xl+dT2P
         um43SBhsJ9JwM66ezIQGEUhduO9JHQvGqruBgdltyHO60g+kmjq8Sq1aT6mQtj1svbV1
         BZiVyjgCZQ6EnC4jwViZnjmCMosUiLI/ZcPlXtEwpwCd86AY8NCpkuU0nGLF65gEBTe4
         2yJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774295078; x=1774899878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SRRIBaQ3cZUqzx3gb0MYjn+zdBeG7CtGKHxi5Gkpn4Y=;
        b=RJW6hdTePrOh6NXLpTzGUR3LbpuU4vtfU/XLhO7hcznY697UuoQ8XjIdOGePnyEVjk
         aedQ5aUie2hXS6pWKXBWpPSXsPhKYy55xit0DjkR6VLpSGJmzfDxvwfpPjCHeomX5t3+
         9iV1byJ3aZFFiLUvr5aAD9rx9P4KX4kJd7SIPy9SdedcaZTeSsnYhRIrc4NQUeJHgf0+
         wQW3qjd8jDOZoX0ULk18YBiCknneHNXJvm347W/hTZATu1rDsQqFEgvLlm2yVeAYEppr
         P2sX6Ls1kHkYqWPowjrqcdJnlOBIF68YIRxctTT/+Awo36pBzpjJuIZoi4gLl9CV8KGL
         UH4A==
X-Forwarded-Encrypted: i=1; AJvYcCVABrt9lFida1C0eydCQkkAfLuNyCa5HZeav+rwQaywdu4sVxE5idwvAIOjN+S8+0MZ2vepnQMs/bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfvDnBCEjEJoPZ09Qctbpm9BestWV4EgVj4X/BOi0MkZ3P6uDi
	inapJ9Zwz59ZHz6KhqzVExNBo6QoiCIbNUpPu14Ha8Q8pdlCBIPdIRJ1
X-Gm-Gg: ATEYQzwwNoqIstbgzYHUOkCIqnlR1f40Qzt12xIAnmSM4S7BXzC3T+IYYmInXjhuM/P
	AL6d9VJ7XL6JiMJ7McVTCLbGQfBWxMko8s8kqQRXj7Tp5gYPo/rsRP+gOG72fln8MWtMvA/SsDa
	6bEvYpjiZiM74nqA1a3rpDWiJKIKhSkyvvimS84mNWcsHVXboELdGdrYqeIaCyr+92hyfdOgSTv
	TOYM8iGTDDb9C1TXLWlstDTe5PJFCysKVqDn0r3ihqtgnJdLJMRfX2b7G/lXcI96l3kMe54yqSd
	EOrBh9ETV0RdSXYH77/wf7vyz9Z1nVAvBPU9GdUFxvaLysz6kcTndqPg9jgAQ3GGYSnyv+VQOS8
	4fuGR72WET6NjxgD6OH8cH70c4/uSgPvvH/QBEdMw4ZNY37MYxrajj8N8f6FTUmdujjbzge2vTR
	zaDc93oo1sjPZGDzIFkOWpLS8=
X-Received: by 2002:a17:903:2449:b0:2b0:686a:d470 with SMTP id d9443c01a7336-2b082724c4fmr144083465ad.23.1774295077790;
        Mon, 23 Mar 2026 12:44:37 -0700 (PDT)
Received: from arch ([2409:40c2:5005:bea7:1ec:aaa7:ee5b:2371])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08366c3f7sm152080805ad.60.2026.03.23.12.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 12:44:37 -0700 (PDT)
From: Bhargav Joshi <rougueprince47@gmail.com>
To: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	xuwei5@hisilicon.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulf.hansson@linaro.org,
	zhangfei.gao@linaro.org,
	linux-mmc@vger.kernel.org
Cc: daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	d-gole@ti.com,
	m-chawdhry@ti.com,
	rougueprince47@gmail.com
Subject: [PATCH 1/2] dt-bindings: mmc: hisilicon,hi3660-dw-mshc: Convert to DT schema
Date: Tue, 24 Mar 2026 01:13:59 +0530
Message-ID: <20260323194400.22886-2-rougueprince47@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323194400.22886-1-rougueprince47@gmail.com>
References: <20260323194400.22886-1-rougueprince47@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Hisilicon DesignWare Mobile Storage Host Controller
(dw-mshc) bindings from text format to DT schema.

As part of this conversion, the binding file is renamed from
k3-dw-mshc.txt to hisilicon,hi3660-dw-mshc.yaml to align with compatible
string naming conventions.

Examples have been updated to pass schema validation.

Signed-off-by: Bhargav Joshi <rougueprince47@gmail.com>
---
 .../mmc/hisilicon,hi3660-dw-mshc.yaml         | 111 ++++++++++++++++++
 .../devicetree/bindings/mmc/k3-dw-mshc.txt    |  73 ------------
 2 files changed, 111 insertions(+), 73 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/hisilicon,hi3660-dw-mshc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt

diff --git a/Documentation/devicetree/bindings/mmc/hisilicon,hi3660-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/hisilicon,hi3660-dw-mshc.yaml
new file mode 100644
index 000000000000..6ba1a42a27ac
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/hisilicon,hi3660-dw-mshc.yaml
@@ -0,0 +1,111 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/hisilicon,hi3660-dw-mshc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hisilicon specific extensions to the Synopsys Designware Mobile Storage Host Controller
+
+maintainers:
+  - Zhangfei Gao <zhangfei.gao@linaro.org>
+
+description:
+  The Synopsys designware mobile storage host controller is used to interface
+  a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
+  differences between the core Synopsys dw mshc controller properties described
+  by synopsys-dw-mshc.txt and the properties used by the Hisilicon specific
+  extensions to the Synopsys Designware Mobile Storage Host Controller.
+
+allOf:
+  - $ref: /schemas/mmc/synopsys-dw-mshc-common.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: hisilicon,hi3660-dw-mshc
+      - items:
+          - const: hisilicon,hi3670-dw-mshc
+          - const: hisilicon,hi3660-dw-mshc
+      - const: hisilicon,hi4511-dw-mshc
+      - const: hisilicon,hi6220-dw-mshc
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: card interface unit clock
+      - description: bus interface unit clock
+
+  clock-names:
+    items:
+      - const: ciu
+      - const: biu
+
+  hisilicon,peripheral-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle of syscon used to control peripheral.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/hi3620-clock.h>
+
+    mmc@fcd03000 {
+        compatible = "hisilicon,hi4511-dw-mshc";
+        reg = <0xfcd03000 0x1000>;
+        interrupts = <0 16 4>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        clocks = <&mmc_clock HI3620_SD_CIUCLK>, <&clock HI3620_DDRC_PER_CLK>;
+        clock-names = "ciu", "biu";
+        vmmc-supply = <&ldo12>;
+        fifo-depth = <0x100>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&sd_pmx_pins &sd_cfg_func1 &sd_cfg_func2>;
+        bus-width = <4>;
+        disable-wp;
+        cd-gpios = <&gpio10 3 0>;
+        cap-mmc-highspeed;
+        cap-sd-highspeed;
+    };
+
+  - |
+    #include <dt-bindings/clock/hi6220-clock.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      mmc@f723e000 {
+          compatible = "hisilicon,hi6220-dw-mshc";
+          bus-width = <0x4>;
+          disable-wp;
+          cap-sd-highspeed;
+          sd-uhs-sdr12;
+          sd-uhs-sdr25;
+          card-detect-delay = <200>;
+          hisilicon,peripheral-syscon = <&ao_ctrl>;
+          reg = <0x0 0xf723e000 0x0 0x1000>;
+          interrupts = <0x0 0x49 0x4>;
+          clocks = <&clock_sys HI6220_MMC1_CIUCLK>,
+                   <&clock_sys HI6220_MMC1_CLK>;
+          clock-names = "ciu", "biu";
+          cd-gpios = <&gpio1 0 1>;
+          pinctrl-names = "default", "idle";
+          pinctrl-0 = <&sd_pmx_func &sd_clk_cfg_func &sd_cfg_func>;
+          pinctrl-1 = <&sd_pmx_idle &sd_clk_cfg_idle &sd_cfg_idle>;
+          vqmmc-supply = <&ldo7>;
+          vmmc-supply = <&ldo10>;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
deleted file mode 100644
index 36c4bea675d5..000000000000
--- a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
+++ /dev/null
@@ -1,73 +0,0 @@
-* Hisilicon specific extensions to the Synopsys Designware Mobile
-  Storage Host Controller
-
-Read synopsys-dw-mshc.txt for more details
-
-The Synopsys designware mobile storage host controller is used to interface
-a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
-differences between the core Synopsys dw mshc controller properties described
-by synopsys-dw-mshc.txt and the properties used by the Hisilicon specific
-extensions to the Synopsys Designware Mobile Storage Host Controller.
-
-Required Properties:
-
-* compatible: should be one of the following.
-  - "hisilicon,hi3660-dw-mshc": for controllers with hi3660 specific extensions.
-  - "hisilicon,hi3670-dw-mshc", "hisilicon,hi3660-dw-mshc": for controllers
-     with hi3670 specific extensions.
-  - "hisilicon,hi4511-dw-mshc": for controllers with hi4511 specific extensions.
-  - "hisilicon,hi6220-dw-mshc": for controllers with hi6220 specific extensions.
-
-Optional Properties:
-- hisilicon,peripheral-syscon: phandle of syscon used to control peripheral.
-
-Example:
-
-	/* for Hi3620 */
-
-	/* SoC portion */
-	dwmmc_0: dwmmc0@fcd03000 {
-		compatible = "hisilicon,hi4511-dw-mshc";
-		reg = <0xfcd03000 0x1000>;
-		interrupts = <0 16 4>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clocks = <&mmc_clock HI3620_SD_CIUCLK>, <&clock HI3620_DDRC_PER_CLK>;
-		clock-names = "ciu", "biu";
-	};
-
-	/* Board portion */
-	dwmmc0@fcd03000 {
-		vmmc-supply = <&ldo12>;
-		fifo-depth = <0x100>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&sd_pmx_pins &sd_cfg_func1 &sd_cfg_func2>;
-		bus-width = <4>;
-		disable-wp;
-		cd-gpios = <&gpio10 3 0>;
-		cap-mmc-highspeed;
-		cap-sd-highspeed;
-	};
-
-	/* for Hi6220 */
-
-	dwmmc_1: dwmmc1@f723e000 {
-		compatible = "hisilicon,hi6220-dw-mshc";
-		bus-width = <0x4>;
-		disable-wp;
-		cap-sd-highspeed;
-		sd-uhs-sdr12;
-		sd-uhs-sdr25;
-		card-detect-delay = <200>;
-		hisilicon,peripheral-syscon = <&ao_ctrl>;
-		reg = <0x0 0xf723e000 0x0 0x1000>;
-		interrupts = <0x0 0x49 0x4>;
-		clocks = <&clock_sys HI6220_MMC1_CIUCLK>, <&clock_sys HI6220_MMC1_CLK>;
-		clock-names = "ciu", "biu";
-		cd-gpios = <&gpio1 0 1>;
-		pinctrl-names = "default", "idle";
-		pinctrl-0 = <&sd_pmx_func &sd_clk_cfg_func &sd_cfg_func>;
-		pinctrl-1 = <&sd_pmx_idle &sd_clk_cfg_idle &sd_cfg_idle>;
-		vqmmc-supply = <&ldo7>;
-		vmmc-supply = <&ldo10>;
-	};
-- 
2.53.0

