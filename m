From: Michal Simek <michal.simek@xilinx.com>
Subject: [RFC PATCH] mmc: Kconfig: Add dependency on GPIOLIB for Arasan driver
Date: Fri, 24 Jul 2015 15:53:16 +0200
Message-ID: <920802cde8579bdfad47baba85d85212735ed90e.1437745991.git.michal.simek@xilinx.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:33027 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753815AbbGXNx1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Jul 2015 09:53:27 -0400
Received: by wicmv11 with SMTP id mv11so65799114wic.0
        for <linux-mmc@vger.kernel.org>; Fri, 24 Jul 2015 06:53:25 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Weijun Yang <Weijun.Yang@csr.com>, Andrew Bresticker <abrestic@chromium.org>, Jean Delvare <jdelvare@suse.de>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-mmc@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>, Scott Branden <sbranden@broadcom.com>, addy ke <addy.ke@rock-chips.com>, Stephen Boyd <sboyd@codeaurora.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Georgi Djakov <gdjakov@mm-sol.com>, Kevin Hao <haokexin@gmail.com>, Vincent Yang <vincent.yang.fujitsu@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>

The patch "mmc: sdhci-of-arasan: Call OF parsing for MMC"
(sha1: 16b23787fc709fe60c5d2bd05927b1a3da33d4e9) introduce new
dependency on GPIOLIB which calls mmc_of_parse() ->
mmc_gpiod_request_cd() (slot-gpio.c) which calls devm_gpiod_get_index()
which returns -ENOSYS.

Error log:
sdhci-arasan ff160000.sdhci: parsing dt failed (4294967258)
sdhci-arasan: probe of ff160000.sdhci failed with error -38

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

This problem is probably in all others drivers.
This is one way how this can be solved.
Maybe better way is to block return value for cd and wp.

---
 drivers/mmc/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index fd9a58e216a5..4b5854759cfc 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -120,6 +120,7 @@ config MMC_SDHCI_PLTFM
 config MMC_SDHCI_OF_ARASAN
 	tristate "SDHCI OF support for the Arasan SDHCI controllers"
 	depends on MMC_SDHCI_PLTFM
+	depends on GPIOLIB
 	depends on OF
 	help
 	  This selects the Arasan Secure Digital Host Controller Interface
-- 
2.3.5

