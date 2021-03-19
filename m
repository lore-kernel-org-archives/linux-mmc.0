Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFABC433E9
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Mar 2021 12:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2477164F65
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Mar 2021 12:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhCSMOl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 19 Mar 2021 08:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhCSMOJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Mar 2021 08:14:09 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E58C06174A;
        Fri, 19 Mar 2021 05:14:08 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id bf3so10504509edb.6;
        Fri, 19 Mar 2021 05:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PnDxUXsKC4qY+dPZkGqCewjoeMfEY94qE2nYfRH4nao=;
        b=cnwDTgfRyXdOcXpbKuesk1hT98jvzkBv2t3XuG/qNVqfEYkn+Rp+2nsDxv3YIzXUGo
         ME/nh0MnpOr13ixUYjMf2v0+X0BarJXt7BkoREum0NrMrgq/pKBcZVGrGs7ns1h0rxfF
         8C14XvBiYQ/1htDqzrXSY6UrejShnouJPZQBt/5yp08tXJ3FDyZ4WUrWhhsdM39+W4lx
         9NWPTE5cWZKyEUd/y85U+No5vYGglpUQ/IstwZLoYCucTqECqQwOe4l5Iwyxi2HpQiS4
         ulA8dPrC2mDkQjDUjsP6666iVsFNrmAVnMpFw6uWq20YsHFh8IxBSJnwnbZZWd6NbSkQ
         AZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PnDxUXsKC4qY+dPZkGqCewjoeMfEY94qE2nYfRH4nao=;
        b=d8x9gKCjAwt3eshM1/dMU3WOH/E6vb/x+wWnuXvsHayEkzt3iptr1J6PxlQfkI0idN
         XzLceGkBAnRgjk6vmykDWrqeEORDJfbPFQ18yU0VKvdhkzpa+i5X42hBNhw25i59BZXl
         d9QRUzgivX8HrZc7vxaXaO+JcyHJpzNxnNeGfDzqI3USN7KUQMCUkjjYqKM7WaFLiz6S
         adZsNs8j/aKl37uj19BSTYiyQMWlhv4OgTLdiKl5/JH0J2yiuhEvQtqvj/JuPXUKi8Vr
         vfqOcP4YbRyR98QZUxhO1CrL0jd5Jra+SxZTo1iS63SA7DRzt5qzaATKtW7n1XHFlwpA
         0/cA==
X-Gm-Message-State: AOAM532RmkU0ytIqswPFwonIKquxDQFGTcLRZMptQlSn7nppWWRnwtqM
        +53nMg878To77+SBrQmaWp8=
X-Google-Smtp-Source: ABdhPJxPno98zjDUYryg1lLQ5fnVnUc3K6+TGN5BDL8Dz/Ee6f/KiKbBdRupl0b/203QSafNWCOoXA==
X-Received: by 2002:aa7:c3c4:: with SMTP id l4mr8987905edr.335.1616156047376;
        Fri, 19 Mar 2021 05:14:07 -0700 (PDT)
Received: from localhost.localdomain (ip5f5bec5d.dynamic.kabel-deutschland.de. [95.91.236.93])
        by smtp.gmail.com with ESMTPSA id q2sm919353eje.24.2021.03.19.05.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 05:14:07 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     rric@kernel.org, ulf.hansson@linaro.org, linus.walleij@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     beanhuo@micron.com
Subject: [PATCH v1 1/2] mmc: cavium: Use '"%s...", __func__' to print function name
Date:   Fri, 19 Mar 2021 13:13:56 +0100
Message-Id: <20210319121357.255176-2-huobean@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210319121357.255176-1-huobean@gmail.com>
References: <20210319121357.255176-1-huobean@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Use preferred way '"%s...", __func__' to print function name.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/mmc/host/cavium.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/cavium.c b/drivers/mmc/host/cavium.c
index 4bb8f2800a2b..95a41983c6c0 100644
--- a/drivers/mmc/host/cavium.c
+++ b/drivers/mmc/host/cavium.c
@@ -656,8 +656,7 @@ static void cvm_mmc_dma_request(struct mmc_host *mmc,
 
 	if (!mrq->data || !mrq->data->sg || !mrq->data->sg_len ||
 	    !mrq->stop || mrq->stop->opcode != MMC_STOP_TRANSMISSION) {
-		dev_err(&mmc->card->dev,
-			"Error: cmv_mmc_dma_request no data\n");
+		dev_err(&mmc->card->dev, "Error: %s no data\n", __func__);
 		goto error;
 	}
 
-- 
2.25.1

