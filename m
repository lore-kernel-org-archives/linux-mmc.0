Return-Path: <SRS0=N8Xy=7R=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0A0C433DF
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Jun 2020 10:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06974206DC
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Jun 2020 10:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/quxgCD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgFDKBQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 4 Jun 2020 06:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgFDKBP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Jun 2020 06:01:15 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1977C03E96D
        for <linux-mmc@vger.kernel.org>; Thu,  4 Jun 2020 03:01:13 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a45so2078660pje.1
        for <linux-mmc@vger.kernel.org>; Thu, 04 Jun 2020 03:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gVOlFrKYltBjgAn8UNA1d3as90lDSVqiJjOnMd7wcNk=;
        b=G/quxgCDOXSlmZB8jjweUfYQk2NofXM2hCAOVxtjBUd3AH5+mneY/Xfe8NE2CClCek
         oBRocwC9K50ET8qxz+l0jHAogWtm5vy9C8XGOpbU6B2b+vr+AX1r89yvt1NUAWDo0tFH
         9WU4t3eTLSD17xjwRirpmy+eRLHMn9lqEQqlZmYbc5cr0kcNDWBwn9Xdz7CaziYbj+Z9
         NBGI43OdEu54bwQfKBJ72vY3NGZsdo6sr/pumyqB7j4CLY9cjGVlXXV5Myc6c7IeX1Vg
         4PXB4Lar0ujJSZJohTLPrP2wNUX3NoaVRnmbiKPtvJKuPSy7xtdIbR1Jg2c3UroYjD0/
         QXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gVOlFrKYltBjgAn8UNA1d3as90lDSVqiJjOnMd7wcNk=;
        b=FECf9+utm/r+zAJ8QcdPipSYPdmMViqTmsZCegV1BFhd855WZdWnXc4rYlH30TAaWq
         Q6P/xk1IJ3n4Cz+3a6tHoOqNe5hAreZSIPfGPxhyzMxIbxKw/bjemRYxKpoA+jyl+xY2
         95/nKYLwvdoUWq9jJekbDct6DZGJyAM60MiqQ1kZORM91UJYqgfYHhnwUnCf9q+hhVng
         mN8BlN8aoFXNstzJKT4hHbf/DS/JND8yoEA4TL3MV/Esr7foNuTwYeNefyEARQ/jpuIw
         /yo/+1rz2sB2XFPu+LOPZ6zguIdMOVLbpFiCTJ1DQGVxTnSq9cTGkk1hrZRg9K2SYzdk
         RsRw==
X-Gm-Message-State: AOAM53067QgtGMrcTIMOF0nxu/O+rRr/YpMl53W9Rygej+UuuheqhKMZ
        nomJ2mmKiHT8VEIEGC6hDt4=
X-Google-Smtp-Source: ABdhPJxXBNxy4woHwM5kZKjI+jEIyE5Gy4yclp871r8B4PwndBZTn/rMl9wf0qdAfJ0oKoUuug65aw==
X-Received: by 2002:a17:90a:328d:: with SMTP id l13mr4828380pjb.236.1591264873396;
        Thu, 04 Jun 2020 03:01:13 -0700 (PDT)
Received: from huyue2.ccdomain.com ([103.29.143.67])
        by smtp.gmail.com with ESMTPSA id j15sm5278777pjj.12.2020.06.04.03.01.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jun 2020 03:01:12 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     ulf.hansson@linaro.org, dianders@chromium.org
Cc:     linux-mmc@vger.kernel.org, huyue2@yulong.com
Subject: [PATCH] mmc: sdio: Return ret if sdio_disable_func() fails
Date:   Thu,  4 Jun 2020 18:01:02 +0800
Message-Id: <20200604100102.13572-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

We should return any possible error returned by mmc_io_rw_direct()
rather than only -EIO in sdio_disable_func() failure path.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/mmc/core/sdio_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
index 2ba00ac..cba54df 100644
--- a/drivers/mmc/core/sdio_io.c
+++ b/drivers/mmc/core/sdio_io.c
@@ -133,7 +133,7 @@ int sdio_disable_func(struct sdio_func *func)
 
 err:
 	pr_debug("SDIO: Failed to disable device %s\n", sdio_func_id(func));
-	return -EIO;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(sdio_disable_func);
 
-- 
1.9.1

