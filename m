Return-Path: <SRS0=lwnd=CM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E047BC433E2
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Sep 2020 23:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFE622078E
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Sep 2020 23:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eoeZ1xlM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgICXZg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 3 Sep 2020 19:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbgICXZK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Sep 2020 19:25:10 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F1BC061246
        for <linux-mmc@vger.kernel.org>; Thu,  3 Sep 2020 16:25:09 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 67so3319311pgd.12
        for <linux-mmc@vger.kernel.org>; Thu, 03 Sep 2020 16:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0oWgj2zq4zbbu5lAqus3SluKKFu5QfUtlWwopTJGHMA=;
        b=eoeZ1xlMPFP7Tf/iVuNvLqP75LmGdaQxIL0WoQWrQV7z/RAJe1VI+/DA7rgv4g5DBu
         f0Hxd7xcKwWdR4vAPofeXOYXGuq3ZOZAmsFgRp6sbKo+mbb7rIzMsOOHkMTDmoyimP1X
         Kd32TS18l3b0IpJjGqqUzlJtQhqZl55x6MECE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0oWgj2zq4zbbu5lAqus3SluKKFu5QfUtlWwopTJGHMA=;
        b=Vk7Uqf/baU8B0jy766WKZ9uS/5BVhW/TUzkHceaV51ygpz8CcufPGSMDLbVMJPSfOy
         zjWnsYg5QhLJaFCU2BZ0WRprwv2cxxjC2gGaUaUl5KoGlM70qoD+Em81c2Vwmh9G3F2+
         yWEvX7nitK2yI2xyWtzEjKMmTrzOIj4D11qSKchTORUrJz4Kfk21qGXXR6POP5Rlfcum
         uKH00JrqnLScbqw4GjovX+isFkQigsdkGcEfE72Lq3rx7Dbt+8+Z3HB+1fAZ4SXYkBIK
         VR49qwPiVuqmfUDP613CcQ54vY/wf5Tu5hsPTB4NR5yoEKssoj193pcaZhtag4kmINmZ
         Ih8w==
X-Gm-Message-State: AOAM5303TEscp6Hp+6SWIwTro1gvL5g249jbxOv/WJaMB+5SGv4xFc+u
        vb5DW0N4P/8NynAFFnOUQA1FEA==
X-Google-Smtp-Source: ABdhPJxXci8J9Qv2zlxPsg4flpI87MuxgFVsNrgjNmKzdj6MjvnpdWRph2Y0Jrgb94EhRBlfr/NozA==
X-Received: by 2002:a62:838a:: with SMTP id h132mr5979867pfe.72.1599175509378;
        Thu, 03 Sep 2020 16:25:09 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id q7sm3614459pgg.10.2020.09.03.16.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 16:25:08 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     swboyd@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH 5/6] mmc: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in v5.4
Date:   Thu,  3 Sep 2020 16:24:40 -0700
Message-Id: <20200903162412.5.I2b630c4d40ff4ea61d5b30b8ccfe95890e257100@changeid>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
In-Reply-To: <20200903232441.2694866-1-dianders@chromium.org>
References: <20200903232441.2694866-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This is like commit 3d3451124f3d ("mmc: sdhci-msm: Prefer asynchronous
probe") but applied to a whole pile of drivers.  This batch converts
the drivers that appeared to be around in the v5.4 timeframe.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/mmc/host/alcor.c           | 1 +
 drivers/mmc/host/sdhci-of-aspeed.c | 2 ++
 drivers/mmc/host/sdhci-sprd.c      | 1 +
 drivers/mmc/host/sdhci_am654.c     | 1 +
 drivers/mmc/host/uniphier-sd.c     | 1 +
 5 files changed, 6 insertions(+)

diff --git a/drivers/mmc/host/alcor.c b/drivers/mmc/host/alcor.c
index 026ca9194ce5..bfb8efeb7eb8 100644
--- a/drivers/mmc/host/alcor.c
+++ b/drivers/mmc/host/alcor.c
@@ -1178,6 +1178,7 @@ static struct platform_driver alcor_pci_sdmmc_driver = {
 	.id_table	= alcor_pci_sdmmc_ids,
 	.driver		= {
 		.name	= DRV_NAME_ALCOR_PCI_SDMMC,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.pm	= &alcor_mmc_pm_ops
 	},
 };
diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index a1bcc0f4ba9e..4f008ba3280e 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -240,6 +240,7 @@ static const struct of_device_id aspeed_sdhci_of_match[] = {
 static struct platform_driver aspeed_sdhci_driver = {
 	.driver		= {
 		.name	= "sdhci-aspeed",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = aspeed_sdhci_of_match,
 	},
 	.probe		= aspeed_sdhci_probe,
@@ -318,6 +319,7 @@ MODULE_DEVICE_TABLE(of, aspeed_sdc_of_match);
 static struct platform_driver aspeed_sdc_driver = {
 	.driver		= {
 		.name	= "sd-controller-aspeed",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.pm	= &sdhci_pltfm_pmops,
 		.of_match_table = aspeed_sdc_of_match,
 	},
diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index a910cb461ed7..f88d38e34a23 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -787,6 +787,7 @@ static struct platform_driver sdhci_sprd_driver = {
 	.remove = sdhci_sprd_remove,
 	.driver = {
 		.name = "sdhci_sprd_r11",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(sdhci_sprd_of_match),
 		.pm = &sdhci_sprd_pm_ops,
 	},
diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index c5f47197d177..a4c6d9d80e88 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -745,6 +745,7 @@ static int sdhci_am654_remove(struct platform_device *pdev)
 static struct platform_driver sdhci_am654_driver = {
 	.driver = {
 		.name = "sdhci-am654",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = sdhci_am654_of_match,
 	},
 	.probe = sdhci_am654_probe,
diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
index 55efd5c53249..3092466a99ab 100644
--- a/drivers/mmc/host/uniphier-sd.c
+++ b/drivers/mmc/host/uniphier-sd.c
@@ -685,6 +685,7 @@ static struct platform_driver uniphier_sd_driver = {
 	.remove = uniphier_sd_remove,
 	.driver = {
 		.name = "uniphier-sd",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = uniphier_sd_match,
 	},
 };
-- 
2.28.0.526.ge36021eeef-goog

