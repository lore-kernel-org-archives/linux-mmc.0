Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC9CC433F5
	for <linux-mmc@archiver.kernel.org>; Thu,  6 Oct 2022 19:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbiJFTFd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 6 Oct 2022 15:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbiJFTFN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Oct 2022 15:05:13 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1A315710
        for <linux-mmc@vger.kernel.org>; Thu,  6 Oct 2022 12:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=HUwlQNu2A8Q0fF
        NHptilVrUK8zfMtGVtxi2HovyQDxo=; b=IGnW8H4NOtDa07RPsgqtOGmkX3rzPt
        dFFS4SKUo5OwnS9wR+SKhsfyYgv+KlWXliqrnWRvYleWOZ+mIbOzX5hC0qpiDQcX
        Tzm31Y7Z7BFwF/kbzHaGOYIRGxX7SYrfjnbexV7FWKW+MsX94KD12zN4kpTgojGo
        /SvBH6AJR5IXE=
Received: (qmail 1467592 invoked from network); 6 Oct 2022 21:05:04 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 Oct 2022 21:05:04 +0200
X-UD-Smtp-Session: l3s3148p1@4cXsXmLq+scucrRL
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH RFC 3/6] mmc: tmio: add callback for dma irq
Date:   Thu,  6 Oct 2022 21:04:49 +0200
Message-Id: <20221006190452.5316-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221006190452.5316-1-wsa+renesas@sang-engineering.com>
References: <20221006190452.5316-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

We don't want to rely only on the access_end irq in the future, so
implement a callback for dma irqs.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/tmio_mmc.h      | 1 +
 drivers/mmc/host/tmio_mmc_core.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 501613c74406..873a06a179c8 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -128,6 +128,7 @@ struct tmio_mmc_dma_ops {
 
 	/* optional */
 	void (*end)(struct tmio_mmc_host *host);	/* held host->lock */
+	bool (*dma_irq)(struct tmio_mmc_host *host);
 };
 
 struct tmio_mmc_host {
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 437048bb8027..a73422382a57 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -670,6 +670,9 @@ static bool __tmio_mmc_sdcard_irq(struct tmio_mmc_host *host, int ireg,
 		return true;
 	}
 
+	if (host->dma_ops && host->dma_ops->dma_irq && host->dma_ops->dma_irq(host))
+		return true;
+
 	return false;
 }
 
-- 
2.35.1

