Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30163C48BD1
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Jun 2021 09:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13BB7613C8
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Jun 2021 09:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhFKJFj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 11 Jun 2021 05:05:39 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33168 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbhFKJFj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Jun 2021 05:05:39 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E2A1721965;
        Fri, 11 Jun 2021 09:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623402220; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=8YCoCRqbOmEh51NxHoLmHsLlkKYsuBLx8KTpCpYe64Q=;
        b=U3+lXwYsQKcVXRhEYlrT/1PslapKoSZDxIG6UFkzvOGaBPqSPcsUA5rsUolUm7ApEtU3lC
        vPDpUkuSaF4LHWAGoLoe60OGCmcfNb2HfSgsdWC8qWaUthQpJxAtmTcnQ3uhD48ahsflk2
        xd980G9HVpeF3Tfyics6AL7nupc59DU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623402220;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=8YCoCRqbOmEh51NxHoLmHsLlkKYsuBLx8KTpCpYe64Q=;
        b=JEZ3F72ca61RfxjewIcXDiRYEUocTp6PJ8smz1ouihGSJG5Fytoi9iQfnmw5G3NgiBPd86
        jTFZi9mE9WC/WQCg==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
        by relay2.suse.de (Postfix) with ESMTP id D1063A3BB3;
        Fri, 11 Jun 2021 09:03:40 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sdhci: Clear unused bounce buffer at DMA mmap error path
Date:   Fri, 11 Jun 2021 11:03:30 +0200
Message-Id: <20210611090330.13039-1-tiwai@suse.de>
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

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/mmc/host/sdhci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index bf238ade1602..5f467b98ca88 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -4072,9 +4072,13 @@ static void sdhci_allocate_bounce_buffer(struct sdhci_host *host)
 					   bounce_size,
 					   DMA_BIDIRECTIONAL);
 	ret = dma_mapping_error(mmc_dev(mmc), host->bounce_addr);
-	if (ret)
+	if (ret) {
+		devm_kfree(mmc->parent, host->bounce_buffer);
+		host->bounce_buffer = NULL;
 		/* Again fall back to max_segs == 1 */
 		return;
+	}
+
 	host->bounce_buffer_size = bounce_size;
 
 	/* Lie about this since we're bouncing */
-- 
2.26.2

