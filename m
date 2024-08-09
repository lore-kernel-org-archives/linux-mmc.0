Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8CE2232A;
	Fri,  9 Aug 2024 23:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723244549; cv=none; b=pguIC+TvCxyo76siFP5/+laRfFxc0kBMkWb5AC5u0tNxLy81t7xcir6PWr3RLwoRqans26+WG2aNgEl3+gJuL8073YL+1P/yscPw16VjrQI7A7/S39srWvUjSKEliigT5M2OERYGyXi5zjVQczuRemDX73tMW2bzeHyufCPvuNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723244549; c=relaxed/simple;
	bh=RvTbMp33rkaKJUsrR0AK0iMSWIXeFbpaWs9RMYiB9DQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=F4a2/5ugE+vDfQeAEa4Fkta+1BmTfBfZgT2B8VTM7Ac9ztOGBH8p8PdYrez9OT649+SDXrm+8OSxa2ncVGyJO7mZn6svJasZ5Z6xE8zRZ0yU6laQJ5TZMS+qYHqGfedSm8c1qmqzuZxzfOfoLqL4q2w1bg3PAYuZYgykLYnLWbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7pmf7OV; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7pmf7OV"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-428f5c0833bso20614245e9.0;
        Fri, 09 Aug 2024 16:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723244546; x=1723849346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wODkYjjXLHu7LoIUK6vdyDoix1Qpc0/A1JJtwyuj/Us=;
        b=g7pmf7OV0d7/x7Mii16uOSM2mNL95/3XIXENnFS2duHfR3SMZGkhxuzCICnSjUzXap
         572fNsKiY65wQKAm1asXIBoe3rtQRT3La43MBy9lPbS8x0KJG+PLwCpbHU1IPQuIQEnM
         UWIhTFN8gwvwy9HcgebSioUhKvU7mENogv9xHWs9o2wCOp8xNiwa/cGF0AjY+T5uRB/S
         7pTywvz3rUs9078Oks0tC3inoqyPsaOiBu/WInAcAcjbYdkjyng07gn/DAQOn8dMHjra
         zGGdBspPAKUYD/mNQfY4zYn84pJW44887Vni4mxu5YlUCdD6T2t0Qn81mz0EcJMCoj28
         tUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723244546; x=1723849346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wODkYjjXLHu7LoIUK6vdyDoix1Qpc0/A1JJtwyuj/Us=;
        b=XUkNyH4h0C+hJHa1CgCSM6jp/p6e0bnZX1t/vZxzJvBrZiEcN5ATccBW1XvFKczXgE
         5j+tXTO5gH3BxXu6KFdMJqKQhGsEykNfV0YLGnO7tWokblHUGgYle3whjilL9KOyTpoN
         ezPVM9Xx8iNmZKgncdyONNkj+2+xkXYIbPB7Aet4Q3F+4C8NUIAlV6HY9W1/HkRLzZfh
         W4qBMYeLFfkpyyiJvBSf06OrWKbZw6TeWtp3CWs062EzYCHh93NOGFmxtjyajKYbp5PR
         47Ot+sZkZarIv/GLyrGjXifipXnafnCDYn7PekMxL/qW0G4FRy05mhf4pdAY6cPT/ZM1
         QBHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRG2/7s4y7jUdvQkl+WNeO/aEe0WtYQXOp1NYY4//+OAJK5m0TRDczeFKFCMn1sSv9QoOOVmhgvhI0o9x3sfiHpV7SHyISMpi34uMXOSwwmvqP0yssHtc71NKDdpUIt7V6R7IJBu7wqUrsGMH5AeteXUK0HlO9plMMnHJfSi2Wa8wAHg==
X-Gm-Message-State: AOJu0Yzk2VCkhQAejR5xATvI8cWbRAFGMVpydN5lZvLAGGUb6d0P7jYl
	DrZOmGXV3TiwJUXQm61CF4+l0rcLFoqZKAi+fnx8Fvu53wEVC+mp
X-Google-Smtp-Source: AGHT+IGgtArHY1Ccvu81bZyYnJJ7slG0Epa/7R5YAnQKAsSgIp4DXcbt2NtFFMJrnz0a9ioEQ+VSXg==
X-Received: by 2002:a05:600c:1c92:b0:428:b4a:7001 with SMTP id 5b1f17b1804b1-429c847ffb9mr1527355e9.15.1723244545925;
        Fri, 09 Aug 2024 16:02:25 -0700 (PDT)
Received: from localhost.localdomain (host-87-10-253-138.retail.telecomitalia.it. [87.10.253.138])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-429c75044a8sm7987485e9.9.2024.08.09.16.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 16:02:25 -0700 (PDT)
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
Subject: [PATCH v4 0/7] mtd: improve block2mtd + airoha parser
Date: Fri,  9 Aug 2024 19:20:58 +0200
Message-ID: <20240809172106.25892-1-ansuelsmth@gmail.com>
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

Changes v4:
- Add additional patch for ofpart kmod with of_update_property
  not exported
Changes v3:
- Fix compilation error for missing slab.h header
- Add compatible to partitions.yaml
Changes v2:
- Fix typo in DT patch
- Fix compilation error for non-OF platform
- Fix compilation error due to recent changes in block2mtd module

Christian Marangi (7):
  dt-bindings: nvme: Document nvme-card compatible
  nvme: assign of_node to nvme device
  dt-bindings: mmc: add property for partitions node in mmc-card node
  block2mtd: attach device OF node to MTD device
  of: also export of_update_property
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
 drivers/of/base.c                             |  1 +
 12 files changed, 308 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.yaml
 create mode 100644 Documentation/devicetree/bindings/nvme/nvme-card.yaml
 create mode 100644 drivers/mtd/parsers/ofpart_airoha.c
 create mode 100644 drivers/mtd/parsers/ofpart_airoha.h

-- 
2.45.2

