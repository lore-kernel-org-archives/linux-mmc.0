Received: from mail-m1973178.qiye.163.com (mail-m1973178.qiye.163.com [220.197.31.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AFA243399;
	Tue, 12 Aug 2025 13:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755004016; cv=none; b=KLp2VNakzpTA/P57unQzRSbueenMSNYmWVC77VLZbb4YPG4+zDww/MCisiwEDuarH+wSYzk8fiyEhSLyw8dnD3QpQ1zBmgtpEmY83UpZVaJIuNMpKjasJmV2U8AcVuVAzv8mnGRKysRnqhBZSpDm4vT6lgp5tqigs1+kx0N8bqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755004016; c=relaxed/simple;
	bh=DEWudkDs7Iyzzd5CQSSDdcSBulpghXtyEw5QR46nGWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YtRQHDWXmUK21IUlStq2maALCjE+MPjR6xGeXeovlEHkgG7valGe68HKy1zGvXcBiCdd35HYU4ZqWX37k2tzELh4xYq5TD0tQm49qM7bWlsIX1HSJzO9+ofrTHUQ+ExHTFLfLFMILzcVBoWAubDra9GaVXLEaOXvLew9cHW7AUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=WXExFBYP; arc=none smtp.client-ip=220.197.31.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="WXExFBYP"
Received: from albert-OptiPlex-7080.. (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1f211b6c3;
	Tue, 12 Aug 2025 20:31:20 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
To: krzk@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulf.hansson@linaro.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	arnd@arndb.de,
	adrian.hunter@intel.com,
	robin.murphy@arm.com,
	ding.wang@bst.ai,
	gordon.ge@bst.ai
Cc: bst-upstream@bstai.top,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	soc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Albert Yang <yangzh0906@thundersoft.com>
Subject: [PATCH v3 0/8] Introduce Black Sesame Technologies C1200 SoC and CDCU1.0 board
Date: Tue, 12 Aug 2025 20:31:02 +0800
Message-ID: <20250812123110.2090460-1-yangzh0906@thundersoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a989e43800c09cckunm52c5de628442aa
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTRkdVh5JQ0wZHkwYSEJCHVYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSk
	tLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=WXExFBYPk7NKVCNi2iseFIS/kU7WjgjUjApwXGxesJJs2m1qId4UbKBMeXv4EJTEIwr8zJ3zWDNVLxV9+S89czj464yRo7yefaCp4S7TusIDXUSyHkGAQcvBU/OPnvt4THiy/p6Kof7yASa1hucucobYx4IWP4MStNT1XAyV03U=; s=default; c=relaxed/relaxed; d=thundersoft.com; v=1;
	bh=jeUxTQ9kPol+qucz8lWjIE1iNI3a/p05jPfDCS+yCg4=;
	h=date:mime-version:subject:message-id:from;

Black Sesame Technologies C1200 is a high-performance Armv8 SoC designed for automotive
and industrial applications. The CDCU1.0 (Central Domain Control Unit) board is the
development platform built by Black Sesame Technologies. You can find more information
about the SoC and related boards at:
https://bst.ai

Currently, to run the upstream kernel on the CDCU1.0 board, you need to use the
bootloader provided by Black Sesame Technologies. The board supports various
interfaces including MMC/SD card, which is implemented using the BST C1200 DWCMSHC
SDHCI controller.

In this series, we add initial SoC and board support for kernel building. The series
includes:

Patch 1: Add Black Sesame Technologies vendor prefix in vendor-prefixes.yaml
- Adds "bst" vendor prefix for Black Sesame Technologies Co., Ltd.
- Required for device tree bindings to properly identify BST hardware

Patch 2: Add device tree bindings for BST SoC platforms
- Creates new binding file Documentation/devicetree/bindings/arm/bst.yaml
- Defines compatible strings for BST C1200 family and C1200 CDCU1.0 board
- Documents BST's focus on automotive-grade SoCs for ADAS applications

Patch 3: Add ARCH_BST configuration for BST silicon support
- Adds Kconfig option for BST architecture support
- Enables building kernel for BST platforms

Patch 4: Add device tree binding for BST DWCMSHC SDHCI controller
- Documents the BST C1200 SDHCI controller binding
- Required for MMC/SD card support on BST platforms

Patch 5: Add BST C1200 SDHCI controller driver
- Implements the MMC host controller driver for BST C1200
- Enables SD card support on BST platforms

Patch 6: Add device tree support for BST C1200 CDCU1.0 board
- Adds device tree source files for C1200 SoC and CDCU1.0 board
- Configures hardware components including MMC controller

Patch 7: Enable BST Soc And C1200 DWCMSHC controller in defconfig
- Enables MMC controller driver in default arm64 config

Patch 8: Update MAINTAINERS for BST support
- Adds maintainer information for BST ARM SoC support
- Consolidates BST-related entries

Changes for v3:
- Patch 1:
  - No changes
- Patch 2:
  - Add Signed-off-by: Ge Gordon
- Patch 3:
  - Reword subject from "for bst silicons" to "for Black Sesame Technologies SoCs"
  - drop unrelated whitespace hunk
- Patch 4:
  - Switch reg schema from maxItems to explicit items with per-entry descriptions
  - Improve example: add irq.h include and wrap under a bus node with address/size cells
  - Drop status = "disabled" from example; keep example concise
  - Add Signed-off-by: Ge Gordon
- Patch 5:
  - Code improvements based on review feedback:
    - Simplified dwcmshc_priv structure by removing unused fields
    - Improved helper functions with better encapsulation
    - Used devm_platform_ioremap_resource() for resource management
    - Updated Kconfig description and alphabetical ordering
    - clarify documentation on hardware limitations and bounce buffer approach
    - remove duplicate sdhci_writew SDHCI_CLOCK_CONTROL
- Patch 6:
  - Split defconfig enablement out into a dedicated defconfig patch
  - Refine memory description: consolidate ranges in memory node and delele unused memory ranges
  - Adjust the order of nodes
  - remove mask of gic
- Patch 7:
  - Also enable CONFIG_ARCH_BST in arm64 defconfig (in addition to CONFIG_MMC_SDHCI_BST)
- Patch 8:
  - No changes

Changes for v2:
- Pass dts build check and mmc driver build check with below commands:
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- O=build_dir CHECK_DTBS=y bst/bstc1200-cdcu1.0-adas_4c2g.dtb W=1
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- drivers/mmc/host/ W=1 O=build_dir
- Patch 2: 
  1. Removed unnecessary pipe (`|`) in description
  2. Dropped invalid `compatible` entry for standalone SoC
  3. Removed root node (`$nodename: '/'`) definition
- Patch 3:
  1. Placed the configuration entry in correct alphabetical order
  2. Used generic family name (ARCH_BST) instead of SoC-specific naming
  3. Followed upstream kernel naming and description conventions
- Patch 4:
  1. Simplified description, removed redundant paragraphs
  2. Updated $schema to reference mmc-specific scheme
  3. Corrected compatible to add soc name
     (bst,c1200-dwcmshc-sdhci)
  4. Removed all redundant property descriptions
  5. Dropped invalid mmc_crm_base/size properties, use reg for all address
     ranges
  6. Cleaned up required properties to only essential entries
  7. Standardized example DTS format, fixed reg syntax and property
     ordering
  8. Removed additionalProperties: true
- Patch 5:
  1. Dependency Simplification:
     - Removed COMMON_CLK dependency from Kconfig (MMC_SDHCI_BST)
     - Add ARCH_BST || COMPILE_TES dependency from Kconfig (MMC_SDHCI_BST)

  2. Resource Management Improvements:
     - Replaced temporary ioremap with persistent mapping
       * Mapped CRM registers once during probe instead of per-access
       * Added proper cleanup in remove callback
     - Refactored bounce buffer allocation:
       * Simplified error handling and memory management
       * Removed unnecessary DMA configuration layers

  3. Code Cleanup & Optimization:
     - Pruned unused headers and legacy vendor debug code
     - Removed deprecated sdhci_bst_print_vendor() export
     - Converted internal functions to static scope
     - Standardized naming conventions:
       * Renamed DRIVER_NAME to match kernel standards
       * Changed default_max_freq to DEFAULT_MAX_FREQ
     - Optimized clock configuration routines

  4. Hardware Integration Fixes:
     - Fixed register access macros for EMMC_CTRL
       * Added proper offset calculation via SDHCI_VENDOR_PTR_R
     - Corrected device tree compatibility string to:
       "bst,c1200-dwcmshc-sdhci"

  5. Error Handling Enhancements:
     - Added robust ioremap error checking
     - Improved bounce buffer allocation failure handling
     - Streamlined probe/remove flow

  6. Maintainability:
     - Updated MODULE_DESCRIPTION and AUTHOR fields
     - Added explanatory comments for hardware limitations
     - Removed redundant multi-host setup infrastructure
  7. fix build warnings from lkp
    | Reported-by: kernel test robot <lkp@intel.com>
    | Closes:
    https://lore.kernel.org/oe-kbuild-all/202505290615.GZzN5rNL-lkp@intel.com/

- Patch 6:
  1. Reorganized memory map into discrete regions
  2. Updated MMC controller definition:
     - Split into core/CRM register regions
     - Removed deprecated properties
     - Updated compatible string
  3. Standardized interrupt definitions and numeric formats
  4. Removed reserved-memory node (superseded by bounce buffers)
  5. Added root compatible string for platform identification
  6. Add soc defconfig

Albert Yang (8):
  dt-bindings: vendor-prefixes: Add Black Sesame Technologies Co., Ltd.
  dt-bindings: arm: add Black Sesame Technologies (bst) SoC
  arm64: Kconfig: add ARCH_BST for Black Sesame Technologies SoCs
  dt-bindings: mmc: add binding for BST DWCMSHC SDHCI controller
  mmc: sdhci: add Black Sesame Technologies BST C1200 controller driver
  arm64: dts: bst: add support for Black Sesame Technologies C1200
    CDCU1.0 board
  arm64: defconfig: enable BST platform and SDHCI controller support
  MAINTAINERS: add and consolidate Black Sesame Technologies (BST) ARM
    SoC support

 .../devicetree/bindings/arm/bst.yaml          |  31 ++
 .../bindings/mmc/bst,dwcmshc-sdhci.yaml       |  70 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |  10 +
 arch/arm64/Kconfig.platforms                  |   8 +
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/bst/Makefile              |   2 +
 .../dts/bst/bstc1200-cdcu1.0-adas_4c2g.dts    |  42 ++
 arch/arm64/boot/dts/bst/bstc1200.dtsi         | 117 ++++
 arch/arm64/configs/defconfig                  |   2 +
 drivers/mmc/host/Kconfig                      |  14 +
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/sdhci-of-bst-c1200.c         | 510 ++++++++++++++++++
 13 files changed, 810 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bst.yaml
 create mode 100644 Documentation/devicetree/bindings/mmc/bst,dwcmshc-sdhci.yaml
 create mode 100644 arch/arm64/boot/dts/bst/Makefile
 create mode 100644 arch/arm64/boot/dts/bst/bstc1200-cdcu1.0-adas_4c2g.dts
 create mode 100644 arch/arm64/boot/dts/bst/bstc1200.dtsi
 create mode 100644 drivers/mmc/host/sdhci-of-bst-c1200.c

-- 
2.43.0

