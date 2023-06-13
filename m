Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC77FEB64D8
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Jun 2023 20:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjFMUec (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Jun 2023 16:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjFMUeb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jun 2023 16:34:31 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C04A1989
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jun 2023 13:34:28 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f619c2ba18so7138841e87.1
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jun 2023 13:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686688466; x=1689280466;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S7UBLcTRqRDwyg2dTPn5N53PKfQxU1SA5dNqRVb2SiA=;
        b=MVhtYZ3zaidcK4sb8yl4WR2oTheh70dTSCD+vkNSi7R31b8Uk+pqOR85uMtcRJVv/z
         ctEXi/2cgxkQmfbvlqypQYC2tqRy0H2ErzChOE4aztJEjCguhjQfsjnbI8/VsQzEe5bN
         nkXBa+0Au3ZT559GepoJg6jOxrRo1sWBM58zSDt2qj1kWe6R7HTZnvDwWzoOCJLbTwjJ
         TciLFO3X1+KGuxcG3ebuZENy9Mq/xc4MewlBvcTyZw1k/+T96M7ChJqrgMud2J/j+B8S
         sEKWs8z6vf/Nvkei7Z4jGF6cGTq+HPgo0Oqi8F7Q/gXoR9p5lZKknqCCem9K9eG2yJa2
         Kaqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686688466; x=1689280466;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7UBLcTRqRDwyg2dTPn5N53PKfQxU1SA5dNqRVb2SiA=;
        b=GhMiUta/e5T0NYEASq9SmEgdj+WF38oiUpFuSR7iuFgAUCFCS4T4ZnENayuHgUMeHY
         WL1TjWaV6dLDrO+4VoYWY0SV2G8c8n8RnrmeWEOz0l0Pu1camqrc3P+V7afYvGVt+cKq
         bmfVHnRMwgEki1mSdaHGwOe0mc4betKC+6HrL9uuEm2Q3E1iyaBKkT6KQwpkjb30uPN1
         /N/4k1zR26DmJox0FWnlsT7U5fIUkweiTc7Jr9NdBJG5sLuS9WjxlcypDcfj0a9DrUqD
         r/ufQr1O5hXlFZ9SmecsgMtnQxB6j9Aajc/i4eb2vHADMbTkcC2XSawOHQb1rp7R4OVA
         07ug==
X-Gm-Message-State: AC+VfDzSwe5PEuwCVv633G27l/EZRlGoIR4sYnDeiAdfFP6ycBdTN+1m
        F32Zc8l9oDk+6LWwTK/mZWBqSg==
X-Google-Smtp-Source: ACHHUZ7W4kB0+K6j6YMrWQpjURfpqZwC7/r7SId+XagPh+drqL6h7JN+J4aLHswQiULgS5gxsosIyw==
X-Received: by 2002:a19:8c4b:0:b0:4db:3d51:6896 with SMTP id i11-20020a198c4b000000b004db3d516896mr6367821lfj.11.1686688466325;
        Tue, 13 Jun 2023 13:34:26 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id l12-20020a19c20c000000b004f26f699e9dsm1897813lfc.184.2023.06.13.13.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 13:34:25 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 13 Jun 2023 22:34:17 +0200
Subject: [PATCH v4 01/10] mmc: mmci: Clear busy_status when starting
 command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v4-1-df9c8c504353@linaro.org>
References: <20230405-pl180-busydetect-fix-v4-0-df9c8c504353@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v4-0-df9c8c504353@linaro.org>
To:     Yann Gautier <yann.gautier@foss.st.com>,
        Stefan Hansson <newbyte@disroot.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-mmc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.2
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

If we are starting a command which can generate a busy
response, then clear the variable host->busy_status
if the variant is using a ->busy_complete callback.

We are lucky that the member is zero by default and
hopefully always gets cleared in the ->busy_complete
callback even on errors, but it's just fragile so
make sure it is always initialized to zero.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- Fix the oneline stray change to semantic order of busy
  flag so the patch is the oneliner it's supposed to be.
ChangeLog v2->v3:
- Clear host->busy_status no matter if the MMC_RSP_BUSY flag
  is set or not.
- Now we have an if inside an if left, so combine these into
  one singel conditional.
- Resulting re-flow the if-clause.
ChangeLog v1->v2:
- Unconditionally clear host->busy_status if we get a
  busy response.
---
 drivers/mmc/host/mmci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 97a77eefb11a..0a4b6b6e0f03 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1238,6 +1238,7 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
 			c |= host->variant->cmdreg_srsp;
 	}
 
+	host->busy_status = 0;
 	if (host->variant->busy_timeout && cmd->flags & MMC_RSP_BUSY) {
 		if (!cmd->busy_timeout)
 			cmd->busy_timeout = 10 * MSEC_PER_SEC;

-- 
2.40.1

