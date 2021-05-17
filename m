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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A233C433ED
	for <linux-mmc@archiver.kernel.org>; Mon, 17 May 2021 10:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E59C611C2
	for <linux-mmc@archiver.kernel.org>; Mon, 17 May 2021 10:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236488AbhEQK41 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 17 May 2021 06:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236500AbhEQK4W (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 May 2021 06:56:22 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3FFC06174A;
        Mon, 17 May 2021 03:54:47 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id t21so2924110plo.2;
        Mon, 17 May 2021 03:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yzBuMiC2XaLs/j1LpNGe2K8TP7QRiNZvMg2908xwCXA=;
        b=ZRu4cOsTud8oyRg8K/dNWXVOFRjhDkEt6GER7grMfhXnJs1Oe2H0kBBbDt7DdT7bXb
         7BYgb+0rL9PrK/4hWSLNuM1XWyontoVNyc0e1t51rEA1r3t3wzzxsTN9g/4CDJSGODQk
         fzknAvXky0Jj5hN5zKWjFt32Yg9z/EzGxlagzAhOMkA2s4gYrA3SrX2H3CvE8uqVdYyt
         JlI4DuQ7MteCjHcXQhO/2lk05O2qxHZSK90Aa6GSfnbFeUptfOdTXX6x2BDZL4GFAjD2
         dZqbel5mgzh7EcPF64NZTP6l8Iuu2m6KoE87aC8BmdKQqIMAgyniPIJZ8Cr0cYobs67t
         W0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yzBuMiC2XaLs/j1LpNGe2K8TP7QRiNZvMg2908xwCXA=;
        b=HOW+YElIoRGnRII3KrDg4s5eke2KIt7Wx8Phrzm0ZXcSSLWUHFZq/WjbVvNlJXPe2d
         TPm6192L6oyrSpGd50dn7oggb/8Nwu/hV9L3y6sssqR9Fb3zlW5VOTbsrUjZQIcuDodH
         KxRkCLq/lRE1ZWt9KbbfRYYTkKpHfEq4/EBMynH91egTVDP5/Xy6V/DfhtxrUMTATaFT
         oEyoq8+DHLyqPI6UdPTafsT+Vg1eQ4yzLL9jrMKI6hg7FLwH+F1da9RrNulSKXc4WIaJ
         w8d0EeTgiN7TieEYfmmtD1XTwYs/M4KIqCL4ZYBfV5j8L7dDCG2oT6u6WfwsGmp6hhQz
         XXIA==
X-Gm-Message-State: AOAM531APC+QMDjaf6QCBUZcIJRmFmK+3GJPyBER1dce5a4SiQRjALVd
        YdTWLwaN7p/gtY9hrA4OoaM=
X-Google-Smtp-Source: ABdhPJwkEw1HtZdsBPLVsJMejfuHolPdJBtBxADQ2kfLqLczA1fjfWTMnR8aQE8eC/N6TVolDm43GA==
X-Received: by 2002:a17:90b:fc5:: with SMTP id gd5mr24334538pjb.99.1621248887281;
        Mon, 17 May 2021 03:54:47 -0700 (PDT)
Received: from tj.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id w8sm10855074pgf.81.2021.05.17.03.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 03:54:46 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        matthias.bgg@gmail.com
Cc:     linux-mmc@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, huyue2@yulong.com, zbestahu@163.com
Subject: [PATCH] mmc: mediatek: remove useless data parameter from msdc_data_xfer_next()
Date:   Mon, 17 May 2021 18:54:32 +0800
Message-Id: <20210517105432.1682-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.29.2.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

We do not use the 'data' in msdc_data_xfer_next().

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/mmc/host/mtk-sd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index c4db944..4dfc246 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1347,8 +1347,7 @@ static void msdc_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
 	}
 }
 
-static void msdc_data_xfer_next(struct msdc_host *host,
-				struct mmc_request *mrq, struct mmc_data *data)
+static void msdc_data_xfer_next(struct msdc_host *host, struct mmc_request *mrq)
 {
 	if (mmc_op_multi(mrq->cmd->opcode) && mrq->stop && !mrq->stop->error &&
 	    !mrq->sbc)
@@ -1407,7 +1406,7 @@ static bool msdc_data_xfer_done(struct msdc_host *host, u32 events,
 				(int)data->error, data->bytes_xfered);
 		}
 
-		msdc_data_xfer_next(host, mrq, data);
+		msdc_data_xfer_next(host, mrq);
 		done = true;
 	}
 	return done;
-- 
1.9.1

