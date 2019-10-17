From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/2] mmc: core: Drop check for mmc_card_is_removable() in mmc_rescan()
Date: Thu, 17 Oct 2019 15:57:38 +0200
Message-ID: <20191017135739.1315-2-ulf.hansson@linaro.org>
References: <20191017135739.1315-1-ulf.hansson@linaro.org>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20191017135739.1315-1-ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Wen Gong <wgong-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Erik Stromdahl <erik.stromdahl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eyal Reizer <eyalreizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Upfront in mmc_rescan() we use the host->rescan_entered flag, to allow
scanning only once for non-removable cards. Therefore, it's also not
possible that we can have bus attached, when we are scanning non-removable
cards. For this reason, let' drop the check for mmc_card_is_removable() as
it's redundant.

Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/mmc/core/core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 221127324709..6f8342702c73 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2297,11 +2297,8 @@ void mmc_rescan(struct work_struct *work)
 
 	mmc_bus_get(host);
 
-	/*
-	 * if there is a _removable_ card registered, check whether it is
-	 * still present
-	 */
-	if (host->bus_ops && !host->bus_dead && mmc_card_is_removable(host))
+	/* Verify a registered card to be functional, else remove it. */
+	if (host->bus_ops && !host->bus_dead)
 		host->bus_ops->detect(host);
 
 	host->detect_change = 0;
-- 
2.17.1
