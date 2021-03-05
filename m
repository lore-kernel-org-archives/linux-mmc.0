Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02913C433E9
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Mar 2021 02:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C36B26500F
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Mar 2021 02:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbhCECO4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 4 Mar 2021 21:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhCECO4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Mar 2021 21:14:56 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C91C061574;
        Thu,  4 Mar 2021 18:14:54 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id t9so901981pjl.5;
        Thu, 04 Mar 2021 18:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ehB5kuf6nm51L8XPj/urF4pDdDtfNb9caSakFu4ip0g=;
        b=k0giN0CRygTS1I+wxcxaONR5lWWUuDwmWJfWpevbjb5IIWi9qeWk6gaQ6T2scG6rmK
         RqReAobS2LAY1rpCsqOk1pSIX5gl7Esaimjg9AnG6dLsabY15Fnz0JcGLY/WatP3LNKm
         xyNKFaJnjsPBi/tbbVjqwJklosdXjrRDxaWxI2qbckoTY+uKcyH4opTN77/1AmgFpNmT
         TW+wC7lAUWBZeVxzm+L7TQrnrjROjDCmmPx4RmaF/iCX4kvLi2IF7DC5P391L6TwsdPP
         A2KS0aJPNlYOyrKHzIRcSuf65NVcfAYYy7lE3GpBh8m5CyC4ySw/ZgKyVq5UbD2wEES2
         RNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ehB5kuf6nm51L8XPj/urF4pDdDtfNb9caSakFu4ip0g=;
        b=MqZmSTwVmUADk9EipzlF0Dt/OPpKThu6+sZvbSQmOKyUHbZoyZanZy7k+/31PrDxtM
         GOl/u4gblklzM112qINsXyAPP0DJqzwGQ6ctb9VLQA6Q1Jib5LVQmpskTARoA/3kr10/
         IIIFynVrcwMiLxNakwyM/J45K+al8D22NHWqsIfHV696/06na7AvJWQx0MeyK3RtaQEH
         qaA/b8HLLz32tDKIsysmB0F44sPbOog2LXkBIPtiLkLFibX/3XHP7vvAjVRo3t7seq4q
         7afWTRusNAzj2XAt6SuDSMmofT8RYAZH8fyKDrMVgemZtAhcDOyCxAO0RX0cGszUmI5l
         8w0Q==
X-Gm-Message-State: AOAM532C2SQZUkbncwxRy2ETES3mJC4rDmDYOKFleAZw4++cL7NNt62K
        mThuVbNjAs/wNA/TUIdKr4o=
X-Google-Smtp-Source: ABdhPJy4TZXWWQikZxDHP5KCdeDJ5CQKHWrsxgquiqZtvR4g20JxC1TRdoJc7QHw+mXnyD0F6jM4Dw==
X-Received: by 2002:a17:90a:4598:: with SMTP id v24mr7768528pjg.102.1614910494078;
        Thu, 04 Mar 2021 18:14:54 -0800 (PST)
Received: from localhost.localdomain ([45.135.186.46])
        by smtp.gmail.com with ESMTPSA id bb24sm488674pjb.5.2021.03.04.18.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 18:14:53 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     maximlevitsky@gmail.com, oakad@yahoo.com, ulf.hansson@linaro.org,
        trix@redhat.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] memstick: core: fix error return code of mspro_block_resume()
Date:   Thu,  4 Mar 2021 18:14:45 -0800
Message-Id: <20210305021445.3435-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

When mspro_block_init_card() fails, no error return code of 
mspro_block_resume() is assigned.
To fix this bug, rc is assigned with the return value of 
mspro_block_init_card(), and then rc is checked.

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/memstick/core/mspro_block.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
index afb892e7ffc6..cf7fe0d58ee7 100644
--- a/drivers/memstick/core/mspro_block.c
+++ b/drivers/memstick/core/mspro_block.c
@@ -1382,7 +1382,8 @@ static int mspro_block_resume(struct memstick_dev *card)
 
 	new_msb->card = card;
 	memstick_set_drvdata(card, new_msb);
-	if (mspro_block_init_card(card))
+	rc = mspro_block_init_card(card);
+	if (rc)
 		goto out_free;
 
 	for (cnt = 0; new_msb->attr_group.attrs[cnt]
-- 
2.17.1

