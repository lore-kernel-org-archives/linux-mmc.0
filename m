Received: from mail-m49206.qiye.163.com (mail-m49206.qiye.163.com [45.254.49.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2203261B83;
	Tue, 23 Sep 2025 06:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758608144; cv=none; b=NWRbxKks8E18z8oLbA944y9eN/1ziIXZ+joj8yRSrbJOTG5stn6LaIxm0emB2WG2623NSJaT6DgBf3KI7jsYfUfMiWp1LQJsCd/w5xtgiKtC+IW47+GQstMvuLVx6w+2Y5dr8WiQTq8K1oNbyEun7O/n9Q/Tgo9PWYiMJzRpke8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758608144; c=relaxed/simple;
	bh=mSj2WCLDiPXpaIZH40IfbgFImD3OHx7gQZfx8yjYYTw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sApSWtBQzriEUrAjSq1fS9DrGZ8E3l4F1wk0n0Z79QKUmaDXnkF6nJtTMUCMYehnDc9s5v3p2sjf3yXg0ocdLthChNQTAlku1JEXsouHghqJwRrcodSdc/AAzScRheu9twWAeshvDpXdpZa+yKPkwD0poMB8ryoPZKjv1z34QR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=SYy6zj8r; arc=none smtp.client-ip=45.254.49.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="SYy6zj8r"
Received: from [127.0.1.1] (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 23bdebfbe;
	Tue, 23 Sep 2025 14:10:28 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
Subject: [PATCH 0/9] arm64: introduce Black Sesame Technologies C1200 SoC
 and CDCU1.0 board
Date: Tue, 23 Sep 2025 14:10:06 +0800
Message-Id: <20250923-v4-patch-final-v1-0-2283ad7cbf88@thundersoft.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL450mgC/x2MQQqAIBAAvxJ7bqGspPpKdBBdayEsNCQI/97Sc
 RhmXkgUmRLM1QuRMic+g0BbV2B3EzZCdsKgGjU0k+ow93iZ2+7oOZgDnbVO+9FrkSDRFcnz8w+
 XtZQPscQLrWAAAAA=
X-Change-ID: 20250923-v4-patch-final-dccd6f8f6092
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ge Gordon <gordon.ge@bst.ai>, 
 BST Linux Kernel Upstream Group <bst-upstream@bstai.top>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, Arnd Bergmann <arnd@arndb.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, 
 soc@lists.linux.dev, Albert Yang <yangzh0906@thundersoft.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758607828; l=9111;
 i=yangzh0906@thundersoft.com; s=20250814; h=from:subject:message-id;
 bh=mSj2WCLDiPXpaIZH40IfbgFImD3OHx7gQZfx8yjYYTw=;
 b=QbXwM+/QkULWaoRTEjiB2SFAGGHhK05AV3eE3cGqksU3ZIe4ntfM4DdPuXzaJW8BACGb3ukGc
 P5MrBqyrPTvAB72VmgNllpXXNvPCtoF7Ba9EVGP2qgandpHXzRVVG8B
X-Developer-Key: i=yangzh0906@thundersoft.com; a=ed25519;
 pk=bEcgALL9KpUg/m7zH44r50xa/re91dI9SA0vGV1/bu4=
X-HM-Tid: 0a997531e40109cckunmfc27e25b4e01c3
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGk5OVk5DT01CSxpNQklOT1YVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSk
	tLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=SYy6zj8rca17RJOuW4vA+kX7iL6G8V4+OykeS8g+1iGIr8L0Gb/pxUocTz7WbpgU0MMbKV1iP+BmsHA5KyJO38OiHw4f0NE5JOyi3q4ThCDYb3vczxy0blNJcer66lPvZDdmf+5wGjPm1wXHn/ljsXgKWYo/udEdBafGO9qVKnc=; c=relaxed/relaxed; s=default; d=thundersoft.com; v=1;
	bh=e7JXaXPfRHuobwQOQcVJlT2z1Yhiyju5p3cQ3WcHFhM=;
	h=date:mime-version:subject:message-id:from;

This patch series introduces comprehensive support for Black Sesame Technologies
(BST) C1200 SoC and CDCU1.0 ADAS 4C2G board. BST is a leading automotive-grade
computing SoC provider focusing on intelligent driving, computer vision, and AI
capabilities for ADAS and autonomous driving applications. You can find more information
about the SoC and related boards at: https://bst.ai

The series includes complete platform enablement from device tree bindings to
drivers and board-level support:

Patch 1: dt-bindings: vendor-prefixes: Add Black Sesame Technologies Co., Ltd.
- Adds BST vendor prefix to device tree vendor prefixes
- Provides company information and website link

Patch 2: dt-bindings: arm: add Black Sesame Technologies (bst) SoC
- Adds device tree bindings for BST ARM SoC family
- Defines compatible strings for C1200 SoC and CDCU1.0 board

Patch 3: arm64: Kconfig: add ARCH_BST for Black Sesame Technologies SoCs
- Adds ARCH_BST configuration option for BST SoC family
- Enables platform-specific features and driver dependencies

Patch 4: dt-bindings: mmc: add binding for BST DWCMSHC SDHCI controller
- Adds device tree binding for BST's DWCMSHC SDHCI controller
- Defines register layout, clocks, and controller-specific properties

Patch 5: mmc: sdhci: add Black Sesame Technologies BST C1200 controller driver
- Comprehensive SDHCI driver for BST C1200 SoC
- Addresses specific hardware constraints with 32-bit DMA limitations
- Implements custom clock management, power management, and tuning
- Uses SRAM-based bounce buffer for DMA operations

Patch 6: mmc: sdhci: allow drivers to pre-allocate bounce buffer
- SDHCI core enhancement to support driver-allocated bounce buffers
- Enables platforms with specific DMA constraints to pre-allocate buffers
- Suggested by Adrian Hunter for better platform integration

Patch 7: arm64: dts: bst: add support for Black Sesame Technologies C1200 CDCU1.0 board
- Complete device tree support for BST C1200 CDCU1.0 ADAS 4C2G board
- Includes SoC dtsi and board-specific dts files
- Defines CPU, memory, peripherals, and platform-specific configurations

Patch 8: arm64: defconfig: enable BST platform and SDHCI controller support
- Enables ARCH_BST and MMC_SDHCI_BST in ARM64 defconfig
- Provides out-of-box support for BST platforms

Patch 9: MAINTAINERS: add Black Sesame Technologies (BST) ARM SoC support
- Adds maintainer entry for BST ARM SoC support
- Covers device tree bindings, drivers, and board files

Changes for v4:
- rebase to 6.17-rc5
- Patch 1 (dt-bindings: vendor-prefixes):
	- Adjust ^bst to the correct alphabetical order
	- Adjust Acked-by order
- Patch 2 (dt-bindings: arm):
	- Remove Signed-off-by: Ge Gordon
	- Add Reviewed-by Krzysztof Kozlowski info
- Patch 3 (arm64: Kconfig):
	- Remove Signed-off-by: Ge Gordon
- Patch 4 (dt-bindings: mmc):
	- Remove Signed-off-by line for Ge Gordon
	- Change `$ref: mmc-controller.yaml#` to `$ref: sdhci-common.yaml#`
	- Change compatible string from `bst,c1200-dwcmshc-sdhci` to `bst,c1200-sdhci`
- Patch 5 (mmc: sdhci driver):
	- Rename all functions from bst_* to sdhci_bst_* for better namespace consistency
	- Rename driver file from sdhci-of-bst-c1200.c to sdhci-of-bst.c
	- Rename dwcmshc_priv structure to sdhci_bst_priv for clarity
	- Update driver name from "sdhci-dwcmshc" to "sdhci-bst" throughout
	- Add comprehensive register bit mask definitions and named constants
	- Replace manual polling loops with read_poll_timeout() for clock stability
	- Add dedicated sdhci_bst_wait_int_clk() function for internal clock management
	- Completely rewrite power management with proper power-off handling
	- Enhance clock control with read-modify-write operations to avoid clobbering
	- Add MBIU burst mode configuration based on power state
	- Improve error handling and cleanup in probe/remove functions
	- Simplify bounce buffer allocation and remove redundant MMC parameter adjustments
	- Add SDHCI_QUIRK_BROKEN_ADMA quirk for hardware limitation
	- Replace ioread32/iowrite32 with readl/writel for consistency
	- Update copyright year and simplify license text
	- Improve tuning algorithm with clearer variable naming
	- Enhance register access patterns with proper bit field manipulation
	- Add power-off clock management to reduce idle power consumption
	- Add Acked-by: Arnd Bergmann
- Patch 6 (mmc: sdhci bounce buffer):
	- Add new patch by suggestion from Adrian Hunter
- Patch 7 (arm64: dts):
	- Remove Signed-off-by line for Ge Gordon
	- Reorder device tree node properties for better consistency
	- CPU nodes: move `device_type` before `compatible`, add explicit `reg` values
	- MMC node: change compatible from `bst,c1200-dwcmshc-sdhci` to `bst,c1200-sdhci`
	- MMC node: remove `bus-width` and `non-removable` from SoC dtsi, move to board dts
	- SoC node: reorder properties (`ranges` before address/size cells)
	- UART node: reorder properties (clock-frequency before interrupts)
	- GIC node: reorder properties for better readability
	- Timer node: reorder properties (always-on before interrupt-parent)
	- Board DTS: add `bus-width = <8>` and `non-removable` to MMC node
	- Board DTS: reorder MMC and UART node references
- Patch 8 (arm64: defconfig):
	- move CONFIG_MMC_SDHCI_BST before CONFIG_MMC_SDHCI_F_SDH30
	- Remove Signed-off-by line for Ge Gordon
	- Simplify commit message (remove detailed description about eMMC/SD functionality)
- Patch 9 (MAINTAINERS):
	- Changed file name: sdhci-of-bst-c1200.c to sdhci-of-bst.c
	- Change title from "add and consolidate" to just "add"
	- Simplify commit message description
	- Remove Signed-off-by line for Ge Gordon

Changes for v3:
- Patch 2: Add Signed-off-by: Ge Gordon
- Patch 3: Reword subject from "for bst silicons" to "for Black Sesame Technologies SoCs"
	and drop unrelated whitespace hunk
- Patch 4: Switch reg schema from maxItems to explicit items with per-entry descriptions,
	improve example with irq.h include and bus node wrapper, add Signed-off-by: Ge Gordon
- Patch 5: Simplify dwcmshc_priv structure, improve helper functions, use
	devm_platform_ioremap_resource(), clarify hardware limitations documentation
- Patch 6: Split defconfig enablement out into dedicated patch, refine memory description,
	adjust node ordering, remove gic mask
- Patch 7: Also enable CONFIG_ARCH_BST in arm64 defconfig

Changes for v2:
- Patch 2: Remove unnecessary pipe in description, drop invalid compatible entry,
	remove root node definition
- Patch 3: Place configuration entry in correct alphabetical order, use generic family name,
	follow upstream naming conventions
- Patch 4: Simplify description, update $schema reference, correct compatible string,
	remove redundant properties, clean up required properties, standardize example format
- Patch 5: Remove COMMON_CLK dependency, add ARCH_BST || COMPILE_TEST dependency,
	replace temporary ioremap with persistent mapping, refactor bounce buffer allocation,
	prune unused headers, fix register access macros, improve error handling
- Patch 6: Reorganize memory map, update MMC controller definition, remove deprecated
	properties, standardize interrupt definitions, add root compatible string

Signed-off-by: Albert Yang <yangzh0906@thundersoft.com>
---
Albert Yang (9):
      dt-bindings: vendor-prefixes: Add Black Sesame Technologies Co., Ltd.
      dt-bindings: arm: add Black Sesame Technologies (bst) SoC
      arm64: Kconfig: add ARCH_BST for Black Sesame Technologies SoCs
      dt-bindings: mmc: add binding for BST DWCMSHC SDHCI controller
      mmc: sdhci: add Black Sesame Technologies BST C1200 controller driver
      mmc: sdhci: allow drivers to pre-allocate bounce buffer
      arm64: dts: bst: add support for Black Sesame Technologies C1200 CDCU1.0 board
      arm64: defconfig: enable BST platform and SDHCI controller support
      MAINTAINERS: add Black Sesame Technologies (BST) ARM SoC support

 Documentation/devicetree/bindings/arm/bst.yaml     |  31 ++
 .../devicetree/bindings/mmc/bst,dwcmshc-sdhci.yaml |  70 +++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 MAINTAINERS                                        |  10 +
 arch/arm64/Kconfig.platforms                       |   8 +
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/bst/Makefile                   |   2 +
 .../boot/dts/bst/bstc1200-cdcu1.0-adas_4c2g.dts    |  43 ++
 arch/arm64/boot/dts/bst/bstc1200.dtsi              | 115 +++++
 arch/arm64/configs/defconfig                       |   2 +
 drivers/mmc/host/Kconfig                           |  14 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/sdhci-of-bst.c                    | 544 +++++++++++++++++++++
 drivers/mmc/host/sdhci.c                           |   7 +
 14 files changed, 850 insertions(+)
---
base-commit: 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c
change-id: 20250923-v4-patch-final-dccd6f8f6092

Best regards,
-- 
Albert Yang <yangzh0906@thundersoft.com>

