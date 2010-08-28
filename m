From: Chris Ball <cjb@laptop.org>
Subject: [PATCH RESEND 2.6.32-rc8 1/3] mmc: Unify and generalize
	UNSTUFF_BITS macro
Date: Sat, 28 Aug 2010 02:21:37 +0100
Message-ID: <20100828012136.GA5770@void.printf.net>
References: <873a3wsncj.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:58355 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751922Ab0H1BVj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 27 Aug 2010 21:21:39 -0400
Content-Disposition: inline
In-Reply-To: <873a3wsncj.fsf@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: don.mullis@gmail.com
Cc: linux-mmc@vger.kernel.org

Hi,

No replies on the list, and not merged; any comments on these three 
patches from Don?

- Chris.

Date: Sun, 29 Nov 2009 19:28:12 -0800
From: don.mullis@gmail.com

Unify duplicated implementations of UNSTUFF_BITS() into a shared .h file.
Recode UNSTUFF_BITS() as an invocation of a new more general macro
UNSTUFF_BITS_ARRAY() that works on arrays of any multiple of 32 bits.

Signed-off-by: don.mullis@gmail.com
---
 drivers/mmc/core/core.h |   21 +++++++++++++++++++++
 drivers/mmc/core/mmc.c  |   14 --------------
 drivers/mmc/core/sd.c   |   14 --------------
 3 files changed, 21 insertions(+), 28 deletions(-)

Index: linux-2.6/drivers/mmc/core/sd.c
===================================================================
--- linux-2.6.orig/drivers/mmc/core/sd.c	2009-11-02 13:02:23.000000000 -0800
+++ linux-2.6/drivers/mmc/core/sd.c	2009-11-02 15:10:28.000000000 -0800
@@ -41,20 +41,6 @@ static const unsigned int tacc_mant[] = 
 	35,	40,	45,	50,	55,	60,	70,	80,
 };
 
-#define UNSTUFF_BITS(resp,start,size)					\
-	({								\
-		const int __size = size;				\
-		const u32 __mask = (__size < 32 ? 1 << __size : 0) - 1;	\
-		const int __off = 3 - ((start) / 32);			\
-		const int __shft = (start) & 31;			\
-		u32 __res;						\
-									\
-		__res = resp[__off] >> __shft;				\
-		if (__size + __shft > 32)				\
-			__res |= resp[__off-1] << ((32 - __shft) % 32);	\
-		__res & __mask;						\
-	})
-
 /*
  * Given the decoded CSD structure, decode the raw CID to our CID structure.
  */
Index: linux-2.6/drivers/mmc/core/core.h
===================================================================
--- linux-2.6.orig/drivers/mmc/core/core.h	2009-11-02 13:02:23.000000000 -0800
+++ linux-2.6/drivers/mmc/core/core.h	2009-11-02 15:12:01.000000000 -0800
@@ -13,6 +13,27 @@
 
 #include <linux/delay.h>
 
+#define UNSTUFF_BITS_ARRAY(u32_array, start, size)			\
+	({								\
+		const int __size = size;				\
+		const u32 __mask = (__size < 32 ? 1 << __size : 0) - 1;	\
+		const int __off = (sizeof(u32_array)/4-1) - ((start) / 32); \
+		const int __shft = (start) & 31;			\
+		u32 __res;						\
+									\
+		__res = (u32_array)[__off] >> __shft;			\
+		if (__size + __shft > 32)				\
+			__res |= (u32_array)[__off-1]			\
+				<< ((32 - __shft) % 32); 		\
+		__res & __mask;						\
+	})
+
+/*
+ * Specific to 128-bit arrays, e.g. raw_cid[] and raw_csd[].
+ */
+#define UNSTUFF_BITS(resp, start, size)	\
+	UNSTUFF_BITS_ARRAY(*(u32(*)[4])resp, start, size)
+
 #define MMC_CMD_RETRIES        3
 
 struct mmc_bus_ops {
Index: linux-2.6/drivers/mmc/core/mmc.c
===================================================================
--- linux-2.6.orig/drivers/mmc/core/mmc.c	2009-11-02 13:02:23.000000000 -0800
+++ linux-2.6/drivers/mmc/core/mmc.c	2009-11-02 13:02:23.000000000 -0800
@@ -39,20 +39,6 @@ static const unsigned int tacc_mant[] = 
 	35,	40,	45,	50,	55,	60,	70,	80,
 };
 
-#define UNSTUFF_BITS(resp,start,size)					\
-	({								\
-		const int __size = size;				\
-		const u32 __mask = (__size < 32 ? 1 << __size : 0) - 1;	\
-		const int __off = 3 - ((start) / 32);			\
-		const int __shft = (start) & 31;			\
-		u32 __res;						\
-									\
-		__res = resp[__off] >> __shft;				\
-		if (__size + __shft > 32)				\
-			__res |= resp[__off-1] << ((32 - __shft) % 32);	\
-		__res & __mask;						\
-	})
-
 /*
  * Given the decoded CSD structure, decode the raw CID to our CID structure.
  */
--

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
