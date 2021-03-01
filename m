Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03951C433DB
	for <linux-mmc@archiver.kernel.org>; Mon,  1 Mar 2021 17:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4B4B6528F
	for <linux-mmc@archiver.kernel.org>; Mon,  1 Mar 2021 17:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbhCARbX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 1 Mar 2021 12:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238191AbhCARXn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Mar 2021 12:23:43 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B45C06178B;
        Mon,  1 Mar 2021 09:21:53 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id f33so17172507otf.11;
        Mon, 01 Mar 2021 09:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KREp6LQzb5haoUvJOG6o2G0DkqaHdaBQjLeQ8PnH12A=;
        b=RDLcxj+GXiavErMB3ekUeewhpr8ylixLAZPsdQOOBX58z/fsTZAtbWv3e/U36bFchE
         ey2dt7SiTbJ5/LJaGywpVx6xGI5B/FL8q9XuuQRP4kmAecFia5tG8iaujh9+/6RPuT20
         6//NQ8Dsb/u9lUzag4QQ0fJAj4LY6KgSXsle1D0Fff9MHoIXj2jnrLmcxzCcDOhQ9c7t
         Zp+8sLu5ZU6QC/jwalYdO+yH2QxbveXsn3HwSyCJZXWJgJ5nHfO31yvYHxrqdrIdKhHm
         DxGDKnOCEGzIX8krrQbjNd6lcQuoFH1QLSIhNHt8Cm30nP26lDE6n85zFOL1adYOFmEG
         OZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KREp6LQzb5haoUvJOG6o2G0DkqaHdaBQjLeQ8PnH12A=;
        b=OaxxN7KR8U0PDp+XtPRQg7PfZ8JxDipdDIf2KX4OLpwX+kC61NPAVib8tU6Lahn0vw
         dpKTL2beSwH3hWFlqXq8J0QczhdHhGPp9U2+5SnrJOSgwTig+A7lRssvjQHXwA7HFIlB
         qurs1XCHcbNqMXZdqhw9IpQrdTEiCyywFOAu12b6pObWyxoMuyvccHnQwL3oFxuDAoIN
         GSM+wf3WKsipjr267+VPyW481AhZc2DkI2SabSZQc5GQWdrEuxbewqgGYCHSafa6EvH9
         eyyyst4ez/osYwpjdJYfbG6eYQ3HK476ZydY36yNB7Rl9UjIAcn4QycxF0Gi+l2HE1jD
         xE7g==
X-Gm-Message-State: AOAM531XyI6epV4/L0l5OHD4JPsbNEnOQu2w1nn2ixeZCo61H/yIfzDA
        Q4U1Yda/4Mg4/ySneB0Fzug=
X-Google-Smtp-Source: ABdhPJwRHDasN0khz1OlKgM8sICryHIbFc014s5ob0cMceWTFNJMR1pkpaxiTuihMAcxmoaqmdwfBg==
X-Received: by 2002:a9d:53c5:: with SMTP id i5mr13934391oth.159.1614619313021;
        Mon, 01 Mar 2021 09:21:53 -0800 (PST)
Received: from ruiqi-desktop.lan (072-177-087-193.res.spectrum.com. [72.177.87.193])
        by smtp.gmail.com with ESMTPSA id p66sm2055517oib.53.2021.03.01.09.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 09:21:52 -0800 (PST)
From:   Frank Li <lznuaa@gmail.com>
X-Google-Original-From: Frank Li <Frank.Li@nxp.com>
To:     lznuaa@gmail.com, adrian.hunter@intel.com, riteshh@codeaurora.org,
        asutoshd@codeaurora.org, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        haibo.chen@nxp.com
Subject: [PATCH 1/1] mmc: cqhci: fix random crash when remove mmc module
Date:   Mon,  1 Mar 2021 11:21:51 -0600
Message-Id: <20210301172151.281814-1-Frank.Li@nxp.com>
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
 drivers/mmc/host/cqhci-core.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index 93b0432bb601..36d292261e50 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -389,6 +389,7 @@ static void cqhci_off(struct mmc_host *mmc)
 static void cqhci_disable(struct mmc_host *mmc)
 {
 	struct cqhci_host *cq_host = mmc->cqe_private;
+	unsigned long flags;
 
 	if (!cq_host->enabled)
 		return;
@@ -397,6 +398,11 @@ static void cqhci_disable(struct mmc_host *mmc)
 
 	__cqhci_disable(cq_host);
 
+	/* need wait for cqhci_request finish before free memory */
+	spin_lock_irqsave(&cq_host->lock, flags);
+	cq_host->enabled = false;
+	spin_unlock_irqrestore(&cq_host->lock, flags);
+
 	dmam_free_coherent(mmc_dev(mmc), cq_host->data_size,
 			   cq_host->trans_desc_base,
 			   cq_host->trans_desc_dma_base);
@@ -408,7 +414,6 @@ static void cqhci_disable(struct mmc_host *mmc)
 	cq_host->trans_desc_base = NULL;
 	cq_host->desc_base = NULL;
 
-	cq_host->enabled = false;
 }
 
 static void cqhci_prep_task_desc(struct mmc_request *mrq,
@@ -612,6 +617,13 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 			cq_host->ops->enable(mmc);
 	}
 
+	spin_lock_irqsave(&cq_host->lock, flags);
+	if (!cq_host->enabled) {
+		pr_err("%s: cqhci: not enabled\n", mmc_hostname(mmc));
+		err = -EINVAL;
+		goto out_unlock;
+	}
+
 	if (mrq->data) {
 		cqhci_prep_task_desc(mrq, cq_host, tag);
 
@@ -619,14 +631,12 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		if (err) {
 			pr_err("%s: cqhci: failed to setup tx desc: %d\n",
 			       mmc_hostname(mmc), err);
-			return err;
+			goto out_unlock;
 		}
 	} else {
 		cqhci_prep_dcmd_desc(mmc, mrq);
 	}
 
-	spin_lock_irqsave(&cq_host->lock, flags);
-
 	if (cq_host->recovery_halt) {
 		err = -EBUSY;
 		goto out_unlock;
-- 
2.25.1

