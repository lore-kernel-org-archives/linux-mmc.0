Return-Path: <SRS0=joLi=AM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B168C433DF
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Jul 2020 09:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B7B52077D
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Jul 2020 09:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbgGAJxb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:53:31 -0400
Received: from smtp.asem.it ([151.1.184.197]:64358 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbgGAJxb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 1 Jul 2020 05:53:31 -0400
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000352730.MSG 
        for <linux-mmc@vger.kernel.org>; Wed, 01 Jul 2020 11:53:28 +0200S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 1 Jul
 2020 11:53:25 +0200
Received: from flavio-x.asem.intra (172.16.17.208) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 1 Jul 2020 11:53:25 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH v1 1/1] mmc: host: sdhci-msm: fix spelling mistake
Date:   Wed, 1 Jul 2020 11:53:13 +0200
Message-ID: <20200701095313.27507-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A090209.5EFC5D16.0032,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Fix typo: "trigered" --> "triggered"

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
v1: add Acked-by: Adrian Hunter <adrian.hunter@intel.com>

 drivers/mmc/host/sdhci-msm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index b277dd7fbdb5..3f615d0ccb61 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1362,7 +1362,7 @@ static inline void sdhci_msm_complete_pwr_irq_wait(
  * To what state the register writes will change the IO lines should be passed
  * as the argument req_type. This API will check whether the IO line's state
  * is already the expected state and will wait for power irq only if
- * power irq is expected to be trigerred based on the current IO line state
+ * power irq is expected to be triggered based on the current IO line state
  * and expected IO line state.
  */
 static void sdhci_msm_check_power_status(struct sdhci_host *host, u32 req_type)
-- 
2.17.1

