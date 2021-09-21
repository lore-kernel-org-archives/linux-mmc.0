Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57899C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Sep 2021 14:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38725611ED
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Sep 2021 14:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbhIUOh6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Sep 2021 10:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbhIUOh6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Sep 2021 10:37:58 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC916C061574
        for <linux-mmc@vger.kernel.org>; Tue, 21 Sep 2021 07:36:29 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id t10so75894829lfd.8
        for <linux-mmc@vger.kernel.org>; Tue, 21 Sep 2021 07:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cPwwPvcnLEwajSFyPXN/bXk6hb2CCeZPFVGYiGI9csQ=;
        b=r3mzGeOoboNUIvZg85542z/eQxg77uDAJbcwlqc+p3yR8QHj+ngM3PNvHQvFmENTHn
         WvbdGx+0I8SoCRCdCGs0teo6kJ0nsQEGd5f1OjsjwX37epjIouhYmtQQIrnO9OuzfSeB
         vYZ+BZR+wnyHVM5gpV4nyFE9XduSEzgfEINGjPxKqqfWNc6X+VRWSjuP8z1MfNjD4Nml
         uzNNEKfnwDz1cJI35dheNN6+Y/t4+NYJ39rWHipejhIR0XDNXoGDUFKvgC1qgW8XO7+L
         8i78gHA1w9qeag6YxbCsl303eHtDxcq52F4S97wq2uF2AEXXYhb7NfpmpxPTLlayRYKp
         enqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cPwwPvcnLEwajSFyPXN/bXk6hb2CCeZPFVGYiGI9csQ=;
        b=nLq5ODapEbX9tBNAWIIuX6hsmFYq88pwTGwXGrFQSls/rzuKnwq6+61O8/rYmZgy3t
         5cjFGlGfG8vqb34RW5i9qnYQfI/bKrEixtClJjjUwiSP5SOKYYBBqSOivL5geUc2G3Tf
         OQrV8xsnxnBtp1RRFZ4ICDx+KppTrRAzRZKxO/hcYQzvghCODWzGOo/OMZzbH6M3v1EB
         +sTx4nWa8/1lj3S4AdifuUCQA0scFG4H40NJIcYzv/Kchcui0TM+12eVcjxAGGE0+NXC
         utZi946YeHfn79eNh5i2J7noNnXL6qmdkGRvE690DN4HXw2/GL2fu8NN83orfLhznYN0
         KMrg==
X-Gm-Message-State: AOAM530plnQmrCVCgbvJfhlq9XbIWYiA5wOeNA57qE8jpehwzlvBXdXD
        40dqZvUDoyUu6WQY5S6Uq+N4GVK/p0nHqQ==
X-Google-Smtp-Source: ABdhPJy1LqSIvlZRJ99TmIvw7WTtgOOe8g1THTDLhfWrmwie0pxEg5oL7mc6fpI5Dlw3A199Q4VQYA==
X-Received: by 2002:ac2:4c47:: with SMTP id o7mr8110674lfk.202.1632234963043;
        Tue, 21 Sep 2021 07:36:03 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id p14sm1529683lfa.299.2021.09.21.07.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 07:36:02 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Yann Gautier <yann.gautier@foss.st.com>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH] mmc: mmci: Add small comment about reset thread
Date:   Tue, 21 Sep 2021 16:33:59 +0200
Message-Id: <20210921143359.1738149-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Put a small comment before assigning IRQ_WAKE_THREAD
telling us what is going on.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Yann Gautier <yann.gautier@foss.st.com>
Cc: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 3765e2f4ad98..c9cacd4d5b22 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1394,6 +1394,10 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 	} else if (host->variant->busy_timeout && busy_resp &&
 		   status & MCI_DATATIMEOUT) {
 		cmd->error = -ETIMEDOUT;
+		/*
+		 * This will wake up mmci_irq_thread() which will issue
+		 * a hardware reset of the MMCI block.
+		 */
 		host->irq_action = IRQ_WAKE_THREAD;
 	} else {
 		cmd->resp[0] = readl(base + MMCIRESPONSE0);
-- 
2.31.1

