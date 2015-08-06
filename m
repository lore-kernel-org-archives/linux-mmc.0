From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH] mmc: Kconfig: Add dependency on GPIOLIB for MMC_SDHCI
Date: Thu,  6 Aug 2015 07:39:26 +0200
Message-ID: <6906e34b62f162018984a5fbd12b3ef6cd5e3a29.1438839562.git.michal.simek@xilinx.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:35059 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167AbbHFFjd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Aug 2015 01:39:33 -0400
Received: by wibxm9 with SMTP id xm9so7870057wib.0
        for <linux-mmc@vger.kernel.org>; Wed, 05 Aug 2015 22:39:32 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: sbranden@broadcom.com, Weijun Yang <Weijun.Yang@csr.com>, Andrew Bresticker <abrestic@chromium.org>, Jean Delvare <jdelvare@suse.de>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-mmc@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>, addy ke <addy.ke@rock-chips.com>, Stephen Boyd <sboyd@codeaurora.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Kevin Hao <haokexin@gmail.com>, Vincent Yang <vincent.yang.fujitsu@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>

Add GPIOLIB dependency for MMC_SDHCI.

Problem was observed after adding the patch
"mmc: sdhci-of-arasan: Call OF parsing for MMC"
(sha1: 16b23787fc709fe60c5d2bd05927b1a3da33d4e9) which calls
mmc_of_parse() -> mmc_gpiod_request_cd() (slot-gpio.c) which
calls devm_gpiod_get_index() which returns -ENOSYS.

Error log:
sdhci-arasan ff160000.sdhci: parsing dt failed (4294967258)
sdhci-arasan: probe of ff160000.sdhci failed with error -38

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

After RFC here https://lkml.org/lkml/2015/7/24/371
adding dependency on MMC_SDHCI.

---
 drivers/mmc/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index fd9a58e216a5..5519803c124b 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -38,6 +38,7 @@ config MMC_PXA
 config MMC_SDHCI
 	tristate "Secure Digital Host Controller Interface support"
 	depends on HAS_DMA
+	depends on GPIOLIB
 	help
 	  This selects the generic Secure Digital Host Controller Interface.
 	  It is used by manufacturers such as Texas Instruments(R), Ricoh(R)
-- 
2.3.5

