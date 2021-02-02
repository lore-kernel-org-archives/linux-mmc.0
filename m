Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C640C433E0
	for <linux-mmc@archiver.kernel.org>; Tue,  2 Feb 2021 10:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE2D764E30
	for <linux-mmc@archiver.kernel.org>; Tue,  2 Feb 2021 10:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhBBKUM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 2 Feb 2021 05:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhBBKUK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Feb 2021 05:20:10 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60031C061573
        for <linux-mmc@vger.kernel.org>; Tue,  2 Feb 2021 02:19:30 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id u25so27086670lfc.2
        for <linux-mmc@vger.kernel.org>; Tue, 02 Feb 2021 02:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Hls5OcwfAUriBGbbZK5f++3bKiEpT4JO9SP17f7tfQ=;
        b=Uer9Rr9oO/JVSCU4bUGxp/dUpSg6f5VOnm7lQZXX/2Gs3o8q93o1aJb2bHo3RFgIAC
         HzKBuyeWnIpER5luSIADmlwEBvRox82CYIqPdO0l1wqGoZgb3YT2d7TfWvJsC5sraU0y
         eB482am/8zL/ExAkKwvDMsjs9fL2KOY1mg/dSXQ6qoZtFQDPQba76JRxuEW0hIHhQ9ZC
         ws3BQ2Q5tjrgpmuvk/JIzjhH6fNPTbjjllziLcWoXvjgFZXkeTRrDMHURLbGDi6VIhC6
         yL5mmFi/KUcnVG0Z/FipKcVvJ2U9ti1hxlNpCwpK3O3ECItkoR3YCWzXUwYScyYMH69y
         einw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Hls5OcwfAUriBGbbZK5f++3bKiEpT4JO9SP17f7tfQ=;
        b=onLwpydnCzBwryM2WonQRnNB4kh/XfrVortL5GlSyV5gOviIktGZ2PlW0QZozZ2/WY
         7Zl/jZKR9W8eJKyIIzs2C3urYDDALIBzraLGQeRyzaAXyZooCgxre/pIUD1HBi3oUgNH
         zRN7khye0SnfEPZftHqzReshRxBQzagSmkcp9nT6GyYLjy2vlxrB4SsTHDCJQm7JXxbG
         /7C9A9u+mIiXiGLB+HXlNSLR1dBt2dfuY6eYZJ1NRPayTqtsLDR+5JkR1rVirjeLqhAL
         KAzmSn9kzRhUUq7c77ozwVdIGp1XykH1xANgPxMkdADy6DJXWImsJqD5ANqoaX001YcV
         IPBg==
X-Gm-Message-State: AOAM531E1hKHuNOG7iYkCB0xvDQLOmiKFzA4ywAkQRN2evIeTlzE8HW8
        fNuVBETBFqWpwpQDc8QoH1DMBVAVvHFelNgJ
X-Google-Smtp-Source: ABdhPJyiPuUdIDjWPQhzRvOkdRyYTrCNF/JIRusrMu3NBHGipXI5d8wr5GyqUYfT/eWEwirE941ZnQ==
X-Received: by 2002:a19:4808:: with SMTP id v8mr805987lfa.352.1612261168269;
        Tue, 02 Feb 2021 02:19:28 -0800 (PST)
Received: from localhost.localdomain (h-98-128-180-179.NA.cust.bahnhof.se. [98.128.180.179])
        by smtp.gmail.com with ESMTPSA id 138sm3230368lfa.281.2021.02.02.02.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 02:19:27 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: core: Drop redundant member in struct mmc host
Date:   Tue,  2 Feb 2021 11:19:24 +0100
Message-Id: <20210202101924.69970-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The Kconfig option to use the blk-mq support was removed in commit
1bec43a3b181 ("mmc: core: Remove option not to use blk-mq"), but forgot to
remove the use_blk_mq member in the struct mmc_host, let's fix it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/mmc/host.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 927ba7566617..26a3c7bc29ae 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -429,7 +429,6 @@ struct mmc_host {
 	unsigned int		doing_retune:1;	/* re-tuning in progress */
 	unsigned int		retune_now:1;	/* do re-tuning at next req */
 	unsigned int		retune_paused:1; /* re-tuning is temporarily disabled */
-	unsigned int		use_blk_mq:1;	/* use blk-mq */
 	unsigned int		retune_crc_disable:1; /* don't trigger retune upon crc */
 	unsigned int		can_dma_map_merge:1; /* merging can be used */
 
-- 
2.25.1

