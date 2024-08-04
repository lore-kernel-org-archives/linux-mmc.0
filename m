Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7082A13C9B3;
	Sun,  4 Aug 2024 17:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722793486; cv=none; b=JX+J7okosr4GylRW+FylPTvpfm6Zm1ufWLcDInhokg8I9Kgp5AI4SDULPSLlDguPm90KB/0InYfuteX/eEHGXp+TrvdN8iZHTnKKaRKHBRUYVfd/dVCCgAaIPgZCxIGlP2y/fEg+anWmf38meWkUo3d+gcxLty9AglklspVgDzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722793486; c=relaxed/simple;
	bh=lmFBhiEFLBTNsYdGWhN1b++NrZ+263IZTBSJ7kubIr0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtpGp3pn/n8NB8/FpvZRwdFllaHUlGCMIupkvyaAJDoH/a8dvW9rwedF3ThQsc+sPZqxUle62bcV0i6JCLxNYg28t08ndLpyonbkvQXYCTOZVqiMQlQ6c8z38ds6uQ+ookiRYYnNFofeVWzRLkkxD2Pt/Km/HON10bmaZr/yEwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDGYKwkG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDGYKwkG"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4281ca54fd3so58153025e9.2;
        Sun, 04 Aug 2024 10:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722793483; x=1723398283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9UVSgx2w+2h8saQn7Nf58i+A85otGYnCOTiNQf2qOnE=;
        b=EDGYKwkGKiZj9hr6qh6zBNxbLtkYsvyMxIDlaVtTJvMOnT/JgYPeiHlm2/dzBQkEqI
         kz7J8Nfuh7+8EUSq5b6zNbGC1vvf45m+sFTevNtR/qt+FGd769SNz4Sds+aVhf4JdZY+
         idb1dWbgAzXdEVq2QhUMJ4B52qVOjJB++xK3SikF7yRhgby7yREUOwMmKTV2RLqrk83j
         0b5KSg3Sg8pldrqFdwh9jNoGiKjZLuwGUWj+qk3mogOi2vTYuDWoiggfOLuhKKHdG9h6
         XteCawB13GrIQoVG7icKAEjgmRY0OtY0JHCy7RQ+3gTGlsZXXzxpXc/VtWV6kS/tYwAe
         fBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722793483; x=1723398283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UVSgx2w+2h8saQn7Nf58i+A85otGYnCOTiNQf2qOnE=;
        b=IkcpEYVtVhn4QN4GVNsxdoDKLMfSpiaA2gfkSkM2ZpMQ1jpG4VoghEfICc1eTSRt6w
         npW2vXNzp9TkRa4RKWyQC0uMj1GCXiRQlZ9TAYuAu1nXNSle8Nft4xNtGeOoD5Phf6kb
         OhI+TC1vDcmmtWTmTfJnVTyHCDl5+afJzJxX8kaHLkUbXAoL7XdO5jOpmB22x/Yw6rU/
         oiy2CfDdaNz+0eZVXLpQhGM0vLdnD6h0xMtLHFpBwYcpQNf+eGu9VBprrkVWTbDajTkA
         T2OX+MbzmYZF104n9krtJZJNB8rjGYyJjCpu6NxvBPCJglagO2xAuwlFRVBGJhYQzUjt
         tmiA==
X-Forwarded-Encrypted: i=1; AJvYcCVVVFbQel7k8K6k3Fq9Avc/SEyldWWap0tXfOx8htN2FqZoczsiRuJpjPKdu7REwpgG4n8kJ32/vzfT5fMtYhRXK/xE4Hr+RcrENG8BzgaLW6OccScBpifXkAyA9XC9/Jv3ZT2eblRuWoKBB1ZfahWPlFbl5emjqp0/FW2coPAGF+AaOg==
X-Gm-Message-State: AOJu0YxdSfAjQOz/klo/xNN9fdSlwF+DlMZfc0ZyqYu03Hg1BL6fS75S
	LyFdKIpdWmazPqj3S2LrHz0X1ScL3uiCM+rQsjnUxAFZjPWnG/pv
X-Google-Smtp-Source: AGHT+IEDPxzd3sx2oWn1F3P5fvzhOdH1szNT0s2kg9Hk1mFyBChT102gESKjdtASr5YYir/D+vGkrQ==
X-Received: by 2002:a7b:c846:0:b0:426:6f17:531 with SMTP id 5b1f17b1804b1-428e6afe872mr64997295e9.13.1722793482561;
        Sun, 04 Aug 2024 10:44:42 -0700 (PDT)
Received: from localhost.localdomain (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-428e6e0357asm109530485e9.12.2024.08.04.10.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 10:44:42 -0700 (PDT)
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
Subject: [PATCH v2 6/6] mtd: parser: add support for Airoha parser
Date: Sun,  4 Aug 2024 19:44:10 +0200
Message-ID: <20240804174414.18171-7-ansuelsmth@gmail.com>
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

