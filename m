Return-Path: <SRS0=M0Y2=63=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AC0C433DF
	for <linux-mmc@archiver.kernel.org>; Wed, 13 May 2020 20:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E052A205ED
	for <linux-mmc@archiver.kernel.org>; Wed, 13 May 2020 20:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20150623.gappssmtp.com header.i=@timesys-com.20150623.gappssmtp.com header.b="2H0HM1h6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgEMUgc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 May 2020 16:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbgEMUgb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 May 2020 16:36:31 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFDDC061A0E
        for <linux-mmc@vger.kernel.org>; Wed, 13 May 2020 13:36:31 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id i5so733590qkl.12
        for <linux-mmc@vger.kernel.org>; Wed, 13 May 2020 13:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kPWaDkD0RAIySfPv/g8z8eXvElgoPuvjXxn+yIeiEDA=;
        b=2H0HM1h6dpP76OySfS+AO0PVuvtJWJ5lqUL4uAk5bAjtLtqWsx6fGAIsvgrW+au2Ws
         JAS07/oqiCSzyyfNTZlq3UkJe9aKghMMvfC93zwOJcvCDFTIYctWD7VQLkZ6U9J0LgJO
         M5FOKb0ZKvvnQHRZQ0D0GvF5Ee2NoA3Mw65Ef++iE9NNm+IOPKNrjPayPMWRtTet+/S5
         LAjPZtzZi918Kjf9zgiZvwYCFIAF657vVG5MFNrFRqlKqzKkDPm/BS2cJjTXWzHdNE2q
         /YtIfRzvdfUmSlwtSWKGmYLwAeSFB5PZRwdBcP8DdULtie2LGlFo5hhHc3LQ51L6XdHN
         NRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kPWaDkD0RAIySfPv/g8z8eXvElgoPuvjXxn+yIeiEDA=;
        b=d3wgOCoIqKZTP/RSJGWiaNsY9GiEQde8pqHF4dOXA5JdR8NNbVt/72oj9V5qbKQorf
         6En1djQRZFkmgiQGXDGnq5a/TB/J9VzsRPLaODeG5nF8SbNF8lSeoX8lp49xKc8JoYUg
         055LB7O5jU+A8E2dT6ppXkGBMy+qKZEjIv3Cmk1R/kUwQkpqpQPlbzxFtUr4bkH8UqUx
         XWcwXQXeWVq06gDkxdos2JrzFFkPGEKZ13vWKHhJpyC8Luxtsq80qmSI5ksBFXf9SOKz
         3gs4t+Qs5VeVELRM2hn4UWptnibgiwOluMLkGciqiwtIhlPio40nJrzyCEE99AOr5yTP
         Y/Fg==
X-Gm-Message-State: AOAM532G1aM+I/8yj/wJ4EfbCY6Z1jrkBig7Bq3soKxZfLg20u/FLTdT
        tPKtV+BpoXc0JEG+yvtA9dwIng==
X-Google-Smtp-Source: ABdhPJwyqamgFgTPWmZMKGLqkPUFYJPKMwvOLbWsqsURcMR3aSw8lSzUeRuyYnEe7rPVRl8VdUbGQg==
X-Received: by 2002:a37:9d55:: with SMTP id g82mr1393002qke.407.1589402190490;
        Wed, 13 May 2020 13:36:30 -0700 (PDT)
Received: from dfj.bfc.timesys.com (host203-36-dynamic.30-79-r.retail.telecomitalia.it. [79.30.36.203])
        by smtp.gmail.com with ESMTPSA id a16sm754528qko.92.2020.05.13.13.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 13:36:30 -0700 (PDT)
From:   Angelo Dureghello <angelo.dureghello@timesys.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        gerg@linux-m68k.org
Cc:     linux-mmc@vger.kernel.org, linux-m68k@vger.kernel.org,
        Angelo Dureghello <angelo.dureghello@timesys.com>
Subject: [PATCH v4 2/3] mmc: sdhci: add quirks for be to le byte swapping
Date:   Wed, 13 May 2020 22:41:32 +0200
Message-Id: <20200513204133.2540568-2-angelo.dureghello@timesys.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513204133.2540568-1-angelo.dureghello@timesys.com>
References: <20200513204133.2540568-1-angelo.dureghello@timesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Some controller as the ColdFire eshdc may require an endianness
byte swap, becouse DMA read endianness is not configurable.

Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
---
Changes for v3:
- add post request callback
Changes for v4:
none
---
 drivers/mmc/host/sdhci.c | 7 +++++++
 drivers/mmc/host/sdhci.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3f716466fcfd..d3bfbb6e11d5 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -637,6 +637,13 @@ static int sdhci_pre_dma_transfer(struct sdhci_host *host,
 			sg_copy_to_buffer(data->sg, data->sg_len,
 					  host->bounce_buffer,
 					  length);
+
+			/*
+			 * Endianness can't be swapped in the sg list,
+			 * since the sg list is processed again later on.
+			 */
+			if (host->ops->pre_dma_transfer)
+				host->ops->pre_dma_transfer(host, data);
 		}
 		/* Switch ownership to the DMA */
 		dma_sync_single_for_device(host->mmc->parent,
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 79dffbb731d3..076054308423 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -653,6 +653,8 @@ struct sdhci_ops {
 	void	(*voltage_switch)(struct sdhci_host *host);
 	void	(*adma_write_desc)(struct sdhci_host *host, void **desc,
 				   dma_addr_t addr, int len, unsigned int cmd);
+	void	(*pre_dma_transfer)(struct sdhci_host *host,
+				    struct mmc_data *data);
 	void	(*request_done)(struct sdhci_host *host,
 				struct mmc_request *mrq);
 };
-- 
2.26.2

