From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 03/18] mmc: meson-gx: explicitely call stop command for
 multi-block commands only
Date: Tue, 14 Feb 2017 21:06:07 +0100
Message-ID: <b0511a1e-7dc4-084f-1d38-5b51171c22fe@gmail.com>
References: <420b75a9-b8c2-b3d7-ae60-3ed8a5a18ead@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36646 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751366AbdBNUHe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Feb 2017 15:07:34 -0500
Received: by mail-wm0-f67.google.com with SMTP id r18so5221371wmd.3
        for <linux-mmc@vger.kernel.org>; Tue, 14 Feb 2017 12:07:33 -0800 (PST)
In-Reply-To: <420b75a9-b8c2-b3d7-ae60-3ed8a5a18ead@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Explicitely call stop command for multi-block commands only.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index e89bdf5f..ece38b44 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -686,10 +686,10 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
 	}
 
 	meson_mmc_read_resp(host->mmc, cmd);
-	if (!data || !data->stop)
-		meson_mmc_request_done(host->mmc, mrq);
-	else
+	if (mmc_op_multi(cmd->opcode))
 		meson_mmc_start_cmd(host->mmc, data->stop);
+	else
+		meson_mmc_request_done(host->mmc, mrq);
 
 	return IRQ_HANDLED;
 }
-- 
2.11.1


