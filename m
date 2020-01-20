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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAB2C32771
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jan 2020 03:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251BA2073D
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jan 2020 03:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoJD4gJL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbgATDcb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 19 Jan 2020 22:32:31 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44572 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729011AbgATDcb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 19 Jan 2020 22:32:31 -0500
Received: by mail-pg1-f193.google.com with SMTP id x7so14804873pgl.11;
        Sun, 19 Jan 2020 19:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kaVyaqcx1+XyBwYscJJnTfM3SI5pH5G1DrO35gYdNN4=;
        b=FoJD4gJL5PJkh212LMvylohSi2Pb6AWHmppyyaghq1/vQjhDr+LM984p7OCt0bSBJU
         ZcLHbDukrD4zyoTRSkCJZWyqpp/pAT2VmDhseq1ttMG5TeMdfQVsuKt0CpjEY3plY4H/
         KUF0zX8/wMbYUV+xaAHCfUH27nMPy+zL/sH/Nltm3atm3IpVSAfMR5ugoUuiSxZovJYb
         qHnKPiLoNegSV9k9WmMIz8OHYUXJ8/rvWHfkntpqM4E+jrFBilAsqKdIihXVfZtdWA0q
         u0b+swRvR4G8td2aTRGqdbYH+CLU1D+kZsdmG3x3ay9DZBlZA/miXsOFe9e6OMy5FkSo
         Bdcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kaVyaqcx1+XyBwYscJJnTfM3SI5pH5G1DrO35gYdNN4=;
        b=SU50LFMlaERkEimpW4tCvHiYUhzPIx5CPqNUHzWdUgi3O8GfA0CF2HLmnKyZSaVguB
         vIC1H6rZzNbomS9fxXMHQdSNqMP3KLOMVc1gXYPD39SiajNggzKJdb9IKB7TD1fo4niv
         fXsoF5ge5NFI2Ak01y1SD5ZBtPCT8Ew6Ga6tRrICtM5hmuj/lVfH8ZXi3fOON2/hxRz5
         qZUPTBi2EHo3A7zupOAEzECn2CBgVe2QCU7p1uce6JzYS35ooajUzYX2jfupPA+2P+EJ
         4BMCh5YS7iIPSrPohdUvXLvXaY6J2NgzQFL8wFkhBWH5QnpS0+8iGOcOftOCkZeiHxX1
         LNwg==
X-Gm-Message-State: APjAAAUAc3huAdwP8Yja/TbTyS39TwJJSdOIytAltTTe1Zox7Rf0iR3l
        1/Q+1fF3//6B9DDqSv54gN2gBKA6
X-Google-Smtp-Source: APXvYqySOgkid6AmSPFPjXJEhZ9w/R1sZ3Uc8tyKbT54CuTFc0wlYPuZ3eSoA/jw9fdxcpQkz9pBTA==
X-Received: by 2002:a63:1204:: with SMTP id h4mr56608273pgl.288.1579491150642;
        Sun, 19 Jan 2020 19:32:30 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id d4sm14746798pjz.12.2020.01.19.19.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2020 19:32:29 -0800 (PST)
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
Date:   Mon, 20 Jan 2020 11:32:23 +0800
Message-Id: <20200120033223.897-1-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200120031023.32482-1-zhang.chunyan@linaro.org>
References: <20200120031023.32482-1-zhang.chunyan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Fix an issue reported by sparse, since mixed types of parameters are
used on calling dmaengine_prep_slave_sg().

Fixes: 36e1da441fec (mmc: sdhci: add support for using external DMA devices)
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

