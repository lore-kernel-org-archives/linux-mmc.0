Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92F7383A1;
	Sun,  4 Aug 2024 11:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722771718; cv=none; b=iBFli59nXXR2uA7uCdECQ4Bq3xwBpMYgqHZNjor5DfNLIk8UQpb8zJoQaZiD7KvrX6lLWmjIcubp4gRsNzW+XkGugZH+pIZPETPAI70iYbpyrV6qZhVfSQBDJlyo0Zm2XE+n4KxDfs5YHXVG0uklPGHW/ikeLBGEROtV4sd1fsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722771718; c=relaxed/simple;
	bh=5LbPMzmNGfuxlauoWeKMsm0e6brfLsdQfHcfl/8nZRs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Un4WD6P50kjnqQPYXuuZNY7n1ZSn+oM9/kd2fp2fTBPY5JAAt72RFiLGRqJ7VBm3DkjhCEbsZn95W7baT9qBPakoQyUO3GIobc3zkuwb+PpppZdjcZUDwyowPoqh4QauDV7YYrkFPoYpwY8lTp0O9oLoVRI2L2rN9PUeULyR0+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdvvTKi0; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdvvTKi0"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42817f1eb1fso59065145e9.1;
        Sun, 04 Aug 2024 04:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722771715; x=1723376515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N4Tqx/xl+do4nmfv0ZFIXdX55krJHtI/dy8e3uyNR1Y=;
        b=AdvvTKi0Cg0RjDvGD98r6PLbeKn7Srz7tI1YVQ+SC5nWU+Li6iqvqMDla4g7Ac8FkU
         /yk/4b1yIYhRpI/2DhZWRO2fTABRcgpnuvFe8YPPa5lX9hH5Ouh+RHBDrCccEVw5mUSD
         s+8/Ia25858Vu0z2HYlEwxdmyW3DEY3GGEWUS8LaunnOM3eJ9JMirQ6N46QFCvf8LVWV
         m6ZmYdrfmY8Mo17BvGeN+xNg7lKTDMV3XS38jIphnvUolFYVIscw2wipZnxFQR2IsrJp
         JF2WtFJ0WwZcEUqIobZ6Q3Jz3OMemkKyZhOYBIYYmVATuzKA7S+llKBb5/YHdz9pJ9b0
         KcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722771715; x=1723376515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4Tqx/xl+do4nmfv0ZFIXdX55krJHtI/dy8e3uyNR1Y=;
        b=VoBIBTYeFMEoMtEOkVaJ3dXDAPY/cVDFCWKZF4FBBDFCs0yzm1VZbP0Facughix1eu
         pjJaIzCzJEVhZiGZvY+wKVhtSpRJRn5soSZUP/4WGC8WGSVUcCDr7cL61IKfOcxos+8k
         Rp6/SidIQ/xWwZljQdu3rSr1ZGiqCCLsh/pfkUkAxJyMQZrQWnApZSXLIvqpyRzAEzx3
         VrYqwFyf7XrUz5ksjHmN/wT8RRLD38k6U9xgz5U8LuBoiIRpWnEZDt/d0GEawiez4ZBZ
         +cm5kwZ1OZrMJh5kVUVwkRk9b1HDRsfslLtA0TQqMlpbDPTBOCV1vN2n8zNQZCm+yLRM
         BsGg==
X-Forwarded-Encrypted: i=1; AJvYcCUnAfP1ZCiMKQuZmrvufmHtwvKAfB+ZE5qhWFtqLSZDJwECksHBnAb6ZHsaHTiT5Dtvf3rKhxud+Fm4Hjwg9lf6CPUsO6BgXILPn3rYBbju3Al2uy6U3X9rzjVMrFpMazLOpXHWVJItcFn7x7tXVFynOMOSZWAw29UMFbqQymzrNcCL2Q==
X-Gm-Message-State: AOJu0YzhdMGUwT/SdOe+XpSXIVZfkW/a6+c8qQTaFlgVooEjWrJQMsfC
	MbxmdF+RpHzS16hLQzypQ1XKnFV1I6jtWKvJxBJ7z0vpZ4uKwdvj
X-Google-Smtp-Source: AGHT+IEh/fFRi3lvw24ntWxbY6FWDsuqyuWXPDM5pSemyCgBJ+obg3zad+nrGbuYwnLYxI5iYfKvgQ==
X-Received: by 2002:a05:600c:3b19:b0:426:61e8:fb35 with SMTP id 5b1f17b1804b1-428e6af2e9amr57295055e9.4.1722771714552;
        Sun, 04 Aug 2024 04:41:54 -0700 (PDT)
Received: from localhost.localdomain ([109.52.148.115])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-36bbd01eff1sm6635130f8f.44.2024.08.04.04.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 04:41:54 -0700 (PDT)
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
Subject: [PATCH 1/6] dt-bindings: nvme: Document nvme-card compatible
Date: Sun,  4 Aug 2024 13:41:01 +0200
Message-ID: <20240804114108.1893-2-ansuelsmth@gmail.com>
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

Document new nvme-card compatible to permit defining fixed-partition in
DT by the use of the block2mtd module to use block devices as MTD.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../devicetree/bindings/nvme/nvme-card.yaml   | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvme/nvme-card.yaml

diff --git a/Documentation/devicetree/bindings/nvme/nvme-card.yaml b/Documentation/devicetree/bindings/nvme/nvme-card.yaml
new file mode 100644
index 000000000000..20e9a877fac4
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvme/nvme-card.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvme/nvme-card.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVME Card
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description: |
+  This documents describes the devicetree bindings for a NVME controller
+  child node describing a nvme-card.
+
+properties:
+  compatible:
+    const: nvme-card
+
+  partitions:
+    $ref: /schemas/mtd/partitions/partitions.yaml
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    pcie {
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        bridge@0,0 {
+            reg = <0x00000000 0 0 0 0>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            ranges;
+
+            nvme@1,0 {
+                compatible = "pci144d,a809";
+
+                reg = <0x00010000 0 0 0 0>;
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                card {
+                    compatible = "nvme-card";
+
+                    partitions {
+                        compatible = "fixed-partitions";
+                        #address-cells = <1>;
+                        #size-cells = <1>;
+
+                        bootloader@0 {
+                          label = "bootloader";
+                          reg = <0x00000000 0x00080000>;
+                        };
+
+                        tclinux@80000 {
+                          label = "tclinux";
+                          reg = <0x00080000 0x02800000>;
+                        };
+
+                        tclinux_slave@2880000 {
+                          label = "tclinux_slave";
+                          reg = <0x02880000 0x02800000>;
+                        };
+
+                        rootfs_data@5080000 {
+                          label = "rootfs_data";
+                          reg = <0x5080000 0x00800000>;
+                        };
+                    };
+                };
+            };
+        };
+    };
-- 
2.45.2

