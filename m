Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7F53D3BF;
	Sun,  4 Aug 2024 11:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722771725; cv=none; b=FvjsnBOseUdLpIWmaJednLLALIvOTGQVFobrU2MgvB0kc4AKyz5zc2t5pSEHyk4xMt4sXdq8vFZXYiA6VWl+AhO0vh/yAiNvXBNqQ8eAm8W0QX2FStY5kLsL7y3eeqwR4znbkYhcNK3mZO0iw+7g+UKYQFCQ94LPRQOnQzo5/Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722771725; c=relaxed/simple;
	bh=0sysWhwNmnNKfHFiwRVWuNqKt3+jxEFZ3zFpJ5/W2Kg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TBDjRlYcdNj6yGLATjBD9dbygGoZoW+PhH5VgcxKzVTMbv3W5A4k8ddWxC5MGYLW9CXlROQTQrGVJbs5WkQq59TRQOC5LAqv+6Kq/4IzwH/lj0GVSSEFvjvViChV+5d3uBA+wfzxfnZaNL6Z8/K3elG9j/lkKOU1C5HbsfQdWLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=figMxNOn; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="figMxNOn"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3683329f787so5300229f8f.1;
        Sun, 04 Aug 2024 04:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722771722; x=1723376522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zJtL0MfF3HGZoWE7QS0/OcrDoRKxdV59VhkJ0rmXwsw=;
        b=figMxNOnim1w4jtmIcirC4PyDiY7Mb3DNnNGyyLTSunRBbCokjvLkCrx6NJQ3bUwrp
         bRnIVoGMbo73GTsjAysCDKpFzINuYCvbaYbcgg1I9Yuaoiuan4acC1q/NxhD5HZvVXab
         M/hLjy+/fgthTZtMS42tgsfykWYzdX74JTZfskxs2Iu5WT1Y6WJ4nPSwdO5hJCZq+Pvf
         36+7otL0Rh5WDjS2A4Q8b0tA6G78ysN2tcBCykcHmLIjJyWAj5F4HT5+GgyuuqKbqfUN
         uvNNuuRj2J43EeUyBxssDw1LFvwVpv5AFUSwtHYWXJ8IuDUpP/mkWgJh4Wfo9jBvfTX9
         9CFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722771722; x=1723376522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJtL0MfF3HGZoWE7QS0/OcrDoRKxdV59VhkJ0rmXwsw=;
        b=aszmrAm/ELHpM9A5ucqpps42cjr9Yy+ETXm9e/1UIJd54wrHWP9kNqr/xqDHKapaEk
         EpYmBGoSb2dfPr6hlAv9f/e8Cmlp+fRUSTUYDktjBY9EO2ekpxOcfuKT2D3WQndcM4iB
         xPz9J6196yJqSn8z1U2ZWBaX3l4bvmzYf18Ln4l7Py1Rkb1A07IaiqeMryYMXcRBBOuh
         N0ktvpwEYhP3Wh8jsLiotVEGbIlNJS0klaAT2p0bsGGtNaoP894EKlshxI9R+9OqRrn+
         DdggjPXrGAw/FiipWUs6xBj4EYNMGhiQJQANa7DKR68KPz/fNFbsTOKMyVuoYZwr58IH
         c9qg==
X-Forwarded-Encrypted: i=1; AJvYcCUaCu3LN9ZG2fJUVbAY0dSKjX5MU4yR/UeYUCHf9bVR6e81V/KNWu0bw0+x3i6b2n5g2ZhToh9rj69YpWJhHt9Pvav6OG91C6Zmw5J5Eu6yK8Wr/DOqCxJW8DHIijaA3SWRzJZWTD7Lap1mtmHEugv26tbfz2l1xvL/dhFVP8/9JyQ0gA==
X-Gm-Message-State: AOJu0YyT+KI1tKFtZD4y9prBEw7HuUqzEMGzttbAEIq/jleW3HK4k0WG
	zDyk3bWV78Biojjb/w0pfVkQGxXj4iOctOrYUOqyOQXdjuqDZ7P8
X-Google-Smtp-Source: AGHT+IGEFh9LhSO6onNwyiaQPUVg7gbETIoF2d9fushpmHT41a6bZNRtUSOPmyLpIODrXsVeGWvaOw==
X-Received: by 2002:a5d:6104:0:b0:368:71bc:2b0c with SMTP id ffacd0b85a97d-36bbc0c69camr4994727f8f.10.1722771721698;
        Sun, 04 Aug 2024 04:42:01 -0700 (PDT)
Received: from localhost.localdomain ([109.52.148.115])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-36bbd01eff1sm6635130f8f.44.2024.08.04.04.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 04:42:01 -0700 (PDT)
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
Subject: [PATCH 3/6] dt-bindings: mmc: add property for partitions node in mmc-card node
Date: Sun,  4 Aug 2024 13:41:03 +0200
Message-ID: <20240804114108.1893-4-ansuelsmth@gmail.com>
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

