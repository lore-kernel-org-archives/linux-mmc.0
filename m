Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEF5137C35;
	Sun,  4 Aug 2024 17:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722793473; cv=none; b=gq+ojF0V1vnB4BQDwZZG6fgV5tMLw/EWZj7O/afaJYABwzyo+i81onnJ/EIRyFO3zbii/ObT9mnCOscx0sjDb+/h15oYLEHaS0hFKP5e2YEyLiZXg4gA/1tQBKrJ9ETJtb5bDXwhMAECzly/9gppIB5hoCFNVYj3OMF9oj8Tw2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722793473; c=relaxed/simple;
	bh=5LbPMzmNGfuxlauoWeKMsm0e6brfLsdQfHcfl/8nZRs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p2a1NmKz2az9HB8HK/ejg4gOdHQRn+l9+hzrgoy08OgfBADspvBwVeqH0rlhcD5edne6d0noP9pXpzOhkX06uEszhwm/xtBd8lBg3mNYdwC/MS4wVRm6ivINtbsQVeCMOvVXxDxnxQy0IzWI5i+LNiLx8Aod99tCKIeMlBPMooU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KF/hmTht; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KF/hmTht"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3684e8220f9so2684608f8f.1;
        Sun, 04 Aug 2024 10:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722793470; x=1723398270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N4Tqx/xl+do4nmfv0ZFIXdX55krJHtI/dy8e3uyNR1Y=;
        b=KF/hmThtjO+KptQRH5cSSRgkGofUJFRU4KrYK08XRHYkgeSEhu83nxhbB5jGvBmaqQ
         rqikIXgxSJBW1lBmHPd7+juDLPBndDzU6ajUHIfc1DWShug8VDbq5hAS8uwWFhFL3Ryj
         tG0kfm/0otl0DMo8MH8yhc8R9ZSKNU2idAg4yTjhNZx7zD0h8IQMNVbBE/EXNlmCk9bx
         cQR4yzBX1c7WRtIY/60VRe5+U55NvvHG1b/QyrohlKDASZgjThyLxq1Z7tZWmG6lKkm4
         gFy5Q/SWMAjx4YZ9rdtDiVu97R7ej1iupZIOkYdknFwyrfcoZPYdspkKzaNpHEX1KRgP
         KHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722793470; x=1723398270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4Tqx/xl+do4nmfv0ZFIXdX55krJHtI/dy8e3uyNR1Y=;
        b=v1QgsDTx0sj6by2kAxlcz6HhxNv0sYAw2Ewz4ZNLE4dx8Mc9ZNyxBTojXSTmWnTyOo
         o3+ygutuCVLcADaWMPQHZqHIMIv5iY4s45ZfIgzPH5zqXud2ehwwl4JvTCIPcHW2reir
         Gjhrm+yESxfLWCaBSifEVCf3Qi/rz0ooPuHPqLGNABQ8xTIT/HDNPTHK1icK1U5FP+wa
         agiUn5OGSi2WZ0b7UA2OeZANWiWiZDaVEr/24Dg3MOioapJYRq2haDe2LjLf/j4MHdxr
         agZxYHzN1WFm5WkR/5XXqvXIOpc5ZgbYemkLN/mBUDCiCllWyyE4ALtrCHxdKIrtCYNL
         VSaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhO5UR3gNHyXXzQPjWpDkcLYtsITY3qNI2bBRnps1H9Bk47+6uwRIt+NMnYK9WH9ji2bOfu/YE1591QTDasHwoNBevUttfuZ7fCpEnaxF1VoJ+xEWSNHriIRNp+nMCrGj937jIexChE5v9HlxO1gBdVS4fACVCZJtRKVLZXBcLiFd7qQ==
X-Gm-Message-State: AOJu0YzfoYaHp9C917Bj8Kp87+liyfdlROoQtBWlrH9JVdkNpMvXcN/p
	tMXB5EJSLau30myJVuzMh/R1TpoY3VnhusS/l/OjNiAMD0btdsda
X-Google-Smtp-Source: AGHT+IEmGipmy6C03p1fUHWreExFigGkvjGoxjZh2tkYrSz+71MUHqO1UlAfqWKZFbKWjp32T3vinQ==
X-Received: by 2002:a05:6000:b50:b0:367:938f:550 with SMTP id ffacd0b85a97d-36bb35de344mr8566122f8f.25.1722793470174;
        Sun, 04 Aug 2024 10:44:30 -0700 (PDT)
Received: from localhost.localdomain (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-428e6e0357asm109530485e9.12.2024.08.04.10.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 10:44:29 -0700 (PDT)
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
Subject: [PATCH v2 1/6] dt-bindings: nvme: Document nvme-card compatible
Date: Sun,  4 Aug 2024 19:44:05 +0200
Message-ID: <20240804174414.18171-2-ansuelsmth@gmail.com>
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

