From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] mmc: tifm_sd: Mark expected switch fall-through
Date: Fri, 5 Oct 2018 11:54:57 +0200
Message-ID: <20181005095457.GA21116@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Dubov <oakad@yahoo.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-mmc@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Notice that in this particular case, I replaced the
"deliberate fall-through" comment with a proper "fall through"
at the bottom of the case, which is what GCC is expecting to find.

Addresses-Coverity-ID: 1373887 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/mmc/host/tifm_sd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/tifm_sd.c b/drivers/mmc/host/tifm_sd.c
index a3d8380..b6644ce 100644
--- a/drivers/mmc/host/tifm_sd.c
+++ b/drivers/mmc/host/tifm_sd.c
@@ -336,7 +336,8 @@ static unsigned int tifm_sd_op_flags(struct mmc_command *cmd)
 		rc |= TIFM_MMCSD_RSP_R0;
 		break;
 	case MMC_RSP_R1B:
-		rc |= TIFM_MMCSD_RSP_BUSY; // deliberate fall-through
+		rc |= TIFM_MMCSD_RSP_BUSY;
+		/* fall-through */
 	case MMC_RSP_R1:
 		rc |= TIFM_MMCSD_RSP_R1;
 		break;
-- 
2.7.4
