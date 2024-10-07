Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0732A1D4615
	for <linux-mmc@vger.kernel.org>; Mon,  7 Oct 2024 14:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728309827; cv=none; b=cw1SQxT7+lo2CbigGNs5D6FtAx5JyA5OFUmLv0q6MQCebf/1Yg9uVNvD6sXPHZl5LGJGLVziXSEwCiPAdIgQslsym0nI9qiTWCfSfIGNz6W8ZO+yh2YUT6Hm4GONh8Crfv90/hv4KqEY8hYY1monVDvzZ6usTUhgb82huE5l360=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728309827; c=relaxed/simple;
	bh=JXZ2QhO+d2v8gfTqiKI3ynod/BjsAjCgD6utx+4qdzE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KMDbF/O/hgbdVxnLpjjp56ch4jidZea0gNoFhQ5OpmXkLlEcho6a+r1hC925bLNh/DpstnZQT9urqcureN9NvLzvV8pSjWuYgDBdD+tZUXCwuomnLxB7phzv+2nj9cdfeCVpsfcNx11mzCxKCQTRcnCGtJmBye/0S03g9oKiw8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H5qHQPaV; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H5qHQPaV"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37cd1ccaf71so3061891f8f.0
        for <linux-mmc@vger.kernel.org>; Mon, 07 Oct 2024 07:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728309822; x=1728914622; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ZtuxoWlLG6MIr63M1MjhSb8isJPhAfS/eTEmbC2Jj4=;
        b=H5qHQPaVi6MjsZIpI/eAlICyKLLwmbF9c0MaMj9R7WstNMk6SlXAB2vpJ30V63Ffc9
         tW3GPTtdtM5B1f5Mg26pQKjh1WgQ8ZXCZcK0iFopO7QSkyc6wFSTEhp8KE646WD85fbE
         y8jlguwthyrjQ2lpchpRsHgbu1mcKYAGT0X60U42f/W3YioiuGaHeXRVqd/eximLXqYp
         kff1/2aUT1CP2l1wzpBKA5w9aGSYMW2asPHhWm502oZkYYOs7EsrLs+Sd+j3Yqn3nTPu
         8np8oAHClIPFwkgUrv3heFU5ahX/v/ZmEOAspY3W0EaOyuYzpp/Qel5aAfx19wY/ycg8
         Iagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728309822; x=1728914622;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ZtuxoWlLG6MIr63M1MjhSb8isJPhAfS/eTEmbC2Jj4=;
        b=FbDAoe9THUZwRTBgk0zFx06pm7uEL0YavVIb7+RLqWMw96HRdQ2ivlVAIMTU8E49og
         UbKP+1vHYr7jtIEnDrgO4Yp3G7nI/eDTz/w8IU1g9VOfYgGDIoCkLRr4dpRiEX/Q7qXt
         I/OXFZN8nbYC0zFVcqPjOjI4hkmh/doOaNKVgHRd5ka0hs6XoVbGmzVDqdczmsuyv65h
         ox/AC4TSxvwdCVHawgRlSj4andHiUko2/zVw4gsiSNxotXpMfMxZuelfB9N3EdpFSxBE
         dlkWmMtb9sDAYh0j8HQR8E5bsWOHR1SsW+ZbZ4pttQFAfxZUDY4PnPv9GtOsFC36e8Vd
         0G3Q==
X-Gm-Message-State: AOJu0YzRVm3NugsTi3JDvqnxq1SXEkLYyF6dT4ApuKW0BzS3SMALCE0/
	72zsbSIZkc8nMZCReCFzNjOqEvO1f4TbOGm+yh90PSFaxYKXgRqHuBse1O7cF3M=
X-Google-Smtp-Source: AGHT+IF/B1xSevIP+5+TzWYbnSoeJtkilnmlHNqtPz88imFSsCXjbZ/m6dbc7bF4oZnEAdxTygwlpA==
X-Received: by 2002:adf:f04e:0:b0:37c:cc7c:761c with SMTP id ffacd0b85a97d-37d0f66e937mr6688754f8f.3.1728309821984;
        Mon, 07 Oct 2024 07:03:41 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1688a486sm5857022f8f.0.2024.10.07.07.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 07:03:41 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 07 Oct 2024 16:03:37 +0200
Subject: [PATCH v3 1/3] dt-bindings: mmc: controller: move properties
 common with slot out to mmc-controller-common
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v3-1-ad4eb22c2a8d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=24383;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=JXZ2QhO+d2v8gfTqiKI3ynod/BjsAjCgD6utx+4qdzE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnA+o6z99UeVWhjdJGlVpbNpN+CDgvqGkIkP2qxXsK
 +8FPUZCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZwPqOgAKCRB33NvayMhJ0VFCD/
 wKiXiEvoVPDlQytUikVq0DV2fbusIpm2dCzBbPm5JfwYvkRNpTRbeqmFYtrU15sNwznT6KqGppyN+X
 SOnt0dzcaUVj5/jBmphOMoA81cpLQc/TpfWwuVoFAs71pMTPWlEp7SvwBEqMI3AXUEADyPbn+jFx8P
 d2Xk8s/F/VMCCij8Q1KK1RdoXuLJeMfy9zQJFW63oG60ZDsfduLe8TudsdOWG8sKaP504K3lrQFOwC
 yZufCX8n71jUzSBWH0QPIftSh64EEbQrdnglGMvGVVsPfHt+nqrOpxG65PFeYX//J685Ep1TF1FjSC
 y5dzjLF/CE7UBuqaKyymwm/Bzm1e+L7eE75j0ErYHJFWZq9jRjdBdEzW0hIgcOfkFxFnAFZB6JlEIh
 bXvn3G0ttJyaEDlqSdQyYnI4fLp2IDpTMMvv1aHZQAGZHu7/yyaTpL/yeLONwV/Y/jP8g8kunA1+8m
 SnrZNAVYjV+jR3qqQvKPkva5WCKBZGRhzVDtT7JhN/n3pAoSs00zSOjGpojDjnRj1z6+Qpm2K3zUNR
 hzSreyJHBGzulcjdVdLMNINWw5aRhzmPkgC5wdU/DFbZoWMh4Tr0v60Gij/Hl4U8DG+wNnef8fb0TZ
 8S/vT7VRkvO0bzaPB4XytOVruQ89oUvjiL1EbU7g+zXfgD3gBeod2QuW93OQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Move the common MMC "slot" properties because they are shared by the
single-slot or multi-slot controllers, and will help defining a simple
mmc-slot bindings document with proper slot properties and nodename.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/mmc/mmc-controller-common.yaml        | 357 +++++++++++++++++++++
 .../devicetree/bindings/mmc/mmc-controller.yaml    | 344 +-------------------
 2 files changed, 360 insertions(+), 341 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
new file mode 100644
index 000000000000..e02d3cbcc271
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
@@ -0,0 +1,357 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/mmc-controller-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MMC Controller & Slots Common Properties
+
+maintainers:
+  - Ulf Hansson <ulf.hansson@linaro.org>
+
+description: |
+  These properties are common to multiple MMC host controllers and the
+  possible slots or ports for multi-slot controllers.
+
+properties:
+  "#address-cells":
+    const: 1
+    description: |
+      The cell is the slot ID if a function subnode is used.
+
+  "#size-cells":
+    const: 0
+
+  # Card Detection.
+  # If none of these properties are supplied, the host native card
+  # detect will be used. Only one of them should be provided.
+
+  broken-cd:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      There is no card detection available; polling must be used.
+
+  cd-gpios:
+    maxItems: 1
+    description:
+      The card detection will be done using the GPIO provided.
+
+  non-removable:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Non-removable slot (like eMMC); assume always present.
+
+  # *NOTE* on CD and WP polarity. To use common for all SD/MMC host
+  # controllers line polarity properties, we have to fix the meaning
+  # of the "normal" and "inverted" line levels. We choose to follow
+  # the SDHCI standard, which specifies both those lines as "active
+  # low." Therefore, using the "cd-inverted" property means, that the
+  # CD line is active high, i.e. it is high, when a card is
+  # inserted. Similar logic applies to the "wp-inverted" property.
+  #
+  # CD and WP lines can be implemented on the hardware in one of two
+  # ways: as GPIOs, specified in cd-gpios and wp-gpios properties, or
+  # as dedicated pins. Polarity of dedicated pins can be specified,
+  # using *-inverted properties. GPIO polarity can also be specified
+  # using the GPIO_ACTIVE_LOW flag. This creates an ambiguity in the
+  # latter case. We choose to use the XOR logic for GPIO CD and WP
+  # lines.  This means, the two properties are "superimposed," for
+  # example leaving the GPIO_ACTIVE_LOW flag clear and specifying the
+  # respective *-inverted property property results in a
+  # double-inversion and actually means the "normal" line polarity is
+  # in effect.
+  wp-inverted:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The Write Protect line polarity is inverted.
+
+  cd-inverted:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The CD line polarity is inverted.
+
+  # Other properties
+
+  bus-width:
+    description:
+      Number of data lines.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 4, 8]
+    default: 1
+
+  max-frequency:
+    description: |
+      Maximum operating frequency of the bus:
+        - for eMMC, the maximum supported frequency is 200MHz,
+        - for SD/SDIO cards the SDR104 mode has a max supported
+          frequency of 208MHz,
+        - some mmc host controllers do support a max frequency upto
+          384MHz.
+      So, lets keep the maximum supported value here.
+
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 400000
+    maximum: 384000000
+
+  disable-wp:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      When set, no physical write-protect line is present. This
+      property should only be specified when the controller has a
+      dedicated write-protect detection logic. If a GPIO is always used
+      for the write-protect detection logic, it is sufficient to not
+      specify the wp-gpios property in the absence of a write-protect
+      line. Not used in combination with eMMC or SDIO.
+
+  wp-gpios:
+    maxItems: 1
+    description:
+      GPIO to use for the write-protect detection.
+
+  cd-debounce-delay-ms:
+    description:
+      Set delay time before detecting card after card insert
+      interrupt.
+
+  no-1-8-v:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      When specified, denotes that 1.8V card voltage is not supported
+      on this system, even if the controller claims it.
+
+  cap-sd-highspeed:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      SD high-speed timing is supported.
+
+  cap-mmc-highspeed:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      MMC high-speed timing is supported.
+
+  sd-uhs-sdr12:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      SD UHS SDR12 speed is supported.
+
+  sd-uhs-sdr25:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      SD UHS SDR25 speed is supported.
+
+  sd-uhs-sdr50:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      SD UHS SDR50 speed is supported.
+
+  sd-uhs-sdr104:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      SD UHS SDR104 speed is supported.
+
+  sd-uhs-ddr50:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      SD UHS DDR50 speed is supported.
+
+  cap-power-off-card:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Powering off the card is safe.
+
+  cap-mmc-hw-reset:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      eMMC hardware reset is supported
+
+  cap-sdio-irq:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      enable SDIO IRQ signalling on this interface
+
+  full-pwr-cycle:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Full power cycle of the card is supported.
+
+  full-pwr-cycle-in-suspend:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Full power cycle of the card in suspend is supported.
+
+  mmc-ddr-1_2v:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      eMMC high-speed DDR mode (1.2V I/O) is supported.
+
+  mmc-ddr-1_8v:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      eMMC high-speed DDR mode (1.8V I/O) is supported.
+
+  mmc-ddr-3_3v:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      eMMC high-speed DDR mode (3.3V I/O) is supported.
+
+  mmc-hs200-1_2v:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      eMMC HS200 mode (1.2V I/O) is supported.
+
+  mmc-hs200-1_8v:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      eMMC HS200 mode (1.8V I/O) is supported.
+
+  mmc-hs400-1_2v:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      eMMC HS400 mode (1.2V I/O) is supported.
+
+  mmc-hs400-1_8v:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      eMMC HS400 mode (1.8V I/O) is supported.
+
+  mmc-hs400-enhanced-strobe:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      eMMC HS400 enhanced strobe mode is supported
+
+  no-mmc-hs400:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      All eMMC HS400 modes are not supported.
+
+  dsr:
+    description:
+      Value the card Driver Stage Register (DSR) should be programmed
+      with.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 0xffff
+
+  no-sdio:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Controller is limited to send SDIO commands during
+      initialization.
+
+  no-sd:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Controller is limited to send SD commands during initialization.
+
+  no-mmc:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Controller is limited to send MMC commands during
+      initialization.
+
+  fixed-emmc-driver-type:
+    description:
+      For non-removable eMMC, enforce this driver type. The value is
+      the driver type as specified in the eMMC specification (table
+      206 in spec version 5.1)
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 4
+
+  post-power-on-delay-ms:
+    description:
+      It was invented for MMC pwrseq-simple which could be referred to
+      mmc-pwrseq-simple.yaml. But now it\'s reused as a tunable delay
+      waiting for I/O signalling and card power supply to be stable,
+      regardless of whether pwrseq-simple is used. Default to 10ms if
+      no available.
+    default: 10
+
+  supports-cqe:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The presence of this property indicates that the corresponding
+      MMC host controller supports HW command queue feature.
+
+  disable-cqe-dcmd:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The presence of this property indicates that the MMC
+      controller\'s command queue engine (CQE) does not support direct
+      commands (DCMDs).
+
+  keep-power-in-suspend:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      SDIO only. Preserves card power during a suspend/resume cycle.
+
+  wakeup-source:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      SDIO only. Enables wake up of host system on SDIO IRQ assertion.
+
+  vmmc-supply:
+    description:
+      Supply for the card power
+
+  vqmmc-supply:
+    description:
+      Supply for the bus IO line power, such as a level shifter.
+      If the level shifter is controlled by a GPIO line, this shall
+      be modeled as a "regulator-fixed" with a GPIO line for
+      switching the level shifter on/off.
+
+  mmc-pwrseq:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      System-on-Chip designs may specify a specific MMC power
+      sequence. To successfully detect an (e)MMC/SD/SDIO card, that
+      power sequence must be maintained while initializing the card.
+
+patternProperties:
+  "^.*@[0-9]+$":
+    type: object
+    description: |
+      On embedded systems the cards connected to a host may need
+      additional properties. These can be specified in subnodes to the
+      host controller node. The subnodes are identified by the
+      standard \'reg\' property. Which information exactly can be
+      specified depends on the bindings for the SDIO function driver
+      for the subnode, as specified by the compatible string.
+
+    properties:
+      compatible:
+        description: |
+          Name of SDIO function following generic names recommended
+          practice
+
+      reg:
+        items:
+          - minimum: 0
+            maximum: 7
+            description:
+              Must contain the SDIO function number of the function this
+              subnode describes. A value of 0 denotes the memory SD
+              function, values from 1 to 7 denote the SDIO functions.
+
+    required:
+      - reg
+
+  "^clk-phase-(legacy|sd-hs|mmc-(hs|hs[24]00|ddr52)|uhs-(sdr(12|25|50|104)|ddr50))$":
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
+    minItems: 2
+    maxItems: 2
+    items:
+      minimum: 0
+      maximum: 359
+      description:
+        Set the clock (phase) delays which are to be configured in the
+        controller while switching to particular speed mode. These values
+        are in pair of degrees.
+
+dependencies:
+  cd-debounce-delay-ms: [ cd-gpios ]
+  fixed-emmc-driver-type: [ non-removable ]
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
index 58ae298cd2fc..99c01ce318d3 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
@@ -18,351 +18,13 @@ description: |
   (and the corresponding mmcblkN devices) by defining an alias in the
   /aliases device tree node.
 
+$ref: mmc-controller-common.yaml#
+
 properties:
   $nodename:
     pattern: "^mmc(@.*)?$"
 
-  "#address-cells":
-    const: 1
-    description: |
-      The cell is the slot ID if a function subnode is used.
-
-  "#size-cells":
-    const: 0
-
-  # Card Detection.
-  # If none of these properties are supplied, the host native card
-  # detect will be used. Only one of them should be provided.
-
-  broken-cd:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      There is no card detection available; polling must be used.
-
-  cd-gpios:
-    maxItems: 1
-    description:
-      The card detection will be done using the GPIO provided.
-
-  non-removable:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      Non-removable slot (like eMMC); assume always present.
-
-  # *NOTE* on CD and WP polarity. To use common for all SD/MMC host
-  # controllers line polarity properties, we have to fix the meaning
-  # of the "normal" and "inverted" line levels. We choose to follow
-  # the SDHCI standard, which specifies both those lines as "active
-  # low." Therefore, using the "cd-inverted" property means, that the
-  # CD line is active high, i.e. it is high, when a card is
-  # inserted. Similar logic applies to the "wp-inverted" property.
-  #
-  # CD and WP lines can be implemented on the hardware in one of two
-  # ways: as GPIOs, specified in cd-gpios and wp-gpios properties, or
-  # as dedicated pins. Polarity of dedicated pins can be specified,
-  # using *-inverted properties. GPIO polarity can also be specified
-  # using the GPIO_ACTIVE_LOW flag. This creates an ambiguity in the
-  # latter case. We choose to use the XOR logic for GPIO CD and WP
-  # lines.  This means, the two properties are "superimposed," for
-  # example leaving the GPIO_ACTIVE_LOW flag clear and specifying the
-  # respective *-inverted property property results in a
-  # double-inversion and actually means the "normal" line polarity is
-  # in effect.
-  wp-inverted:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      The Write Protect line polarity is inverted.
-
-  cd-inverted:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      The CD line polarity is inverted.
-
-  # Other properties
-
-  bus-width:
-    description:
-      Number of data lines.
-    $ref: /schemas/types.yaml#/definitions/uint32
-    enum: [1, 4, 8]
-    default: 1
-
-  max-frequency:
-    description: |
-      Maximum operating frequency of the bus:
-        - for eMMC, the maximum supported frequency is 200MHz,
-        - for SD/SDIO cards the SDR104 mode has a max supported
-          frequency of 208MHz,
-        - some mmc host controllers do support a max frequency upto
-          384MHz.
-      So, lets keep the maximum supported value here.
-
-    $ref: /schemas/types.yaml#/definitions/uint32
-    minimum: 400000
-    maximum: 384000000
-
-  disable-wp:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      When set, no physical write-protect line is present. This
-      property should only be specified when the controller has a
-      dedicated write-protect detection logic. If a GPIO is always used
-      for the write-protect detection logic, it is sufficient to not
-      specify the wp-gpios property in the absence of a write-protect
-      line. Not used in combination with eMMC or SDIO.
-
-  wp-gpios:
-    maxItems: 1
-    description:
-      GPIO to use for the write-protect detection.
-
-  cd-debounce-delay-ms:
-    description:
-      Set delay time before detecting card after card insert
-      interrupt.
-
-  no-1-8-v:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      When specified, denotes that 1.8V card voltage is not supported
-      on this system, even if the controller claims it.
-
-  cap-sd-highspeed:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      SD high-speed timing is supported.
-
-  cap-mmc-highspeed:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      MMC high-speed timing is supported.
-
-  sd-uhs-sdr12:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      SD UHS SDR12 speed is supported.
-
-  sd-uhs-sdr25:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      SD UHS SDR25 speed is supported.
-
-  sd-uhs-sdr50:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      SD UHS SDR50 speed is supported.
-
-  sd-uhs-sdr104:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      SD UHS SDR104 speed is supported.
-
-  sd-uhs-ddr50:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      SD UHS DDR50 speed is supported.
-
-  cap-power-off-card:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      Powering off the card is safe.
-
-  cap-mmc-hw-reset:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      eMMC hardware reset is supported
-
-  cap-sdio-irq:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      enable SDIO IRQ signalling on this interface
-
-  full-pwr-cycle:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      Full power cycle of the card is supported.
-
-  full-pwr-cycle-in-suspend:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      Full power cycle of the card in suspend is supported.
-
-  mmc-ddr-1_2v:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      eMMC high-speed DDR mode (1.2V I/O) is supported.
-
-  mmc-ddr-1_8v:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      eMMC high-speed DDR mode (1.8V I/O) is supported.
-
-  mmc-ddr-3_3v:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      eMMC high-speed DDR mode (3.3V I/O) is supported.
-
-  mmc-hs200-1_2v:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      eMMC HS200 mode (1.2V I/O) is supported.
-
-  mmc-hs200-1_8v:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      eMMC HS200 mode (1.8V I/O) is supported.
-
-  mmc-hs400-1_2v:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      eMMC HS400 mode (1.2V I/O) is supported.
-
-  mmc-hs400-1_8v:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      eMMC HS400 mode (1.8V I/O) is supported.
-
-  mmc-hs400-enhanced-strobe:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      eMMC HS400 enhanced strobe mode is supported
-
-  no-mmc-hs400:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      All eMMC HS400 modes are not supported.
-
-  dsr:
-    description:
-      Value the card Driver Stage Register (DSR) should be programmed
-      with.
-    $ref: /schemas/types.yaml#/definitions/uint32
-    minimum: 0
-    maximum: 0xffff
-
-  no-sdio:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      Controller is limited to send SDIO commands during
-      initialization.
-
-  no-sd:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      Controller is limited to send SD commands during initialization.
-
-  no-mmc:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      Controller is limited to send MMC commands during
-      initialization.
-
-  fixed-emmc-driver-type:
-    description:
-      For non-removable eMMC, enforce this driver type. The value is
-      the driver type as specified in the eMMC specification (table
-      206 in spec version 5.1)
-    $ref: /schemas/types.yaml#/definitions/uint32
-    minimum: 0
-    maximum: 4
-
-  post-power-on-delay-ms:
-    description:
-      It was invented for MMC pwrseq-simple which could be referred to
-      mmc-pwrseq-simple.yaml. But now it\'s reused as a tunable delay
-      waiting for I/O signalling and card power supply to be stable,
-      regardless of whether pwrseq-simple is used. Default to 10ms if
-      no available.
-    default: 10
-
-  supports-cqe:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      The presence of this property indicates that the corresponding
-      MMC host controller supports HW command queue feature.
-
-  disable-cqe-dcmd:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      The presence of this property indicates that the MMC
-      controller\'s command queue engine (CQE) does not support direct
-      commands (DCMDs).
-
-  keep-power-in-suspend:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      SDIO only. Preserves card power during a suspend/resume cycle.
-
-  wakeup-source:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      SDIO only. Enables wake up of host system on SDIO IRQ assertion.
-
-  vmmc-supply:
-    description:
-      Supply for the card power
-
-  vqmmc-supply:
-    description:
-      Supply for the bus IO line power, such as a level shifter.
-      If the level shifter is controlled by a GPIO line, this shall
-      be modeled as a "regulator-fixed" with a GPIO line for
-      switching the level shifter on/off.
-
-  mmc-pwrseq:
-    $ref: /schemas/types.yaml#/definitions/phandle
-    description:
-      System-on-Chip designs may specify a specific MMC power
-      sequence. To successfully detect an (e)MMC/SD/SDIO card, that
-      power sequence must be maintained while initializing the card.
-
-patternProperties:
-  "^.*@[0-9]+$":
-    type: object
-    description: |
-      On embedded systems the cards connected to a host may need
-      additional properties. These can be specified in subnodes to the
-      host controller node. The subnodes are identified by the
-      standard \'reg\' property. Which information exactly can be
-      specified depends on the bindings for the SDIO function driver
-      for the subnode, as specified by the compatible string.
-
-    properties:
-      compatible:
-        description: |
-          Name of SDIO function following generic names recommended
-          practice
-
-      reg:
-        items:
-          - minimum: 0
-            maximum: 7
-            description:
-              Must contain the SDIO function number of the function this
-              subnode describes. A value of 0 denotes the memory SD
-              function, values from 1 to 7 denote the SDIO functions.
-
-    required:
-      - reg
-
-  "^clk-phase-(legacy|sd-hs|mmc-(hs|hs[24]00|ddr52)|uhs-(sdr(12|25|50|104)|ddr50))$":
-    $ref: /schemas/types.yaml#/definitions/uint32-array
-
-    minItems: 2
-    maxItems: 2
-    items:
-      minimum: 0
-      maximum: 359
-      description:
-        Set the clock (phase) delays which are to be configured in the
-        controller while switching to particular speed mode. These values
-        are in pair of degrees.
-
-dependencies:
-  cd-debounce-delay-ms: [ cd-gpios ]
-  fixed-emmc-driver-type: [ non-removable ]
-
-additionalProperties: true
+unevaluatedProperties: true
 
 examples:
   - |

-- 
2.34.1

