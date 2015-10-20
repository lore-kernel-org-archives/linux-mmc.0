From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH 1/5] ARM: Keystone: Enable PINCTRL for Keystone ARCH
Date: Tue, 20 Oct 2015 16:50:05 -0500
Message-ID: <1445377809-12516-1-git-send-email-fcooper@ti.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35981 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753557AbbJTVuR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Oct 2015 17:50:17 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux@arm.linux.org.uk, ssantosh@kernel.org, ulf.hansson@linaro.org, m-karicheri2@ti.com, grygorii.strashko@ti.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Franklin Cooper <fcooper@ti.com>

From: Franklin Cooper <fcooper@ti.com>

Unlike other Keystone 2 devices, newer Keystone 2 SOCs may utilize
pinmuxing which requires PINCTRL to be enabled. Therefore, enable
PINCTRL for all Keystone 2 devices.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 arch/arm/mach-keystone/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-keystone/Kconfig b/arch/arm/mach-keystone/Kconfig
index ea955f6db..7a432ee 100644
--- a/arch/arm/mach-keystone/Kconfig
+++ b/arch/arm/mach-keystone/Kconfig
@@ -11,6 +11,7 @@ config ARCH_KEYSTONE
 	select ZONE_DMA if ARM_LPAE
 	select MIGHT_HAVE_PCI
 	select PCI_DOMAINS if PCI
+	select PINCTRL
 	help
 	  Support for boards based on the Texas Instruments Keystone family of
 	  SoCs.
-- 
2.6.1

