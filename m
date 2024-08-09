Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2C516EBFE;
	Fri,  9 Aug 2024 23:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723244560; cv=none; b=OircUqjrqd5COYGlRuXhUSB+duknX+prE1UOQ+XmHX8r2POETUJ8hlNrwu7piW3Bp1gIuu/jrPddauAvY7d/niT1By/fiS2IK9WIUmBSntHCO5QMnyh1HWw6pw+W6AfjNfpntTtx7wkgf/ujj+L5bXHskWbeqFbuJP58jBucGGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723244560; c=relaxed/simple;
	bh=6IE7tvskZW59pVR1UJxmlFcac0npVXGRA3ZaUx+Dgm0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DKn3O04EERmDbUcHXgtvinc2Xj6r3kEFo/XeMsrj0YhRUGsnCU0cBSAtZNeEOwKhCmTrXv+oSoMrAclDzYprDr23qFcZW6UEyqFnWYo0dj0q+2wwqdkwXRfypFxq20FsxgfR06fWC3vGpNkI4C/cvanBlqd9OZgkhgCQpUSRKc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDJR4Sdx; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDJR4Sdx"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4280c55e488so14898175e9.0;
        Fri, 09 Aug 2024 16:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723244557; x=1723849357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5xBEuESArl0fBfjXYsEhDBEbTfGt9gI5ouD6sU73/GU=;
        b=IDJR4SdxSxLqNgeXEePRJyA4IdbZdAU7QfxsdH4xoPlhRp8+N0b0ZszmtFuf326YT5
         fQyOoivU6WGta8sejgC63LLTotamldOH2fvx+/7jmzYmO5DHAuIQQbflzNYLgV7vvHUL
         SMRN+KhZuI8NKcCtn54u+QlqYxKGnk4lZ6cnyv7gkOvQhHdiEe0a+e3pC02hj9pIGCUb
         zDhD5a4ubze/IpchfBOONns7AbO7aI1H+AjKdKirUneoGw2u2uVTBVXnnULCCOvj4ZVL
         8gT4q1r/ShKsDHTT3ncNKXm3+QBsTjuPcXT2JRXP0jITXicXkOZSBHSDWh2i7mr9EIA/
         tQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723244557; x=1723849357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xBEuESArl0fBfjXYsEhDBEbTfGt9gI5ouD6sU73/GU=;
        b=FTQxIEFyIY3/o20yp4MJojlteAnQtFPtpFL3hMEz4z4yJMoPSu933TbAC9x2X4vOzK
         1mARGiZ87TWGmqPe+bK4x7DMKncuF16de9PIMUhZKADRtlEzHJC2fD/HdSUPR4yQPbYT
         j2YweJ0Zq5KnZkCP1BpfUigMVSvDGW0ubdkvyvyCYIIN0jlpzfAzXdRAaC6YHmUyiQd7
         UPDfqxYJvFrFdhTIygbp/59bcMLpH4Wm8pCWdhtFCpS4RXrDfhHQsj8+th30ipRhXvqv
         5fHFKr/s9Uxyza+oQPnlMRWOsmb15oIu5ZYzPygC3A+egVuYO9WO2RCyL6Pa10eieuZN
         mC2A==
X-Forwarded-Encrypted: i=1; AJvYcCUZiSmUfnwLUbrRKO5raSFBDAiv/wTcDOJP+utfxov4DGKCTg5quENtdegXlZ7HCx2xUc55uOMfqfCKK7orwwzO2qZef6u2Cdnv8PONzXHuA57JR/mittiUoLPbxy8hGXlr/wD+nAgAyHCoz/64TPnnzZ+bO+PP4M4mSNACbJth331WwQ==
X-Gm-Message-State: AOJu0Yy9Wglqm68eEzTam31h1ABCVH0z7vE7tb3KTIZA5BdrK6PgjxcH
	nVsXof0xBZSaHs/2FHyUIgWbSwMtO1Rddha2LjHXWsvVnQWg7ly5
X-Google-Smtp-Source: AGHT+IFaIZzfJMZGEZqQdwrs5TglTqfV4r7biRyhTVd339hoMEUvKuDwHH0rtXy2N3qYTRaD/OaGZA==
X-Received: by 2002:a05:600c:1394:b0:428:9c0:2ad with SMTP id 5b1f17b1804b1-4290b8deddbmr49137295e9.18.1723244557103;
        Fri, 09 Aug 2024 16:02:37 -0700 (PDT)
Received: from localhost.localdomain (host-87-10-253-138.retail.telecomitalia.it. [87.10.253.138])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-429c75044a8sm7987485e9.9.2024.08.09.16.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 16:02:36 -0700 (PDT)
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
	Saravana Kannan <saravanak@google.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH v4 6/7] dt-bindings: mtd: Add Documentation for Airoha fixed-partitions
Date: Fri,  9 Aug 2024 19:21:04 +0200
Message-ID: <20240809172106.25892-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240809172106.25892-1-ansuelsmth@gmail.com>
References: <20240809172106.25892-1-ansuelsmth@gmail.com>
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

