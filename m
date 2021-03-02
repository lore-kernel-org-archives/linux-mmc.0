Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA50C433E9
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Mar 2021 01:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2003D64EBB
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Mar 2021 01:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242909AbhCCBsA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 2 Mar 2021 20:48:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:39740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1448067AbhCBNzD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 2 Mar 2021 08:55:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95E7864F82;
        Tue,  2 Mar 2021 11:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614686277;
        bh=IZhI9osWjtg0MOE4hSW1YPjyCoMH3yJTtKp/Y1ecWg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F4o6tzn9J2Q+buKqJELyMfDBorgjpthkjZkY09I9mO3vgK682Xk55FDB5Ru1lc0Hq
         OC8b3uXmxhw6L8kOkLw00F5UPx/EHfDCvzEF9J3iAEDJ92eqSgNlLxvkoLwPV2Wv5Q
         AUVjDcHwhVt0ivYfzgYtGjbf5tB3mZcnYGWPjq1/jsVCczefuf/YeEYYfwTPq2huX/
         Y7+sAa2offwH6aEm9FCPBW2No+DACs0iielCdjgDXFH29ZO0OxF0RHqoAo+O3vBMGP
         V2yQNSg81H7DoLNPK2u4h19DGaRxKuu90nd/CzIDfD6l6UYdaBJSZuWOv7TmRRRm7V
         wvnKz9Lg8GCwQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 05/33] mmc: sdhci-of-dwcmshc: set SDHCI_QUIRK2_PRESET_VALUE_BROKEN
Date:   Tue,  2 Mar 2021 06:57:21 -0500
Message-Id: <20210302115749.62653-5-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302115749.62653-1-sashal@kernel.org>
References: <20210302115749.62653-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

[ Upstream commit 5f7dfda4f2cec580c135fd81d96a05006651c128 ]

The SDHCI_PRESET_FOR_* registers are not set(all read as zeros), so
set the quirk.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Link: https://lore.kernel.org/r/20201210165510.76b917e5@xhacker.debian
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index a5137845a1c7..6793fb8fe976 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -58,6 +58,7 @@ static const struct sdhci_ops sdhci_dwcmshc_ops = {
 static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
 	.ops = &sdhci_dwcmshc_ops,
 	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 };
 
 static int dwcmshc_probe(struct platform_device *pdev)
-- 
2.30.1

