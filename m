Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7652FC433E6
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 00:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53F9664F5B
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 00:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbhCDAAj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243029AbhCCRoX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Mar 2021 12:44:23 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3BFC061756;
        Wed,  3 Mar 2021 09:42:50 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id i21so24587808oii.2;
        Wed, 03 Mar 2021 09:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V8VdtQXYDN09uyRdvFGWLLCv0BtBl70U4TGMNFxWvsk=;
        b=eiNtvc6DIc7fJXWHQIi7eK3t4gkBo6+wljNxYJ4bmYqpZDkMF9lYXRR+1GeLLkg8++
         hRKEr7ZVWzBUfM/PHJ7vsArNsxUMAj36eEIxyklgfKZAXbFSx0KI320MRHFJM+RDk00R
         Uj8XGEG231KeL5kt99vvl1xKd25wokgACiOuSq2kMykXRa1EKQ51JWvvfFlID7AcWdYd
         IWe8uIo0DHyw4JN9L+mrBOxDpr2Fq6MnE1jFx6NEaUgWq6AZGC510n4UQCCn90bx9kmg
         AOH4IaHvmxexZK2/C5guXYx2qQJhXFBVXeb9Aki5tg5jUwTPNe2lBsUhCtHJz4wU4aPp
         fKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V8VdtQXYDN09uyRdvFGWLLCv0BtBl70U4TGMNFxWvsk=;
        b=gmnuNOUr1X9j2SjZcu3Iz1Zc1yHY9KW+zq/ieJV89ATDNsyY/Mj9FUWT+IztNdbYjt
         N9FGhPr6N89JXOdxxk+ImnLFF2YxBXi9cFKAo8mBfgTt2pY5gkBlRwuxVg5iDkVClKXZ
         JGrh7dEqUCLKCjztLS4kzfWBevrM50BSPXHOs8ZzxdxJDELXnCWejsX75OTd7tlzJ6yR
         gXdb77XyhqIkdL2ZCV0RwcLBOv/b96SIZDhb/dhN201r/69dcccZXJ2ZimYIigV3wsCo
         ldROKh3yVWQQHx6TWgJ0hMKrV1A+cMl45bpFj7yyamRHm0IsE8aiC62T13RJQtHGo/Gb
         /1zQ==
X-Gm-Message-State: AOAM531aHUYbtqAg2eIOlzzfLIreaJgBH+K40wxMbIkl2z7K/U1ufIQ6
        WPdUJCtteKpBHySLAT1sMug=
X-Google-Smtp-Source: ABdhPJxiePPrQ0snF3RwizYrHyFQFMG97OHMNPdmHiZm2MqdGwGNxIqVhCUW0RlemfHF+W2+rQT6/Q==
X-Received: by 2002:a05:6808:14ce:: with SMTP id f14mr8058486oiw.59.1614793370042;
        Wed, 03 Mar 2021 09:42:50 -0800 (PST)
Received: from ruiqi-desktop.lan (072-177-087-193.res.spectrum.com. [72.177.87.193])
        by smtp.gmail.com with ESMTPSA id r13sm4791277oot.41.2021.03.03.09.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 09:42:49 -0800 (PST)
From:   Frank Li <lznuaa@gmail.com>
X-Google-Original-From: Frank Li <Frank.Li@nxp.com>
To:     lznuaa@gmail.com, adrian.hunter@intel.com, riteshh@codeaurora.org,
        asutoshd@codeaurora.org, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        haibo.chen@nxp.com
Subject: [PATCH v2 1/1] mmc: cqhci: fix random crash when remove mmc module
Date:   Wed,  3 Mar 2021 11:42:48 -0600
Message-Id: <20210303174248.542175-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

[ 6684.493350] Unable to handle kernel paging request at virtual address ffff800011c5b0f0
[ 6684.498531] mmc0: card 0001 removed
[ 6684.501556] Mem abort info:
[ 6684.509681]   ESR = 0x96000047
[ 6684.512786]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 6684.518394]   SET = 0, FnV = 0
[ 6684.521707]   EA = 0, S1PTW = 0
[ 6684.524998] Data abort info:
[ 6684.528236]   ISV = 0, ISS = 0x00000047
[ 6684.532986]   CM = 0, WnR = 1
[ 6684.536129] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000081b22000
[ 6684.543923] [ffff800011c5b0f0] pgd=00000000bffff003, p4d=00000000bffff003, pud=00000000bfffe003, pmd=00000000900e1003, pte=0000000000000000
[ 6684.557915] Internal error: Oops: 96000047 [#1] PREEMPT SMP
[ 6684.564240] Modules linked in: sdhci_esdhc_imx(-) sdhci_pltfm sdhci cqhci mmc_block mmc_core fsl_jr_uio caam_jr caamkeyblob_desc caamhash_desc caamalg_desc crypto_engine rng_core authenc libdes crct10dif_ce flexcan can_dev caam error [last unloaded: mmc_core]
[ 6684.587281] CPU: 0 PID: 79138 Comm: kworker/0:3H Not tainted 5.10.9-01410-g3ba33182767b-dirty #10
[ 6684.596160] Hardware name: Freescale i.MX8DXL EVK (DT)
[ 6684.601320] Workqueue: kblockd blk_mq_run_work_fn

[ 6684.606094] pstate: 40000005 (nZcv daif -PAN -UAO -TCO BTYPE=--)
[ 6684.612286] pc : cqhci_request+0x148/0x4e8 [cqhci]
^GMessage from syslogd@  at Thu Jan  1 01:51:24 1970 ...[ 6684.617085] lr : cqhci_request+0x314/0x4e8 [cqhci]
[ 6684.626734] sp : ffff80001243b9f0
[ 6684.630049] x29: ffff80001243b9f0 x28: ffff00002c3dd000
[ 6684.635367] x27: 0000000000000001 x26: 0000000000000001
[ 6684.640690] x25: ffff00002c451000 x24: 000000000000000f
[ 6684.646007] x23: ffff000017e71c80 x22: ffff00002c451000
[ 6684.651326] x21: ffff00002c0f3550 x20: ffff00002c0f3550
[ 6684.656651] x19: ffff000017d46880 x18: ffff00002cea1500
[ 6684.661977] x17: 0000000000000000 x16: 0000000000000000
[ 6684.667294] x15: 000001ee628e3ed1 x14: 0000000000000278
[ 6684.672610] x13: 0000000000000001 x12: 0000000000000001
[ 6684.677927] x11: 0000000000000000 x10: 0000000000000000
[ 6684.683243] x9 : 000000000000002b x8 : 0000000000001000
[ 6684.688560] x7 : 0000000000000010 x6 : ffff00002c0f3678
[ 6684.693886] x5 : 000000000000000f x4 : ffff800011c5b000
[ 6684.699211] x3 : 000000000002d988 x2 : 0000000000000008
[ 6684.704537] x1 : 00000000000000f0 x0 : 0002d9880008102f
[ 6684.709854] Call trace:
[ 6684.712313]  cqhci_request+0x148/0x4e8 [cqhci]
[ 6684.716803]  mmc_cqe_start_req+0x58/0x68 [mmc_core]
[ 6684.721698]  mmc_blk_mq_issue_rq+0x460/0x810 [mmc_block]
[ 6684.727018]  mmc_mq_queue_rq+0x118/0x2b0 [mmc_block]

cqhci_request was called after cqhci_disable.

cqhci_disable                                 cqhci_request
{                                             {
	dmam_free_coherent();  (1) free
                                                  if(!cq_host->enable)
                                                       return
				         (2) pass check here
	cq_host->enable = false;

                                                  task_desc= get_desc(cq_host,tag);
                                                             ^^^^ crash here
                                         (3) access memory which is already free

}                                             }

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Change from v1 to v2
 - use Adrian Hunter suggested method to fix this problem

 drivers/mmc/core/bus.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index c2e70b757dd1..4383c262b3f5 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -399,11 +399,6 @@ void mmc_remove_card(struct mmc_card *card)
 	mmc_remove_card_debugfs(card);
 #endif
 
-	if (host->cqe_enabled) {
-		host->cqe_ops->cqe_disable(host);
-		host->cqe_enabled = false;
-	}
-
 	if (mmc_card_present(card)) {
 		if (mmc_host_is_spi(card->host)) {
 			pr_info("%s: SPI card removed\n",
@@ -416,6 +411,10 @@ void mmc_remove_card(struct mmc_card *card)
 		of_node_put(card->dev.of_node);
 	}
 
+	if (host->cqe_enabled) {
+		host->cqe_ops->cqe_disable(host);
+		host->cqe_enabled = false;
+	}
+
 	put_device(&card->dev);
 }
-
-- 
2.25.1

