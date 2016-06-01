From: Michal Kadlic <michal.kadlic@spinet.sk>
Subject: mmc-moxart: CMD6 locks up the controller
Date: Wed, 1 Jun 2016 15:10:20 +0200
Message-ID: <298c9ee5-37c7-6120-196d-860ec8eb0f9c@spinet.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.spinet.sk ([212.89.230.194]:34107 "EHLO mail.spinet.sk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758158AbcFANQb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 1 Jun 2016 09:16:31 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jonas Jensen <jonas.jensen@gmail.com>

Hello,

newbie here, please bear with me...

It seems that CMD6/SD_SWITCH request locks up the mmc-moxart controller. 
It does not respond to any command after CMD6.
The fix suggested by Mr. Jonas Jensen <jonas.jensen@gmail.com>  is to 
ignore the SD_SWITCH request in moxart_request()
My question is - looking at mmc_read_switch() in drivers/mmc/core/sd.c - 
would be -EINVAL a proper response in this case?

This diff is against kernel 4.6.

Best regards,
Michal Kadlic
---

diff -purN a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
--- a/drivers/mmc/host/moxart-mmc.c     2016-06-01 14:23:01.000000000 +0200
+++ b/drivers/mmc/host/moxart-mmc.c     2016-06-01 14:37:08.856296102 +0200
@@ -411,6 +411,14 @@ static void moxart_request(struct mmc_ho
                 mrq->cmd->error = -ETIMEDOUT;
                 goto request_done;
         }
+
+       if (mrq->cmd->opcode == SD_SWITCH) {
+
+                /* CMD6 (at least in mode 0) locks up the controller
+                 * so we have to ignore this request */
+                mrq->cmd->error = -EINVAL;
+                goto request_done;
+        }

         moxart_prepare_data(host);
         moxart_send_command(host, host->mrq->cmd)
