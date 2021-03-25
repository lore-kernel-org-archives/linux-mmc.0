Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA515C433C1
	for <linux-mmc@archiver.kernel.org>; Thu, 25 Mar 2021 19:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7709561A26
	for <linux-mmc@archiver.kernel.org>; Thu, 25 Mar 2021 19:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhCYT3Y (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 25 Mar 2021 15:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhCYT24 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Mar 2021 15:28:56 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2DAC06174A;
        Thu, 25 Mar 2021 12:28:52 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id y6so3745824eds.1;
        Thu, 25 Mar 2021 12:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=quzKjEj1MtNh5k+TvieXlNYy4mtRV9X0SO8O1gUhSR0=;
        b=opjo8/NixDoaTA7r0J0M6qko/9RvqgWLvaV1mXIltHk/LPjRG+7CyIICAfCoFKlS1g
         7zO5G1ZRyjl8EOWS6g0wfqN8ulx74Dqzdyxx7oI2Bzq36K2G/tlHLEwFy9vQnQWcwgrb
         C13YTsgj+kfAQ+dzXU3tUWW0zyZnp2K5ADPFgC/Wqc/bZsMXO5fWD1SWIQ7/kt5YSOd0
         /Ehl3Z/hPdVEy610ftTErTifi1QoCVzyA36xt6qdJcme/Ah+2PH8bUuwdWMGjxuxhhi2
         5VpLr2Vi56M0DbvQZR680Pw4vSYy8PkFF3caDNQo0xVsqYy8FpU2h1OL+QP67zbs6hpx
         vrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=quzKjEj1MtNh5k+TvieXlNYy4mtRV9X0SO8O1gUhSR0=;
        b=PCjEWxhWnICOTE6iUKRROT5DFnddM2IZWbYtU9zc0MUvTcQsTR6WvCW4pxExJbVLwB
         mEOXLj+5wnZsh18FqwxjZzCQop3JH38hwOeTr+AhzeR0OEGx/1gLb3BmkOw0sVm1PnQU
         Y9fm3Z9X4pzAEG5aRfDxHHIO1cCHdiSP3ocjduRi8Dy2n6E8UDES+7SpeHXUBxfjWMiw
         wE4NHGFE/93Zn2NGfx/R55QgIZJsLk+QSs2A1fY8rMEwHxK9/LXfzjX1r5NiTfQ5de9M
         clNjV5cUkjGvqSOWGeDxgcrRiNbe54rPA+31ejPO/rITEEj/8dKxqs4fjeLxzYyuxE/5
         EJ9Q==
X-Gm-Message-State: AOAM532bVCmTChaVWwQmm/DctHQYhivsMF+ggQkIYnh5SCzmScfoIZs6
        W6anWWjOmyV+fNAn93aZPJs8KdpLA14=
X-Google-Smtp-Source: ABdhPJwruY07NORIAKjD4ra4ynyRSf4nbBMxJrUnfTuPAUO6aczH+RAbqpDo0VJNycosNCL7BR5q2Q==
X-Received: by 2002:aa7:d316:: with SMTP id p22mr10542463edq.107.1616700530738;
        Thu, 25 Mar 2021 12:28:50 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id oy8sm2827471ejb.58.2021.03.25.12.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 12:28:50 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: sdhci-brcmstb: Remove CQE quirk
Date:   Thu, 25 Mar 2021 15:28:34 -0400
Message-Id: <20210325192834.42955-1-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Remove the CQHCI_QUIRK_SHORT_TXFR_DESC_SZ quirk because the
latest chips have this fixed and earlier chips have other
CQE problems that prevent the feature from being enabled.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/mmc/host/sdhci-brcmstb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index f9780c65ebe9..f24623aac2db 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -199,7 +199,6 @@ static int sdhci_brcmstb_add_host(struct sdhci_host *host,
 	if (dma64) {
 		dev_dbg(mmc_dev(host->mmc), "Using 64 bit DMA\n");
 		cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
-		cq_host->quirks |= CQHCI_QUIRK_SHORT_TXFR_DESC_SZ;
 	}
 
 	ret = cqhci_init(cq_host, host->mmc, dma64);

base-commit: e138138003eb3b3d06cc91cf2e8c5dec77e2a31e
-- 
2.17.1

