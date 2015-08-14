From: Hongtao Wu <wuht06@gmail.com>
Subject: [RFC PATCH v3 0/3] Add MMC host driver for Spreadtrum SoC
Date: Sat, 15 Aug 2015 00:55:50 +0800
Message-ID: <1439571353-30165-1-git-send-email-wuht06@gmail.com>
References: <y>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <y>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-arm-kernel@lists.infradead.org, shawn.lin@rock-chips.com
Cc: Orson.Zhai@spreadtrum.com, Chunyan.Zhang@spreadtrum.com, Jason.Wu@spreadtrum.com
List-Id: linux-mmc@vger.kernel.org

This patch adds MMC host driver for Spreadtrum SoC.
The following coding style may be not meet kernel coding style.
I am not sure this kind of coding style is better or worse.
1) A macro that represent some bits of a register is added a prefix "__",
    for example:
    #define SDHOST_16_HOST_CTRL_2   0x3E
    #define __TIMING_MODE_SDR12     0x0000
    #define __TIMING_MODE_SDR25     0x0001
    #define __TIMING_MODE_SDR50     0x0002
    I think it is more useful to distinguish a register from a bit of this
    register.
2) A function in order to operate a register is also added a prefix "_".
    If the functions(A) call other function(B), we added a prefix "__" before B,
    for example:
    static inline void _sdhost_enable_int(struct sdhost_host *host, u32 mask)
    {
        __local_writel(mask, host, SDHOST_32_INT_ST_EN);
        __local_writel(mask, host, SDHOST_32_INT_SIG_EN);
    }
    I think this make the relationship of the function call more explicit.

Changes in v3:
- add Spreadtrum MMC DT bindings.
- add MMC nodes in Spreadtrum DT files
- release resources when there is an error or removing MMC host driver.

Changes in v2:
- delete some redundant mdelay()
- add error handling in some functions.

Billows Wu(HongtaoWu) (3):
  mmc: sprd: add MMC host driver for Spreadtrum SoC
  Documentation: add Spreadtrum MMC DT bindings.
  DT: add MMC nodes in Spreadtrum DT files.

 Documentation/devicetree/bindings/mmc/sprd-mmc.txt |   46 +
 arch/arm64/boot/dts/sprd/sc9836-openphone.dts      |   24 +
 arch/arm64/boot/dts/sprd/sharkl64.dtsi             |   44 +
 drivers/mmc/host/Kconfig                           |    6 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/sprd_sdhost.c                     | 1202 ++++++++++++++++++++
 drivers/mmc/host/sprd_sdhost.h                     |  615 ++++++++++
 drivers/mmc/host/sprd_sdhost_debugfs.c             |  212 ++++
 drivers/mmc/host/sprd_sdhost_debugfs.h             |   27 +
 9 files changed, 2177 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sprd-mmc.txt
 create mode 100644 drivers/mmc/host/sprd_sdhost.c
 create mode 100644 drivers/mmc/host/sprd_sdhost.h
 create mode 100644 drivers/mmc/host/sprd_sdhost_debugfs.c
 create mode 100644 drivers/mmc/host/sprd_sdhost_debugfs.h

--
1.7.9.5
