Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1248C4167B
	for <linux-mmc@archiver.kernel.org>; Sun, 18 Dec 2022 17:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbiLRRIH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 18 Dec 2022 12:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbiLRRGm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 18 Dec 2022 12:06:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319CDCE11;
        Sun, 18 Dec 2022 08:23:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E38EBB80BA8;
        Sun, 18 Dec 2022 16:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E454EC433EF;
        Sun, 18 Dec 2022 16:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671380578;
        bh=yPl+W0vivCeUr4WZMW40HE08Gc6NkZUO0IEisN3YrCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pE0nwrYyxBLvS20IQ8uEEq4KSNszAL3+BX/Won0UoCvSU1xCSm57itWFBbvgUSLHY
         PnaTYO+2JViCTwhu8hwG+xomofq3EARnITUuPxGMef5jcIPkruKRPlfa1dgKwe2qGX
         OmD5uASPv4GIG1fG1s1PYGLAXWye6CzO+yukzbSElwiyLTvOoWWlQylEssW8pMYZ4Y
         wmG3Cz24eVEn0nq7VHo9dU2NUCretBko8bAF9Bmo1gDg6j/S+96yiRdcldu9z+yY60
         y/9CNWxOk5rvTITPWIAoS3Y1PyvPDOXNKwW3AA3wKTZC9KlU+/32RnkxLRkeplVFTk
         Bl938nWJv9Qwg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 21/23] mmc: f-sdh30: Add quirks for broken timeout clock capability
Date:   Sun, 18 Dec 2022 11:21:47 -0500
Message-Id: <20221218162149.935047-21-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221218162149.935047-1-sashal@kernel.org>
References: <20221218162149.935047-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

[ Upstream commit aae9d3a440736691b3c1cb09ae2c32c4f1ee2e67 ]

There is a case where the timeout clock is not supplied to the capability.
Add a quirk for that.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Acked-by: Jassi Brar <jaswinder.singh@linaro.org>
Link: https://lore.kernel.org/r/20221111081033.3813-7-hayashi.kunihiko@socionext.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci_f_sdh30.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
index 111b66f5439b..43e787954293 100644
--- a/drivers/mmc/host/sdhci_f_sdh30.c
+++ b/drivers/mmc/host/sdhci_f_sdh30.c
@@ -180,6 +180,9 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
 	if (reg & SDHCI_CAN_DO_8BIT)
 		priv->vendor_hs200 = F_SDH30_EMMC_HS200;
 
+	if (!(reg & SDHCI_TIMEOUT_CLK_MASK))
+		host->quirks |= SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK;
+
 	ret = sdhci_add_host(host);
 	if (ret)
 		goto err_add_host;
-- 
2.35.1

