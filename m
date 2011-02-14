From: Shawn Guo <shawn.guo@freescale.com>
Subject: [PATCH v2 2/7] ARM: mxs/clock: fix base address missing in name##_set_parent
Date: Mon, 14 Feb 2011 10:32:21 +0800
Message-ID: <1297650746-12841-3-git-send-email-shawn.guo@freescale.com>
References: <1297650746-12841-1-git-send-email-shawn.guo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1outboundpool.messaging.microsoft.com ([216.32.181.183]:58432
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754676Ab1BMSbD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Feb 2011 13:31:03 -0500
In-Reply-To: <1297650746-12841-1-git-send-email-shawn.guo@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, s.hauer@pengutronix.de, arnd@arndb.de, LW@KARO-electronics.de, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Shawn Guo <shawn.guo@freescale.com>

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-mxs/clock-mx23.c |    2 +-
 arch/arm/mach-mxs/clock-mx28.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mxs/clock-mx23.c b/arch/arm/mach-mxs/clock-mx23.c
index 350b28c..c19b69a 100644
--- a/arch/arm/mach-mxs/clock-mx23.c
+++ b/arch/arm/mach-mxs/clock-mx23.c
@@ -347,7 +347,7 @@ static int name##_set_parent(struct clk *clk, struct clk *parent)	\
 {									\
 	if (parent != clk->parent) {					\
 		__raw_writel(BM_CLKCTRL_CLKSEQ_BYPASS_##bit,		\
-			 HW_CLKCTRL_CLKSEQ_TOG);			\
+			CLKCTRL_BASE_ADDR + HW_CLKCTRL_CLKSEQ_TOG);	\
 		clk->parent = parent;					\
 	}								\
 									\
diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index a3b4787..9f4ee36 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -483,7 +483,7 @@ static int name##_set_parent(struct clk *clk, struct clk *parent)	\
 {									\
 	if (parent != clk->parent) {					\
 		__raw_writel(BM_CLKCTRL_CLKSEQ_BYPASS_##bit,		\
-			 HW_CLKCTRL_CLKSEQ_TOG);			\
+			CLKCTRL_BASE_ADDR + HW_CLKCTRL_CLKSEQ_TOG);	\
 		clk->parent = parent;					\
 	}								\
 									\
-- 
1.7.1


