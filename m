From: Richard Zhao <richard.zhao@linaro.org>
Subject: [PATCH V4 02/14] ARM: mxc: time: add clk_prepare/clk_unprepare
Date: Tue, 15 Nov 2011 14:47:57 +0800
Message-ID: <1321339689-25256-3-git-send-email-richard.zhao@linaro.org>
References: <1321339689-25256-1-git-send-email-richard.zhao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-va3.bigfish.com ([216.32.180.10]:55010 "EHLO
	VA3EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752711Ab1KOGsb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Nov 2011 01:48:31 -0500
In-Reply-To: <1321339689-25256-1-git-send-email-richard.zhao@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org, netdev@vger.kernel.org, linux-serial@vger.kernel.org
Cc: linux@arm.linux.org.uk, amit.kucheria@canonical.com, kernel@pengutronix.de, ben-linux@fluff.org, cjb@laptop.org, alan@linux.intel.com, eric.miao@linaro.org, richard.zhao@linaro.org

It's for migrating to generic clk framework API.

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/plat-mxc/time.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/time.c b/arch/arm/plat-mxc/time.c
index 4b0fe28..b4e8b18 100644
--- a/arch/arm/plat-mxc/time.c
+++ b/arch/arm/plat-mxc/time.c
@@ -292,7 +292,7 @@ void __init mxc_timer_init(struct clk *timer_clk, void __iomem *base, int irq)
 {
 	uint32_t tctl_val;
 
-	clk_enable(timer_clk);
+	clk_prepare_enable(timer_clk);
 
 	timer_base = base;
 
-- 
1.7.5.4


