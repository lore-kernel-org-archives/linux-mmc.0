Return-Path: <SRS0=CGCI=65=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B36C433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 15 May 2020 14:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E70420759
	for <linux-mmc@archiver.kernel.org>; Fri, 15 May 2020 14:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aX8u4ajF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgEOOE6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 15 May 2020 10:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726168AbgEOOE6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 May 2020 10:04:58 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE849C061A0C
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2020 07:04:56 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 188so1906199lfa.10
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2020 07:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KqMvS6Pwv6qwK7ezeFo5bAq4FbNQAaDLk8gZGW9T6as=;
        b=aX8u4ajFiW391041HpRcD7gqgJfPAZ/hJVoyWEEUaZsOnxW/NcXwN+EP9hbJck9lLH
         WDjTLqSnvRdOScIHXz0y+IBj5FybBPu1wchgIGEn/3IEiKao7HzyrKmf/G4hVoi7NNWb
         IPeRDmM186Y88s49kG7u0h8mS9W6ca3w4wRNbFKAwUz3ZFb7y9BzuueL9PWOj+XGazv0
         tOFcmxK4RueEOop4uFOwyOLHJPLzMKedGWodstvusmZwisrbLg5M/5rtpcy5EnacqsZk
         CU3TCrmqzDVd6bQzneNAvp/KVozlKkU20ehMcnqfYKerAr/tPgdLCo+d5bojHWfP6EYt
         kwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KqMvS6Pwv6qwK7ezeFo5bAq4FbNQAaDLk8gZGW9T6as=;
        b=Y6HKedTLUMRQPab6k4HC34SZ+v+QXuxvGcFeMP9/XzLk54CUAcqk8Pe/GBmv35XnuH
         +3EJAeLAlJRk7XIXlE4YC8pMQYlVx8+y28Kd6BTm0yr8jctmNvnB1zc8gCGE2MdLxNDB
         AP7jWodnqUP1/i7LGvKr3eDY7TIWNVOpEIyIJ/6G8NncB6UdplOOgLW71MJPKf0luMGc
         help0mPFwpicOYb27VH/ETJCvhLZWVBfmSKKhyrtD4qMHt+94ISLIrlbFVyleBoARuYP
         JrFvQyzIRE4rn1cqkpu9uIvc/GVVc6abjvgjuFuzyDrCFhdq+TeOvWBHQrkg1plBjL/p
         oOOg==
X-Gm-Message-State: AOAM5338MpCHmeKYRLzNlgHjnebFl5vnNp2CAvEDyQWTQJoA/Gdinsm1
        Hm2cTKS2w+VEd+SgSz6imkpMSu+WEDQ=
X-Google-Smtp-Source: ABdhPJwD6NGbv8QK0RiAWkvYC0Di8KBIOeOG9AwX2UOFScSP2rYJA8jKEFuP52XOClUvMPOa2FvGJw==
X-Received: by 2002:a19:505b:: with SMTP id z27mr2401339lfj.123.1589551494656;
        Fri, 15 May 2020 07:04:54 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-7.NA.cust.bahnhof.se. [98.128.181.7])
        by smtp.gmail.com with ESMTPSA id q17sm1281448lfa.28.2020.05.15.07.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 07:04:53 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Ulrich Hecht <uli+renesas@fpond.eu>,
        Simon Horman <horms+renesas@verge.net.au>,
        Niklas Soderlund <niklas.soderlund@ragnatech.se>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] mmc: tmio: Further fixup runtime PM management at remove
Date:   Fri, 15 May 2020 16:04:45 +0200
Message-Id: <20200515140445.15218-1-ulf.hansson@linaro.org>
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

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
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

