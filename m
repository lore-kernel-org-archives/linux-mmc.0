From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH v3 02/12] clk: Include of.h in clock-provider.h
Date: Thu, 11 Sep 2014 22:18:16 +0200
Message-ID: <1410466706-27386-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1410466706-27386-1-git-send-email-maxime.ripard@free-electrons.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:49725 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756875AbaIKUW1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Sep 2014 16:22:27 -0400
In-Reply-To: <1410466706-27386-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Emilio Lopez <emilio@elopez.com.ar>, chris@printf.net, david.lanzendoerfer@o2s.ch, ulf.hansson@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, wens@csie.org, Maxime Ripard <maxime.ripard@free-electrons.com>

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
2.1.0

