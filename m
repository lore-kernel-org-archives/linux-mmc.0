From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 06/22] mmc: tmio: move mmc_host_ops to struct tmio_mmc_host from static data
Date: Sat, 25 Nov 2017 01:24:41 +0900
Message-ID: <1511540697-27387-7-git-send-email-yamada.masahiro@socionext.com>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Currently, tmio_mmc_ops is static data and tmio_mmc_host_probe()
updates some hooks in the static data.  This is a problem when
two or more instances call tmio_mmc_host_probe() and each of them
requests to use its own card_busy/start_signal_voltage_switch.

We can borrow a solution from sdhci_alloc_host().  Copy the whole
ops structure to host->mmc_host_ops, then override the hooks in
malloc'ed data.  Constify tmio_mmc_ops since it is now a template
ops used by default.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Changes in v2:
  - Rename "mmc_host_ops" to "ops" per Wolfram Sang

 drivers/mmc/host/tmio_mmc.h      | 1 +
 drivers/mmc/host/tmio_mmc_core.c | 9 +++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 3e6ff89..4fdb51b 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -134,6 +134,7 @@ struct tmio_mmc_host {
 	struct mmc_request      *mrq;
 	struct mmc_data         *data;
 	struct mmc_host         *mmc;
+	struct mmc_host_ops     ops;
 
 	/* Callbacks for clock / power control */
 	void (*set_pwr)(struct platform_device *host, int state);
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index d3b7af9..af9ed6a 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1098,7 +1098,7 @@ static int tmio_multi_io_quirk(struct mmc_card *card,
 	return blk_size;
 }
 
-static struct mmc_host_ops tmio_mmc_ops = {
+static const struct mmc_host_ops tmio_mmc_ops = {
 	.request	= tmio_mmc_request,
 	.set_ios	= tmio_mmc_set_ios,
 	.get_ro         = tmio_mmc_get_ro,
@@ -1158,6 +1158,8 @@ tmio_mmc_host_alloc(struct platform_device *pdev)
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
 	host->pdev = pdev;
+	host->ops = tmio_mmc_ops;
+	mmc->ops = &host->ops;
 
 	return host;
 }
@@ -1203,10 +1205,9 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 	if (ret < 0)
 		return ret;
 
-	tmio_mmc_ops.card_busy = _host->card_busy;
-	tmio_mmc_ops.start_signal_voltage_switch =
+	_host->ops.card_busy = _host->card_busy;
+	_host->ops.start_signal_voltage_switch =
 		_host->start_signal_voltage_switch;
-	mmc->ops = &tmio_mmc_ops;
 
 	mmc->caps |= MMC_CAP_4_BIT_DATA | pdata->capabilities;
 	mmc->caps2 |= pdata->capabilities2;
-- 
2.7.4
