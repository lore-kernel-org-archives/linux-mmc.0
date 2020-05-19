Return-Path: <SRS0=/V3P=7B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6889C433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 15:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7B722075F
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 15:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lGUEhzjL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbgESPYp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 May 2020 11:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728725AbgESPYo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 May 2020 11:24:44 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6672EC08C5C0
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2020 08:24:44 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id a9so11583168lfb.8
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2020 08:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kMsv3cAqsxyDutgPEs20bbhBPO7GSajJGggFJHsZRI0=;
        b=lGUEhzjLLdHI8as19cQ2pCWFuK6xvwZguwaW9TS+VtiZ8X4Gi+to4WRDESe4Do8BQ3
         WyWk/PO2hThZCGZobHv/KzQwUpSfjTWU/qLOD6816KxNSorN8PqSN8KpnJg7Y01U9H8y
         i5J5GCcygexpAuA2CySyuHBwTEYZyqLJJoicdam8CXTHEtjEmJ006AGxozkEVvDpnwY4
         FLdNW+oSlQ86sexnHXedBhq233CrW5qz3bLTSKLTs+NtwvhyPjUmYzi9YCqrLEJmRVHs
         VJr1vv6R0qJOB/vh+h7ZTaFf2Iwa1MARc4DF2cwmvNyJQ6fR/1PQ1t60yUkewNzineR6
         ZOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kMsv3cAqsxyDutgPEs20bbhBPO7GSajJGggFJHsZRI0=;
        b=LPkoOHCdOREa1m/xA3lrrVOgII1QdDDmfcxQygVocEWbKihhok5iQgUv9XC/MXw8Qy
         cSXVTKYAXCmx3Q6jcqrkSoIt+FM7JEXIwXMlNyfCRTkpeGzfe6O+5VAuGpEZqXgBOObk
         r3DRAGPgSntxPtJh/ZqW/udzGYkaUjjcUAkoGHnDnfi/W1P2UDTMCTgWDcuwE4zvNmS8
         1ELI2y5XvJRKqcMzOmgnsuuethc9KqhBbvrK4nN6UM3Lg033hOO68bkyF0Ee6CRSkhEa
         seRYWxpwNtjmc0EvvU4jUIij+gdAQVma51BSEqrw81S3jJrFoMdrnhzGReVcNB3rogPI
         K6Zg==
X-Gm-Message-State: AOAM530LweQmjNp6ameS4A8nq5DiQ+aDffOJXXsqGZPseL2g9TwRmQDd
        isF7j7VYQrZ7MdjxzhkI58Q8D51+vV2qEA==
X-Google-Smtp-Source: ABdhPJxotfu8oI16gvvkE4fLb6GdKQ4dZhP8pjqzDAWcRYAIgwAiYdOyobAdLV0U61rWkSQud8mvAQ==
X-Received: by 2002:a05:6512:3082:: with SMTP id z2mr15811421lfd.32.1589901880766;
        Tue, 19 May 2020 08:24:40 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-7.NA.cust.bahnhof.se. [98.128.181.7])
        by smtp.gmail.com with ESMTPSA id y20sm1144645lji.31.2020.05.19.08.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 08:24:39 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Ulrich Hecht <uli+renesas@fpond.eu>,
        Simon Horman <horms+renesas@verge.net.au>,
        Niklas Soderlund <niklas.soderlund@ragnatech.se>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] mmc: tmio: Further fixup runtime PM management at remove
Date:   Tue, 19 May 2020 17:24:34 +0200
Message-Id: <20200519152434.6867-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Before calling tmio_mmc_host_probe(), the caller is required to enable
clocks for its device, as to make it accessible when reading/writing
registers during probe.

Therefore, the responsibility to disable these clocks, in the error path of
->probe() and during ->remove(), is better managed outside
tmio_mmc_host_remove(). As a matter of fact, callers of
tmio_mmc_host_remove() already expects this to be the behaviour.

However, there's a problem with tmio_mmc_host_remove() when the Kconfig
option, CONFIG_PM, is set. More precisely, tmio_mmc_host_remove() may then
disable the clock via runtime PM, which leads to clock enable/disable
imbalance problems, when the caller of tmio_mmc_host_remove() also tries to
disable the same clocks.

To solve the problem, let's make sure tmio_mmc_host_remove() leaves the
device with clocks enabled, but also make sure to disable the IRQs, as we
normally do at ->runtime_suspend().

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/tmio_mmc_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index f31afd1c2671..ba301fb7656b 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1231,12 +1231,14 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
 	cancel_work_sync(&host->done);
 	cancel_delayed_work_sync(&host->delayed_reset_work);
 	tmio_mmc_release_dma(host);
+	tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_ALL);
 
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	if (host->native_hotplug)
 		pm_runtime_put_noidle(&pdev->dev);
-	pm_runtime_put_sync(&pdev->dev);
+
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
 }
 EXPORT_SYMBOL_GPL(tmio_mmc_host_remove);
 
-- 
2.20.1

