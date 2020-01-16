Return-Path: <SRS0=GOb8=3F=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58893C33CB6
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 18:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB2220684
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 18:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579198265;
	bh=TG5zhRS08XgjaFvPCbqcWFFnRDBrZMFyoPlDmRPuNak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MSAcGJkSWFp+Wx5gFe/XTvWJqDAQ828NRYFeVT/QVrBNePgmIY2ZBMUZTeRgCp8Is
	 XLvug/fXQqyclsWOUwiRHq2tM6ZZFMYrl/r+LT4O8enc5RmYYTqA476h8e+ZBtS6x0
	 61l/OrJmNxQoWJ9SnSIezUiHqKxLzDj9xmFr9zrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394302AbgAPSKu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:10:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:53178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393195AbgAPRhn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 16 Jan 2020 12:37:43 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 116A2246D8;
        Thu, 16 Jan 2020 17:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196262;
        bh=TG5zhRS08XgjaFvPCbqcWFFnRDBrZMFyoPlDmRPuNak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jyHndrtOaGmWF4XI5RFtsLNV73Svb81iC57k6AZiKYRMO9Ab0qHjXnR8T0fW1oft+
         kqxYyWDKhIkhGa3MZlIvvfWNn/gdvie4S+fefzzeeQdTbH4o68JV7HS9IlV3Xgd6Xj
         d7byMNn61jZgjflj5W7xDA5xZ/zkS+WH0uE+S0jg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.9 087/251] mmc: sdhci-brcmstb: handle mmc_of_parse() errors during probe
Date:   Thu, 16 Jan 2020 12:33:56 -0500
Message-Id: <20200116173641.22137-47-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173641.22137-1-sashal@kernel.org>
References: <20200116173641.22137-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Stefan Wahren <stefan.wahren@i2se.com>

[ Upstream commit 1e20186e706da8446f9435f2924cd65ab1397e73 ]

We need to handle mmc_of_parse() errors during probe otherwise the
MMC driver could start without proper initialization (e.g. power sequence).

Fixes: 476bf3d62d5c ("mmc: sdhci-brcmstb: Add driver for Broadcom BRCMSTB SoCs")
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-brcmstb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 159f6f64c68e..ed6473731b45 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -90,7 +90,9 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 	host->mmc->caps2 |= MMC_CAP2_HC_ERASE_SZ;
 
 	sdhci_get_of_property(pdev);
-	mmc_of_parse(host->mmc);
+	res = mmc_of_parse(host->mmc);
+	if (res)
+		goto err;
 
 	/*
 	 * Supply the existing CAPS, but clear the UHS modes. This
-- 
2.20.1

