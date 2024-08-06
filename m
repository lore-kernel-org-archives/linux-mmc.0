Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC1A1C579C;
	Tue,  6 Aug 2024 11:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722944499; cv=none; b=B8N+Z44rfm1WMnMofk1dO1sElgrX0NBdHhZ/1ntoPsyWl/AEAHkSX0aXkRw05IPALQnT2aGLgSxCdpZn1RYAAk7MCfHGWvySFwn/R7R0HClai9PUpDeZlDMH4+KO+TTIHdvW0jDmrQJ5IkP0yWsB81O0I8P2vrBOEFeuokdi4Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722944499; c=relaxed/simple;
	bh=6IE7tvskZW59pVR1UJxmlFcac0npVXGRA3ZaUx+Dgm0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+GAHdhR/gC6mOVdg4ua4ZHNmODy8oFsx46HCJ+oGs/gAkXYZsL1/JebWdlWouKNbGrmAqfo8PlfG/K2grnnCOkWej0GGx00CW3BjW21pgGqFmrpVUhcj5NAlr0ARgAR/io/dpJGzFZS0XXXmr1k/9VpTe+ZHJxgyRePZrmmQJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxDiEFBi; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxDiEFBi"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2eeb1ba040aso8326581fa.1;
        Tue, 06 Aug 2024 04:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722944496; x=1723549296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5xBEuESArl0fBfjXYsEhDBEbTfGt9gI5ouD6sU73/GU=;
        b=ZxDiEFBiYr60G1lZIoU9mV5HkZjaYv9DCC4niatclRHkTZzm8WIlp2frltmSzsS5ZO
         OvTZRgoWd/J3O43XFNr0873WGvf04ctPSRkn60aNNPhOKckpNdi+XdOip0m/aw28fFLv
         1HgrvDAQ6U5LHaKYMGVDCJDPmC5TRb05b3pyKcAYrc5y8LSNHoQGodQDv4Z2EKdHWCGT
         JmspYIE3BiBBQPE4j/r02JHWHCGzfGdbFTXP5RYLZ/CQpZuk7H2EmJp+kCRFDpaXbYv4
         S2Rqp+sMzAXvBiOdJFbRuFyuYwD/XFvaIhedqTYzB+HLNv1HMcvl5A7jyKDZ6sNPcHd0
         Ommg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722944496; x=1723549296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xBEuESArl0fBfjXYsEhDBEbTfGt9gI5ouD6sU73/GU=;
        b=h3HHF/IMh7jr/fwINjwqMftVlvZneaUH5q6Jc5HbkWINvPIYL+y/coJuBQZpx16An+
         /wh7+cmy4h1/qRdFUhj4tzV49BgSLUwjZzWA3i+LqKrDlEF84Vy0T0rHtRpiNu3RXisp
         7K7PPK0YR8kBAtE3Uwp2yFOc3FVwuBoj5FqyNUJQKS9p79DVUc+xazwiNHL+dujVbs9b
         oMvHLeEvWgcyRkqm1vDsz62CA8GBsZNVqnZ/cDivaWd5/WAGH3DsLk3uEHbFjbdpNH7m
         lu88YfxfgnavgC5JaGXMT1PuJy1yFHhqQZntqulFihPZVzQ9vqXsALx1EXo6JIvV6yvk
         mHHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNJc77c97WaVq1dS/FaQUO8YO9ipx2VX/u0rN7gVScgVy9DwI6XsYT2174YWkjOULF102xtxCfIF0PAHPw3mDqP0r0b1DqRBQMMpgyUyrmL6hj6zCnDhfEGp94HE0RFodiOPY6vr1PZH3VbHnYluxUxg1/O3+gfv5u39x1PzQrYvAQcg==
X-Gm-Message-State: AOJu0Yxc+ZzhB6a6iKIXXhvZBK+rjMgvSJWjnRzv2xvzhfSMPQu5I8pe
	YxZhwH91hQN9ZBaC3BN70GjDWrjo7fRMLCc2BwE3xsCEbpgpq4xG
X-Google-Smtp-Source: AGHT+IGEw7FbfFGV4bGUwud7W+/31hW0KginGDZdKiOUFG09QuHWu6Nsg6YcjdixER72oYD5wUIGqQ==
X-Received: by 2002:a2e:999a:0:b0:2ef:2f19:a8b3 with SMTP id 38308e7fff4ca-2f15ab049f2mr102072831fa.41.1722944495774;
        Tue, 06 Aug 2024 04:41:35 -0700 (PDT)
Received: from localhost.localdomain (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-428e6e7cce6sm176105845e9.31.2024.08.06.04.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 04:41:35 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Joern Engel <joern@lazybastard.org>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH v3 5/6] dt-bindings: mtd: Add Documentation for Airoha fixed-partitions
Date: Tue,  6 Aug 2024 13:41:15 +0200
Message-ID: <20240806114118.17198-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806114118.17198-1-ansuelsmth@gmail.com>
References: <20240806114118.17198-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Documentation for Airoha fixed-partitions compatibles.

Airoha based SoC declare a dedicated partition at the end of the flash to
store calibration and device specific data, in addition to fixed
partitions.
The offset of this special partition is not well defined as it depends on
flash bad block management that might require reserving additional space
at the end of the flash.

This binding allows defining all fixed partitions and marking the last one
to detect the correct offset.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../partitions/airoha,fixed-partitions.yaml   | 80 +++++++++++++++++++
 .../bindings/mtd/partitions/partitions.yaml   |  1 +
 2 files changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.yaml
new file mode 100644
index 000000000000..8d7221561f51
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/airoha,fixed-partitions.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha SoC partitioning
+
+description: |
+  Airoha based SoC declare a dedicated partition at the end of the flash to
+  store calibration and device specific data, in addition to fixed partitions.
+  The offset of this special partition is not well defined as it depends on
+  flash bad block management that might require reserving additional space at the
+  end of the flash.
+
+  This binding allows defining all fixed partitions and marking the last one to
+  detect the correct offset.
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+select: false
+
+properties:
+  compatible:
+    const: airoha,fixed-partitions
+
+  "#address-cells":
+    enum: [ 1, 2 ]
+
+  "#size-cells":
+    enum: [ 1, 2 ]
+
+patternProperties:
+  "^partition@[0-9a-f]+$":
+    $ref: partition.yaml#
+    properties:
+      compatible:
+        const: airoha,dynamic-art
+    unevaluatedProperties: false
+
+required:
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    partitions {
+        compatible = "airoha,fixed-partitions";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition@0 {
+          label = "bootloader";
+          reg = <0x00000000 0x00080000>;
+        };
+
+        partition@80000 {
+          label = "tclinux";
+          reg = <0x00080000 0x02800000>;
+        };
+
+        partition@2880000 {
+          label = "tclinux_slave";
+          reg = <0x02880000 0x02800000>;
+        };
+
+        partition@5080000 {
+          label = "rootfs_data";
+          reg = <0x5080000 0x00800000>;
+        };
+
+        partition@ffffffff {
+          compatible = "airoha,dynamic-art";
+          label = "art";
+          reg = <0xffffffff 0x00300000>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
index 1dda2c80747b..ec254e03adf0 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
@@ -14,6 +14,7 @@ maintainers:
   - Miquel Raynal <miquel.raynal@bootlin.com>
 
 oneOf:
+  - $ref: airoha,fixed-partitions.yaml
   - $ref: arm,arm-firmware-suite.yaml
   - $ref: brcm,bcm4908-partitions.yaml
   - $ref: brcm,bcm947xx-cfe-partitions.yaml
-- 
2.45.2

