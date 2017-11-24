From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 16/22] mmc: tmio: fix never-detected card insertion bug
Date: Sat, 25 Nov 2017 01:24:51 +0900
Message-ID: <1511540697-27387-17-git-send-email-yamada.masahiro@socionext.com>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

The TMIO mmc cannot detect the card insertion in native_hotplug mode
if the driver is probed without a card inserted.

The reason is obvious; all IRQs are disabled by tmio_mmc_host_probe(),
as follows:

  tmio_mmc_disable_mmc_irqs(_host, TMIO_MASK_ALL);

The IRQs are first enabled by tmio_mmc_start_command() as follows:

  if (!host->native_hotplug)
          irq_mask &= ~(TMIO_STAT_CARD_REMOVE | TMIO_STAT_CARD_INSERT);
  tmio_mmc_enable_mmc_irqs(host, irq_mask);

If the driver is probed without a card, tmio_mmc_start_command() is
never called in the first place.  So, the card is never detected.

The card event IRQs must be enabled in probe/resume functions.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Newly added

 drivers/mmc/host/tmio_mmc_core.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index b51bb06..7d169ed 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -350,8 +350,6 @@ static int tmio_mmc_start_command(struct tmio_mmc_host *host,
 			c |= TRANSFER_READ;
 	}
 
-	if (!host->native_hotplug)
-		irq_mask &= ~(TMIO_STAT_CARD_REMOVE | TMIO_STAT_CARD_INSERT);
 	tmio_mmc_enable_mmc_irqs(host, irq_mask);
 
 	/* Fire off the command */
@@ -1292,11 +1290,13 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 		irq_mask |= TMIO_MASK_READOP;
 	if (!_host->chan_tx)
 		irq_mask |= TMIO_MASK_WRITEOP;
-	if (!_host->native_hotplug)
-		irq_mask &= ~(TMIO_STAT_CARD_REMOVE | TMIO_STAT_CARD_INSERT);
 
 	_host->sdcard_irq_mask &= ~irq_mask;
 
+	if (_host->native_hotplug)
+		tmio_mmc_enable_mmc_irqs(_host,
+				TMIO_STAT_CARD_REMOVE | TMIO_STAT_CARD_INSERT);
+
 	spin_lock_init(&_host->lock);
 	mutex_init(&_host->ios_lock);
 
@@ -1383,6 +1383,10 @@ int tmio_mmc_host_runtime_resume(struct device *dev)
 	if (host->clk_cache)
 		tmio_mmc_set_clock(host, host->clk_cache);
 
+	if (host->native_hotplug)
+		tmio_mmc_enable_mmc_irqs(host,
+				TMIO_STAT_CARD_REMOVE | TMIO_STAT_CARD_INSERT);
+
 	tmio_mmc_enable_dma(host, true);
 
 	if (tmio_mmc_can_retune(host) && host->select_tuning(host))
-- 
2.7.4
