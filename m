Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054DDECAAD4
	for <linux-mmc@archiver.kernel.org>; Wed, 31 Aug 2022 12:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiHaMoX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 31 Aug 2022 08:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbiHaMoV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Aug 2022 08:44:21 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E56D3EF6
        for <linux-mmc@vger.kernel.org>; Wed, 31 Aug 2022 05:44:20 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id bh13so13418241pgb.4
        for <linux-mmc@vger.kernel.org>; Wed, 31 Aug 2022 05:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=4pqIrm9XF11uoq7wqDqM7YICZ90z1eeNdlzFxcvpJAs=;
        b=TaIePInDwPcb00zXdI1pUdEU+sZzyaMqdh0eBnj8D3eqePcohnCgrXBQq2XGswDPSp
         BbkF9wurlGgnxhmXpHeStMF48vq7GV4r80XOJWQ5EzIVjWl+JQhet6CijEo6gfOdWG+n
         pMXlY7K+tovAyNqWahyTDpnLLRyanQ3PATFuc1wjAJ2yiBBSDEepbqk93P6+C5vKvBka
         l7h75sNUTEypYDvxUYerZ0mSUO11MVDQxxrNoMQxrU1xvVoV/7EYKn89pee/WwRW9C96
         QsOvdrAd8TBwfEqUamOGwPgLHuBznr0EmM2bhYPl5uY+NwDXp+YrA45lSbtx8+GKG+pW
         h8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=4pqIrm9XF11uoq7wqDqM7YICZ90z1eeNdlzFxcvpJAs=;
        b=UGhajIZyktjUxaflFg+6ao0eB7nIRPcCJHprCMC3mOa4Ag922NQCtSGXJaXg7p1h84
         V682ytGd73dIjePKfUohawHomoaf3bzu66YT5W0PTq4/oPV5iFR856UtcSyS845J0VdR
         hVSuLc4QDqjw+R5qpdK8uWHlzB2rHhbSuskHTiD1YYy5yFMbWbtNjRXZCnuJ834OpWA+
         K/zZZyv86IzVwVmnHGbUQbBCJi3mICzwm1hLP21ZSN3Dmmx7+WLz4aj5HHtV6Ocn2J1E
         Pa6SUBomRKmJEyix5WxnEBdpTI3dW4KhpZTchtNoX+EU6oFOjKByi/garCxCZ53SEw/b
         nlOw==
X-Gm-Message-State: ACgBeo2FVqBWR+qTqsQ1kIjqhMA5yWm5zFmgV4IEQnMDaBxjVWwcF3qY
        v6wnH0oM3xdsIAhnKeSHIvz65kQQ8Y9PjasYO94=
X-Google-Smtp-Source: AA6agR7Jn4AE/WgdxjdHUjLEsebeFV6EwNXj/n6opb650bKzQeuDHsc9bFIC45klPtUH3jFH1Uy2QA==
X-Received: by 2002:a63:2cc2:0:b0:41c:681d:60d2 with SMTP id s185-20020a632cc2000000b0041c681d60d2mr21164645pgs.502.1661949860044;
        Wed, 31 Aug 2022 05:44:20 -0700 (PDT)
Received: from localhost ([111.184.129.17])
        by smtp.gmail.com with ESMTPSA id w1-20020a170902ca0100b00174be817124sm6632005pld.221.2022.08.31.05.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 05:44:19 -0700 (PDT)
From:   "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
X-Google-Original-From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To:     linux-mmc@vger.kernel.org
Cc:     "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
        Ram Muthiah <rammuthiah@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/1] mmc: sdhci: check host->cmd is null or not in sdhci_cqe_irq()
Date:   Wed, 31 Aug 2022 20:43:59 +0800
Message-Id: <20220831124359.2005165-2-paulliu@debian.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220831124359.2005165-1-paulliu@debian.org>
References: <20220831124359.2005165-1-paulliu@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>

If we don't check host->cmd. We will get the following oops
when booting from eMMC on RockPi4.

 Unable to handle kernel read from unreadable memory at
   virtual address 0000000000000000
 Call trace:
   sdhci_cqe_irq+0x40/0x254

Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
Signed-off-by: Ram Muthiah <rammuthiah@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ritesh Harjani <riteshh@codeaurora.org>
Cc: Asutosh Das <asutoshd@codeaurora.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
---
 drivers/mmc/host/sdhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7689ffec5ad1..e0e7768bd6c0 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3928,7 +3928,7 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
 
 	if (intmask & (SDHCI_INT_INDEX | SDHCI_INT_END_BIT | SDHCI_INT_CRC)) {
 		*cmd_error = -EILSEQ;
-		if (!mmc_op_tuning(host->cmd->opcode))
+		if (host->cmd && !mmc_op_tuning(host->cmd->opcode))
 			sdhci_err_stats_inc(host, CMD_CRC);
 	} else if (intmask & SDHCI_INT_TIMEOUT) {
 		*cmd_error = -ETIMEDOUT;
@@ -3938,7 +3938,7 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
 
 	if (intmask & (SDHCI_INT_DATA_END_BIT | SDHCI_INT_DATA_CRC)) {
 		*data_error = -EILSEQ;
-		if (!mmc_op_tuning(host->cmd->opcode))
+		if (host->cmd && !mmc_op_tuning(host->cmd->opcode))
 			sdhci_err_stats_inc(host, DAT_CRC);
 	} else if (intmask & SDHCI_INT_DATA_TIMEOUT) {
 		*data_error = -ETIMEDOUT;
-- 
2.35.1

