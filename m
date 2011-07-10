From: Ido Yariv <ido@wizery.com>
Subject: [PATCH v2 5/6] arm: davinci: DA850: Add GPIO pinmux configuration for wl1271
Date: Sun, 10 Jul 2011 16:14:38 +0300
Message-ID: <1310303679-17936-6-git-send-email-ido@wizery.com>
References: <1310303679-17936-1-git-send-email-ido@wizery.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55270 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896Ab1GJNPD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 10 Jul 2011 09:15:03 -0400
Received: by mail-ww0-f44.google.com with SMTP id 5so3184676wwe.1
        for <linux-mmc@vger.kernel.org>; Sun, 10 Jul 2011 06:15:02 -0700 (PDT)
In-Reply-To: <1310303679-17936-1-git-send-email-ido@wizery.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: davinci-linux-open-source@linux.davincidsp.com, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: Ido Yariv <ido@wizery.com>

The wl1271 daughter board makes use of a few GPIOs:
GPIO6_9 is used for powering down/up the WLAN functionality.
GPIO6_10 is used as an input IRQ line from the WLAN chip.

Add the required pinmux configuration for these GPIOs.

Signed-off-by: Ido Yariv <ido@wizery.com>
---
 arch/arm/mach-davinci/da850.c            |    2 ++
 arch/arm/mach-davinci/include/mach/mux.h |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index f6eafb4..bfe9b71 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -590,6 +590,8 @@ static const struct mux_config da850_pins[] = {
 	MUX_CFG(DA850, GPIO3_13,	7,	8,	15,	8,	false)
 	MUX_CFG(DA850, GPIO4_0,		10,	28,	15,	8,	false)
 	MUX_CFG(DA850, GPIO4_1,		10,	24,	15,	8,	false)
+	MUX_CFG(DA850, GPIO6_9,		13,	24,	15,	8,	false)
+	MUX_CFG(DA850, GPIO6_10,	13,	20,	15,	8,	false)
 	MUX_CFG(DA850, GPIO6_13,	13,	8,	15,	8,	false)
 	MUX_CFG(DA850, RTC_ALARM,	0,	28,	15,	2,	false)
 #endif
diff --git a/arch/arm/mach-davinci/include/mach/mux.h b/arch/arm/mach-davinci/include/mach/mux.h
index 7fb7f1e..a7e92fc 100644
--- a/arch/arm/mach-davinci/include/mach/mux.h
+++ b/arch/arm/mach-davinci/include/mach/mux.h
@@ -924,6 +924,8 @@ enum davinci_da850_index {
 	DA850_GPIO3_13,
 	DA850_GPIO4_0,
 	DA850_GPIO4_1,
+	DA850_GPIO6_9,
+	DA850_GPIO6_10,
 	DA850_GPIO6_13,
 	DA850_RTC_ALARM,
 };
-- 
1.7.4.1

