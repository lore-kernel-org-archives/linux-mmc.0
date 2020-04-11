Return-Path: <SRS0=d44f=53=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9FBC2BBFD
	for <linux-mmc@archiver.kernel.org>; Sat, 11 Apr 2020 23:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A184206E9
	for <linux-mmc@archiver.kernel.org>; Sat, 11 Apr 2020 23:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586647265;
	bh=EwabVwJVuMwwj07DslH218fSfFsyXeDyKZMeNlvoJeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SK/zfRq3KR7lAzK2/SjrCIwi8LjqA5zwNL6T6HqZVSVXK81927gx/oum1QIRtgaB1
	 vrICITIRYGyDQD4OIwZ5cDU8KJQR8kroK2AXRsF992UAtvGrThgry1oGVUU2ey6cCZ
	 QxHZDu6mVgTIo3DwbUtOEQQStjbkpW6bfmdP7nRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbgDKXU7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:20:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729765AbgDKXNc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 11 Apr 2020 19:13:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88FBE21744;
        Sat, 11 Apr 2020 23:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646812;
        bh=EwabVwJVuMwwj07DslH218fSfFsyXeDyKZMeNlvoJeQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QpYuIBQlUih8iQnu+4ZAqymBUP7ePK2v2k1hOjLgwB1NNO/tLsZRKRlHqEYqDLG3I
         5KPTXoZrQ6Ne+PO7QPJGDd303UE7vYFbim3eoVkiQvAJ1MxJMggN63YhUlEL+1n0+7
         In1oGOzOGu5oEnAGsGhLlWqfIGqKuc6Nxz7FZ44s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Haibo Chen <haibo.chen@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 04/37] mmc: sdhci: do not enable card detect interrupt for gpio cd type
Date:   Sat, 11 Apr 2020 19:12:53 -0400
Message-Id: <20200411231327.26550-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411231327.26550-1-sashal@kernel.org>
References: <20200411231327.26550-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

[ Upstream commit e65bb38824711559844ba932132f417bc5a355e2 ]

Except SDHCI_QUIRK_BROKEN_CARD_DETECTION and MMC_CAP_NONREMOVABLE,
we also do not need to handle controller native card detect interrupt
for gpio cd type.
If we wrong enabled the card detect interrupt for gpio case, it will
cause a lot of unexpected card detect interrupts during data transfer
which should not happen.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/1582100563-20555-2-git-send-email-haibo.chen@nxp.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4f1c884c0b508..33028099d3a01 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -133,7 +133,7 @@ static void sdhci_set_card_detection(struct sdhci_host *host, bool enable)
 	u32 present;
 
 	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) ||
-	    !mmc_card_is_removable(host->mmc))
+	    !mmc_card_is_removable(host->mmc) || mmc_can_gpio_cd(host->mmc))
 		return;
 
 	if (enable) {
-- 
2.20.1

