Return-Path: <SRS0=q0fh=CA=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5B7C433E1
	for <linux-mmc@archiver.kernel.org>; Sat, 22 Aug 2020 06:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8317620825
	for <linux-mmc@archiver.kernel.org>; Sat, 22 Aug 2020 06:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmcE3FxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgHVGPj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 22 Aug 2020 02:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgHVGPi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 22 Aug 2020 02:15:38 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934A8C061573;
        Fri, 21 Aug 2020 23:15:38 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p37so2018709pgl.3;
        Fri, 21 Aug 2020 23:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fifKzZY0qdLJQEBEXEYD5nOp3Oo8eoTT9qv7E8Okxdc=;
        b=gmcE3FxIz1pTECEv7Ib3E7T5Q1/clFxcPTQ82pECSXX1SBdFSS5sh/vs46N2nrXOnH
         55F5ds+g1H5UhDYGIb2+nAybwJU/vbLnkQ26WLuCPcAkGQjv2oMuAnSfL6v72sSxTlqF
         kO0rrOydaddclOE4zgsWILDjGVC2o+r4DNt/xbr8d+i9dpCEYnL/+Pu/4ukYCIRSlvO8
         YWWMS8sPSpiBX1cWDmxDSXDyfpvItqh1lrS3ml2zDTa3d3uEtRNjSzmMOsxEPWD5HbT+
         WmEdwWDoAqi+cxXB3IkjhCVjgi6wseVq84mV5As01fXgiZS6KejhjyT3WPyIAk6Di9Bi
         ZGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fifKzZY0qdLJQEBEXEYD5nOp3Oo8eoTT9qv7E8Okxdc=;
        b=AKxZs/sRQzEwvxb6AcBssqJI9d+9zmOdp2FPuPlM8S5JMFWDihbRavZbd+UMcmRpMA
         9sNoJHB6wOiCbGv1yYsl2oyKoQ9WkVN+2Biqi6aUGMMr81+/PzPG1+LjnWOwMERHpwD+
         oCwwUqLFyzgHLvOvKKsd4iHG17Xgc/Miz6oaZZpKiegn8ehN+RYJ5mP17nf5ZsNP5FE9
         zFSlvcLjF0GKnGtNzaRUKem/C5+/7vnkHnwjluMEKUC7CkFatxmi96Ctm5/+EVeiB2oh
         WM4L3yC+EKpNqf9EPqCYgRUU8scXUqPWna5R1b/YkRhYhbe/aT65xiYFE1XzsS5ddL44
         BZGQ==
X-Gm-Message-State: AOAM531Ktg68fvRiqrC/BZ93ypcmAPhBcy09ZRwJh0Qj7/V82tsy7/Py
        oNp46WqM26QhV59KKwJNdukrY/A1fg==
X-Google-Smtp-Source: ABdhPJz5qi9VrfyPvyxtw7BqJcL/06LNMaxTH7wjLMfxubkMec2ovTR9LavX0xdm50tnrICSb3/XZQ==
X-Received: by 2002:a62:5fc6:: with SMTP id t189mr5222464pfb.138.1598076938059;
        Fri, 21 Aug 2020 23:15:38 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:cfa:ae3e:f998:8f12:465c:736b])
        by smtp.gmail.com with ESMTPSA id y20sm4440244pfn.183.2020.08.21.23.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 23:15:37 -0700 (PDT)
From:   madhuparnabhowmik10@gmail.com
To:     brucechang@via.com.tw, HaraldWelte@viatech.com,
        ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrianov@ispras.ru, ldv-project@linuxtesting.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: [PATCH v2] drivers: mmc: host: via-sdmmc: Fix data race bug
Date:   Sat, 22 Aug 2020 11:45:28 +0530
Message-Id: <20200822061528.7035-1-madhuparnabhowmik10@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

via_save_pcictrlreg() should be called with host->lock held
as it writes to pm_pcictrl_reg, otherwise there can be a race
condition between via_sd_suspend() and via_sdc_card_detect().
The same pattern is used in the function via_reset_pcictrl()
as well, where via_save_pcictrlreg() is called with host->lock
held.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
---
v2: Rebase v5.9-rc1

 drivers/mmc/host/via-sdmmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
index 49dab9f42b6d..9b755ea0fa03 100644
--- a/drivers/mmc/host/via-sdmmc.c
+++ b/drivers/mmc/host/via-sdmmc.c
@@ -1257,11 +1257,14 @@ static void __maybe_unused via_init_sdc_pm(struct via_crdr_mmc_host *host)
 static int __maybe_unused via_sd_suspend(struct device *dev)
 {
 	struct via_crdr_mmc_host *host;
+	unsigned long flags;
 
 	host = dev_get_drvdata(dev);
 
+	spin_lock_irqsave(&host->lock, flags);
 	via_save_pcictrlreg(host);
 	via_save_sdcreg(host);
+	spin_unlock_irqrestore(&host->lock, flags);
 
 	device_wakeup_enable(dev);
 
-- 
2.17.1

