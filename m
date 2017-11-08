From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 2/3] mmc: tmio: use mmc_can_gpio_cd() instead of checking TMIO_MMC_USE_GPIO_CD
Date: Wed,  8 Nov 2017 19:16:59 +0900
Message-ID: <1510136220-31853-3-git-send-email-yamada.masahiro@socionext.com>
References: <1510136220-31853-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conuserg-08.nifty.com ([210.131.2.75]:43318 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752057AbdKHKR7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Nov 2017 05:17:59 -0500
In-Reply-To: <1510136220-31853-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org
Cc: Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

To use a GPIO line for card detection, TMIO_MMC_USE_GPIO_CD is used
by a legacy board (arch/sh/boards/mach-ecovec24).

For DT platforms, the "cd-gpios" property is a legitimate way for that
in case the IP-builtin card detection can not be used for some reason.
mmc_of_parse() calls mmc_gpiod_request_cd() to set up ctx->cd_gpio if
the "cd-gpios" property is specified.

To cater to both cases, mmc_can_gpio_cd() is a correct way to check
which card detection logic is used.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/tmio_mmc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 7c0e952..9fd0874 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1228,7 +1228,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 	}
 	mmc->max_seg_size = mmc->max_req_size;
 
-	_host->native_hotplug = !(pdata->flags & TMIO_MMC_USE_GPIO_CD ||
+	_host->native_hotplug = !(mmc_can_gpio_cd(mmc) ||
 				  mmc->caps & MMC_CAP_NEEDS_POLL ||
 				  !mmc_card_is_removable(mmc));
 
-- 
2.7.4

