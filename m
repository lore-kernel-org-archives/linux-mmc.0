From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 01/10] mmc: core: Add TRANsfer state to non-HPI state
Date: Sat, 18 Aug 2012 00:22:21 +0530
Message-ID: <1345229550-8672-2-git-send-email-svenkatr@ti.com>
References: <1345229550-8672-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1345229550-8672-1-git-send-email-svenkatr@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: cjb@laptop.org, balajitk@ti.com, vishp@ti.com, Venkatraman S <svenkatr@ti.com>
List-Id: linux-mmc@vger.kernel.org

HPI can be issued only in programming state to bring the card to
transfer state. If the card is already in transfer state, doing
a HPI is redundant.
Fix this by adding transfer state to the list of exceptions to
doing HPI and return without error.

Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 drivers/mmc/core/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 8ac5246..835c9f0 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -424,8 +424,9 @@ int mmc_interrupt_hpi(struct mmc_card *card)
 	case R1_STATE_IDLE:
 	case R1_STATE_READY:
 	case R1_STATE_STBY:
+	case R1_STATE_TRAN:
 		/*
-		 * In idle states, HPI is not needed and the caller
+		 * In idle and transfer states, HPI is not needed and the caller
 		 * can issue the next intended command immediately
 		 */
 		goto out;
-- 
1.7.11.1.25.g0e18bef

