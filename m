From: Johan Rudholm <johan.rudholm@axis.com>
Subject: [PATCH] mmc: sd: warn if card stays busy during init
Date: Fri, 23 May 2014 16:15:03 +0200
Message-ID: <1400854503-9945-1-git-send-email-johanru@axis.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:43530 "EHLO
	bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281AbaEWOWf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 May 2014 10:22:35 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jesper Nilsson <jespern@axis.com>, jrudholm@gmail.com, Johan Rudholm <johanru@axis.com>

The initialization of some SD-cards fails because the card never
leaves the busy state. Aid trouble shooting by indicating this in the
kernel log.

Signed-off-by: Johan Rudholm <johanru@axis.com>
---
 drivers/mmc/core/sd_ops.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index 274ef00..48d0c93 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -184,6 +184,9 @@ int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
 		mmc_delay(10);
 	}
 
+	if (!i)
+		pr_err("%s: card never left busy state\n", mmc_hostname(host));
+
 	if (rocr && !mmc_host_is_spi(host))
 		*rocr = cmd.resp[0];
 
-- 
1.7.2.5

