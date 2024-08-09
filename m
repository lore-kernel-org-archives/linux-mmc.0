Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C8016D9AB;
	Fri,  9 Aug 2024 23:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723244554; cv=none; b=gdWwVcCGG/AraUsM+IFoqedQ9iINbYNlojhFXP0FELX7y/kvPB3kM7deOEadeX9Uf2gDXVehSEa69KZCQ2oMcjicjgQbb2rzFkIsr2isqFFpY56kUUj6sbTdBZvzjouRmbMevQi2YesrqSNadFS7EUcuhoWkiubauKpw2qWkfHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723244554; c=relaxed/simple;
	bh=0sysWhwNmnNKfHFiwRVWuNqKt3+jxEFZ3zFpJ5/W2Kg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yj7go83GGGzUdhIbGlKpdbTVQ1LLPYxC56cev6thAKQc4X43N8D2W7Yl2ezzDjd13uGHVE7VVDLsvGl8p9asonMhNJMBPxsD1TP2s/REaqIZ+tbob4GlEmurscJSfYVFqoFoIksfsjgNmT351NfjaEfAMq1suaIF18I+ksp62kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOGnMd7S; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOGnMd7S"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so14781005e9.1;
        Fri, 09 Aug 2024 16:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723244552; x=1723849352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zJtL0MfF3HGZoWE7QS0/OcrDoRKxdV59VhkJ0rmXwsw=;
        b=SOGnMd7SpmQgHck4TMbHO7JQo1YvL1mcR3+bq9E3HS+6HAAiw73a1bBJ8nLklaUOMS
         UgvnxKaWYYuz84rWluyh0aLXmIFp6v/+SlGHDiO3Z31C73AoWbBWI9y0iJknb2jjZwkE
         OrHFJfVbbWaXI+PES/KmmRzrYJZt0BtOebnSvbJDtfoZLnuPvwdDecwPHP3scHxG2vVg
         VaZEjkko2L+i3RALIjlAz94VgpxwtSLbB+HfdGMYJwZFyFBpa+q28liK373SsqycH38U
         KMhOy8JXFNO+iS4+I+gFO9GPFBVJGmJzmfKvwg47Sy2qLoa1dGwohAZ8PuHUNRw5j5Aj
         moFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723244552; x=1723849352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJtL0MfF3HGZoWE7QS0/OcrDoRKxdV59VhkJ0rmXwsw=;
        b=Ca4bWSraooj+UxhhUgw7Dr+w/JxPr22thDYRLKsSMaZBsCGpLqt77bVoWhQlR685Ru
         b2+/27IxilRS/s7dm93VDQijnSTTJDrmIe8sPmENfo/JR0AxNyy4jao+tIMYJRC35tL+
         KGS7uIHYaX2DOZgGHfYTUy6snFApTLnS4RYHwUqopG6pgiGp66vU0XSk53tFgKeSp8Pe
         qZqCPa4qBFfxzrhXTYC9mFSwlTDxMs7tbXZCZkeBzLdebWmZ0kRCZ3c1JPZvWxcaFg24
         E+2SDFwP7PkE3BHvhDkoh+YeqSXupx1VdRgcm5D6s/dfRf8kpXMiKfIhW+4zwcT7GAJx
         Hbfg==
X-Forwarded-Encrypted: i=1; AJvYcCWJ7AdvRzrpCGogKdTT7I+SUaSncRiHE5QBs2HFztk7txmekeJ8dsqKkVvua9P5YlbGqHr0FTXAv2iLX9Rx07Ik8lNw+jPeG3pQQ8Iv5nmnzOU1Ujaga/sEFOEGdyvPBN+yLTWdYOI48ufhcnHJk8JCtqE6vfEUUlN71IHu+wQPqxJrzg==
X-Gm-Message-State: AOJu0YzgHgwuKOBWXifrwdw27PHk2eFX2UKvpyPaO/qfG7I3Rp/9joC7
	6S01V93WBwTqYD1u8hFTw8Hd81IyEkKROkSfLEJ3mawN7d+nJtjo
X-Google-Smtp-Source: AGHT+IFxZor+5gNGTlA+oAGQcOKniA7tCPtYOXKQQ764BxqhepnN1UfZ1qeLzc7ivDbkqqu6KUpp8w==
X-Received: by 2002:a05:600c:4e8d:b0:424:a7f1:ba2 with SMTP id 5b1f17b1804b1-4290b8dee6dmr56055055e9.17.1723244551486;
        Fri, 09 Aug 2024 16:02:31 -0700 (PDT)
Received: from localhost.localdomain (host-87-10-253-138.retail.telecomitalia.it. [87.10.253.138])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-429c75044a8sm7987485e9.9.2024.08.09.16.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 16:02:31 -0700 (PDT)
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
Subject: [PATCH v4 3/7] dt-bindings: mmc: add property for partitions node in mmc-card node
Date: Fri,  9 Aug 2024 19:21:01 +0200
Message-ID: <20240809172106.25892-4-ansuelsmth@gmail.com>
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

