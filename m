From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/2] MIPS: db1235: Don't use MMC_CLKGATE
Date: Mon, 30 Sep 2013 16:41:59 +0200
Message-ID: <1380552120-31003-2-git-send-email-ulf.hansson@linaro.org>
References: <1380552120-31003-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f43.google.com ([74.125.83.43]:62376 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753979Ab3I3OmJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Sep 2013 10:42:09 -0400
Received: by mail-ee0-f43.google.com with SMTP id e52so2751571eek.16
        for <linux-mmc@vger.kernel.org>; Mon, 30 Sep 2013 07:42:08 -0700 (PDT)
In-Reply-To: <1380552120-31003-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org

As a first step in removing code for MMC_CLKGATE, MIPS db1235 defconfig
which is the only current user, shall move away from this option.

The mmc host drivers au1xmmc and jz4740_mmc, which are used on MIPS
don't support clock gating through MMC_CLKGATE, thus removing the
config option will have no effect on power save - clock gating wise.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/mips/configs/db1235_defconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/configs/db1235_defconfig b/arch/mips/configs/db1235_defconfig
index e2b4ad5..28e49f2 100644
--- a/arch/mips/configs/db1235_defconfig
+++ b/arch/mips/configs/db1235_defconfig
@@ -351,7 +351,6 @@ CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_USB_STORAGE=y
 CONFIG_MMC=y
-CONFIG_MMC_CLKGATE=y
 CONFIG_MMC_AU1X=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
-- 
1.7.9.5

