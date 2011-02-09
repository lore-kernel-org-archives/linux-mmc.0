From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH] mmc: fix the mmc_app_send_scr() for dma transfer
Date: Wed, 09 Feb 2011 13:51:09 +0900
Message-ID: <4D521D3D.8040308@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relmlor1.renesas.com ([210.160.252.171]:52276 "EHLO
	relmlor1.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845Ab1BIEvL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Feb 2011 23:51:11 -0500
Received: from relmlir3.idc.renesas.com ([10.200.68.153])
 by relmlor1.idc.renesas.com ( SJSMS)
 with ESMTP id <0LGC00JT12TA1BE0@relmlor1.idc.renesas.com> for
 linux-mmc@vger.kernel.org; Wed, 09 Feb 2011 13:51:10 +0900 (JST)
Received: from relmlac1.idc.renesas.com ([10.200.69.21])
 by relmlir3.idc.renesas.com ( SJSMS)
 with ESMTP id <0LGC00DNW2TA2HD0@relmlir3.idc.renesas.com> for
 linux-mmc@vger.kernel.org; Wed, 09 Feb 2011 13:51:10 +0900 (JST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org

This patch is based on the commit "af51715079e7fb6b290e1881d63d815dc4de5011":

   * Bugfix to that mmc_send_cxd_data() code:  dma-to-stack is
     unsafe/nonportable, so kmalloc a bounce buffer instead.

The driver may invalidate the mmc_card->csd when host driver uses dma.
So the subroutine also needs kmalloc buffer.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/mmc/core/sd_ops.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index 797cdb5..76af349 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -9,6 +9,7 @@
  * your option) any later version.
  */

+#include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/scatterlist.h>

@@ -252,6 +253,7 @@ int mmc_app_send_scr(struct mmc_card *card, u32 *scr)
 	struct mmc_command cmd;
 	struct mmc_data data;
 	struct scatterlist sg;
+	void *data_buf;

 	BUG_ON(!card);
 	BUG_ON(!card->host);
@@ -263,6 +265,13 @@ int mmc_app_send_scr(struct mmc_card *card, u32 *scr)
 	if (err)
 		return err;

+	/* dma onto stack is unsafe/nonportable, but callers to this
+	 * routine normally provide temporary on-stack buffers ...
+	 */
+	data_buf = kmalloc(sizeof(card->raw_scr), GFP_KERNEL);
+	if (data_buf == NULL)
+		return -ENOMEM;
+
 	memset(&mrq, 0, sizeof(struct mmc_request));
 	memset(&cmd, 0, sizeof(struct mmc_command));
 	memset(&data, 0, sizeof(struct mmc_data));
@@ -280,12 +289,15 @@ int mmc_app_send_scr(struct mmc_card *card, u32 *scr)
 	data.sg = &sg;
 	data.sg_len = 1;

-	sg_init_one(&sg, scr, 8);
+	sg_init_one(&sg, data_buf, 8);

 	mmc_set_data_timeout(&data, card);

 	mmc_wait_for_req(card->host, &mrq);

+	memcpy(scr, data_buf, sizeof(card->raw_scr));
+	kfree(data_buf);
+
 	if (cmd.error)
 		return cmd.error;
 	if (data.error)
-- 
1.7.1
