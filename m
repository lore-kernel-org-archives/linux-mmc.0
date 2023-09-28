Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D10E732D0
	for <linux-mmc@archiver.kernel.org>; Thu, 28 Sep 2023 13:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjI1N5f (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 28 Sep 2023 09:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbjI1N5e (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Sep 2023 09:57:34 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D82419E
        for <linux-mmc@vger.kernel.org>; Thu, 28 Sep 2023 06:57:30 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-65d066995aeso11760846d6.2
        for <linux-mmc@vger.kernel.org>; Thu, 28 Sep 2023 06:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1695909449; x=1696514249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oSN40jT34NDKom0qJtUzhXag8Ev4KHRW8ZHHC4ki3H0=;
        b=a6R/TvQ6qHyG5GNvxngelhHFeFTkn61FN0+PBN6nicF5Bs3PnI7vZn/GK51SCICN+V
         qFZIHoz6UrH2zTbA5FjiS4o41ShBXCP6J/vAmJvQvlZkAnwB4JYHiqIeAPSKKJ8SuEA5
         J4AmLQd4/rN9V3vEaV7Z8mc3C0SAiFBo9q6d5cV4mnzf+SQkkjK64ri+1QVhgEnIOpE/
         dmb08S13LAfLUlSEJj/J0JaMeFowUQNKGJ+lahad30Dz1dK3OOFcAdnNuvy8TdraskZt
         Nbj/4KiEVp4JhWXxxKElYQO+WM63WTqJcNKMg772Im8si3sK6QQnLUw11D69+1U837bq
         PR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695909449; x=1696514249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oSN40jT34NDKom0qJtUzhXag8Ev4KHRW8ZHHC4ki3H0=;
        b=EfjU1auItmLG0M6S5MXb8ZscH0QyY4Vzg1Sh7j61byg6ZQ4T1jfrGYDkePOHnMbZz3
         gSaXN+c8c9cNhtFMviPrrPIgnQY8HGFvAR20zpqZY779oyF4JioV5DUvzfH+OtPElH2d
         kSO26boshqecE1uCe6bZIgUCZDLjCS3gHZ1ayI1wR61xzc3lU3nUsRMJZQgPrkPnZK7H
         aHzwx2m4sF9LMUlB9TV+dNrrtlq3AgNfTYphT8NeoMbixie3dJn5wwmVZVKG2vD+F0/Z
         7pDXQLIQX3nrEGlGuK1jr4uIuQceiyU3+c9blp4J6mNQ9cW2+h6eE+lyQqF2+jj5yobT
         2bhA==
X-Gm-Message-State: AOJu0YxKKN0n2f/s7TyLLvbVCR6sss2/Tie8aJhKuGsZi28CVOzx08DI
        NXqaPDRvzKnII2Lb4PjWA+YIfg==
X-Google-Smtp-Source: AGHT+IGWdn26NNdifnVExovijL5Usr/Yz4eGRPPDpetnJW0N8ZJ8ASVWk2eVgwnW8IZq0ltvmEXprg==
X-Received: by 2002:a0c:cb12:0:b0:64f:4a4a:edc9 with SMTP id o18-20020a0ccb12000000b0064f4a4aedc9mr1141508qvk.64.1695909449665;
        Thu, 28 Sep 2023 06:57:29 -0700 (PDT)
Received: from localhost.localdomain ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id r10-20020a0c9e8a000000b006562b70805bsm3843529qvd.84.2023.09.28.06.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 06:57:29 -0700 (PDT)
From:   Ben Wolsieffer <ben.wolsieffer@hefring.com>
To:     linux-stm32@st-md-mailman.stormreply.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Yann Gautier <yann.gautier@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ben Wolsieffer <Ben.Wolsieffer@hefring.com>
Subject: [PATCH v2] mmc: mmci: use peripheral flow control for STM32
Date:   Thu, 28 Sep 2023 09:56:44 -0400
Message-ID: <20230928135644.1489691-1-ben.wolsieffer@hefring.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ben Wolsieffer <Ben.Wolsieffer@hefring.com>

The STM32 SDMMC peripheral (at least for the STM32F429, STM32F469 and
STM32F746, which are all the currently supported devices using periphid
0x00880180) requires DMA to be performed in peripheral flow controller
mode. From the STM32F74/5 reference manual, section 35.3.2:

"SDMMC host allows only to use the DMA in peripheral flow controller
mode. DMA stream used to serve SDMMC must be configured in peripheral
flow controller mode"

This patch adds a variant option to control peripheral flow control and
enables it for the STM32 variant.

Signed-off-by: Ben Wolsieffer <Ben.Wolsieffer@hefring.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v2: use bool instead of u8:1

 drivers/mmc/host/mmci.c | 3 ++-
 drivers/mmc/host/mmci.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 769b34afa835..90e32f18abbc 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -249,6 +249,7 @@ static struct variant_data variant_stm32 = {
 	.f_max			= 48000000,
 	.pwrreg_clkgate		= true,
 	.pwrreg_nopower		= true,
+	.dma_flow_controller	= true,
 	.init			= mmci_variant_init,
 };
 
@@ -1012,7 +1013,7 @@ static int _mmci_dmae_prep_data(struct mmci_host *host, struct mmc_data *data,
 		.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES,
 		.src_maxburst = variant->fifohalfsize >> 2, /* # of words */
 		.dst_maxburst = variant->fifohalfsize >> 2, /* # of words */
-		.device_fc = false,
+		.device_fc = variant->dma_flow_controller,
 	};
 	struct dma_chan *chan;
 	struct dma_device *device;
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 253197f132fc..34d9897c289b 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -332,6 +332,7 @@ enum mmci_busy_state {
  * @opendrain: bitmask identifying the OPENDRAIN bit inside MMCIPOWER register
  * @dma_lli: true if variant has dma link list feature.
  * @stm32_idmabsize_mask: stm32 sdmmc idma buffer size.
+ * @dma_flow_controller: use peripheral as flow controller for DMA.
  */
 struct variant_data {
 	unsigned int		clkreg;
@@ -378,6 +379,7 @@ struct variant_data {
 	u8			dma_lli:1;
 	u32			stm32_idmabsize_mask;
 	u32			stm32_idmabsize_align;
+	bool			dma_flow_controller;
 	void (*init)(struct mmci_host *host);
 };
 
-- 
2.42.0

