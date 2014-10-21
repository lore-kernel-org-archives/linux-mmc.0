From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 02/15] mmc: core: Remove duplicated definition of mmc_send_ext_csd()
Date: Tue, 21 Oct 2014 19:19:00 +0200
Message-ID: <1413911953-19012-3-git-send-email-ulf.hansson@linaro.org>
References: <1413911953-19012-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:47565 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933114AbaJURT0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Oct 2014 13:19:26 -0400
Received: by mail-lb0-f182.google.com with SMTP id z11so1432275lbi.27
        for <linux-mmc@vger.kernel.org>; Tue, 21 Oct 2014 10:19:22 -0700 (PDT)
In-Reply-To: <1413911953-19012-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>

mmc_send_ext_csd() is an exported function used by both the mmc core
and the mmc block layer. Let's remove the local duplicated definition
in the mmc core.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc_ops.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 390dac6..f752ec6 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -20,7 +20,6 @@ int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr);
 int mmc_all_send_cid(struct mmc_host *host, u32 *cid);
 int mmc_set_relative_addr(struct mmc_card *card);
 int mmc_send_csd(struct mmc_card *card, u32 *csd);
-int mmc_send_ext_csd(struct mmc_card *card, u8 *ext_csd);
 int mmc_send_status(struct mmc_card *card, u32 *status);
 int mmc_send_cid(struct mmc_host *host, u32 *cid);
 int mmc_spi_read_ocr(struct mmc_host *host, int highcap, u32 *ocrp);
-- 
1.9.1

