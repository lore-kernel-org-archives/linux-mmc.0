Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC181C461B;
	Tue,  6 Aug 2024 11:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722944495; cv=none; b=eKFBsZGviOX54W6k9f6KG27sUV+1RyktWZ4axuvwdBqwC1mGKLXU1dP77pGXGmVJGZVOv1aSVvIO7RVplhAbyD8Ub7rhXRgnK/v7jPSEfl+auC1chCFH9oqnZ7cPLw7YZuBUSotYg0RLYaLxOix1XJ4LweoX5R9Ds/OS04MthnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722944495; c=relaxed/simple;
	bh=0sysWhwNmnNKfHFiwRVWuNqKt3+jxEFZ3zFpJ5/W2Kg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UOXqt5ZfaA/DcCQGkjNkgp5Mt6/C7UXS9FSJ+9Hebzc9H8swC0XZlbOIjE9EAYNlhgZY4iMOhzWWiKmXkzDLJXHpvhW2D57J7g37gdn6rmQ/KaCOXl8ThvqLU6su8ZlIoxQXnmp8eSmwRWXbBMVNWqun/322TUVGSyRxK/GjxjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVO514SC; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVO514SC"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-428e3129851so3317085e9.3;
        Tue, 06 Aug 2024 04:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722944492; x=1723549292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zJtL0MfF3HGZoWE7QS0/OcrDoRKxdV59VhkJ0rmXwsw=;
        b=YVO514SCcXQcVb+A5DWSR3SKze1Z5TYuxyUkV4w+sElvFaJ6Y/RGCcNzIYfBQmHvtr
         /XiaOLX5XMm9pUz3Ws9JfOYduIxpLj2wdzAy9EsfceHYtYS4tuo5gfqRAFtmbNIvrwki
         j7B+VkpRLxMXy3oLmcdt0O93P5rBY0hsWTyZOR1mFTHB5OvTaS1Ifgqe4m7dOniSoora
         Ltjq2Hge4GCTEVqV2tZb/Jh58SvmOr7vPjLhpp/I5jHCetwd8HH/2AkNAXA99ucPXPfr
         ThdSh+1NCxnQ+skEuC0/O2SlHNxQ0WDQHl18VzBrpLnqgXCcphWPIecPQU0CZyMuRy9A
         Xe6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722944492; x=1723549292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJtL0MfF3HGZoWE7QS0/OcrDoRKxdV59VhkJ0rmXwsw=;
        b=bHcM0TnP1fnEfksEhqQDL6KGkfZq3pVRqA1jKdgoOQcYiCISpEzWU+NJWHDpAVr2UE
         /+sE1Qfu0RmYhGg9aLR+4XUKGPMAAYHKQUldNG7Yfs7KW/RwveelboWXNKqiwREG8WRH
         Ouz58z9ADVtI0xpBO/1rLWNq5Azhoe4b2G/oCo7noH6VqssZi5UCFpkr0VvW8uz8OMPL
         n0tAxY3XV/qCnQ6pGNjqnH5qgh3cjAc5jF6mICwwLh7I6hLruF3f2A1Tq8Ezj+Zh9fZj
         tehIKFR793WN5LHBcPVi0snZe2tD0R63GXaQTMqnt/J3IZImc0VhbXUP7QaljIiewbTo
         sOCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWr39QD4inqM+FM06jjfV0IMrtvlHfie7tXicH1YELUijLGvj5mTqzYRjKlPQCm8+r6N47fTdtr+fG2BOpFRiILoFmgjVeac2KUOotkuVg5a5p/We88mZ8Lxzvjb4ybVyj//u59oPb1tf1l+rDZxSBupudZF0b/O7PwSdPFAPO4HWwv2A==
X-Gm-Message-State: AOJu0YywnK3dNwS3VgR9S6tpyDlQWPHdJ6Pusypb50/2EDaZM1dicg1C
	BcbJKTrbD9SLpoQX+7bsUZZie7mWWcRGZbn6+AgfC9F7CSRZR7yv
X-Google-Smtp-Source: AGHT+IEtsLb9ubCDZAG9HKspu+Ejg5Bny2dpdCF+3riHPRWpHuMWqRmG9LivPX6D4Zet1J/ot/MWyg==
X-Received: by 2002:a05:600c:1d89:b0:426:6a5e:73c5 with SMTP id 5b1f17b1804b1-428e6b92d50mr97449265e9.37.1722944492093;
        Tue, 06 Aug 2024 04:41:32 -0700 (PDT)
Received: from localhost.localdomain (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-428e6e7cce6sm176105845e9.31.2024.08.06.04.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 04:41:31 -0700 (PDT)
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
Subject: [PATCH v3 3/6] dt-bindings: mmc: add property for partitions node in mmc-card node
Date: Tue,  6 Aug 2024 13:41:13 +0200
Message-ID: <20240806114118.17198-4-ansuelsmth@gmail.com>
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

Add property for defining partitions node in mmc-card node to define
partitions in DT by the use of the block2mtd module to use block
devices as MTD.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../devicetree/bindings/mmc/mmc-card.yaml     | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.yaml b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
index fd347126449a..0f32d24417bc 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-card.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
@@ -26,6 +26,9 @@ properties:
       Use this to indicate that the mmc-card has a broken hpi
       implementation, and that hpi should not be used.
 
+  partitions:
+    $ref: /schemas/mtd/partitions/partitions.yaml
+
 required:
   - compatible
   - reg
@@ -45,4 +48,41 @@ examples:
         };
     };
 
+    mmc1 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        card@0 {
+            compatible = "mmc-card";
+            reg = <0>;
+            broken-hpi;
+
+            partitions {
+                compatible = "fixed-partitions";
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                bootloader@0 {
+                  label = "bootloader";
+                  reg = <0x00000000 0x00080000>;
+                };
+
+                tclinux@80000 {
+                  label = "tclinux";
+                  reg = <0x00080000 0x02800000>;
+                };
+
+                tclinux_slave@2880000 {
+                  label = "tclinux_slave";
+                  reg = <0x02880000 0x02800000>;
+                };
+
+                rootfs_data@5080000 {
+                  label = "rootfs_data";
+                  reg = <0x5080000 0x00800000>;
+                };
+            };
+        };
+    };
+
 ...
-- 
2.45.2

