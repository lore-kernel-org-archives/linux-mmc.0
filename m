Return-Path: <SRS0=cqRv=AC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32FDC433DF
	for <linux-mmc@archiver.kernel.org>; Sun, 21 Jun 2020 02:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81A13247C8
	for <linux-mmc@archiver.kernel.org>; Sun, 21 Jun 2020 02:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592708042;
	bh=8kz0YS2YpXAP78yJ5e4pDrntY+2vR5l3xnCBVIzu5io=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=VKoQ1Y+kqxDy7GZLsdzt7+l9r1niru1OIFM0vJgbfyV6KBrcgj3IEuFtvJ4Vep2y9
	 rCHWLtMONcnlyBTrTaH9PEXEqpLaDZPY7duWMzG5EM7Tfmw9K+mhWZLb9lZpt0IMd6
	 FFy8J8Y34S6lgzX+bI1YTQSDvhyuZTNayLl6a0LM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgFUCyB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 20 Jun 2020 22:54:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728992AbgFUCyB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 20 Jun 2020 22:54:01 -0400
Received: from Mani-XPS-13-9360.localdomain (unknown [157.50.185.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BC12247AF;
        Sun, 21 Jun 2020 02:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592708041;
        bh=8kz0YS2YpXAP78yJ5e4pDrntY+2vR5l3xnCBVIzu5io=;
        h=From:To:Cc:Subject:Date:From;
        b=MkmXiACrOD/CQ+R0OcgDaSmrMSBNtwmVcOliTbhfTRdv+8ukxaJxc5XKrB1BU1Uww
         WGUFIcBENadA6UIj0NCww9g6Igu6mWztI8mqCnpp54vVrt6bvmSkTYgLAr4h2LMygJ
         iisi/tz0tzEA7birQe0bw/wIqRpOWPmYwxTxEdhE=
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     ulf.hansson@linaro.org
Cc:     afaerber@suse.de, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH] mmc: owl-mmc: Get rid of of_match_ptr() macro
Date:   Sun, 21 Jun 2020 08:23:30 +0530
Message-Id: <20200621025330.10561-1-mani@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Remove the 'of_match_ptr()' macro to fix the warning when CONFIG_OF is
not selected.

drivers/mmc/host/owl-mmc.c:677:34: warning: unused variable 'owl_mmc_of_match'
[-Wunused-const-variable]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/mmc/host/owl-mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/owl-mmc.c b/drivers/mmc/host/owl-mmc.c
index 5e20c099fe03..df43f42855e2 100644
--- a/drivers/mmc/host/owl-mmc.c
+++ b/drivers/mmc/host/owl-mmc.c
@@ -689,7 +689,7 @@ MODULE_DEVICE_TABLE(of, owl_mmc_of_match);
 static struct platform_driver owl_mmc_driver = {
 	.driver = {
 		.name	= "owl_mmc",
-		.of_match_table = of_match_ptr(owl_mmc_of_match),
+		.of_match_table = owl_mmc_of_match,
 	},
 	.probe		= owl_mmc_probe,
 	.remove		= owl_mmc_remove,
-- 
2.17.1

