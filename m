From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH 2/3] ARM: imx6q: switch to use pinctrl subsystem
Date: Wed, 2 May 2012 19:31:21 +0800
Message-ID: <1335958282-3068-2-git-send-email-b29396@freescale.com>
References: <1335958282-3068-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:49180
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751864Ab2EBLXQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 May 2012 07:23:16 -0400
In-Reply-To: <1335958282-3068-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: devicetree-discuss@lists.ozlabs.org, linus.walleij@stericsson.com, swarren@wwwdotorg.org, s.hauer@pengutronix.de, shawn.guo@freescale.com, kernel@pengutronix.de, grant.likely@secretlab.ca, rob.herring@calxeda.com, cjb@laptop.org, w.sang@pengutronix.de, linux-mmc@vger.kernel.org

From: Dong Aisheng <dong.aisheng@linaro.org>

Acked-by: Stephen Warren <swarren@wwwdotorg.org>
Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
 arch/arm/mach-imx/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 7561eca..e0fc67c 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -842,6 +842,8 @@ config SOC_IMX6Q
 	select HAVE_IMX_MMDC
 	select HAVE_IMX_SRC
 	select HAVE_SMP
+	select PINCTRL
+	select PINCTRL_IMX6Q
 	select USE_OF
 
 	help
-- 
1.7.0.4


