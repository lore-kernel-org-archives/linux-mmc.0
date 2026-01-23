Received: from mail-m4921.qiye.163.com (mail-m4921.qiye.163.com [45.254.49.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFA221ABBB;
	Fri, 23 Jan 2026 10:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769164167; cv=none; b=K6mDnlqKSJcc8KMt8VbLh5xHfuFaaVFoz0kK3geD04/Fkt2kNuQH8GpD9Sd28oauIDD5ts0v0FPcrpOT7gWIcYCooXrMkuxaA20ZlLHnoNAy48RRXG7ZuSezKEpnec7W74TCHD9/l+8D4zZ4dkQuihsOd+Vpg2+hlYRNxLykhbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769164167; c=relaxed/simple;
	bh=tpeh31nmEUxZ3JAN+LltrnTkA8QXHD2f31rI6Qz/9Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PnUg3pBXw4zd27aixQo4mvFKM1QXxYbGIdAP2j4qpC5Jge/MJ8/JbgAIJ2N25sc0sm3tsl0vtFXeYfU4m4HZYHDNOX9IC30XHxu5EVaIDRjGkUZPnqdaWCaknQCvz1Kg/uKX9O/jgII4+WkQNilKIvxmtNY8lZD6k6DE4kndw/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=FEab32P+; arc=none smtp.client-ip=45.254.49.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="FEab32P+"
Received: from albert-OptiPlex-7080.. (unknown [112.65.126.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 31bc9a75e;
	Fri, 23 Jan 2026 17:53:50 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ge Gordon <gordon.ge@bst.ai>,
	Arnd Bergmann <arnd@arndb.de>
Cc: BST Linux Kernel Upstream Group <bst-upstream@bstai.top>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Albert Yang <yangzh0906@thundersoft.com>
Subject: [PATCH v5 0/6] mmc: add support for BST C1200 SDHCI controller
Date: Fri, 23 Jan 2026 17:53:36 +0800
Message-ID: <20260123095342.272505-1-yangzh0906@thundersoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bea463c2709cckunm2b675df11c3d86
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSEpCVhhMGhpNShhPQh1OT1YVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSklVTU5VSklNVUpNSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0
	tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=FEab32P+zcZXZFCMSdiOH2kEhavXVqtATqWfMdbsLa6WtU+tCRK7IPsRE4ZRAPHVYjRt6HVq0//JaBoziCAsfatIhgmD+UOPKYxxOhpXa4fjRDpD5d7VeTlh2EeAn4etETjKyxTjktIqdl373jo1nWddkLB/v+culGDEinl2SCw=; c=relaxed/relaxed; s=default; d=thundersoft.com; v=1;
	bh=R2dnjTDdAxtFe1SNVIGyD//Zr6oIkw6elS/2GxgPMzM=;
	h=date:mime-version:subject:message-id:from;

This series adds MMC/eMMC controller support for Black Sesame Technologies
C1200 SoC. BST is a leading automotive-grade computing SoC provider focusing
on intelligent driving, computer vision, and AI capabilities for ADAS and
autonomous driving applications. More information: https://bst.ai

== Background ==

This is the MMC portion split from the original v4 series [1] following
feedback from Arnd Bergmann [2]. The platform support (vendor-prefix,
SoC bindings, Kconfig ARCH_BST, base DTS, defconfig ARCH_BST) has already
been merged into Linux 6.19 through the SoC tree [3].

== Series Overview ==

Patch 1: dt-bindings: mmc: add binding for BST DWCMSHC SDHCI controller
Patch 2: mmc: sdhci: allow drivers to pre-allocate bounce buffer
Patch 3: mmc: sdhci: add Black Sesame Technologies BST C1200 controller driver
Patch 4: arm64: dts: bst: enable eMMC controller in C1200 CDCU1.0 board
Patch 5: arm64: defconfig: enable BST SDHCI controller
Patch 6: MAINTAINERS: add MMC files to BST entry

== Testing ==

  - checkpatch.pl: PASS (all patches)
  - dt_binding_check: PASS
  - dtbs_check (CHECK_DTBS=y): PASS
  - Build tested with ARCH=arm64 defconfig

== Changes since v4 ==

  - Split: Platform patches merged separately via SoC tree; this series is
    MMC-only, submitted to MMC maintainers

  DT binding (patch 1):
  - Rename file from bst,dwcmshc-sdhci.yaml to bst,c1200-sdhci.yaml
  - Fix example compatible string to match property definition

  Driver (patch 3):
  - Fix compatible string to match dt-bindings (bst,c1200-sdhci)
  - Simplify clock divider calculation with clearer frequency range logic
  - Add linux/bits.h and linux/bitfield.h headers
  - Remove unused linux/ioport.h header
  - Rename SDHCI_TUNING_COUNT to BST_TUNING_COUNT
  - Rename BST_EMMC_CTRL_BIT2 to BST_EMMC_CTRL_RST_N
  - Fix BST_DEFAULT_MAX_FREQ from 2MHz to 200MHz
  - Convert kernel-doc to regular comments (per Adrian Hunter)
  - Add sdhci_bst_free_bounce_buffer() helper (per Adrian Hunter)


== References ==

[1] v4: https://lore.kernel.org/lkml/20250923-v4-patch-final-v1-0-2283ad7cbf88@thundersoft.com/
[2] Split: https://lore.kernel.org/lkml/09b1318e-21dc-4354-8733-866b70696295@app.fastmail.com/
[3] Merged via soc-newsoc-6.19

Albert Yang (6):
  dt-bindings: mmc: add binding for BST DWCMSHC SDHCI controller
  mmc: sdhci: allow drivers to pre-allocate bounce buffer
  mmc: sdhci: add Black Sesame Technologies BST C1200 controller driver
  arm64: dts: bst: enable eMMC controller in C1200 CDCU1.0 board
  arm64: defconfig: enable BST SDHCI controller
  MAINTAINERS: add MMC files to BST entry

 .../bindings/mmc/bst,c1200-sdhci.yaml         |  70 +++
 MAINTAINERS                                   |   2 +
 .../dts/bst/bstc1200-cdcu1.0-adas_4c2g.dts    |  19 +
 arch/arm64/boot/dts/bst/bstc1200.dtsi         |  18 +
 arch/arm64/configs/defconfig                  |   1 +
 drivers/mmc/host/Kconfig                      |  14 +
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/sdhci-of-bst.c               | 521 ++++++++++++++++++
 drivers/mmc/host/sdhci.c                      |   7 +
 9 files changed, 653 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/bst,c1200-sdhci.yaml
 create mode 100644 drivers/mmc/host/sdhci-of-bst.c

base-commit: 0f61b1860cc3f52aef9036d7235ed1f017632193
-- 
2.43.0

