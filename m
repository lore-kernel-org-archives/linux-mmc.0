From: Venkatraman S <svenkatr@ti.com>
Subject: [RFC PATCH 02/11] mm: Add page swapping markers to memory management
Date: Wed, 18 Apr 2012 11:55:23 +0530
Message-ID: <1334730332-22244-3-git-send-email-svenkatr@ti.com>
References: <1334730332-22244-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1334730332-22244-1-git-send-email-svenkatr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: arnd.bergmann@linaro.org, cjb@laptop.org, alex.limberg@sandisk.com, ilan.smith@sandisk.com, lporzio@micron.com, Alex Lemberg <alex.lemberg@sandisk.com>, Venkatraman S <svenkatr@ti.com>
List-Id: linux-mmc@vger.kernel.org

From: Ilan Smith <ilan.smith@sandisk.com>

Add attribute to identify swap page read requests.
Mark swap read requests with swapin attributes.

Signed-off-by: Ilan Smith <ilan.smith@sandisk.com>
Signed-off-by: Alex Lemberg <alex.lemberg@sandisk.com>
Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 include/linux/bio.h       |    1 +
 include/linux/blk_types.h |    2 ++
 mm/page_io.c              |    3 ++-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 264e0ef..8494b2f 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -63,6 +63,7 @@ static inline bool bio_rw_flagged(struct bio *bio, unsigned long flag)
 }
 
 #define bio_dmpg(bio)	bio_rw_flagged(bio, REQ_RW_DMPG)
+#define bio_swapin(bio)	bio_rw_flagged(bio, REQ_RW_SWAPIN)
 
 /*
  * various member access, note that bio_data should of course not be used
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 87feb80..df2b9ea 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -151,6 +151,7 @@ enum rq_flag_bits {
 	__REQ_IO_STAT,		/* account I/O stat */
 	__REQ_MIXED_MERGE,	/* merge of different types, fail separately */
 	__REQ_RW_DMPG,
+	__REQ_RW_SWAPIN,
 	__REQ_NR_BITS,		/* stops here */
 };
 
@@ -193,5 +194,6 @@ enum rq_flag_bits {
 #define REQ_MIXED_MERGE		(1 << __REQ_MIXED_MERGE)
 #define REQ_SECURE		(1 << __REQ_SECURE)
 #define REQ_RW_DMPG		(1 << __REQ_RW_DMPG)
+#define REQ_RW_SWAPIN		(1 << __REQ_RW_SWAPIN)
 
 #endif /* __LINUX_BLK_TYPES_H */
diff --git a/mm/page_io.c b/mm/page_io.c
index dc76b4d..a148bea 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -128,8 +128,9 @@ int swap_readpage(struct page *page)
 		ret = -ENOMEM;
 		goto out;
 	}
+	bio->bi_rw |= REQ_RW_SWAPIN;
 	count_vm_event(PSWPIN);
-	submit_bio(READ, bio);
+	submit_bio(READ | REQ_RW_SWAPIN, bio);
 out:
 	return ret;
 }
-- 
1.7.10.rc2
