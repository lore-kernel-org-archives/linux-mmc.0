From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH -v2 10/26] mmc: rename random32() to prandom_u32()
Date: Thu,  3 Jan 2013 21:19:06 +0900
Message-ID: <1357215562-6288-11-git-send-email-akinobu.mita@gmail.com>
References: <1357215562-6288-1-git-send-email-akinobu.mita@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1357215562-6288-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Use more preferable function name which implies using a pseudo-random
number generator.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org
---

No change from v1

 drivers/mmc/core/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index aaed768..4b05da5 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -120,8 +120,8 @@ static void mmc_should_fail_request(struct mmc_host *host,
 	    !should_fail(&host->fail_mmc_request, data->blksz * data->blocks))
 		return;
 
-	data->error = data_errors[random32() % ARRAY_SIZE(data_errors)];
-	data->bytes_xfered = (random32() % (data->bytes_xfered >> 9)) << 9;
+	data->error = data_errors[prandom_u32() % ARRAY_SIZE(data_errors)];
+	data->bytes_xfered = (prandom_u32() % (data->bytes_xfered >> 9)) << 9;
 }
 
 #else /* CONFIG_FAIL_MMC_REQUEST */
-- 
1.7.11.7
