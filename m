Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0ABBC433DB
	for <linux-mmc@archiver.kernel.org>; Sat, 13 Mar 2021 17:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADB1164ED9
	for <linux-mmc@archiver.kernel.org>; Sat, 13 Mar 2021 17:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbhCMRh6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 13 Mar 2021 12:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbhCMRhm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 13 Mar 2021 12:37:42 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7B1C061574
        for <linux-mmc@vger.kernel.org>; Sat, 13 Mar 2021 09:37:41 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id 6so6340359qty.3
        for <linux-mmc@vger.kernel.org>; Sat, 13 Mar 2021 09:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=99UXm2bK0b+j4PKx8DY4eP69XsoTe2LlKSBzFsKKLDc=;
        b=XxZWbVtpK8/1ifkXWGCxoD1Tc+xpeoo43tnmiCD9I/ciVIrvDXqfn/YlOy8OX9Ygcw
         q8dUhvIpb1/D/j3iCHhbt+bwU3wGc0SNSjmLZ19mGGsvpNvBaBn08JvqD868EfQ43U+q
         8QNpZU4C62DYkJM6hXhpKMLfiqtPoSuAjpdeEpOm1fZE13qq7i0MMRoHyONAdDg3spFC
         dsx1CYfUUIPHa1ZIo+cb99HQkX4VbhV1F90Vejmy8dNulmwUg2su81hv70IXyNM3M1b+
         1nXes0fJ279vkv38My0/mXrKreQ1U90xgRlegE/4NXJJUK1zUpqYjhHys4XPSxANUHe5
         2kXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=99UXm2bK0b+j4PKx8DY4eP69XsoTe2LlKSBzFsKKLDc=;
        b=CVG2NfQtbOr9rptrcGc+cHtLCXVejgu5YxRteQTNtnlS5zHhipATVh9S2WsSEjOVaL
         waio8q5iiAY3rOnw6zhldQSjNgdyjx4vN8orLNRhGTyivO4T3vtbfJ80mUl/LP0U01O2
         lRBVnlyTMb4E/8pgZdLqDaNoDUEhd6RQp+rq3QpAvtsFHbBVfACePZp86gW7O88vs309
         1OUNFMPXUmsk9R9xvm8oS2bbxlOGNgaMuh+5fo6O1hHSnmC4MucYglq4PasFhISJbFUM
         zWC6y2SXXjBheW27XJEDpZBAsedE1ClPnX9HqLozs5yHep1w+He87h1SNTyHvk3Cbx/h
         RyZA==
X-Gm-Message-State: AOAM5302rprhEuJo9iYtZkIMXdS/y1hfmAtR416xhcLd4DVPprP9Glsw
        WwoNafzp0zX2+3QD3zM1wA8AHN08uco=
X-Google-Smtp-Source: ABdhPJwGtvzvBn4VadI24AiRq1/DWtdYTmJoanJygW6tiP4XUcRb4a5fbEb3dfklWwdld68Q84NRdQ==
X-Received: by 2002:ac8:148e:: with SMTP id l14mr16596786qtj.164.1615657061001;
        Sat, 13 Mar 2021 09:37:41 -0800 (PST)
Received: from joeylaptop ([2601:5cc:0:a480:77c5:f4b4:99be:b2ea])
        by smtp.gmail.com with ESMTPSA id o7sm6886307qki.63.2021.03.13.09.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 09:37:40 -0800 (PST)
Date:   Sat, 13 Mar 2021 12:37:40 -0500
From:   Joey Pabalan <jpabalanb@gmail.com>
To:     Maxim Levitsky <maximlevitsky@gmail.com>
Cc:     linux-mmc@vger.kernel.org
Subject: [PATCH] memstick: Remove useless else branch
Message-ID: <20210313173740.GA580681@joeylaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Remove else branch on line 334 of memstick.c, after the return of the
previous branch. Found by checkpatch.

Signed-off-by: Joey Pabalan <jpabalanb@gmail.com>
---
 drivers/memstick/core/memstick.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
index 12bc3f5a6cbb..bb1065990aeb 100644
--- a/drivers/memstick/core/memstick.c
+++ b/drivers/memstick/core/memstick.c
@@ -331,18 +331,17 @@ static int h_memstick_read_dev_id(struct memstick_dev *card,
 				  sizeof(struct ms_id_register));
 		*mrq = &card->current_mrq;
 		return 0;
-	} else {
-		if (!(*mrq)->error) {
-			memcpy(&id_reg, (*mrq)->data, sizeof(id_reg));
-			card->id.match_flags = MEMSTICK_MATCH_ALL;
-			card->id.type = id_reg.type;
-			card->id.category = id_reg.category;
-			card->id.class = id_reg.class;
-			dev_dbg(&card->dev, "if_mode = %02x\n", id_reg.if_mode);
-		}
-		complete(&card->mrq_complete);
-		return -EAGAIN;
 	}
+	if (!(*mrq)->error) {
+		memcpy(&id_reg, (*mrq)->data, sizeof(id_reg));
+		card->id.match_flags = MEMSTICK_MATCH_ALL;
+		card->id.type = id_reg.type;
+		card->id.category = id_reg.category;
+		card->id.class = id_reg.class;
+		dev_dbg(&card->dev, "if_mode = %02x\n", id_reg.if_mode);
+	}
+	complete(&card->mrq_complete);
+	return -EAGAIN;
 }
 
 static int h_memstick_set_rw_addr(struct memstick_dev *card,
-- 
2.27.0

