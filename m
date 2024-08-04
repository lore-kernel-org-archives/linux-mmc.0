Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830D113AD29;
	Sun,  4 Aug 2024 17:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722793478; cv=none; b=ZSbwp0SowJLTeKbjTCnH2XoKemsLexqFQiYHDErWbUeGiCRJM5mpMRPnlr8b2rsXe96SexcwC8PdbB1Tdev5xIS/iuMWfZIxqvfeNU3dupABoc3vdwoAvPFYw/C2DyOzPVJ0OzLwl/D0GqdP1oTi8icn1wBaUGyuqVAqNia8Zek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722793478; c=relaxed/simple;
	bh=0sysWhwNmnNKfHFiwRVWuNqKt3+jxEFZ3zFpJ5/W2Kg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U8BL7HzWOW3gqJO3nIGXMmLuhAfmFHWQ2LMN3P/O/ubgJGnSZP4GF9zWYZL/bgL5NzkI7QjxZgAARI2qFDEE5WK/sl8zl6Pn9fOTdXxlz0KxjmbWz33L0/h1HOLEGEgvHcU9odjVRXsoxwMcMBVA8+ucPF+JCo3L60ZUs6iAerY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTAeNyHE; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTAeNyHE"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-428163f7635so66246455e9.2;
        Sun, 04 Aug 2024 10:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722793475; x=1723398275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zJtL0MfF3HGZoWE7QS0/OcrDoRKxdV59VhkJ0rmXwsw=;
        b=jTAeNyHEc6Oi3acm0BHrbQeMVAx1dtSkUcfpiasWxd1BKMe1Ibr46XVgvtu4YWIJfJ
         nsntfXXa+7LCcTALQKnqzc8/CautyJTtjHHERLvbY4DDc7PvQusnDSSIyt3fL/RAKwqR
         +rDtl+BrBiN/ch7DnJrt2gopn3QddBGLBoGE+uEw9gh5TFM4fqeBUAeCszIQVpmvxZV0
         vJHurBiDPmpNLzVC5QqruKgOA4Jzd4z0dXEU63j9YeYoN/Suov/vkbk2N9RcswF6sV7d
         3d8aaWanwjZTbEgZxJpE5lY0+5/NYh3dSaHuj+SQSDzVMqlNucWllvSl7xSf5UFhzGK0
         uVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722793475; x=1723398275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJtL0MfF3HGZoWE7QS0/OcrDoRKxdV59VhkJ0rmXwsw=;
        b=c7ESUf0785QkR2VsVaoxawqHNjclLeNUzAkwI2avJDVDZ9hV2etZTCgQ9RmkFQWDF9
         HMQjIeHqAOMJ7GTEzGQCslNzinKolHKlXEn+LmO2QLmYieQCVdmomQED4Fur4wQmjfNR
         sVg4xrGkv18gLcgtmZbm73QJiB0TyoEeUIZHftKVZsoOjhbysuvwaW3Uoz3isIBxj0AX
         gR1HIcnnZ+o7OWAYNRXCUtysv6S7Ms1rDgQ6dSI1n6Aj6gOmBQ6IO5/J3hZI8l8QEqc9
         ZZ0X2P9uMM8G/6ms1jVbGOIo8bdf4uvFc8DXOFNuEB1/42TlBXRa0pGX5pcryl+w41Tp
         XMVA==
X-Forwarded-Encrypted: i=1; AJvYcCUrW/l2uM6ua3l75y+CZYy8D/m08D16gzkoOwRaf8Oxtq6eJTr4lDT/UMK28D+bpUC9Y+SAy/94SScQD25dAsPreCGLZUHM2TH/wYIM0mBk5R5h4i3U8zJl5hyrdtxcOgfEPTgdm0tVeam3rG5JBWoNo5yYB+afR4l0Wo1ZX+EkVgpbrw==
X-Gm-Message-State: AOJu0YzwPb1QQ2pu7HIt+iAU4GhgS6YQ94e2D1TY8Ie5SjU7grRVTr3u
	/yNM2b4uGJEMHztY9gkYJjwo7eV/FQWMAI+SIHDYJSFpK2xrSXco
X-Google-Smtp-Source: AGHT+IFN8eD9eeHRek82k2yYE+fWbJDyGcXBovLeKVHyNRAcWSy58vdincZxAdx4fAZXLwmahnfYCg==
X-Received: by 2002:a05:600c:3acc:b0:426:5f7d:addc with SMTP id 5b1f17b1804b1-428e6b8380dmr57122375e9.37.1722793474565;
        Sun, 04 Aug 2024 10:44:34 -0700 (PDT)
Received: from localhost.localdomain (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-428e6e0357asm109530485e9.12.2024.08.04.10.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 10:44:34 -0700 (PDT)
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
Subject: [PATCH v2 3/6] dt-bindings: mmc: add property for partitions node in mmc-card node
Date: Sun,  4 Aug 2024 19:44:07 +0200
Message-ID: <20240804174414.18171-4-ansuelsmth@gmail.com>
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

