From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH 5/5] ARM: keystone: defconfig: Enable CAN support
Date: Tue, 20 Oct 2015 16:50:09 -0500
Message-ID: <1445377809-12516-5-git-send-email-fcooper@ti.com>
References: <1445377809-12516-1-git-send-email-fcooper@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445377809-12516-1-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@arm.linux.org.uk, ssantosh@kernel.org, ulf.hansson@linaro.org, m-karicheri2@ti.com, grygorii.strashko@ti.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-mmc@vger.kernel.org

Newer Keystone 2 devices support CAN. Enable CAN support as modules.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 arch/arm/configs/keystone_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index ed3e83e..e9bd825 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -137,6 +137,9 @@ CONFIG_I2C_DAVINCI=y
 CONFIG_SPI=y
 CONFIG_SPI_DAVINCI=y
 CONFIG_SPI_SPIDEV=y
+CONFIG_CAN=m
+CONFIG_CAN_C_CAN=m
+CONFIG_CAN_C_CAN_PLATFORM=m
 CONFIG_MMC=y
 CONFIG_MMC_OMAP_HS=y
 # CONFIG_HWMON is not set
-- 
2.6.1
