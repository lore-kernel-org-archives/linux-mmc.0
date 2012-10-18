From: Sangho Yi <antiroot@gmail.com>
Subject: [PATCH 1/4] mmc: core: sd.c: Added a space after comma on an argument definition
Date: Fri, 19 Oct 2012 02:19:17 +0900
Message-ID: <1350580760-3886-1-git-send-email-antiroot@gmail.com>
References: <n>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43236 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932119Ab2JRRUx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Oct 2012 13:20:53 -0400
In-Reply-To: <n>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: prakity@marvell.com, aaron.lu@amd.com, linus.walleij@linaro.org, ulf.hansson@stericsson.com, cjb@laptop.org
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Sangho Yi <antiroot@gmail.com>

Added a space between comma and an argument on the function definition

Signed-off-by: Sangho Yi <antiroot@gmail.com>
---
 drivers/mmc/core/sd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 74972c2..91a73d7 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -44,7 +44,7 @@ static const unsigned int tacc_mant[] = {
 	35,	40,	45,	50,	55,	60,	70,	80,
 };
 
-#define UNSTUFF_BITS(resp,start,size)					\
+#define UNSTUFF_BITS(resp, start, size)					\
 	({								\
 		const int __size = size;				\
 		const u32 __mask = (__size < 32 ? 1 << __size : 0) - 1;	\
-- 
1.7.9.5

