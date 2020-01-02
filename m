Return-Path: <SRS0=NlIn=2X=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FB2C2D0DC
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Jan 2020 10:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C5C2085B
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Jan 2020 10:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="DXaAe4bi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgABKa5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 2 Jan 2020 05:30:57 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:6023 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727990AbgABKa5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 2 Jan 2020 05:30:57 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47pPSs5fcMz9d;
        Thu,  2 Jan 2020 11:30:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1577961054; bh=+y18ZtRqL20vwnFJzTy9vluqY/s49t024oi+gFIwAUE=;
        h=Date:From:Subject:To:Cc:From;
        b=DXaAe4bikHDm1EgyvVJUYtCQRE8aD2UL43f5LqeXB4cz+0IAmpE4A/TsrPnpO8wUy
         3T0yLBXdwFGtI0Ow/AjmO220Tw0CXR8v03u+VNUls/aG2EkamLTUEJ5bxNNaGEUsQE
         4eetRTutA+wHYQnBm/sFKZFFisK0BLeO1UIfT+7NEm0zgCzVFnzqViBPJxBOOQfYo6
         fm6fExTf/XnOqUwQHFJfmFoYj7o4PyX3A1jdzn8Iw2TzQ6UcNWLulfjIjdBxnKY6kA
         xFcWlLBrQ1xW9TtX/NiFYiRaPuyPCkk9GwuPMg28WudzGEKlUTvxiIrO5/+9S5nMCd
         9kuO6PrvRPKiw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Thu, 02 Jan 2020 11:30:50 +0100
Message-Id: <245d569e4c258063dbd78bd30c7027638b30f059.1577960737.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] mmc: tegra: fix SDR50 tuning override
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     linux-mmc@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lucas Stach <dev@lynxeye.de>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Commit 7ad2ed1dfcbe inadvertently mixed up a quirk flag's name and
broke SDR50 tuning override. Use correct NVQUIRK_ name.

Fixes: 7ad2ed1dfcbe ("mmc: tegra: enable UHS-I modes")
Depends-on: 4f6aa3264af4 ("mmc: tegra: Only advertise UHS modes if IO regulator is present")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/mmc/host/sdhci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 7bc950520fd9..403ac44a7378 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -386,7 +386,7 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
 			misc_ctrl |= SDHCI_MISC_CTRL_ENABLE_DDR50;
 		if (soc_data->nvquirks & NVQUIRK_ENABLE_SDR104)
 			misc_ctrl |= SDHCI_MISC_CTRL_ENABLE_SDR104;
-		if (soc_data->nvquirks & SDHCI_MISC_CTRL_ENABLE_SDR50)
+		if (soc_data->nvquirks & NVQUIRK_ENABLE_SDR50)
 			clk_ctrl |= SDHCI_CLOCK_CTRL_SDR50_TUNING_OVERRIDE;
 	}
 
-- 
2.20.1

