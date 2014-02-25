From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 10/10] mmc: dw_mmc: Fix NULL pointer dereference
Date: Tue, 25 Feb 2014 15:18:28 +0530
Message-ID: <1393321708-9719-10-git-send-email-sachin.kamat@linaro.org>
References: <1393321708-9719-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:45555 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318AbaBYJye (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Feb 2014 04:54:34 -0500
Received: by mail-pb0-f50.google.com with SMTP id rq2so7917942pbb.9
        for <linux-mmc@vger.kernel.org>; Tue, 25 Feb 2014 01:54:34 -0800 (PST)
In-Reply-To: <1393321708-9719-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, sachin.kamat@linaro.org

If mrq->sbc is not NULL but data->stop happens to be NULL,
it will lead to NULL pointer dereferencing. Avoid this by
having a NULL check for data->stop.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 55cd110a49c4..0c56faa6730e 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1345,7 +1345,7 @@ static void dw_mci_tasklet_func(unsigned long priv)
 
 			if (!err) {
 				if (!data->stop || mrq->sbc) {
-					if (mrq->sbc)
+					if (mrq->sbc && data->stop)
 						data->stop->error = 0;
 					dw_mci_request_end(host, mrq);
 					goto unlock;
-- 
1.7.9.5

