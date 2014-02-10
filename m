From: Puthikorn Voravootivat <puthik@chromium.org>
Subject: [PATCH v2] mmc: enable trim in eMMC device
Date: Mon, 10 Feb 2014 14:54:51 -0800
Message-ID: <1392072891-21302-1-git-send-email-puthik@chromium.org>
References: <1391798398-24634-1-git-send-email-puthik@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f74.google.com ([209.85.212.74]:52815 "EHLO
	mail-vb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179AbaBJWzE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Feb 2014 17:55:04 -0500
Received: by mail-vb0-f74.google.com with SMTP id x14so887720vbb.5
        for <linux-mmc@vger.kernel.org>; Mon, 10 Feb 2014 14:55:03 -0800 (PST)
In-Reply-To: <1391798398-24634-1-git-send-email-puthik@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: MMC list <linux-mmc@vger.kernel.org>, Gwendal Grignou <gwendal@chromium.org>, Grant Grundler <grundler@chromium.org>, Puthikorn Voravootivat <puthik@chromium.org>

Force all host to have erase capacity to enable trim or
discard feature in supported eMMC device.

Signed-off-by: Puthikorn Voravootivat <puthik@chromium.org>
---
V2 change:
Instead of add MMC_CAP_ERASE just only for dw_mmc, this patch adds
this capability to all host.

 drivers/mmc/core/host.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 49bc403..a21f590 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -521,6 +521,8 @@ int mmc_add_host(struct mmc_host *host)
 	WARN_ON((host->caps & MMC_CAP_SDIO_IRQ) &&
 		!host->ops->enable_sdio_irq);
 
+	host->caps |= MMC_CAP_ERASE;
+
 	err = device_add(&host->class_dev);
 	if (err)
 		return err;
-- 
1.9.0.rc1.175.g0b1dcb5

