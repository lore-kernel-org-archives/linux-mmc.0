Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93670C48BD1
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Jun 2021 10:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78A22613E9
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Jun 2021 10:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhFKKVu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 11 Jun 2021 06:21:50 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59300 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhFKKVt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Jun 2021 06:21:49 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 58A911FD6C;
        Fri, 11 Jun 2021 10:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623406791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=EEVv8+Y68AKuFcnRR39WUeUcighivtR1a//+t2osEQQ=;
        b=jB/WKsg3tkJNnhcuOxRbJRTWJRVVt8Norn4wRUbtQnh+EcuII3j3KwN/1afeJNOUOrzFwc
        CZDGIMOtD5xTvxc+i75dJwpt481GGMRGx5Ro4Mekh+NcMGH7niEV20Wwzu7OAc6YaXW5L5
        fMDxL540q6wy22TOEzRBpLvk3TCA4Vo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623406791;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=EEVv8+Y68AKuFcnRR39WUeUcighivtR1a//+t2osEQQ=;
        b=W0eCPVfLqLCax/n1FI+p7ycQseWODwo8MORQ8PEtlAcn1nE9if7x97JRpp28PKPOaiIasD
        2kFwUEhzD3SSSoBA==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
        by relay2.suse.de (Postfix) with ESMTP id 46B5EA3BAA;
        Fri, 11 Jun 2021 10:19:51 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mmc: sdhci: Clear unused bounce buffer at DMA mmap error path
Date:   Fri, 11 Jun 2021 12:19:48 +0200
Message-Id: <20210611101948.18972-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

When DMA-mapping of the bounce buffer fails, the driver tries to fall
back, but it leaves the allocated host->bounce_buffer although its
size is zero.  Later on, the driver checks the use of bounce buffer
with host->bounce_buffer pointer, and it tries to use the buffer
incorrectly, resulting in Oops.

This patch clears the release the unused buffer and clears the
bounce_buffer pointer for addressing the problem.

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
v1->v2: correct the device pointer to mmc_dev(mmc)

 drivers/mmc/host/sdhci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index bf238ade1602..c80bc6c4ebf3 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -4072,9 +4072,13 @@ static void sdhci_allocate_bounce_buffer(struct sdhci_host *host)
 					   bounce_size,
 					   DMA_BIDIRECTIONAL);
 	ret = dma_mapping_error(mmc_dev(mmc), host->bounce_addr);
-	if (ret)
+	if (ret) {
+		devm_kfree(mmc_dev(mmc), host->bounce_buffer);
+		host->bounce_buffer = NULL;
 		/* Again fall back to max_segs == 1 */
 		return;
+	}
+
 	host->bounce_buffer_size = bounce_size;
 
 	/* Lie about this since we're bouncing */
-- 
2.26.2

