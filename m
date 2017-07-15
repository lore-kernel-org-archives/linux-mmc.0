From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH] mmc: atmel-mci: add missing of_node_put
Date: Sat, 15 Jul 2017 18:27:41 +0200
Message-ID: <1500136061-12135-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:47196 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751088AbdGOQwl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 15 Jul 2017 12:52:41 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: kernel-janitors@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

for_each_child_of_node performs an of_node_get on each iteration, so a
break out the loop requires an of_node_put.

The semantic patch that fixes this problem is as follows
(http://coccinelle.lip6.fr):

// <smpl>
@@
local idexpression n;
expression e,e1;
iterator name for_each_child_of_node;
@@

 for_each_child_of_node(e1,n) {
   ...
(
   of_node_put(n);
|
   e = n
|
+  of_node_put(n);
?  break;
)
   ...
 }
... when != n
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/mmc/host/atmel-mci.c |    1 +
 1 file changed, 1 insertion(+)

diff -u -p a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -673,6 +673,7 @@ atmci_of_init(struct platform_device *pd
 		if (slot_id >= ATMCI_MAX_NR_SLOTS) {
 			dev_warn(&pdev->dev, "can't have more than %d slots\n",
 			         ATMCI_MAX_NR_SLOTS);
+			of_node_put(cnp);
 			break;
 		}
 

