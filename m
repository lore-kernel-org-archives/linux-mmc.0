From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] mmc: dw_mmc: Fix NULL pointer dereference
Date: Wed, 15 Jan 2014 15:59:13 +0530
Message-ID: <1389781753-28217-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:56879 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883AbaAOKda (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2014 05:33:30 -0500
Received: by mail-pb0-f44.google.com with SMTP id rq2so952675pbb.17
        for <linux-mmc@vger.kernel.org>; Wed, 15 Jan 2014 02:33:30 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: chris@printf.net, tgih.jun@samsung.com, jh80.chung@samsung.com, sachin.kamat@linaro.org, patches@linaro.org

If mrq->sbc is not NULL but data->stop happens to be NULL,
it will lead to NULL pointer dereferencing. Avoid this by
having a NULL check for data->stop.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/mmc/host/dw_mmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 9ded62c8225e..8b3e58a5f9ed 100644
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

