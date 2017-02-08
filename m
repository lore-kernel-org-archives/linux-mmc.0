From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 2/4] mmc: pwrseq: implement reset operation in pwrseq_emmc
Date: Wed, 8 Feb 2017 22:49:07 +0100
Message-ID: <ea0583ff-8e41-9833-cc7c-638ff6c1d476@gmail.com>
References: <75ad5eac-412b-fe73-ff53-3d8b975937e4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34925 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbdBHWAJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Feb 2017 17:00:09 -0500
Received: by mail-wm0-f68.google.com with SMTP id u63so274463wmu.2
        for <linux-mmc@vger.kernel.org>; Wed, 08 Feb 2017 13:58:51 -0800 (PST)
In-Reply-To: <75ad5eac-412b-fe73-ff53-3d8b975937e4@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

In pwrseq_emmc a reset function exists already and just needs to
be exposed as reset hook.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/core/pwrseq_emmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/core/pwrseq_emmc.c b/drivers/mmc/core/pwrseq_emmc.c
index adc9c0c6..a30e7352 100644
--- a/drivers/mmc/core/pwrseq_emmc.c
+++ b/drivers/mmc/core/pwrseq_emmc.c
@@ -57,6 +57,7 @@ static int mmc_pwrseq_emmc_reset_nb(struct notifier_block *this,
 
 static const struct mmc_pwrseq_ops mmc_pwrseq_emmc_ops = {
 	.post_power_on = mmc_pwrseq_emmc_reset,
+	.reset = mmc_pwrseq_emmc_reset,
 };
 
 static int mmc_pwrseq_emmc_probe(struct platform_device *pdev)
-- 
2.11.0


