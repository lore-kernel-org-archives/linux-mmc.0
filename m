From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH v7 0/10] Add external dma support for Synopsys MSHC
Date: Mon, 24 Aug 2015 09:24:39 +0800
Message-ID: <1440379479-24308-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.133]:51732 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753535AbbHXB0A (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 23 Aug 2015 21:26:00 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: jh80.chung@samsung.com, ulf.hansson@linaro.org
Cc: Vineet.Gupta1@synopsys.com, Wei Xu <xuwei5@hisilicon.com>, Joachim Eastwood <manabian@gmail.com>, Alexey Brodkin <abrodkin@synopsys.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Russell King <linux@arm.linux.org.uk>, Zhangfei Gao <zhangfei.gao@linaro.org>, Jun Nie <jun.nie@linaro.org>, Ralf Baechle <ralf@linux-mips.org>, Govindraj Raja <govindraj.raja@imgtec.com>, Arnd Bergmann <arnd@arndb.de>, heiko@sntech.de, dianders@chromium.org, linux-samsung-soc@vger.kernel.org, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shawn Lin <shawn.lin@rock-chips.com>


Synopsys DesignWare mobile storage host controller supports three
types of transfer mode: pio, internal dma and external dma. However,
dw_mmc can only supports pio and internal dma now. Thus some platforms
using dw-mshc integrated with generic dma can't work in dma mode. So we
submit this patch to achieve it.

And the config option, CONFIG_MMC_DW_IDMAC, was added by Will Newton
(commit:f95f3850) for the first version of dw_mmc and never be touched since
then. At that time dt-bindings hadn't been introduced into dw_mmc yet means
we should select CONFIG_MMC_DW_IDMAC to enable internal dma mode at compile
time. Nowadays, device-tree helps us to support a variety of boards with one
kernel. That's why we need to remove it and decide the transfer mode by reading
dw_mmc's HCON reg at runtime.

This RFC patch needs lots of ACKs. I know it's hard, but it does need someone
to make the running.

Patch does the following things:
- remove CONFIG_MMC_DW_IDMAC config option
- add bindings for edmac used by synopsys-dw-mshc
  at runtime
- add edmac support for synopsys-dw-mshc

Patch is based on next of git://git.linaro.org/people/ulf.hansson/mmc

Test emmc throughput on my platform with edmac support and without edmac support(pio only)
iozone -L64 -S32 -azecwI -+n -r4k -r64k -r128k -s1g -i0 -i1 -i2 -f datafile -Rb out.xls > /mnt/result.txt
(light cpu loading, Direct IO, fixed line size, all pattern recycle, 1GB data in total)
 ___________________________________________________________
|                   external dma mode                       |
|-----------------------------------------------------------|
|blksz | Random Read | Random Write | Seq Read   | Seq Write|
|-----------------------------------------------------------|
|4kB   |  13953kB/s  |    8602kB/s  | 13672kB/s  |  9785kB/s|
|-----------------------------------------------------------|
|64kB  |  46058kB/s  |   24794kB/s  | 48058kB/s  | 25418kB/s|
|-----------------------------------------------------------|
|128kB |  57026kB/s  |   35117kB/s  | 57375kB/s  | 35183kB/s|
|-----------------------------------------------------------|
                           VS
 ___________________________________________________________
|                          pio mode                         |
|-----------------------------------------------------------|
|blksz | Random Read  | Random Write | Seq Read  | Seq Write|
|-----------------------------------------------------------|
|4kB   |  11720kB/s   |    8644kB/s  | 11549kB/s |  9624kB/s|
|-----------------------------------------------------------|
|64kB  |  21869kB/s   |   24414kB/s  | 22031kB/s | 27986kB/s|
|-----------------------------------------------------------|
|128kB |  23718kB/s   |   34495kB/s  | 24698kB/s | 34637kB/s|
|-----------------------------------------------------------|


Changes in v7:
- rebased on Ulf's next
- combine condition state
- elaborate more about DMA_INTERFACE
- define some macro for DMA_INERFACE value
- spilt HCON ops' changes into another patch

Changes in v6:
- add trans_mode condition for IDMAC initialization
  suggested by Heiko
- re-test my patch on rk3188 platform and update commit msg
- update performance of pio vs edmac in cover letter

Changes in v5:
- add the title of cover letter
- fix typo of comment
- add macro for reading HCON register
- add "Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>" for exynos_defconfig patch
- add "Acked-by: Vineet Gupta <vgupta@synopsys.com>" for axs10x_defconfig patch
- add "Acked-by: Govindraj Raja <govindraj.raja@imgtec.com>" and
  "Acked-by: Ralf Baechle <ralf@linux-mips.org>" for pistachio_defconfig patch
- add "Acked-by: Joachim Eastwood <manabian@gmail.com>" for lpc18xx_defconfig patch
- add "Acked-by: Wei Xu <xuwei5@hisilicon.com>" for hisi_defconfig patch
- rebase on "https://github.com/jh80chung/dw-mmc.git tags/dw-mmc-for-ulf-v4.2" for merging easily

Changes in v4:
- remove "host->trans_mode" and use "host->use_dma" to indicate
  transfer mode.
- remove all bt-bindings' changes since we don't need new properities.
- check transfer mode at runtime by reading HCON reg
- spilt defconfig changes for each sub-architecture
- fix the title of cover letter
- reuse some code for reducing code size

Changes in v3:
- choose transfer mode at runtime
- remove all CONFIG_MMC_DW_IDMAC config option
- add supports-idmac property for some platforms

Changes in v2:
- Fix typo of dev_info msg
- remove unused dmach from declaration of dw_mci_dma_slave

Shawn Lin (10):
  mmc: dw_mmc: Add external dma interface support
  mmc: dw_mmc: use macro for HCON register operations
  Documentation: synopsys-dw-mshc: add bindings for idmac and edmac
  mips: pistachio_defconfig: remove CONFIG_MMC_DW_IDMAC
  arc: axs10x_defconfig: remove CONFIG_MMC_DW_IDMAC
  arm: exynos_defconfig: remove CONFIG_MMC_DW_IDMAC
  arm: hisi_defconfig: remove CONFIG_MMC_DW_IDMAC
  arm: lpc18xx_defconfig: remove CONFIG_MMC_DW_IDMAC
  arm: multi_v7_defconfig: remove CONFIG_MMC_DW_IDMAC
  arm: zx_defconfig: remove CONFIG_MMC_DW_IDMAC

 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |  25 ++
 arch/arc/configs/axs101_defconfig                  |   1 -
 arch/arc/configs/axs103_defconfig                  |   1 -
 arch/arc/configs/axs103_smp_defconfig              |   1 -
 arch/arm/configs/exynos_defconfig                  |   1 -
 arch/arm/configs/hisi_defconfig                    |   1 -
 arch/arm/configs/lpc18xx_defconfig                 |   1 -
 arch/arm/configs/multi_v7_defconfig                |   1 -
 arch/arm/configs/zx_defconfig                      |   1 -
 arch/mips/configs/pistachio_defconfig              |   1 -
 drivers/mmc/host/Kconfig                           |  11 +-
 drivers/mmc/host/dw_mmc-pltfm.c                    |   2 +
 drivers/mmc/host/dw_mmc.c                          | 277 +++++++++++++++++----
 drivers/mmc/host/dw_mmc.h                          |   9 +
 include/linux/mmc/dw_mmc.h                         |  23 +-
 15 files changed, 283 insertions(+), 73 deletions(-)

-- 
2.3.7


