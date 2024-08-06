Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100ED1C379B;
	Tue,  6 Aug 2024 11:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722944491; cv=none; b=qWM0NQO+UVj03WZSIwfWJYyZva32876u51+Odmf/vnvh9FWpQXElmnriU+okkKTIkwlUBN078ndWc6bOlW7Bwa/AQo4KL38Rvusb5VydaGnSZD4LazfwD+6FwgShrKnPw6oBbZEsr7D/dUCo7DkFisSywcyHciHIa2ArJjHuAkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722944491; c=relaxed/simple;
	bh=5LbPMzmNGfuxlauoWeKMsm0e6brfLsdQfHcfl/8nZRs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PcnY/LcRZHlIXbkwDmOj8s0Jd04thTFnx4TQCU5a+QK9AxT/7bShSre4n4/dXy1LA0KlWr1LoDFJGspUqtdGkjCJynemKwPs6a/C4ygVIZ5XcrG8E/s8LlJhNn8F1bd0lnZMDF1vdM4h2C8zZxoQiEQVeri+bQJM0ZWtrBGDsoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfYlrGrv; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfYlrGrv"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-428ec6c190eso4174025e9.1;
        Tue, 06 Aug 2024 04:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722944488; x=1723549288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N4Tqx/xl+do4nmfv0ZFIXdX55krJHtI/dy8e3uyNR1Y=;
        b=SfYlrGrv9pOqbDSGHmgF4N5PrTk48HWGv2flq8QJdvaGbbX7YBTro1ZCkiVgBSCw9E
         +8y/CaA+JXDfNOLE0oC0oNHLszUjRp+qyuUWzTFPj+6Y8NB2lj6Wpj85uAgidYWNhYAl
         qJQR7/wRWQypwA1x8eWetAEotB6MAwxoDcnP5JWQGeCLTr6WOd4xhWFFBgzxM73URpdE
         y72lbp5XAFSt+VwOTm+vmrw8v6p1ynDZv3D5Zl5DaV3EEvNTzqseZo9Cmr/Q7rpRz7Qd
         dvcDjx7QcwBmDRuMvqQYbkEHdz74hSgq72t0uauo6MvbKq6Gsta2inPWqstJXGO5imNT
         heIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722944488; x=1723549288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4Tqx/xl+do4nmfv0ZFIXdX55krJHtI/dy8e3uyNR1Y=;
        b=eEk8RvPyd39thDwTnz8bkCDWixE3aBlLX0ZiQfFk40U8XbPzOX9yMIThW36kN2a2qt
         cjJk9R7IyVReylhDe2BsAOIe3627KeUcBdEJIShHAoh7Bbsvd6fK4pTQphKLjNmTQKZW
         jXXz/mkA+I5pDkRqMl3X50eVdOR1JVz5KSLkLbB7o4T8scgC8MQXEHX/82XP8pwk9Dkh
         1UdBRb+9Altd/voe5F87cngvvsmLsIG0uEb+8CysjQZddKdF/QyPlh+ebjMAG+4g4KgR
         I0shgBsBlGsUx8fonO4/prLnJwP544AuUwGf01/FcvglC9GccFnBHdQokfre4U0Xl9Pf
         CWrA==
X-Forwarded-Encrypted: i=1; AJvYcCVfc4qKFFTTsgsf2iVDB0aGVnFxH1pe6q2Hg47pSSglRGWiF2RdWLDzglRiRVE4j63pKFyIr15EAi8mQ48iOAV1/dLWQhEVAL/PcaZWfYGPocVP6eKB26AO+6A2DAa434tgRCLsJpEhkANUXTIvLUV63LMI/P/VOnnc/98l/ZH8HxSB8A==
X-Gm-Message-State: AOJu0YxuPHLwJhrgSbvc5w7XFIN2nPeU0+FLzBvi3NrO0Woqn7Z36Ebr
	RrArElpGkkZJFibXf5aiV+7WzLi1Pxwao+3Gwrp+kib3s61PEY1w
X-Google-Smtp-Source: AGHT+IG9k8L6rRkA1Va2sD8UO032mLhZSWZwsxwXlldLySXDGaw0sRlChwet0LU+bpg2jQOFstrw/Q==
X-Received: by 2002:a05:600c:4f0c:b0:426:6099:6eaa with SMTP id 5b1f17b1804b1-428e6b7c61emr101771725e9.26.1722944488151;
        Tue, 06 Aug 2024 04:41:28 -0700 (PDT)
Received: from localhost.localdomain (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-428e6e7cce6sm176105845e9.31.2024.08.06.04.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 04:41:27 -0700 (PDT)
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
Subject: [PATCH v3 1/6] dt-bindings: nvme: Document nvme-card compatible
Date: Tue,  6 Aug 2024 13:41:11 +0200
Message-ID: <20240806114118.17198-2-ansuelsmth@gmail.com>
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

