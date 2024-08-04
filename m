Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D8855884;
	Sun,  4 Aug 2024 11:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722771737; cv=none; b=pZe7aPOiqD1dwjy6bm1L3YpI/0OK4BbvmVCk18d12M1x8aoaH8gai8MPtHYA/GiKBMiKtoTMpOhFS/j818Ivh9oBLKsjmOPkhhDs6JBdlesLh/w7SBOI8D0rt9vBBzB416UFONhCB0NQ5aEdLIf3RF4Guirb84eaZFArqZC+qdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722771737; c=relaxed/simple;
	bh=lmFBhiEFLBTNsYdGWhN1b++NrZ+263IZTBSJ7kubIr0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bM0mHbK12xv6T8hiXwhW/G0qYI7GPEJGEWaULIbM/yuNObi0mtUXzRyTBouTWMDueqiWs+xaqct0UdoO43tpi0tTbJ+QI3Q8WT60XiudFw0Y7tF3+S3gYwVbgqLmJl+RQSiUDwjP4LvEfIs8DaKYfgpHrkGhn6klxU158DpfgvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2uoVBSD; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2uoVBSD"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-36ba3b06186so2311293f8f.2;
        Sun, 04 Aug 2024 04:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722771734; x=1723376534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9UVSgx2w+2h8saQn7Nf58i+A85otGYnCOTiNQf2qOnE=;
        b=K2uoVBSD0ELWz0eusnK0ZRprj5Nq9upS7HNhMClNa4jAdQl3mLTwb20DxSOrCqyF2Z
         o+20kgR7+20Fb1afAnI0iPxgCj5hlYM2AKzT185Q2XnsWr9XIjudzX0x+yFXbLU36+4K
         AMwslH7C/AiTn2h9OMyXP1U74A7XtFN+DmEABusyPrskTnCzX1MM1ckiNST/hBKVIocA
         +h9Kr4qnmeLQONxcPq41m0EI8JNOXBQcl6qM0mbPwHPFW+eW9RvwTKqfyd/pJHG6LMXk
         LVbRkthjp4QmixqgUpRN1TW746eX4GH3ioD16LD8G7YChHBw8+173CuliPeaZF30yfQz
         Elpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722771734; x=1723376534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UVSgx2w+2h8saQn7Nf58i+A85otGYnCOTiNQf2qOnE=;
        b=Z02l6aymLjUq5Nz1DFAwccsbAhlX/mfGbh+b4CeRLFzBg5qnKV4kwIuhzjfLm0SMmw
         nAr47jFbLvnz9piXaczaH1s9cV54hcsAkOQT+A1FdH44qR+fSEsJf2jvmPaPK31FwMfN
         O5fgqAzs8ptcp5uZhxSrJSYiDtS//HAA/343ULW71gukZEaVsPwUGIFADrI0ROSXhxGO
         WJUI6IMT06QUieeFYRzPrXGfLvyfVR1M4nMapTtT5ab8Ms/Rpzk3yaFvj/uEWGxIVP99
         iFxehqze8QVOaczlw36QY9un5Q+I35J2w/7nwBlAfcEEVWwUaaqxZD5LOns8FKhKYdfM
         FRPw==
X-Forwarded-Encrypted: i=1; AJvYcCWq/eW8QrL0P1Qb/uZbdAv1vyrVTqaH+psaiJdbA9Uvhep4SsQUzs1oZbB9saaHEVWcbMMlSKNyRxHL02SnyQRIlGZBEdQE+FciqOaYXaJ5A/N5xTvXZJbsDWDLdvBigdCSK4MU0qLm67VfsKEXuQwwNspvHFy1pDCsn1iDiUSVisxRRg==
X-Gm-Message-State: AOJu0Yz0BkyetZ9RAg+nSmk9/podZ1niX4qVCOfyrA3G1bMF+C7Trjex
	dwEP9BFRHDflCgA3r/e/cbYtZW3mBKISPb4CFUWVQ9FC/KZodaFQ
X-Google-Smtp-Source: AGHT+IGKaCDEArKFCkMRQiZKdcUjJdCjj4WZCLTvBf7YPdaEPgvS4EnneXBtmeDcGQXSLmrXmUCU+A==
X-Received: by 2002:a05:6000:1faf:b0:368:d0d:a5d6 with SMTP id ffacd0b85a97d-36bbc1beb75mr5955443f8f.50.1722771733531;
        Sun, 04 Aug 2024 04:42:13 -0700 (PDT)
Received: from localhost.localdomain ([109.52.148.115])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-36bbd01eff1sm6635130f8f.44.2024.08.04.04.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 04:42:13 -0700 (PDT)
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
Subject: [PATCH 6/6] mtd: parser: add support for Airoha parser
Date: Sun,  4 Aug 2024 13:41:06 +0200
Message-ID: <20240804114108.1893-7-ansuelsmth@gmail.com>
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

Add support for Airoha parser based on a post parse ofpart function.

Airoha partition table follow normal fixed-partition implementation
with a special implementation for the ART partition. This is always the
last partition and is placed from the end of the flash - the partition
size.

To enable this special implementation for ART partition, the relevant
node require the "airoha,dynamic-art" compatible. With that declared,
offset value is ignored and real offset is updated with the calculated
value.

Due to usage of specific bad block management driver, the MTD size might
vary hence the ART partition offset needs to be dynamically parsed and
can't be declared statically.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/mtd/parsers/Kconfig         | 10 ++++++
 drivers/mtd/parsers/Makefile        |  1 +
 drivers/mtd/parsers/ofpart_airoha.c | 56 +++++++++++++++++++++++++++++
 drivers/mtd/parsers/ofpart_airoha.h | 18 ++++++++++
 drivers/mtd/parsers/ofpart_core.c   |  6 ++++
 5 files changed, 91 insertions(+)
 create mode 100644 drivers/mtd/parsers/ofpart_airoha.c
 create mode 100644 drivers/mtd/parsers/ofpart_airoha.h

diff --git a/drivers/mtd/parsers/Kconfig b/drivers/mtd/parsers/Kconfig
index da03ab6efe04..d6c53aa16ea6 100644
--- a/drivers/mtd/parsers/Kconfig
+++ b/drivers/mtd/parsers/Kconfig
@@ -72,6 +72,16 @@ config MTD_OF_PARTS
 	  flash memory node, as described in
 	  Documentation/devicetree/bindings/mtd/mtd.yaml.
 
+config MTD_OF_PARTS_AIROHA
+	bool "Airoha EN7815 partitioning support"
+	depends on MTD_OF_PARTS && (ARCH_AIROHA || COMPILE_TEST)
+	default ARCH_AIROHA
+	help
+	  This provides partitions parser for Airoha EN7815 family devices
+	  that can have dynamic "ART" partition at the end of the flash.
+	  It takes care of finding the correct offset and update property
+	  with it.
+
 config MTD_OF_PARTS_BCM4908
 	bool "BCM4908 partitioning support"
 	depends on MTD_OF_PARTS && (ARCH_BCMBCA || COMPILE_TEST)
diff --git a/drivers/mtd/parsers/Makefile b/drivers/mtd/parsers/Makefile
index 9b00c62b837a..d67f9b4d39ac 100644
--- a/drivers/mtd/parsers/Makefile
+++ b/drivers/mtd/parsers/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_MTD_BRCM_U_BOOT)		+= brcm_u-boot.o
 obj-$(CONFIG_MTD_CMDLINE_PARTS)		+= cmdlinepart.o
 obj-$(CONFIG_MTD_OF_PARTS)		+= ofpart.o
 ofpart-y				+= ofpart_core.o
+ofpart-$(CONFIG_MTD_OF_PARTS_AIROHA)	+= ofpart_airoha.o
 ofpart-$(CONFIG_MTD_OF_PARTS_BCM4908)	+= ofpart_bcm4908.o
 ofpart-$(CONFIG_MTD_OF_PARTS_LINKSYS_NS)+= ofpart_linksys_ns.o
 obj-$(CONFIG_MTD_PARSER_IMAGETAG)	+= parser_imagetag.o
diff --git a/drivers/mtd/parsers/ofpart_airoha.c b/drivers/mtd/parsers/ofpart_airoha.c
new file mode 100644
index 000000000000..905df53f7716
--- /dev/null
+++ b/drivers/mtd/parsers/ofpart_airoha.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Christian Marangi <ansuelsmth@gmail.com>
+ */
+
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+
+#include "ofpart_airoha.h"
+
+int airoha_partitions_post_parse(struct mtd_info *mtd,
+				 struct mtd_partition *parts,
+				 int nr_parts)
+{
+	struct mtd_partition *part;
+	int len, a_cells, s_cells;
+	struct device_node *pp;
+	struct property *prop;
+	const __be32 *reg;
+	__be32 *new_reg;
+
+	part = &parts[nr_parts - 1];
+	pp = part->of_node;
+
+	/* Skip if ART partition have a valid offset instead of a dynamic one */
+	if (!of_device_is_compatible(pp, "airoha,dynamic-art"))
+		return 0;
+
+	/* ART partition is set at the end of flash - size */
+	part->offset = mtd->size - part->size;
+
+	/* Update the offset with the new calculate value in DT */
+	prop = kzalloc(sizeof(*prop), GFP_KERNEL);
+	if (!prop)
+		return -ENOMEM;
+
+	/* Reg already validated by fixed-partition parser */
+	reg = of_get_property(pp, "reg", &len);
+
+	/* Fixed partition */
+	a_cells = of_n_addr_cells(pp);
+	s_cells = of_n_size_cells(pp);
+
+	prop->name = "reg";
+	prop->length = (a_cells + s_cells) * sizeof(__be32);
+	prop->value = kmemdup(reg, (a_cells + s_cells) * sizeof(__be32),
+			      GFP_KERNEL);
+	new_reg = prop->value;
+	memset(new_reg, 0, a_cells * sizeof(__be32));
+	new_reg[a_cells - 1] = cpu_to_be32(part->offset);
+	if (a_cells > 1)
+		new_reg[0] = cpu_to_be32(part->offset >> 32);
+	of_update_property(pp, prop);
+
+	return 0;
+}
diff --git a/drivers/mtd/parsers/ofpart_airoha.h b/drivers/mtd/parsers/ofpart_airoha.h
new file mode 100644
index 000000000000..3e8a8456c13a
--- /dev/null
+++ b/drivers/mtd/parsers/ofpart_airoha.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __OFPART_AIROHA_H
+#define __OFPART_AIROHA_H
+
+#ifdef CONFIG_MTD_OF_PARTS_AIROHA
+int airoha_partitions_post_parse(struct mtd_info *mtd,
+				 struct mtd_partition *parts,
+				 int nr_parts);
+#else
+static inline int airoha_partitions_post_parse(struct mtd_info *mtd,
+					       struct mtd_partition *parts,
+					       int nr_parts)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
+#endif
diff --git a/drivers/mtd/parsers/ofpart_core.c b/drivers/mtd/parsers/ofpart_core.c
index e7b8e9d0a910..9e078636d158 100644
--- a/drivers/mtd/parsers/ofpart_core.c
+++ b/drivers/mtd/parsers/ofpart_core.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/mtd/partitions.h>
 
+#include "ofpart_airoha.h"
 #include "ofpart_bcm4908.h"
 #include "ofpart_linksys_ns.h"
 
@@ -23,6 +24,10 @@ struct fixed_partitions_quirks {
 	int (*post_parse)(struct mtd_info *mtd, struct mtd_partition *parts, int nr_parts);
 };
 
+static struct fixed_partitions_quirks airoha_partitions_quirks = {
+	.post_parse = airoha_partitions_post_parse,
+};
+
 static struct fixed_partitions_quirks bcm4908_partitions_quirks = {
 	.post_parse = bcm4908_partitions_post_parse,
 };
@@ -192,6 +197,7 @@ static const struct of_device_id parse_ofpart_match_table[] = {
 	/* Generic */
 	{ .compatible = "fixed-partitions" },
 	/* Customized */
+	{ .compatible = "airoha,fixed-partitions", .data = &airoha_partitions_quirks, },
 	{ .compatible = "brcm,bcm4908-partitions", .data = &bcm4908_partitions_quirks, },
 	{ .compatible = "linksys,ns-partitions", .data = &linksys_ns_partitions_quirks, },
 	{},
-- 
2.45.2

