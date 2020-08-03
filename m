Return-Path: <SRS0=0lJu=BN=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B7DC433E0
	for <linux-mmc@archiver.kernel.org>; Mon,  3 Aug 2020 07:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83800206E2
	for <linux-mmc@archiver.kernel.org>; Mon,  3 Aug 2020 07:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2aThiXp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgHCH3I (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 3 Aug 2020 03:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgHCH3I (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Aug 2020 03:29:08 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDDAC06174A;
        Mon,  3 Aug 2020 00:29:08 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id o1so20286506plk.1;
        Mon, 03 Aug 2020 00:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tlFv8p7PrXE4U8lsxSb50hSc4sf1CRTi/2In4NKS0vI=;
        b=M2aThiXpuOYXtob+rSfmzq8jLCsn9uVeQHWSRRKPyEHhOW1DmGNsbIJzr70VA9ZRuq
         zoDvmdMFS8e1VWlw5ZaK9py20GqaMtKUmO3+yR7I9tDiD1Xbs3UwfNyN4dLtTVfT7Lsh
         o/OVznuBrWxbxDgsVUkrOSttpuUFHwCnbvLE4WOdHoVSPKDzymFNhCSNJ19x3uyUw6qV
         4h2+2mdYq8zAdzGvSf9vglWxzMR687h7fPoCHNNfK7rW2aqSYvAl5N2ycKgRumHaJUaX
         LKIulzL9iZz/lRmMAcYIUqcIloUy6NUtLm0kAlbIMxqP+i+zYNwcihLjROjxHLh/8tm9
         dTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tlFv8p7PrXE4U8lsxSb50hSc4sf1CRTi/2In4NKS0vI=;
        b=d4IxYyxdhSR4OoiR/4tVfJkSGQoq6NhoMhxfzYKkXxbDXLbTkHUlt6IeTT1q2pc62l
         T8Olpi16RRRivvDTiL3EvYex/EgFr2K8uRQKUU0DRPIBhv2LzyOjdJ7BhboAczBk18ia
         kM6ZAfC5R5DiNe6cvGmtITsv+6Ry8Jl6VSYIsar+2TuC86XcYZlHxjHRX6lnbw/BU5Yx
         kcZJLlZGTFf03IvhCld8m7r7yEcdMlCss+FL0ltklbODyGXdXujnm2WUQnvEVZK7lR1Z
         QzkfDgW183MV8rqZvPgNeaQd67ka/eYM4v0syajMT+9Kpia7mQJR7LS6aGt+RAUuCZhn
         zqBw==
X-Gm-Message-State: AOAM533LX3w24iscVul2WAkitajcCgjNDhLCaEzB1DSJQhVhzEIYaszs
        620LSAXfUbLgGktw87mBSA==
X-Google-Smtp-Source: ABdhPJznIV42qbkS5es22IyLBLsXWeUm2B7eWGSnRwo9XZftv8lhKWnhi6HwLyb/GSfnQKoZfxeZVQ==
X-Received: by 2002:a17:90a:a58d:: with SMTP id b13mr16997327pjq.55.1596439747998;
        Mon, 03 Aug 2020 00:29:07 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:ce2:8573:b0b2:951:c50:ed47])
        by smtp.gmail.com with ESMTPSA id o10sm16648105pjo.55.2020.08.03.00.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 00:29:07 -0700 (PDT)
From:   madhuparnabhowmik10@gmail.com
To:     brucechang@via.com.tw, HaraldWelte@viatech.com,
        ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org, andrianov@ispras.ru,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: [PATCH] drivers: mmc: host: via-sdmmc: Fix data race bug
Date:   Mon,  3 Aug 2020 12:58:57 +0530
Message-Id: <20200803072857.8880-1-madhuparnabhowmik10@gmail.com>
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
 drivers/mmc/host/via-sdmmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
index ef95bce50889..e4d8126cd4e5 100644
--- a/drivers/mmc/host/via-sdmmc.c
+++ b/drivers/mmc/host/via-sdmmc.c
@@ -1259,11 +1259,14 @@ static void via_init_sdc_pm(struct via_crdr_mmc_host *host)
 static int via_sd_suspend(struct pci_dev *pcidev, pm_message_t state)
 {
 	struct via_crdr_mmc_host *host;
+	unsigned long flags;
 
 	host = pci_get_drvdata(pcidev);
 
+	spin_lock_irqsave(&host->lock, flags);
 	via_save_pcictrlreg(host);
 	via_save_sdcreg(host);
+	spin_unlock_irqrestore(&host->lock, flags);
 
 	pci_save_state(pcidev);
 	pci_enable_wake(pcidev, pci_choose_state(pcidev, state), 0);
-- 
2.17.1

