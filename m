From: NeilBrown <neilb@suse.de>
Subject: [PATCH 2/4] mmc: core: allow non-blocking form of mmc_claim_host
Date: Sat, 31 Jan 2015 06:05:37 +1100
Message-ID: <20150130190537.20910.46413.stgit@notabene.brown>
References: <20150130185742.20910.52715.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150130185742.20910.52715.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Andreas Fenkart <afenkart@gmail.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, GTA04 owners <gta04-owner@goldelico.com>, NeilBrown <neil@brown.name>, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Change the handling for the 'abort' flag so that if
it is set, but we can claim the host, then do the claim,
rather than aborting.

When the abort is async this just means that a race between aborting
an allowing a claim is resolved slightly differently.  Any
code must already be able to handle 'abort' being set just as the host
is claimed.

This allows extra functionality.  If __mmc_claim_host() is called
with an 'abort' pointer which is initialized to '1', it will effect a
non-blocking 'claim'.

Signed-off-by: NeilBrown <neil@brown.name>
---
 drivers/mmc/core/core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index e9eb721e3664..051198073d21 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -912,10 +912,11 @@ int __mmc_claim_host(struct mmc_host *host, atomic_t *abort)
 		spin_lock_irqsave(&host->lock, flags);
 	}
 	set_current_state(TASK_RUNNING);
-	if (!stop) {
+	if (!host->claimed || host->claimer == current) {
 		host->claimed = 1;
 		host->claimer = current;
 		host->claim_cnt += 1;
+		stop = 0;
 	} else
 		wake_up(&host->wq);
 	spin_unlock_irqrestore(&host->lock, flags);
