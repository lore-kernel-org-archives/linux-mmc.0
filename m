From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] mmc: mxcmmc: Fix missing parentheses and brace
Date: Thu, 12 Jul 2018 12:59:37 -0700
Message-ID: <20180712195937.GA36007@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Looks like the adjusted syntax wasn't fully build tested. This fixes
failures with powerpc builds:

drivers/mmc/host/mxcmmc.c: In function ‘mxcmci_swap_buffers’:
drivers/mmc/host/mxcmmc.c:296:51: error: expected ‘)’ before ‘;’ token
   void *buf = kmap_atomic(sg_page(sg) + sg->offset;
                                                   ^
drivers/mmc/host/mxcmmc.c:299:1: error: expected ‘,’ or ‘;’ before ‘}’ token
 }
 ^

Fixes: b189e7589f6d3 ("mmc: mxcmmc: handle highmem pages")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/mmc/host/mxcmmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 75f781c11e89..de4e6e5bf304 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -293,9 +293,10 @@ static void mxcmci_swap_buffers(struct mmc_data *data)
 	int i;
 
 	for_each_sg(data->sg, sg, data->sg_len, i) {
-		void *buf = kmap_atomic(sg_page(sg) + sg->offset;
+		void *buf = kmap_atomic(sg_page(sg) + sg->offset);
 		buffer_swap32(buf, sg->length);
 		kunmap_atomic(buf);
+	}
 }
 #else
 static inline void mxcmci_swap_buffers(struct mmc_data *data) {}
-- 
2.17.1


-- 
Kees Cook
Pixel Security
