From: Joe Perches <joe@perches.com>
Subject: [PATCH 11/44] drivers/mmc: Remove unnecessary semicolons
Date: Sun, 14 Nov 2010 19:04:30 -0800
Message-ID: <6391af02ba7ec4a76c5c5f462d8013fc1f52f999.1289789604.git.joe@perches.com>
References: <cover.1289789604.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1289789604.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <trivial@kernel.org>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/mmc/host/davinci_mmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index e15547c..b643dde 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -480,7 +480,7 @@ static void mmc_davinci_send_dma_request(struct mmc_davinci_host *host,
 	struct scatterlist	*sg;
 	unsigned		sg_len;
 	unsigned		bytes_left = host->bytes_left;
-	const unsigned		shift = ffs(rw_threshold) - 1;;
+	const unsigned		shift = ffs(rw_threshold) - 1;
 
 	if (host->data_dir == DAVINCI_MMC_DATADIR_WRITE) {
 		template = &host->tx_template;
-- 
1.7.3.1.g432b3.dirty
