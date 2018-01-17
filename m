From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v3 16/16] mmc: tmio: remove useless TMIO_MASK_CMD handling in tmio_mmc_host_probe()
Date: Thu, 18 Jan 2018 01:28:16 +0900
Message-ID: <1516206496-16612-17-git-send-email-yamada.masahiro@socionext.com>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Ulf Magnusson <ulfalizer@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

TMIO_MASK_CMD is properly enabled in tmio_mmc_start_command().

We have no reason to set it up in tmio_mmc_host_probe().  (If we
really wanted to set it in the probe, we would have to do likewise
when resuming.)

Even worse, the following code is extremely confusing:

  _host->sdcard_irq_mask &= ~irq_mask;

The logic is opposite between "->sdcard_irq_mask" and "irq_mask".
The intention is not clear at a glance.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3: None
Changes in v2:
  - Newly added

 drivers/mmc/host/tmio_mmc_core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 494f0b3..b75a51b 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1209,7 +1209,6 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 	struct tmio_mmc_data *pdata = _host->pdata;
 	struct mmc_host *mmc = _host->mmc;
 	int ret;
-	u32 irq_mask = TMIO_MASK_CMD;
 
 	/*
 	 * Check the sanity of mmc->f_min to prevent tmio_mmc_set_clock() from
@@ -1291,8 +1290,6 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 	_host->sdcard_irq_mask = sd_ctrl_read16_and_16_as_32(_host, CTL_IRQ_MASK);
 	tmio_mmc_disable_mmc_irqs(_host, TMIO_MASK_ALL);
 
-	_host->sdcard_irq_mask &= ~irq_mask;
-
 	if (_host->native_hotplug)
 		tmio_mmc_enable_mmc_irqs(_host,
 				TMIO_STAT_CARD_REMOVE | TMIO_STAT_CARD_INSERT);
-- 
2.7.4
