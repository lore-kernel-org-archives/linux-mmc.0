Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4CE13C684;
	Sun,  4 Aug 2024 17:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722793483; cv=none; b=UXzMpBy0mtSRk9k3o6mjLBDGPmt5S3HHqZ751Tn5XR87Iv0fDuxv3QInun0LJ5Sxh+8cjgeJyh98UBGPXB5/oO4Igw6bN4Tu8z0ZU9NkJJphj/zMd2xbRzosEbPW8Hs6AB6cv1Ke/1gxxN0ND4+x+zQtiJXscXna6c9W1hcyh1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722793483; c=relaxed/simple;
	bh=oX/ZKMzDsgeqI5cjVzfnGmIF6ySpnog9LxLFYO3bQKE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYhod9c9RjVt4o0ho5ykA+ezkqsd4hxoh2eecgf/2AEqLLf2u95VjpHrDlKdDp3s9DfWKynbcEzPj3wAS+JdeLP2JMYNTScTGBYnrbLjQPLeS0xMyNrtob/H7eDmZhjmV6uf/x2181LagPMGKmaQ8PeFoo21HMfvBP7IZXJqkC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TalXd8I4; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TalXd8I4"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f025b94e07so123614351fa.0;
        Sun, 04 Aug 2024 10:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722793480; x=1723398280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fvAc4YhKm/u3S+4O+Aw+vXQgk5wKoMLQshnx93IPvPo=;
        b=TalXd8I4fK4eWg9LprzcT2+zwz7GlJ/v0k5zMZQDB9zT9xcU/kS7h3wyZbXQckUdIM
         8Ns6YebrOiunGPFFMtRHqccQVDDhbVyfiqx1mUXquutwaGkPMUn/DkVL20XjQWDD4Y20
         n8vQg1sN3ufaYkK2MhUseBWmJV48e1hba+VrKrbuyhEQoa/uTmCpt1yKOfkUS9wusblB
         LXBGVpDuQm3K/h/OMMRU9A/KWGWehShom7SGiWk7jEM1aWs51V2Fcxv+zbSeXhGTj8/p
         uRBS0WavuX+0sifFhryCJprs8EyscGsWN3FZ1kF43T1z/giC9nvRmLhZVcAqooNWe728
         Wn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722793480; x=1723398280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvAc4YhKm/u3S+4O+Aw+vXQgk5wKoMLQshnx93IPvPo=;
        b=Q33EQYqOOtEwKfMjzh7ifED8AehH2G0LpAjnMZS3YI66MZ0nMdk1I1Rh538lq2o23v
         7S+dmwhT3O4bi3qlIIPIzRrM2IccDZj1ihDD5Rcf4N/enS+OJbFu2mNzEt2/t3LnsfpM
         vAO7A8RMMl4fLE+zVXsqBW4ls9GLqfjysp6erE6aD6R68LznDlkOIvrAPB0vKtJPqeS/
         iA2TNZ/b+gCH1A7Z/rTOOX8qJYv7Rh2QBiFFDGlaV2qYYeEiuSnVtc5mNU/KGRwRgacH
         zn5/zdfIP2AEDuSt4aa0o3NMahtmFdEDWFYgyYALMAN+JmBnd0Jzo/43XJYBWXacoEgy
         ugPg==
X-Forwarded-Encrypted: i=1; AJvYcCWD45zabf+dITj3EAYN4MwF4oO0UgL01kDCcTrbqQDnFqIz7iKyYCGoWg/Py5Id67k/8f/hXFlZ6IcxnMNK3m2jzoL5pDhXT/UsOHuhJUyoG8kUx4GGUKda0Ph+1GH5QM5tZ2tXTLD1VW2AAWu/VUb+gA1iFGovbE9M3tgQ+zId6S5vPQ==
X-Gm-Message-State: AOJu0YxIDOrfPu9W5Og6rRmBOZ3/negzzA0N0EFUPh4NglDBC4q1p0eF
	vTka5VDaP8lk122VtoPk3vLTnh2zwMzvlWOK0tQkwnQJaHtqH3kt
X-Google-Smtp-Source: AGHT+IFU8AJjmTAyV92JRJYtOdqk61Rt6Gt62ZAN8oIR6M3nrfeJsTuXcuqLW4SL5nh2FbVIg6bieg==
X-Received: by 2002:a2e:9794:0:b0:2ef:284e:1d07 with SMTP id 38308e7fff4ca-2f15aa97d16mr69060581fa.13.1722793479648;
        Sun, 04 Aug 2024 10:44:39 -0700 (PDT)
Received: from localhost.localdomain (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-428e6e0357asm109530485e9.12.2024.08.04.10.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 10:44:39 -0700 (PDT)
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
Subject: [PATCH v2 5/6] dt-bindings: mtd: Add Documentation for Airoha fixed-partitions
Date: Sun,  4 Aug 2024 19:44:09 +0200
Message-ID: <20240804174414.18171-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240804174414.18171-1-ansuelsmth@gmail.com>
References: <20240804174414.18171-1-ansuelsmth@gmail.com>
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
-- 
2.45.2

