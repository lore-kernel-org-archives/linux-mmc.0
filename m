Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE4C2557A;
	Sun,  4 Aug 2024 11:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722771714; cv=none; b=CtpmqxJ4DQo5Cnw1FIuxHggNHa+bQ1aYM1DipIO+JvER/1XN8qF5WEY9inN8ENKlvvo8jmgKzm5YV9RCs5gO5OUEU0C6vpYEEByhPiyYO0UaqFHwiek+kn8kHVMcToATdRf/GeflMvqyPak2+YwrwDkia7IVSKQRV4vNEAG32xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722771714; c=relaxed/simple;
	bh=JEcyACUaJFGodv9vunRI6bw4Xqlmc41fmwuaisBEX94=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DZn+1avIrPcZyV5DcCDggakNPmzoXRt8S46NhZEGUiDBAIF4i/k3T45ijeUUNiLMNqthWp8PbrFAIXAxMEqWdxVsT+myZd3S5J4dxC56YAZ4RWNZcd4kZtLl2RaUjo+PaWNTlyP7Y3Nu+C51yNPZ8dGUJw8Tybt+XrurlwLi2lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjePufQu; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjePufQu"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ef2cb7d562so121133411fa.3;
        Sun, 04 Aug 2024 04:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722771711; x=1723376511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uWf5gTHI+JT/SQK1TNIP2OxNSLbRQh1nvSdD+ourA08=;
        b=cjePufQu4dkbcRhNmxBdllmggt4uQD0M5xvuL7nvjPPjqetdMIylBtJd849nnvT3ta
         FT+fOU9gWXKZgUvZyIsWupYwF9hLA123EC7GCSpl7+19G6s2s86yUxbOJx1Kbkm1pGAK
         oZQLeq4XtzWuzyPOO3JsT7+zHaL7l0ZhdXxHSkoaxddLkc8/pQoMGBhDqGunqB44aqTR
         S6e3nKGnEPPLEzB25UxuF7OVwE9L07AnlbnK1AsY61W9kYFf/+hRaEXHqllleotReUwq
         ImUzYGF6k4Zpj4CUiMJiy3d3vbCOZVOUciizvZZAy9PRYdtvHi1I5mU3XSQbH5DzPdDH
         jUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722771711; x=1723376511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uWf5gTHI+JT/SQK1TNIP2OxNSLbRQh1nvSdD+ourA08=;
        b=ZjGCkWbFW00NuULPFJ5+9BuqWPCynmBXn+O63n3vs0FHkgKIzeuqfA2Q/AcY/JTwHY
         iGHl6FYAmLuK9RrAXwP7Ec2Ksyrkoh9xiPN67FAvy6iYHnsn8vV3rSzi4ptWVAbEety2
         5/yk7HWodqnVW6O91iHuX19duFjbQha/an1/14/WiQv7A8GmQKMoaXP7+ouNM5C2dqgp
         UNYT4czHyACCWQyCVCKF3yCpbKWWl0H3gM2AmhYSmk5hKNQ7qHYW6p/TFvjiiB7XhGSN
         zqGp8/PGRRQcUww1j6glF52+yS2/BAbVt4JAB7wAKMaa8OV7Bo85WDBgOcw0Krz3kmvL
         At9A==
X-Forwarded-Encrypted: i=1; AJvYcCU/FjUZh/tNvCrC2zKDCQqxRKIxvxB4SfOuycDTT2j0ffT1YK9XT+OZEsUq5N3Xzy334Edo47lAshauoYyY0eSBxldmq/xSQcSwYCv3aeodJVnB+BNIszybfoIYHqwdg1v2NmwP80Vq0/SvpcGvq9rY9Yu0LI5JQKvkMlDI8zKWQQ5xEw==
X-Gm-Message-State: AOJu0YxyQwhvCIKnmMAACTwVTlkLkqEkqErNN+qnoFP0laMuj0rOV6ws
	hHNsoaErN8cHndkRCCsIHjoyorIBex8ofMFgOhloOggsttFCeCxA
X-Google-Smtp-Source: AGHT+IFQ4ywEK+Nr05gDozWWIKvELkaPNu9X1hjfL7jSZE7JaOVmh+yHXQJ/j3NTm9CnUOJtPHdoxg==
X-Received: by 2002:a2e:a409:0:b0:2ef:296d:1dd5 with SMTP id 38308e7fff4ca-2f15a9fd29cmr61440031fa.0.1722771710561;
        Sun, 04 Aug 2024 04:41:50 -0700 (PDT)
Received: from localhost.localdomain ([109.52.148.115])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-36bbd01eff1sm6635130f8f.44.2024.08.04.04.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 04:41:50 -0700 (PDT)
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
Subject: [PATCH 0/6] mtd: improve block2mtd + airoha parser
Date: Sun,  4 Aug 2024 13:41:00 +0200
Message-ID: <20240804114108.1893-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small series handle 2 problems.

It does try to ""standardize"" the usage of block2mtd module with
MTD OF nodes.

It is very easy to add support for MTD parser by just adding an
OF node to the mtd created for block2mtd.

This apply only if the root block is used for block2mtd to allow
scenario where the full eMMC or an NVME is used for MTD and it doesn't
have any partition table.

To also support NVME, similar to how it's done with eMMC, we introduce
a subnode to the NVME controller that needs to have the "nvme-card"
compatible where a dev can define fixed-paritions for MTD parser usage.

This series also add support for the Airoha partition table where
the last partition is always ART and is placed at the end of the flash.

This require dynamic calculation of the offset as some dedicated
driver for bad block management might be used that reserve some space
at the end of the flash for block accounting.

New aarch64 Airoha SoC make use of this partition table and use block2mtd
for eMMC to treat them as MTD with custom bad block management and block
tracking.

Christian Marangi (6):
  dt-bindings: nvme: Document nvme-card compatible
  nvme: assign of_node to nvme device
  dt-bindings: mmc: add property for partitions node in mmc-card node
  block2mtd: attach device OF node to MTD device
  dt-bindings: mtd: Add Documentation for Airoha fixed-partitions
  mtd: parser: add support for Airoha parser

 .../devicetree/bindings/mmc/mmc-card.yaml     | 40 ++++++++++
 .../partitions/airoha,fixed-partitions.yaml   | 80 +++++++++++++++++++
 .../devicetree/bindings/nvme/nvme-card.yaml   | 78 ++++++++++++++++++
 drivers/mtd/devices/block2mtd.c               | 11 +++
 drivers/mtd/parsers/Kconfig                   | 10 +++
 drivers/mtd/parsers/Makefile                  |  1 +
 drivers/mtd/parsers/ofpart_airoha.c           | 56 +++++++++++++
 drivers/mtd/parsers/ofpart_airoha.h           | 18 +++++
 drivers/mtd/parsers/ofpart_core.c             |  6 ++
 drivers/nvme/host/core.c                      |  3 +
 10 files changed, 303 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.yaml
 create mode 100644 Documentation/devicetree/bindings/nvme/nvme-card.yaml
 create mode 100644 drivers/mtd/parsers/ofpart_airoha.c
 create mode 100644 drivers/mtd/parsers/ofpart_airoha.h

-- 
2.45.2

