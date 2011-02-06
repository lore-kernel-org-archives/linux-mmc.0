From: Pierre Tardy <pierre.tardy@intel.com>
Subject: [PATCH v2 1/3] mmc: put the led blinking code after clock ungating
Date: Sun,  6 Feb 2011 19:02:48 +0100
Message-ID: <171444bc8d0e6db780533b51d3e227fc5bc2c745.1297014479.git.pierre.tardy@intel.com>
References: <cover.1297014479.git.pierre.tardy@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1297014479.git.pierre.tardy@intel.com>
In-Reply-To: <cover.1297014479.git.pierre.tardy@intel.com>
References: <cover.1297014479.git.pierre.tardy@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@lists.linux-foundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Pierre Tardy <pierre.tardy@intel.com>
List-Id: linux-mmc@vger.kernel.org

as mmc clock gating can also be used as a power gating
tip, this is better to put the led blinking after having
ungate the clock

Signed-off-by: Pierre Tardy <pierre.tardy@intel.com>
---
 drivers/mmc/core/core.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 6625c05..34a7e8c 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -167,8 +167,6 @@ mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 
 	WARN_ON(!host->claimed);
 
-	led_trigger_event(host->led, LED_FULL);
-
 	mrq->cmd->error = 0;
 	mrq->cmd->mrq = mrq;
 	if (mrq->data) {
@@ -194,6 +192,7 @@ mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 		}
 	}
 	mmc_host_clk_ungate(host);
+	led_trigger_event(host->led, LED_FULL);
 	host->ops->request(host, mrq);
 }
 
-- 
1.7.2.3

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
