From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 1/2] mmc: wbsd: Remove unneded semicolon
Date: Wed, 16 Sep 2015 11:30:03 +0200
Message-ID: <1442395804-17736-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:36487 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751637AbbIPJaN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 16 Sep 2015 05:30:13 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Pierre Ossman <pierre@ossman.eu>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

It's not needed an is just creating a null statement, so remove it.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/mmc/host/wbsd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
index ca183ea767b3..c3fd16d997ca 100644
--- a/drivers/mmc/host/wbsd.c
+++ b/drivers/mmc/host/wbsd.c
@@ -809,7 +809,7 @@ static void wbsd_request(struct mmc_host *mmc, struct mmc_request *mrq)
 			cmd->error = -EINVAL;
 
 			goto done;
-		};
+		}
 	}
 
 	/*
-- 
2.4.3

