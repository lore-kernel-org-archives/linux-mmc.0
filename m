Return-Path: <SRS0=jYsQ=4V=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD48C3F2D1
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Mar 2020 07:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8231C21739
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Mar 2020 07:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fb7xo1+h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgCDHmd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Mar 2020 02:42:33 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40425 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728486AbgCDHmc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Mar 2020 02:42:32 -0500
Received: by mail-pg1-f193.google.com with SMTP id t24so581620pgj.7;
        Tue, 03 Mar 2020 23:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=8qfiF1JKhG0mrt/OgfCJuZM/2Izclz7AEG9/yixgqhQ=;
        b=Fb7xo1+hcswdrEmZ0Ao2l2+UmxCRa3DJk/uJbhRK5zh2wyiCsaQD6wAxr6lEJHRrWe
         g9t1IZv9tXw4p5ml8f2Zry5kLXtT992rgflFKZILMKy5te+XMX3tnCcag43MaLpCxt8c
         v6CaJAbpMbuy2SKDw7qRj7Pe6xWucem5zMZgaJGcB+8hfcv0NxifFjmdI3HRKS2MEpA5
         KMPDYWug4Ud5hDB0tvY4nbYrFFFwdyL4AXOv+e3XjC2JmKbSlvlYjKqAaMZRuwkaG74I
         p9tb7/TRwJzfxLdmSTttIk4RC7p3OLr+chOqGdaGOD0k2E3YxoXqRWyUcGzqd60B4uh+
         cY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=8qfiF1JKhG0mrt/OgfCJuZM/2Izclz7AEG9/yixgqhQ=;
        b=iW5k6iuRTya4WbENePefB0Jhk98WL+MYGebP5osUSy7TRDDjT17A1xAB9eMhCQoPeh
         K3NhhpFS90R8284uRCQRavD0XMaJrvZNGZYkDCQ7AR1nUgXEnPXTgJ5FLQYn7TUHku0M
         /qgoJvzA1ZYZ3oeu5HZrY2zPh+Ivv0SZgDJvfWOV41V1blNSry7QlZ0LpsnOLbjGtBa5
         jpB8OXf3Tt9yC7A/O/sYD2bxc4tP8r+eCnujHGL1QNaTKmqKraxRoBxMNCGHIChan8Zb
         JQbY4rZxJQREa7KSrNx2/R1YRui+DHO0v2hL3TypQcufUfcsZSLHfpP6O4o96hCTa9i4
         W/3w==
X-Gm-Message-State: ANhLgQ1ikRYzGUksjVsqNEQo/u8kpQlKk2OTlbw6YUr11JDLkPBCMB4+
        18GLoLi5N6aohmDc7t3nahE=
X-Google-Smtp-Source: ADFU+vv1zPEVt+gfYSdIkr9WcdJI3KlX0GD57qZAq2UCUD0Wb78zn+Eq0a5ft05dFOp7K/McNh+3hg==
X-Received: by 2002:a63:5c4:: with SMTP id 187mr1470272pgf.348.1583307751056;
        Tue, 03 Mar 2020 23:42:31 -0800 (PST)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id k24sm24097374pgm.61.2020.03.03.23.42.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Mar 2020 23:42:30 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang7@gmail.com,
        arnd@arndb.de, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 3/3] mmc: host: hsq: Support request_atomic() API
Date:   Wed,  4 Mar 2020 15:42:02 +0800
Message-Id: <e57cf579a833364c855f438203dc53a3e626e1c0.1583307441.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1583307441.git.baolin.wang7@gmail.com>
References: <cover.1583307441.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1583307441.git.baolin.wang7@gmail.com>
References: <cover.1583307441.git.baolin.wang7@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add support to submit a request by request_atomic() API.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mmc/host/mmc_hsq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
index 59d2776..fdbaa98 100644
--- a/drivers/mmc/host/mmc_hsq.c
+++ b/drivers/mmc/host/mmc_hsq.c
@@ -41,7 +41,10 @@ static void mmc_hsq_pump_requests(struct mmc_hsq *hsq)
 
 	spin_unlock_irqrestore(&hsq->lock, flags);
 
-	mmc->ops->request(mmc, hsq->mrq);
+	if (mmc->ops->request_atomic)
+		mmc->ops->request_atomic(mmc, hsq->mrq);
+	else
+		mmc->ops->request(mmc, hsq->mrq);
 }
 
 static void mmc_hsq_update_next_tag(struct mmc_hsq *hsq, int remains)
-- 
1.9.1

