From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] mmc: goldfish: use resource_size() macro
Date: Wed, 13 Mar 2013 13:35:41 +0800
Message-ID: <CAPgLHd-iO6waDExMjctAdAa_YmdDATOD8yTfcCFtnfF56r1C9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f54.google.com ([209.85.214.54]:43980 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932Ab3CMFfn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Mar 2013 01:35:43 -0400
Received: by mail-bk0-f54.google.com with SMTP id w5so254595bku.27
        for <linux-mmc@vger.kernel.org>; Tue, 12 Mar 2013 22:35:41 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, yunhong.jiang@intel.com, sheng@linux.intel.com, mikechan@google.com, xiaohui.xin@intel.com, jun.nakajima@intel.com
Cc: yongjun_wei@trendmicro.com.cn, linux-mmc@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Use resource_size function on resource object
instead of explicit computation.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/mmc/host/android-goldfish.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/android-goldfish.c b/drivers/mmc/host/android-goldfish.c
index ef3aef0..7780c14 100644
--- a/drivers/mmc/host/android-goldfish.c
+++ b/drivers/mmc/host/android-goldfish.c
@@ -476,7 +476,7 @@ static int goldfish_mmc_probe(struct platform_device *pdev)
 	host->mmc = mmc;
 
 	pr_err("mmc: Mapping %lX to %lX\n", (long)res->start, (long)res->end);
-	host->reg_base = ioremap(res->start, res->end - res->start + 1);
+	host->reg_base = ioremap(res->start, resource_size(res));
 	if (host->reg_base == NULL) {
 		ret = -ENOMEM;
 		goto ioremap_failed;


