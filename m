Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A501C636CD
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Feb 2023 14:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbjBJOi7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Feb 2023 09:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjBJOi6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Feb 2023 09:38:58 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6CF6D8F1
        for <linux-mmc@vger.kernel.org>; Fri, 10 Feb 2023 06:38:57 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id rp23so16377298ejb.7
        for <linux-mmc@vger.kernel.org>; Fri, 10 Feb 2023 06:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3v2OsNDhuNc/QtUD+nMa+IQk6nE6+botf1Olqk/Fwfk=;
        b=bbddggMbs5Zi0wLnr7moJVL6ULVQp1RDlIjubmHRh7k8RyyixQvwEQfW08gum3D5fc
         jqU3mgtv9d17kbr4FrXByw2lycm7C0914bzVIPOahPrTaRygecedB2hiyOGXK+vXPnt2
         BtyoesBSL0iCFQaAdKVc6Hjbk0K/DE9d+3Ul41CQuVYRg8Tu1KUhLrcx7WQOEWP6rt6i
         xhJqdQF6H/v9aHCTr0ni6g41jqDPVoYg+FyuW3/vNLsIXcoh45d7eqYODhUOC6ftqthi
         8+x95/BjnCwKprqS4P0gBiSTAy+bNSSpQVZK4eN7+sA2PwVQePftZ7ZsDi3jvJfUcc8r
         ceMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3v2OsNDhuNc/QtUD+nMa+IQk6nE6+botf1Olqk/Fwfk=;
        b=Nome41KGsw+ITMtlTjfp05gpHfdyBiS9EnpIbKU8tIa1A09ypQ+QzywSOQMZ9ah8gb
         payPWyP739GzAFz/JQ5mPXwr6TG9F/7C7vwOzMsaoDyE4agW+uMWExifZCpPrih2bjtE
         +ghIATRInNGdh4a5JJx74i9y7JKd+Pwws3tytWUr/InxmPOa+VOuHr6UlhnDyCewWqu3
         Jn3ex9757sYlQ68OiZQhH+SL81at5HWCNOoLD41wR9HcJlz4QyXrhlUMPa8nqwPDsUB8
         4D3YSpd/J5A1iPxJiASWGwROk1xl1IrqyGjs7MY9bEoGmPU9HFAWYTymQSrjfnqLe8vY
         1iGQ==
X-Gm-Message-State: AO0yUKVUk9fslD90hy4s9KrFMTx1lAGNNyyNo51dk3Wmbgk9LCnNAvvG
        gEc75Qk8oYceRWwO0Tr6xpkJ3QTyFwY=
X-Google-Smtp-Source: AK7set96kB2F7SPbYSmZfwCbwlO8yBquLF2AEokhdfK0/bJ49UaErHl63QBDAkiivdW9QodsNaCgGQ==
X-Received: by 2002:a17:906:a013:b0:878:4e5a:18b8 with SMTP id p19-20020a170906a01300b008784e5a18b8mr15012635ejy.66.1676039935521;
        Fri, 10 Feb 2023 06:38:55 -0800 (PST)
Received: from saproj-Latitude-5501.yandex.net ([2a02:6b8:0:40c:e457:f2f1:7ffc:fb09])
        by smtp.gmail.com with ESMTPSA id g22-20020a170906199600b0087bd629e9e4sm2455894ejd.179.2023.02.10.06.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 06:38:55 -0800 (PST)
From:   Sergei Antonov <saproj@gmail.com>
To:     linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc:     jonas.jensen@gmail.com, Sergei Antonov <saproj@gmail.com>
Subject: [PATCH] mmc: moxart: set maximum request/block/segment sizes
Date:   Fri, 10 Feb 2023 17:38:43 +0300
Message-Id: <20230210143843.369943-1-saproj@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Per datasheet: maximum block length is 2048 bytes,
data length field is in bits 0-23 of the Data Length Register.

Also for DMA mode we have to take into account rx/tx buffers' sizes.

In my tests this change doubles SD card I/O performance on big files.
Before the change Linux used default request size of 4 KB.

Signed-off-by: Sergei Antonov <saproj@gmail.com>
---
 drivers/mmc/host/moxart-mmc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index 52ed30f2d9f4..2d002c81dcf3 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -611,6 +611,9 @@ static int moxart_probe(struct platform_device *pdev)
 	mmc->f_max = DIV_ROUND_CLOSEST(host->sysclk, 2);
 	mmc->f_min = DIV_ROUND_CLOSEST(host->sysclk, CLK_DIV_MASK * 2);
 	mmc->ocr_avail = 0xffff00;	/* Support 2.0v - 3.6v power. */
+	mmc->max_blk_size = 2048; /* Max. block length in REG_DATA_CONTROL */
+	mmc->max_req_size = DATA_LEN_MASK; /* bits 0-23 in REG_DATA_LENGTH */
+	mmc->max_blk_count = mmc->max_req_size / 512;
 
 	if (IS_ERR(host->dma_chan_tx) || IS_ERR(host->dma_chan_rx)) {
 		if (PTR_ERR(host->dma_chan_tx) == -EPROBE_DEFER ||
@@ -628,6 +631,8 @@ static int moxart_probe(struct platform_device *pdev)
 		}
 		dev_dbg(dev, "PIO mode transfer enabled\n");
 		host->have_dma = false;
+
+		mmc->max_seg_size = mmc->max_req_size;
 	} else {
 		dev_dbg(dev, "DMA channels found (%p,%p)\n",
 			 host->dma_chan_tx, host->dma_chan_rx);
@@ -646,6 +651,10 @@ static int moxart_probe(struct platform_device *pdev)
 		cfg.src_addr = host->reg_phys + REG_DATA_WINDOW;
 		cfg.dst_addr = 0;
 		dmaengine_slave_config(host->dma_chan_rx, &cfg);
+
+		mmc->max_seg_size = min3(mmc->max_req_size,
+			dma_get_max_seg_size(host->dma_chan_rx->device->dev),
+			dma_get_max_seg_size(host->dma_chan_tx->device->dev));
 	}
 
 	if (readl(host->base + REG_BUS_WIDTH) & BUS_WIDTH_4_SUPPORT)
-- 
2.34.1

