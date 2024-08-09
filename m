Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74671166317;
	Fri,  9 Aug 2024 23:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723244551; cv=none; b=oftSEtSUX3RIPLg3jB2DAbB3u3R3d4dR7jDItYvCCqSwBmY9W6F9cVf7SjBrT+pZ+iviPjj2RlwuYY3BjspZO0wYdP9dyxkWDh7NfiTQHP4XjUWSbz4JuM95IZ2ScFYDYRNiAm7TboQaqAolhsY7nBQC65wkLIF9TWRXKBB5l8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723244551; c=relaxed/simple;
	bh=5LbPMzmNGfuxlauoWeKMsm0e6brfLsdQfHcfl/8nZRs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bwuiA7uQ3S5XV6qInIKkLfIGJsB0egaec/jQ9HNtHfANhJzGRzhRpR3vgNhrkOhDXfK46H6awyP5NUxkUxalLRq9wBbTcTsN7/u/s5URChHGIdIXvXE5qvICGanD6XjMIBYkwd/X74yX9Obyiq06JVtHt/n+j3SMD4MQVg8JvKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZyMRSXX; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZyMRSXX"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42816ca782dso18655395e9.2;
        Fri, 09 Aug 2024 16:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723244548; x=1723849348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N4Tqx/xl+do4nmfv0ZFIXdX55krJHtI/dy8e3uyNR1Y=;
        b=dZyMRSXXS0gAN1Gc9zS1OVZLLylUhcmbgFbWJIJNoGkQ6HxQoDt4NShJJ05NMRTrFS
         4xec7pLPwT6EvgPt54x6emNKaFqliJ7Y3ibEUAwo9EiosaAqcF9/E7/fIEpTeoODFmuS
         HebstWTfR2gDlTFKN98hmzILlx+flxfaRp1Jpwv/mYF3YusDbQNrzLdwwdjEyzwGzIHj
         qzr3juMl1hbnfYHLOaGHSsJ5oO8YosnH2A59kpihJb5yOWX5MImqF8YCBDKcatWN7RFo
         eRdMWwiux8OuaLgRvqAHiqBG7rDF5qUehYO6UfRURQAkjNM3kvRcWQwKPanC/uwn8OMB
         1x+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723244548; x=1723849348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4Tqx/xl+do4nmfv0ZFIXdX55krJHtI/dy8e3uyNR1Y=;
        b=bAuqQM6xEEZU1elV9UELCKHKKuu1k+PFS0yC3+EeE9QyN3NVM4BhHJw+LNMzqV/3TH
         qMrJG0nYCObDyM4opjWzMwmlH5ygZHpqZrE3xMj/oKRwdcE9LdwyyrYdelCRzOavzX5x
         4YtF3opV44aDW77Ex0jqTAZ3JvPoHZiBBHJO/+sFNM9QwoVLVa2+ZYzoaIDZpxiqcx2v
         SyLSf+PKtZ+sdyV8ewVPRggttqmSCAgQ0h9O1ld0o/KJBpN+9TbQstXuwNqjVqM64vwr
         MoElDueUbqEo71CpefG74lnxfqvgJLr8MYSk+u02lhglTTTD+BmRIBK85NNf6RuzGVA0
         W2uw==
X-Forwarded-Encrypted: i=1; AJvYcCWyseFm1s6FbMx4N0SbHlqQM03cW6rvA+xgtHLPpAUFiRsuOAYTQIaqno7A+0Tk3lFxeL0vzg7xGAyzjnZTRs/hOwNmFQkQg/3E4MITi6QT5C5ejZXjJrmH0hetD/68XbWPOxNdZn35/Vl6rOvw7xoj/EBugITKpA1Khx74w+6AV0wU9w==
X-Gm-Message-State: AOJu0Yx/cbKEtFppcQt1kj0wYkOA7VxdFQXgXz/o1kcU1b/c+s7X0pd9
	c7ZxIH2XCjchmEGXlq++yQnljt0ojGz7MT0qGPPQP/JGBOarTJjk
X-Google-Smtp-Source: AGHT+IHFgbKyEx10eub1CxAs8MOPrz33JkUp9CHrjEA+O5aqKs/q4nCgeahl2FdAWSLxkS0xZ29OAQ==
X-Received: by 2002:a05:600c:568f:b0:428:2e9:65a9 with SMTP id 5b1f17b1804b1-429c3a52c4cmr21777295e9.28.1723244547725;
        Fri, 09 Aug 2024 16:02:27 -0700 (PDT)
Received: from localhost.localdomain (host-87-10-253-138.retail.telecomitalia.it. [87.10.253.138])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-429c75044a8sm7987485e9.9.2024.08.09.16.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 16:02:27 -0700 (PDT)
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
Subject: [PATCH v4 1/7] dt-bindings: nvme: Document nvme-card compatible
Date: Fri,  9 Aug 2024 19:20:59 +0200
Message-ID: <20240809172106.25892-2-ansuelsmth@gmail.com>
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

