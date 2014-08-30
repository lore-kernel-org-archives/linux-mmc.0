From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH v2 02/12] clk: Include of.h in clock-provider.h
Date: Sat, 30 Aug 2014 22:03:01 +0200
Message-ID: <1409428991-2442-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1409428991-2442-1-git-send-email-maxime.ripard@free-electrons.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:53615 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751786AbaH3UFI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 30 Aug 2014 16:05:08 -0400
In-Reply-To: <1409428991-2442-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Emilio Lopez <emilio@elopez.com.ar>, chris@printf.net, david.lanzendoerfer@o2s.ch, ulf.hansson@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>

CLK_OF_DECLARE relies on OF_DECLARE_1 that is defined in of.h. Fixes build
errors when one use CLK_OF_DECLARE but doesn't include of.h

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 include/linux/clk-provider.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 201a6195a3eb..69b20d4c1e1a 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -13,6 +13,7 @@
 
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/of.h>
 
 #ifdef CONFIG_COMMON_CLK
 
-- 
2.0.2

