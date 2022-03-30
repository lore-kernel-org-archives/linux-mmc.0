Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B677FC433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Mar 2022 21:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239988AbiC3VTk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Mar 2022 17:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbiC3VTj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Mar 2022 17:19:39 -0400
X-Greylist: delayed 520 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Mar 2022 14:17:51 PDT
Received: from mxout02.lancloud.ru (mxout02.lancloud.ru [45.84.86.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDA05939D
        for <linux-mmc@vger.kernel.org>; Wed, 30 Mar 2022 14:17:51 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 7120722C8A7E
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] mmc: core: block: fix sloppy typing in
 mmc_blk_ioctl_multi_cmd()
To:     Ulf Hansson <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>
Organization: Open Mobile Platform
Message-ID: <eea3b0bd-6091-f005-7189-b5b7868abdb6@omp.ru>
Date:   Thu, 31 Mar 2022 00:09:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Despite mmc_ioc_multi_cmd::num_of_cmds is a 64-bit field, its maximum
value is limited to MMC_IOC_MAX_CMDS (only 255); using a 64-bit local
variable to hold a copy of that field leads to gcc generating ineffective
loop code: despite the source code using an *int* variable for the loop
counters,  the 32-bit object code uses 64-bit unsigned counters.  Also,
gcc has to drop the most significant word of that 64-bit variable when
calling kcalloc() and assigning to mmc_queue_req::ioc_count anyway.
Using the *unsigned int* variable instead results in a better code.

Found by Linux Verification Center (linuxtesting.org) with the SVACE static
analysis tool.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the 'next' branch of Ulf Hansson's 'mmc.git' repo.

 drivers/mmc/core/block.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

Index: mmc/drivers/mmc/core/block.c
===================================================================
--- mmc.orig/drivers/mmc/core/block.c
+++ mmc/drivers/mmc/core/block.c
@@ -676,8 +676,9 @@ static int mmc_blk_ioctl_multi_cmd(struc
 	struct mmc_ioc_cmd __user *cmds = user->cmds;
 	struct mmc_card *card;
 	struct mmc_queue *mq;
-	int i, err = 0, ioc_err = 0;
+	int err = 0, ioc_err = 0;
 	__u64 num_of_cmds;
+	unsigned int i, n;
 	struct request *req;
 
 	if (copy_from_user(&num_of_cmds, &user->num_of_cmds,
@@ -690,15 +691,16 @@ static int mmc_blk_ioctl_multi_cmd(struc
 	if (num_of_cmds > MMC_IOC_MAX_CMDS)
 		return -EINVAL;
 
-	idata = kcalloc(num_of_cmds, sizeof(*idata), GFP_KERNEL);
+	n = num_of_cmds;
+	idata = kcalloc(n, sizeof(*idata), GFP_KERNEL);
 	if (!idata)
 		return -ENOMEM;
 
-	for (i = 0; i < num_of_cmds; i++) {
+	for (i = 0; i < n; i++) {
 		idata[i] = mmc_blk_ioctl_copy_from_user(&cmds[i]);
 		if (IS_ERR(idata[i])) {
 			err = PTR_ERR(idata[i]);
-			num_of_cmds = i;
+			n = i;
 			goto cmd_err;
 		}
 		/* This will be NULL on non-RPMB ioctl():s */
@@ -725,18 +727,18 @@ static int mmc_blk_ioctl_multi_cmd(struc
 	req_to_mmc_queue_req(req)->drv_op =
 		rpmb ? MMC_DRV_OP_IOCTL_RPMB : MMC_DRV_OP_IOCTL;
 	req_to_mmc_queue_req(req)->drv_op_data = idata;
-	req_to_mmc_queue_req(req)->ioc_count = num_of_cmds;
+	req_to_mmc_queue_req(req)->ioc_count = n;
 	blk_execute_rq(req, false);
 	ioc_err = req_to_mmc_queue_req(req)->drv_op_result;
 
 	/* copy to user if data and response */
-	for (i = 0; i < num_of_cmds && !err; i++)
+	for (i = 0; i < n && !err; i++)
 		err = mmc_blk_ioctl_copy_to_user(&cmds[i], idata[i]);
 
 	blk_mq_free_request(req);
 
 cmd_err:
-	for (i = 0; i < num_of_cmds; i++) {
+	for (i = 0; i < n; i++) {
 		kfree(idata[i]->buf);
 		kfree(idata[i]);
 	}
