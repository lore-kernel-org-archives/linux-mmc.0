From: "Steven J. Hill" <steven.hill@cavium.com>
Subject: [PATCH 4/4] MIPS: Octeon: cavium_octeon_defconfig: Enable Octeon MMC
Date: Mon, 24 Apr 2017 13:41:58 -0500
Message-ID: <1493059318-767-5-git-send-email-steven.hill@cavium.com>
References: <1493059318-767-1-git-send-email-steven.hill@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1493059318-767-1-git-send-email-steven.hill@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: David Daney <david.daney@cavium.com>, Jan Glauber <jglauber@cavium.com>, linux-mmc@vger.kernel.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: "Steven J. Hill" <Steven.Hill@cavium.com>

Enable the Octeon MMC driver in the defconfig.

Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
---
 arch/mips/configs/cavium_octeon_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/configs/cavium_octeon_defconfig b/arch/mips/configs/cavium_octeon_defconfig
index 31e3c4d..d4fda41 100644
--- a/arch/mips/configs/cavium_octeon_defconfig
+++ b/arch/mips/configs/cavium_octeon_defconfig
@@ -127,6 +127,11 @@ CONFIG_USB_EHCI_HCD=m
 CONFIG_USB_EHCI_HCD_PLATFORM=m
 CONFIG_USB_OHCI_HCD=m
 CONFIG_USB_OHCI_HCD_PLATFORM=m
+CONFIG_MMC=y
+# CONFIG_PWRSEQ_EMMC is not set
+# CONFIG_PWRSEQ_SIMPLE is not set
+# CONFIG_MMC_BLOCK_BOUNCE is not set
+CONFIG_MMC_CAVIUM_OCTEON=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_STAGING=y
-- 
2.1.4
