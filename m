From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 09/22] mmc: tmio: use mmc_can_gpio_cd() instead of checking TMIO_MMC_USE_GPIO_CD
Date: Sat, 25 Nov 2017 01:24:44 +0900
Message-ID: <1511540697-27387-10-git-send-email-yamada.masahiro@socionext.com>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conuserg-11.nifty.com ([210.131.2.78]:61431 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753584AbdKXQZ6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Nov 2017 11:25:58 -0500
In-Reply-To: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

To use a GPIO line for card detection, TMIO_MMC_USE_GPIO_CD is set
by a legacy board (arch/sh/boards/mach-ecovec24).

For DT platforms, the "cd-gpios" property is a legitimate way for that
in case the IP-builtin card detection can not be used for some reason.
mmc_of_parse() calls mmc_gpiod_request_cd() to set up ctx->cd_gpio if
the "cd-gpios" property is specified.

To cater to both cases, mmc_can_gpio_cd() is a correct way to check
which card detection logic is used.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 drivers/mmc/host/tmio_mmc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index efffb04..610f26f 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1232,7 +1232,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 	}
 	mmc->max_seg_size = mmc->max_req_size;
 
-	_host->native_hotplug = !(pdata->flags & TMIO_MMC_USE_GPIO_CD ||
+	_host->native_hotplug = !(mmc_can_gpio_cd(mmc) ||
 				  mmc->caps & MMC_CAP_NEEDS_POLL ||
 				  !mmc_card_is_removable(mmc));
 
-- 
2.7.4

