Received: from mail-m49207.qiye.163.com (mail-m49207.qiye.163.com [45.254.49.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E501C862E;
	Wed,  2 Jul 2025 09:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751449903; cv=none; b=o3Ubg2VlQNfkN1ZROPX3c522m/WSYQcvUu3YoEaDwViO7pqpT3MZZQ1O1aB5WIQJ+SgXg9OLE0uw3Bcc7iR05U98N6mi+umJHmJ0J85I0HbFsMYXVvtBQufwP0mzlFMLEL5/xWPh3zur2DUVlqQxfs9dOwT6AaW6jQ6R4uJryxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751449903; c=relaxed/simple;
	bh=DQ4Fbet7w98kyyULmyFDZuR7DJV+8egvEdngnk+ZEec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rzkOqpANw4iwk402RBPhnhnsJo4CPFaHJNo4LHuzsYOc0MtG6rU/Fk6yAAY2Jz2/sHiYI50vOpe6Y2uh8bHb/2x4Y/toC+7ioiwcy1cZzF/XZEKRiVGGFLO6WYIdCSl99MhKYSrJMCiHNtG1ojD9tKd0PYB/KSyjdJlLyZ8lkK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=iHKKT1GP; arc=none smtp.client-ip=45.254.49.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="iHKKT1GP"
Received: from localhost.localdomain (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1aaa9ed20;
	Wed, 2 Jul 2025 17:46:26 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	krzk@kernel.org,
	conor+dt@kernel.org,
	gordon.ge@bst.ai,
	catalin.marinas@arm.com,
	geert.uytterhoeven@gmail.com,
	will@kernel.org,
	ulf.hansson@linaro.org,
	adrian.hunter@intel.com,
	arnd@arndb.de
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	soc@lists.linux.dev,
	bst-upstream@bstai.top,
	neil.armstrong@linaro.org,
	jonathan.cameron@huawei.com,
	bigfoot@classfun.cn,
	kever.yang@rock-chips.com,
	mani@kernel.org,
	geert+renesas@glider.be,
	andersson@kernel.org,
	nm@ti.com,
	nfraprado@collabora.com,
	quic_tdas@quicinc.com,
	ebiggers@google.com,
	victor.shih@genesyslogic.com.tw,
	shanchun1218@gmail.com,
	ben.chuang@genesyslogic.com.tw,
	Albert Yang <yangzh0906@thundersoft.com>
Subject: [PATCH v2 0/8] arm64: Introduce Black Sesame Technologies C1200 SoC and CDCU1.0 board
Date: Wed,  2 Jul 2025 17:44:36 +0800
Message-Id: <20250702094444.3523973-1-yangzh0906@thundersoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250528085403.481055-1-yangzh0906@thundersoft.com>
References: <20250528085403.481055-1-yangzh0906@thundersoft.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTkhOVksZT0pMGUxKGEgZGFYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ01VSk
	tLVUtZBg++
X-HM-Tid: 0a97ca87cb5509cckunmee1cabff3eba3f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ky46Nio4ODE1OE8VDRkCHQIU
	ChYaFElVSlVKTE5KT09CTkNDQ05CVTMWGhIXVQIaFRwBE0tCS007DxMOFR8eCQgUHQ9VGBQWRVlX
	WRILWUFZSkpMVUpDT1VKSUJVSkhPWVdZCAFZQUNDS083Bg++
DKIM-Signature:a=rsa-sha256;
	b=iHKKT1GP4KttxGichlFKsKKQUX3VlHslxuzfV2b0Stiu7ntwzMlWnzOP5cW8eu8zAHtbo7WhfUtplVfy3Ar52X6zXBBqL5ej3hFi4IvUJu/mRP1HdfO9T9mXowEwW31TrRxMmnZRSLTPL+g+C3vLctZ01FVkgCPt2JFwjf0vebQ=; c=relaxed/relaxed; s=default; d=thundersoft.com; v=1;
	bh=0IAmHcK+vzj2JRzJWMHVRyNXmp3uUsUGFRVCGAFIqUw=;
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

Patch 7: Enable BST SoC in arm64 defconfig
- Adds ARCH_BST configuration to default arm64 config

Patch 8: Enable BST C1200 DWCMSHC controller in defconfig
- Enables MMC controller driver in default arm64 config

Patch 9: Update MAINTAINERS for BST support
- Adds maintainer information for BST ARM SoC support
- Consolidates BST-related entries

Changes for v2:
- Pass dts build check and mmc driver build check with below commands:
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- O=build_dir CHECK_DTBS=y bst/bstc1200-cdcu1.0-adas_4c2g.dtb W=1
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- drivers/mmc/host/ W=1 O=build_dir
- Patch 2: 
  1. Removed unnecessary pipe (`|`) in description
  2. Dropped invalid `compatible` entry for standalone SoC
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
  arm64: Kconfig: add ARCH_BST for bst silicons
  dt-bindings: mmc: add binding for BST DWCMSHC SDHCI controller
  mmc: sdhci: add Black Sesame Technologies BST C1200 controller driver
  arm64: dts: bst: add support for Black Sesame Technologies C1200
    CDCU1.0 board and defconfig
  arm64: defconfig: enable BST C1200 DWCMSHC SDHCI controller
  MAINTAINERS: add and consolidate Black Sesame Technologies (BST) ARM
    SoC support

 .../devicetree/bindings/arm/bst.yaml          |  30 +
 .../bindings/mmc/bst,dwcmshc-sdhci.yaml       |  67 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |  10 +
 arch/arm64/Kconfig.platforms                  |  10 +
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/bst/Makefile              |   2 +
 .../dts/bst/bstc1200-cdcu1.0-adas_4c2g.dts    |  60 ++
 arch/arm64/boot/dts/bst/bstc1200.dtsi         | 117 ++++
 arch/arm64/configs/defconfig                  |   2 +
 drivers/mmc/host/Kconfig                      |  11 +
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/sdhci-of-bst-c1200.c         | 557 ++++++++++++++++++
 13 files changed, 870 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bst.yaml
 create mode 100644 Documentation/devicetree/bindings/mmc/bst,dwcmshc-sdhci.yaml
 create mode 100644 arch/arm64/boot/dts/bst/Makefile
 create mode 100644 arch/arm64/boot/dts/bst/bstc1200-cdcu1.0-adas_4c2g.dts
 create mode 100644 arch/arm64/boot/dts/bst/bstc1200.dtsi
 create mode 100644 drivers/mmc/host/sdhci-of-bst-c1200.c

-- 
2.25.1

