Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7728EC41513
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Oct 2023 09:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjJPJ4U (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Oct 2023 05:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjJPJ4T (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Oct 2023 05:56:19 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95AEB4
        for <linux-mmc@vger.kernel.org>; Mon, 16 Oct 2023 02:56:16 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4056ce55e7eso42390835e9.2
        for <linux-mmc@vger.kernel.org>; Mon, 16 Oct 2023 02:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697450175; x=1698054975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Ykfy1aQinss/cScFDXLYGVKdm7XaTfwtTVLqUolg/A=;
        b=YT1vyB+ko87mdpuZ/ahTYSNMImDPDrmq7sDPHZhlPJfsiw7X0+UL0NDR4FGvEswfgi
         DgZN2Cnq/ZcrTluvj6iSL/AtFmNTj0kD218izW8vzbi5/92p+88U0PF/UFDSC+SZ95hT
         BqBlsmSnReQNULSl9BiDMhBOBRh3KOwE4O98s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697450175; x=1698054975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Ykfy1aQinss/cScFDXLYGVKdm7XaTfwtTVLqUolg/A=;
        b=qkq5XOuIIUIckAsAIsKCst40OTeBg5iIpT1K8pommL4UiZE05phnE/Bnx3xazSX3Tg
         CYOReiEjUeF3BiHmsjVvyNrsMN4uktZdH2l23Q2BcrVkya9Cgr2qy3AYZ3BqoR1lBWNH
         //g0B/x8nLZEymYJAUuLYMuSnOhIzY5lvvonlN4kZVN3p5Mco8qJJnhn3/OeE7H6SUBa
         vsqNS9y8zucvxeKC+L6sCZRd2FhnpxpKNdG9jeA4S6ehBRe+3R/7mJQzp9lATkpAb11n
         APtKQrNFcVSOkcspMkdhxwir34Gy19plgmSpTzPgCr88Fh7qnT8UQch331s2jxiW1wRM
         YArQ==
X-Gm-Message-State: AOJu0YxTmFld1hPKwxA2hg4vg3MneniOXyL2iU3tIse2ydZ1Sx3n/V46
        mLXZldsPkvV7qghL3QH2drdkX7AfwXcQQO7QApU=
X-Google-Smtp-Source: AGHT+IEajqlMs7jK0VUTXrO2Mp+eRM0mC2/Xk8/DfFOEueyPhrOyDbU2cqu5hQjB2lnEIueoLeR6eA==
X-Received: by 2002:a5d:4d08:0:b0:32d:a405:b6b7 with SMTP id z8-20020a5d4d08000000b0032da405b6b7mr4410671wrt.32.1697450174747;
        Mon, 16 Oct 2023 02:56:14 -0700 (PDT)
Received: from orzel1.c.googlers.com.com (180.232.140.34.bc.googleusercontent.com. [34.140.232.180])
        by smtp.gmail.com with ESMTPSA id t11-20020a5d534b000000b003232380ffd5sm26899696wrv.106.2023.10.16.02.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 02:56:14 -0700 (PDT)
From:   =?UTF-8?q?Kornel=20Dul=C4=99ba?= <korneld@chromium.org>
To:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Radoslaw Biernacki <biernacki@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>, upstream@semihalf.com,
        =?UTF-8?q?Kornel=20Dul=C4=99ba?= <korneld@chromium.org>
Subject: [PATCH] mmc: cqhci: Be more verbose in error irq handler
Date:   Mon, 16 Oct 2023 09:56:10 +0000
Message-ID: <20231016095610.1095084-1-korneld@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

There are several reasons for controller to generate an error interrupt.
They include controller<->card timeout, and CRC mismatch error.
Right now we only get one line in the logs stating that CQE recovery was
triggered, but with no information about what caused it.
To figure out what happened be more verbose and dump the registers from
irq error handler logic.
This matches the behaviour of the software timeout logic, see
cqhci_timeout.

Signed-off-by: Kornel Dulęba <korneld@chromium.org>
---
 drivers/mmc/host/cqhci-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index b3d7d6d8d654..33abb4bd53b5 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -700,8 +700,9 @@ static void cqhci_error_irq(struct mmc_host *mmc, u32 status, int cmd_error,
 
 	terri = cqhci_readl(cq_host, CQHCI_TERRI);
 
-	pr_debug("%s: cqhci: error IRQ status: 0x%08x cmd error %d data error %d TERRI: 0x%08x\n",
-		 mmc_hostname(mmc), status, cmd_error, data_error, terri);
+	pr_warn("%s: cqhci: error IRQ status: 0x%08x cmd error %d data error %d\n",
+		 mmc_hostname(mmc), status, cmd_error, data_error);
+	cqhci_dumpregs(cq_host);
 
 	/* Forget about errors when recovery has already been triggered */
 	if (cq_host->recovery_halt)
-- 
2.42.0.655.g421f12c284-goog

