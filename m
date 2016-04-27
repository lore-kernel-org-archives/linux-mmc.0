From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH v3 5/5] mmc: tmio: document CTL_STATUS handling
Date: Wed, 27 Apr 2016 18:51:27 +0200
Message-ID: <1461775887-12786-6-git-send-email-wsa@the-dreams.de>
References: <1461775887-12786-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1461775887-12786-1-git-send-email-wsa@the-dreams.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Now that reading CTL_STATUS is consistent, we can remove CTL_STATUS2 and
document how this is handled internally.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/tmio_mmc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 8dd5ea4be0a371..1aac2ad8edf265 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -30,8 +30,9 @@
 #define CTL_STOP_INTERNAL_ACTION 0x08
 #define CTL_XFER_BLK_COUNT 0xa
 #define CTL_RESPONSE 0x0c
+/* driver merges STATUS and following STATUS2 */
 #define CTL_STATUS 0x1c
-#define CTL_STATUS2 0x1e
+/* driver merges IRQ_MASK and following IRQ_MASK2 */
 #define CTL_IRQ_MASK 0x20
 #define CTL_SD_CARD_CLK_CTL 0x24
 #define CTL_SD_XFER_LEN 0x26
-- 
2.7.0
