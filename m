Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BA7C11F68
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Jul 2021 13:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF87F6142E
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Jul 2021 13:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbhGBNpW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 2 Jul 2021 09:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbhGBNpV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Jul 2021 09:45:21 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E47FC0613DB
        for <linux-mmc@vger.kernel.org>; Fri,  2 Jul 2021 06:42:48 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id n14so18169449lfu.8
        for <linux-mmc@vger.kernel.org>; Fri, 02 Jul 2021 06:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NoI9BTrBB2j37D3MNXSwVMTEwSv5M2czDJC0Zd1MVQU=;
        b=kIPiqSzOvGOz6+vds3ovZUM/np0UiY4usyIqfkwIruTbbiB7jfsb59JXiQvjBOtPG7
         AzpyvWEpq3Djr5Yw99qCRr57XT9ZMa7NCMpR2FGFZrldljoYSFp1jCpXGut/679U+xF0
         eEkjntEQ7xK5R8sZqdkN6AFpKayx8o8lEqK1u8Y//YLck63gs+iJlwnqBpFvuw5/Btny
         qMFC8MMIAH+2Adr5iOP1x8pPgsjCeeNGzvU/TZ3HZwSdBtavQbNlVJ/N5J6uS0Fe3CBI
         z9WONDRhmmi7gnhicE8IHWCDegzJ80MMxx79kaNUaB482viXRKR/fm6Aj6azJZJ3KIJk
         Xe/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NoI9BTrBB2j37D3MNXSwVMTEwSv5M2czDJC0Zd1MVQU=;
        b=BnW67ta0hGSb1iJ7jbtwaZLpHDN1wYRD3IILC7H+hcTkzTyqCzBBiC84WuT5GjnzcW
         qXGtPqqXtGG01vcoDgeRrzdlDDdO0+RbEmuy5VMYyDD+q5XvXr/rtQ5ajR32ECeuu3Ey
         EoY7H8tl8vRZDtQbGDjtzfvzl/2WC6Kcn6hT69AsvCwkaq7YWvAx9PYrF1byQ6ZWGBxc
         bboGp22Yt7NCoxRahpMy5WyEzWqbi6i3Nl4L8rkLdix5vY7/EuzgxE0g/wT+bkzUMA6h
         PtXJp8rYKlg24vaOZSULFcA/UCJjwZuTw385g20y3iXQ73ejNIJ4VJjCzvQxcdz0A2NY
         XstA==
X-Gm-Message-State: AOAM530qq87Ii03SiYiS85/+aBUIqGbxXmM3NrDuVro3IeIc/pSAQf6w
        WVvUEogfn0AxyCITT6lcsH6Yk44ZVLR6ASOv
X-Google-Smtp-Source: ABdhPJwJOqCe7efbM/lMcm+PNg0kMxyZmH1OrHYVCdAXAbQ8gwaiTDU8d7GiRNDai6Nn/8fCom5gPg==
X-Received: by 2002:ac2:42c1:: with SMTP id n1mr3931436lfl.270.1625233366311;
        Fri, 02 Jul 2021 06:42:46 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id u5sm277486lfg.268.2021.07.02.06.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 06:42:45 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Christian Lohle <CLoehle@hyperstone.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] mmc: core: Avoid hogging the CPU while polling for busy for mmc ioctls
Date:   Fri,  2 Jul 2021 15:42:28 +0200
Message-Id: <20210702134229.357717-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210702134229.357717-1-ulf.hansson@linaro.org>
References: <20210702134229.357717-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

When __mmc_blk_ioctl_cmd() calls card_busy_detect() to verify that the
card's states moves back into transfer state, the polling with CMD13 is
done without any delays in between the commands being sent.

Rather than fixing card_busy_detect() in this regards, let's instead
convert into using the common mmc_poll_for_busy(), which also helps us to
avoid open-coding.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/block.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 1b5576048cdb..0f9044cf3aab 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -599,7 +599,8 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 		 * Ensure RPMB/R1B command has completed by polling CMD13
 		 * "Send Status".
 		 */
-		err = card_busy_detect(card, MMC_BLK_TIMEOUT_MS, NULL);
+		err = mmc_poll_for_busy(card, MMC_BLK_TIMEOUT_MS, false,
+					MMC_BUSY_IO);
 	}
 
 	return err;
-- 
2.25.1

