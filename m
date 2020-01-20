Return-Path: <SRS0=gs89=3J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F0DC33CAF
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jan 2020 03:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA707208CD
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jan 2020 03:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuVns5CM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgATDKu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 19 Jan 2020 22:10:50 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46520 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728949AbgATDKu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 19 Jan 2020 22:10:50 -0500
Received: by mail-pg1-f195.google.com with SMTP id z124so14776946pgb.13;
        Sun, 19 Jan 2020 19:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fKCZr7SPbdkR0t4be+CXKygxBqoOpm4Q6ztu7jbGjlc=;
        b=GuVns5CMr7Qfwg4QsVwJic5Qd9NDweGkiZRpAP9Mi2h9qzBs++5Yjie4sieope2hiH
         RhKy800d6kTRaphcyJG6SMK30KjIxV6lUFp7fiCW2dMZtIbvGmgnUaetnoQXXw7jdLX7
         okY4SJP1HhQLvsrMDy4yEZepZ7mUPjdYYBSJ7PkFCsPH1xWm9GOofLJugAkCLo21D6pb
         AxFFy3PKN01GiQzxTIkGznVSbD0mmAPdOOIPXmFnmBCXHmh/PVUK0qXSWXyrbrU3ammG
         a7L9v6DrZegzJbYqoPdLBBbMCq0Db7zSL+rySutvuBDLuQuGMjBOy2AgjZgo6AfeD6AN
         7wiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fKCZr7SPbdkR0t4be+CXKygxBqoOpm4Q6ztu7jbGjlc=;
        b=GnqgS44QcbFcas4FVUayMm4dGyPaz9sZH8ECMVDvKsZS6nsTDjLZ/6HB8YE15qfELe
         52vOuKJHINjCyt/1euQvoXhwZt5gDbli07DENvmhJ6dKm5akxrIZyjn4nCDXAmqYdp/j
         Vjph3WKKsFbHKYVlSa2thGqdsGDVB/NqgipzVie5zCvkJHA4S+kchYIocYth0a6ph5zj
         8yE1suX9D/aUbRYqDBmZaykgVBNyFqyDAe+EmuuEuRVBYbknJp1XsUKWXaS95EoAJJfV
         xRJaC79skjOn8nh0RJcI5sKgU3fayaE/T9dngMt5+EA6z31FEuSF3kFG/L8Td5/I+nn2
         ZOrA==
X-Gm-Message-State: APjAAAVQbhrOstSkCfzV3zBB/6WhLpys3BdZmyXeddpVJsN0aUCM4vrk
        EVIAA+s5J8xuJGtD54gTSyU=
X-Google-Smtp-Source: APXvYqygJXviM1rFMRcrOikmwjaSQOKa7kFMmDO2et9m7seIpguNx9RI6BvTBxyEqU0kspEppTA4NQ==
X-Received: by 2002:aa7:8687:: with SMTP id d7mr15122349pfo.164.1579489849577;
        Sun, 19 Jan 2020 19:10:49 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id v10sm35462899pgk.24.2020.01.19.19.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2020 19:10:48 -0800 (PST)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
X-Google-Original-From: Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Faiz Abbas <faiz_abbas@ti.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        linux-mmc@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH v2] mmc: sdhci: fix an issue of mixing different types
Date:   Mon, 20 Jan 2020 11:10:23 +0800
Message-Id: <20200120031023.32482-1-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Fix an issue reported by sparse, since mixed types of parameters are
used on calling dmaengine_prep_slave_sg().

Fixes: f9a7c2112165 (mmc: sdhci: Add using external dma)
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
---
Changes from v1:
* address comments from Nathan Chancellor
- define a new variable to avoid type conversions.
---
 drivers/mmc/host/sdhci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 30b5a624b50e..f9e0b5f2c692 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1201,6 +1201,7 @@ static int sdhci_external_dma_setup(struct sdhci_host *host,
 				    struct mmc_command *cmd)
 {
 	int ret, i;
+	enum dma_transfer_direction dir;
 	struct dma_async_tx_descriptor *desc;
 	struct mmc_data *data = cmd->data;
 	struct dma_chan *chan;
@@ -1234,8 +1235,8 @@ static int sdhci_external_dma_setup(struct sdhci_host *host,
 	if (sg_cnt <= 0)
 		return -EINVAL;
 
-	desc = dmaengine_prep_slave_sg(chan, data->sg, data->sg_len,
-				       mmc_get_dma_dir(data),
+	dir = data->flags & MMC_DATA_WRITE ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
+	desc = dmaengine_prep_slave_sg(chan, data->sg, data->sg_len, dir,
 				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc)
 		return -EINVAL;
-- 
2.20.1

