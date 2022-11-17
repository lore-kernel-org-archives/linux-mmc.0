Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D489AC433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Nov 2022 07:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiKQHYj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 17 Nov 2022 02:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239065AbiKQHYi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Nov 2022 02:24:38 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8414299C
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2022 23:24:33 -0800 (PST)
Received: from mxde.zte.com.cn (unknown [10.35.20.165])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NCWdC4grRz1Dsj
        for <linux-mmc@vger.kernel.org>; Thu, 17 Nov 2022 15:24:31 +0800 (CST)
Received: from mxus.zte.com.cn (unknown [10.207.168.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxde.zte.com.cn (FangMail) with ESMTPS id 4NCWd809FWz64Wdn
        for <linux-mmc@vger.kernel.org>; Thu, 17 Nov 2022 15:24:28 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxus.zte.com.cn (FangMail) with ESMTPS id 4NCWd43jN4zdmc16
        for <linux-mmc@vger.kernel.org>; Thu, 17 Nov 2022 15:24:24 +0800 (CST)
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NCWd14Fppz8R041
        for <linux-mmc@vger.kernel.org>; Thu, 17 Nov 2022 15:24:21 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NCWcy6Fz6z4y0vK;
        Thu, 17 Nov 2022 15:24:18 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2AH7O9Qq090542;
        Thu, 17 Nov 2022 15:24:09 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 17 Nov 2022 15:24:11 +0800 (CST)
Date:   Thu, 17 Nov 2022 15:24:11 +0800 (CST)
X-Zmail-TransId: 2af96375e19b4b0447f0
X-Mailer: Zmail v1.0
Message-ID: <202211171524116446204@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <ulf.hansson@linaro.org>
Cc:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIG1tYzogcHdyc2VxOiBVc2UgZGV2aWNlX21hdGNoX29mX25vZGUoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2AH7O9Qq090542
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.14.novalocal with ID 6375E1AE.001 by FangMail milter!
X-FangMail-Envelope: 1668669871/4NCWdC4grRz1Dsj/6375E1AE.001/10.35.20.165/[10.35.20.165]/mxde.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6375E1AE.001/4NCWdC4grRz1Dsj
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Replace the open-code with device_match_of_node().

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/mmc/core/pwrseq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/pwrseq.c b/drivers/mmc/core/pwrseq.c
index ef675f364bf0..2374669b588a 100644
--- a/drivers/mmc/core/pwrseq.c
+++ b/drivers/mmc/core/pwrseq.c
@@ -29,7 +29,7 @@ int mmc_pwrseq_alloc(struct mmc_host *host)

 	mutex_lock(&pwrseq_list_mutex);
 	list_for_each_entry(p, &pwrseq_list, pwrseq_node) {
-		if (p->dev->of_node == np) {
+		if (device_match_of_node(p->dev, np)) {
 			if (!try_module_get(p->owner))
 				dev_err(host->parent,
 					"increasing module refcount failed\n");
-- 
2.25.1
