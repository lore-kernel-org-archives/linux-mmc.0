Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876801C2324;
	Tue,  6 Aug 2024 11:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722944490; cv=none; b=ZGd1OZus2LB5uwIQIPqBfSwJEzQl82FXAilM4ynqC09b9KyOGgkiObMXZVbxYPLfShQXBpHNBFeUi1y6sSK3yR1sibIWA0jC5eoE5INMGyWk8QO+j35sMAjhLOGCPAYa7kbPKBtPC0LJoDOD99RQXaitHIVScvnd22qBhMtNmOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722944490; c=relaxed/simple;
	bh=0cuXlLqNV1nI6qmvoA149YGaAWIEPfuv5YFddNUum0o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jm0CPdpsxJqS4xQcdzHlEMAOMn4SB1+caI+4qSx0E39OAejDE7m8ouWuHeemtEHgokXYAjSk7qSkTBlw9bTmQ85Pnt5xM5UB9NQCH7Vv3EU+/bN1jP9ol8XhE7RV45X8UQ2R3mCV1X27APuWjhRi5tZDF3tpOJfuxpGE0dRz9E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kK+tBEwV; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kK+tBEwV"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42808071810so3186965e9.1;
        Tue, 06 Aug 2024 04:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722944487; x=1723549287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YpfYwGb98vUIAZ4eOkYm143SZkEFj932lYgjUfhnx5I=;
        b=kK+tBEwVWjLsogOkiZgAcEgEQiyfmYNHkgMJN1i+Bkxcof7TAr4Bc6SmvvDp4QpLQe
         /tNuv5uLPjSdqUWw4AeA0I2fQlDJpHNrYOPM11VOPSuWs2z8hydciUDJS5oy65LW9k7d
         hRmg9QYYd0Ov3rB4f49NIsCRnVZ0iglNbNUzXL59800S/3l6xrsPEZjey2GiVZHFx7ig
         kehri+AkEE6VBp4nnXGkYCkWRbFvNXkw6QrgH/uVGjdB/D0CdY0uVk3xYqdZUwQ+LmOn
         D9kd2B6sU8GfFZ+P2hEAWN833FadMXdwutyBvOYkwxu6b+vzmAvg5G5K6zPqtxCQXus5
         FWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722944487; x=1723549287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YpfYwGb98vUIAZ4eOkYm143SZkEFj932lYgjUfhnx5I=;
        b=wXznGtA8xnFd9NNU+TiC9YgJ6FCrr0U1LxZ8j5CLcSTGFuZw+HJlLUJla2rzDjp1G3
         lCMUR8IYGA0M1bEIfVx8oowWyZU0WQbdPBex4y2qB/9IvWzhKmNVMex7zeXD18E+J3YM
         RqCIvG8ZFEGwHGJ++4ZSLYrqlexJMouVfClix0UrAFryp5j8KnVf9DWn7FaxdLsSODFa
         ODVk47Oo86BUrXj5LMjQVrp+pOZuVJIThyormFMPWsmYgC04kHIBfkU2asp+WUA3xZR1
         Xh+tFKqUCQNNPSaR//tlGu8PokosYwQ3ueCMf3l8K32h6mpXwS7X76YoeHwpfKSTO9Y/
         d/cQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDxXEGEH9qXYMVkakzLjCcku9snvgiIMCHPG1MYvFb89Anq8vc/fZTR7jsufIjoHenEoHvp3MTWj83nlzGYsp6tqAhvFVgjpnW6+44wTnSGeS3mgGe3D4kVCSbtxKOZ8jLafgxyMqTrMqsyH6JPBfBV0b2HpyqC0dWd/7A2TaJI20amQ==
X-Gm-Message-State: AOJu0Yw8F6rWAVQDin9yBFK17OG1pW5ColgefwlGarjNSgTDJV73Xibp
	zIwKTUNj1OL6SRv6WwdOVJ2vowmG/9X3hjIvz/Qn49m7IEd3arlo
X-Google-Smtp-Source: AGHT+IH3bACCHKh1gLb1eYfDR32vW4Ay/HBQR1YwSGOa4TNKvGPiVuBbrwRDssiyzifL5Rm50ofl/w==
X-Received: by 2002:a05:600c:4f4b:b0:426:614b:1a72 with SMTP id 5b1f17b1804b1-428e6b07ea1mr107971085e9.17.1722944486415;
        Tue, 06 Aug 2024 04:41:26 -0700 (PDT)
Received: from localhost.localdomain (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-428e6e7cce6sm176105845e9.31.2024.08.06.04.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 04:41:26 -0700 (PDT)
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
Subject: [PATCH v3 0/6] mtd: improve block2mtd + airoha parser
Date: Tue,  6 Aug 2024 13:41:10 +0200
Message-ID: <20240806114118.17198-1-ansuelsmth@gmail.com>
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

Changes v3:
- Fix compilation error for missing slab.h header
- Add compatible to partitions.yaml
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
 .../bindings/mtd/partitions/partitions.yaml   |  1 +
 .../devicetree/bindings/nvme/nvme-card.yaml   | 78 ++++++++++++++++++
 drivers/mtd/devices/block2mtd.c               | 12 +++
 drivers/mtd/parsers/Kconfig                   | 10 +++
 drivers/mtd/parsers/Makefile                  |  1 +
 drivers/mtd/parsers/ofpart_airoha.c           | 57 +++++++++++++
 drivers/mtd/parsers/ofpart_airoha.h           | 18 +++++
 drivers/mtd/parsers/ofpart_core.c             |  6 ++
 drivers/nvme/host/core.c                      |  4 +
 11 files changed, 307 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.yaml
 create mode 100644 Documentation/devicetree/bindings/nvme/nvme-card.yaml
 create mode 100644 drivers/mtd/parsers/ofpart_airoha.c
 create mode 100644 drivers/mtd/parsers/ofpart_airoha.h

-- 
2.45.2

