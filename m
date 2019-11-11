From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v6 4/4] mmc: host: sdhci: Add a variable to defer to complete requests if needed
Date: Mon, 11 Nov 2019 15:34:00 +0800
Message-ID: <119d3285ab610967b43f7c822dfdc0ebb8d521cb.1573456284.git.baolin.wang@linaro.org>
References: <cover.1573456283.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1573456283.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1573456283.git.baolin.wang@linaro.org>
References: <cover.1573456283.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, asutoshd@codeaurora.org
Cc: orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de, linus.walleij@linaro.org, vincent.guittot@linaro.org, baolin.wang@linaro.org, baolin.wang7@gmail.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

When using the host software queue, it will trigger the next request in
irq handler without a context switch. But the sdhci_request() can not be
called in interrupt context when using host software queue for some host
drivers, due to the get_cd() ops can be sleepable.

But for some host drivers, such as Spreadtrum host driver, the card is
nonremovable, so the get_cd() ops is not sleepable, which means we can
complete the data request and trigger the next request in irq handler
to remove the context switch for the Spreadtrum host driver.

Thus we still need introduce a variable in struct sdhci_host to indicate
that we will always to defer to complete requests if the sdhci_request()
can not be called in interrupt context for some host drivers, when using
the host software queue.

Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/sdhci.c |    2 +-
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 850241f..4bef066 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3035,7 +3035,7 @@ static inline bool sdhci_defer_done(struct sdhci_host *host,
 {
 	struct mmc_data *data = mrq->data;
 
-	return host->pending_reset ||
+	return host->pending_reset || host->always_defer_done ||
 	       ((host->flags & SDHCI_REQ_USE_DMA) && data &&
 		data->host_cookie == COOKIE_MAPPED);
 }
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index d89cdb9..a73ce89 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -533,6 +533,7 @@ struct sdhci_host {
 	bool pending_reset;	/* Cmd/data reset is pending */
 	bool irq_wake_enabled;	/* IRQ wakeup is enabled */
 	bool v4_mode;		/* Host Version 4 Enable */
+	bool always_defer_done;	/* Always defer to complete requests */
 
 	struct mmc_request *mrqs_done[SDHCI_MAX_MRQS];	/* Requests done */
 	struct mmc_command *cmd;	/* Current command */
-- 
1.7.9.5
