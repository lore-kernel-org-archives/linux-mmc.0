Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C37C433F5
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Dec 2021 14:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344276AbhLFOdX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Dec 2021 09:33:23 -0500
Received: from smtp2.axis.com ([195.60.68.18]:10560 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245749AbhLFOdW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 6 Dec 2021 09:33:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1638800994;
  x=1670336994;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NeRpLsWyPIeNTXYAGIU96z1OBWXWfVQIvsePl4gHj9M=;
  b=mwfyGhLmZhdubQO/I8qsnWQ2PBfvlEPfmgq+RRmTXqwWVr+N+bXu9Jzl
   nEX540HzJLyHNN6wX//TzuTFsXOGwPIbO18qXBkZLrldP05CvJs3WNvWL
   0q219wo8/rZ0JAojFV2ngqIzNHUnKSj+1FbZU24wr5aJSk9+OFd98Vqoz
   ONdSYUSKhR6cVLuQKkqMg4Am2Ws0z5r2qCVbvQMsxDTKpkejihXgeLv3n
   adNII9NjJCfcn0yFh5j13JXRGxGnyot4vFQReN7FnCmkSd6tCV+qsfhXl
   OyW+O90quR8kFUIhOMSOpF8q17LJmR4aEy1j2LSGuViTMQhWnFE1WVGhg
   Q==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jaehoon Chung <jh80.chung@samsung.com>
CC:     Doug Anderson <dianders@google.com>, <kernel@axis.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH v2 4/4] mmc: dw_mmc: Do not wait for DTO in case of error
Date:   Mon, 6 Dec 2021 15:29:29 +0100
Message-ID: <20211206142929.26729-5-marten.lindahl@axis.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211206142929.26729-1-marten.lindahl@axis.com>
References: <20211206142929.26729-1-marten.lindahl@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

When running the ARTPEC-8 DWMMC IP version, and a data error interrupt
comes during a data read transfer, there is no guarantee for the data
transfer over interrupt (DTO) to come within the specified data timeout.
This case is handled by the dto_timer handler which will complete the
request with the comment:

 /*
  * If DTO interrupt does NOT come in sending data state,
  * we should notify the driver to terminate current transfer
  * and report a data timeout to the core.
  */

But since the ARTPEC-8 DWMMC IP version, supports an extended TMOUT
register which allows longer timeouts than the non ARTPEC-8 version
does, waiting for the dto_timer to complete the request in error cases
may cause the request to take significantly longer time than necessary.
This is specifically true for the failing steps during tuning of a
device.

Fix this by completing the request when the error interrupt comes.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---
 drivers/mmc/host/dw_mmc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 45ea9fd97a6a..d6b76f47b1a2 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2777,11 +2777,19 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 		if (pending & DW_MCI_DATA_ERROR_FLAGS) {
 			spin_lock(&host->irq_lock);
 
+			if (host->quirks & DW_MMC_QUIRK_EXTENDED_TMOUT)
+				del_timer(&host->dto_timer);
+
 			/* if there is an error report DATA_ERROR */
 			mci_writel(host, RINTSTS, DW_MCI_DATA_ERROR_FLAGS);
 			host->data_status = pending;
 			smp_wmb(); /* drain writebuffer */
 			set_bit(EVENT_DATA_ERROR, &host->pending_events);
+
+			if (host->quirks & DW_MMC_QUIRK_EXTENDED_TMOUT)
+				/* In case of error, we cannot expect a DTO */
+				set_bit(EVENT_DATA_COMPLETE, &host->pending_events);
+
 			tasklet_schedule(&host->tasklet);
 
 			spin_unlock(&host->irq_lock);
-- 
2.20.1

