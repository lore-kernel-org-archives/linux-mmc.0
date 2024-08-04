Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4964479C2;
	Sun,  4 Aug 2024 17:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722793472; cv=none; b=KIWUFHOMxzA92omNgqtapGGvpE1CGBHWYfNfPVOzAtb/EHMyqKsZR3Ez/3b5DGBvcC+KKM0op0Q1fv5fsOMIWdHcXNYbUstAsVqbjnSxKQOvj1hu0+gwXpgKqPPW0iBrobHQByNfS7PkdrmpT1ECbmDo8lC4DiaXKRuo0LFAZXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722793472; c=relaxed/simple;
	bh=zZK56cdTnNzlyrnhxGKEQ+rlQ7fhgOSdcH1Du9XaLgA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=djehCC/apD2zzSPOtC8J2qV0Q7RdO7ZCgKyeCcn8224yvsn54Znk6DfWqwzCM+hU9SrhhZ7bfowbe+EcpXG1APQGzXQ9v0nCLw6h7KrO5GfYrARj/I6xULVle5YkenO9lbPM4n5fZDeIv3yct9yHh3mg6snaGWe6nnslPb28pIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkyK5uvo; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkyK5uvo"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f035ae0fe0so112651801fa.3;
        Sun, 04 Aug 2024 10:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722793468; x=1723398268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EoiP+tcKUyZMgtTqxHp6GAW77if+rMXqLxj1wKgai0w=;
        b=KkyK5uvoYAN3jpzj/ZPr+kot8EbzFrbvs//G/Sm4Ug/My2qQe/pL9MTyeTYedc1geU
         7tL2QPS0shmOJ18B4NfkjaCF1359wFvjiQL89DsEBdO1UUCayuboFnRvhitQyMH1LNHf
         PFc+6B13GZmYPkWpz0TlX5ZnH+o+ycQBEyLtvpmeqlQcOyJrr9bOQXV6TwKqvbr2Abx9
         54iIETifFFrQk9g3OzF3zum/4gHz5GTKf6trpq93AyPQwKlR0ceuB/T87CR1yP5XUMoU
         bSpKOP5l3op4RUIH4dHQOGkYgzfw0y3hzEQrmyDllD5MPXPlJBnv5zqgDtyR5Z4QxKkH
         PDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722793468; x=1723398268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EoiP+tcKUyZMgtTqxHp6GAW77if+rMXqLxj1wKgai0w=;
        b=GkZ5lhLBgxpX2aVIM/qm+KIHJFOdMbd9lA8A+lYzqmfYiWx8m8bedZ/tpwPtdbxNeH
         I4zXYJhZQ/oyBewQcczlNW2eZEFQvfa60Cyj2+O1hoY9Y6hqIMSOkHYCZVXpYlN+nuDe
         xJ90IpuB28cWLlC6johZwHfX+zkmDoaY7cdOTAgB6Q30rUsndq55Jir8Qp1qHEZ/lC4U
         c0C65xdgUTswn9/0r6x4tDKRSJqqIiSDTkO0eLfpLBX5rnuEJ4aWK2OO76v2lPFVGppu
         5p4dl8wkARUgyjkvw6qLc65SKqXXi1EeZ0LDiKHzRM3b7lD+WWXX9sIFmz5ycEj16wcf
         UrBA==
X-Forwarded-Encrypted: i=1; AJvYcCXMhqPogbufw8H8sgQ/IXkl07SCSfZ89sfyCdCGL4Ej0VGaqB5vO9SLvj3zZdyGSLXPYGBe9R5R5rE1jMnGRxQ8MGByhVqo6rD5wwgZ5sCgJNKB1xHhOtAf/wpJwSxOaybbJRp6Dgw1/A900JyKUg6Htj5bfK67x/t3n/IRAS0tFwnB3w==
X-Gm-Message-State: AOJu0YwacD891G4eF6MccD2XWh2APG7aSbgDGPQ+cfZoOlxEZZqA/gfg
	jsDoqEomnebrQzHANVUMKxnPszFZhRyW1vroUBRaXIEYU8OXwaBd
X-Google-Smtp-Source: AGHT+IErwMK3q/CPUbM0UcDWLOMSWoax6ZCTojye0vK4OjNmfjDst57FStXCrUKjx2otYofggK9xrw==
X-Received: by 2002:a2e:9e96:0:b0:2ef:2f37:345b with SMTP id 38308e7fff4ca-2f15ab0bff6mr59848521fa.30.1722793467836;
        Sun, 04 Aug 2024 10:44:27 -0700 (PDT)
Received: from localhost.localdomain (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-428e6e0357asm109530485e9.12.2024.08.04.10.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 10:44:27 -0700 (PDT)
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
Subject: [PATCH v2 0/6] mtd: improve block2mtd + airoha parser
Date: Sun,  4 Aug 2024 19:44:04 +0200
Message-ID: <20240804174414.18171-1-ansuelsmth@gmail.com>
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

Changes v2:
- Fix typo in DT patch
- Fix compilation error for non-OF platform
- Fix compilation error due to recent changes in block2mtd module

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
 drivers/mtd/devices/block2mtd.c               | 12 +++
 drivers/mtd/parsers/Kconfig                   | 10 +++
 drivers/mtd/parsers/Makefile                  |  1 +
 drivers/mtd/parsers/ofpart_airoha.c           | 56 +++++++++++++
 drivers/mtd/parsers/ofpart_airoha.h           | 18 +++++
 drivers/mtd/parsers/ofpart_core.c             |  6 ++
 drivers/nvme/host/core.c                      |  4 +
 10 files changed, 305 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.yaml
 create mode 100644 Documentation/devicetree/bindings/nvme/nvme-card.yaml
 create mode 100644 drivers/mtd/parsers/ofpart_airoha.c
 create mode 100644 drivers/mtd/parsers/ofpart_airoha.h

-- 
2.45.2

