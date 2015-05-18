From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 1/1 linux-next] mmc: mmc-test: use swap() in mmc_test_nonblock_transfer()
Date: Mon, 18 May 2015 19:52:58 +0200
Message-ID: <1431971578-20700-1-git-send-email-fabf@skynet.be>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailrelay116.isp.belgacom.be ([195.238.20.143]:58991 "EHLO
	mailrelay116.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752762AbbERRxI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 May 2015 13:53:08 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Fabian Frederick <fabf@skynet.be>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org

Use kernel.h macro definition.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/mmc/card/mmc_test.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index 5e90b3f..b78cf5d 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -820,9 +820,7 @@ static int mmc_test_nonblock_transfer(struct mmc_test_card *test,
 				mmc_test_nonblock_reset(&mrq1, &cmd1,
 							&stop1, &data1);
 		}
-		done_areq = cur_areq;
-		cur_areq = other_areq;
-		other_areq = done_areq;
+		swap(cur_areq, other_areq);
 		dev_addr += blocks;
 	}
 
-- 
2.4.0

