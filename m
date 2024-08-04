Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5094F52F74;
	Sun,  4 Aug 2024 11:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722771734; cv=none; b=lTGOS+nH9x05C2qNGBbKEtPvZ0Gdx2CAJahOAoNILtugaayVsC+Aqh8GepFOSInsowAFiFY3kBH7RNhWNm6Iv1XSWgp5QJd7mRa/8tuPVZq0PbgI7WUM6c0KXH029+nljhVdMmSmxkXvHQd+nNsbi61ODt0CfRLpZyD2E/TY13o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722771734; c=relaxed/simple;
	bh=370rhaxdNhI4ZAkdiwqODKZusyMGY79BtFAAsTZ015M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3B6dXp/P6+XrY84S+hWo1O/ccYFxXgZFwut6rEbfNszY0i4i/6tjFLTl7G/4lcftK8PNwCHMlYPe9bP3EyiyGJd+TH3z+lBjDTdoioFJhjg6XVECjX9d9IeswktNQ3B27tWbMstz0GeE6QlLwUxe9fcHdGkHV0rWFPFtg5WwRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Junpm3Fm; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Junpm3Fm"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3684e8220f9so2569120f8f.1;
        Sun, 04 Aug 2024 04:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722771731; x=1723376531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HGKaaQieag+Q14DTix3aGJa4i3xg34VJO5/0gIeYwCA=;
        b=Junpm3FmYTrybrJM2xDBAbkMjC0t+Fk0Z3DN4bsYSINuFSPusSAbUr0pZs1M0L/iOK
         E6v+Ru5ezi8u0JpvC9rp5A0Aeu2act1PJ2JixRJEx01VPITUTYIglSnd2TAiuT2ABKDU
         GN3BDDL96WTFYzbyoMKA7nB+EzH2Z3ixLKOQQ7hK24IKMN7L7eIyeIbF1I8lgQKCaHi1
         Va8U5Dd8oqY3a42cAgcfVmloxaeWxXpZ457PZeWQ8xuzS3yL5Ks8SRniFjPj8rdgsbPw
         VdIzMxpCNEKispAEjmvojD1sSIn9GO/p7Dz7qDPEvymos7gAXTYeoOEDX7LhNUVSKi3n
         izPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722771731; x=1723376531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGKaaQieag+Q14DTix3aGJa4i3xg34VJO5/0gIeYwCA=;
        b=jyfyrzvo6Q8e7f65McOUY52TNi5aNbbqVTI9RW4dehNA+1WGoNAzJKwtp00fBZktEC
         ADE1vEsH4kG7sNQjLzGKrm0cGjmMZh2sEbGI0kgYP+v+82nPrmrmIf1HXPRMhXeUTwNJ
         CGgax8+8jJKBFU1+QH5ohBjnBahnE3SZIuTH9Az16Thu8hUi8DcGK1puuzV1fBGkmLes
         T66BVgDbFDqUGeKlGXR0hKfZ2wqC88mV8ZDf1mKcR+Z9eLaGxn5yl9g1ivFFuOxv9c5k
         Czveqxl2/C9H4D4hZHQ73WB0V4c6Is4oJBLU7dUH3sPWEdkTEKCOXDi9oAHT9uY3AlnQ
         ktPw==
X-Forwarded-Encrypted: i=1; AJvYcCXld3PKZVb+hmJc38hKkc+9/0lknqsjQkguJbSlp4rE+9ikXPXY6wUIq4HRfzNTS5CCMOCit4ZePPe4aNZDCgFExH0SVtcbTygGauUvup8RYAUXrhnm4R5vLXq8lZ3wVFZA1OvOTFqKLc8QwGgTKY1nwInBJ8sLPyTebdo9R2nweUPTQw==
X-Gm-Message-State: AOJu0YwBym1+Zy9rIXzcMUWuL+XfXG0YmAGenZ5xTngs2UcUBgSdbVZ6
	aq4HpN+tpwlJtvqV7olRmaSIpQC0i+dh7pyBsQHkzpwXlyIIX3mfkqM87A==
X-Google-Smtp-Source: AGHT+IFLHuekhjS3wn/gQuthegTYTE1hpUglR72MMyu4qD76bmaYcfmhvlzvI4IbB+867YnyApqvfQ==
X-Received: by 2002:a5d:59a2:0:b0:366:ee84:6a77 with SMTP id ffacd0b85a97d-36bb358463cmr8743186f8f.3.1722771730142;
        Sun, 04 Aug 2024 04:42:10 -0700 (PDT)
Received: from localhost.localdomain ([109.52.148.115])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-36bbd01eff1sm6635130f8f.44.2024.08.04.04.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 04:42:09 -0700 (PDT)
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
	Florian Fainelli <f.fainelli@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 5/6] dt-bindings: mtd: Add Documentation for Airoha fixed-partitions
Date: Sun,  4 Aug 2024 13:41:05 +0200
Message-ID: <20240804114108.1893-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240804114108.1893-1-ansuelsmth@gmail.com>
References: <20240804114108.1893-1-ansuelsmth@gmail.com>
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
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.yaml
new file mode 100644
index 000000000000..da7879c98317
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
+    const: airoha,fixed-partition
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
-- 
2.45.2

