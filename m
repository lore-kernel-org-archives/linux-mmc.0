Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4002C433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 10 Dec 2020 20:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2C7223E25
	for <linux-mmc@archiver.kernel.org>; Thu, 10 Dec 2020 20:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393868AbgLJU6M (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 10 Dec 2020 15:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393867AbgLJU6L (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Dec 2020 15:58:11 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7157C061793
        for <linux-mmc@vger.kernel.org>; Thu, 10 Dec 2020 12:57:31 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id t37so5369054pga.7
        for <linux-mmc@vger.kernel.org>; Thu, 10 Dec 2020 12:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x9XZjdK+GoE1mq8etKM4GO7I6PYftFYYwI933vQGPrg=;
        b=f4y4CWJMbq7bvpHEMdEn1gOxY5zMEythQvdW55CNq1exSYugch1Q4G9S0MgiOkrr8S
         C2v60pJj6agFzc+SdSIi2YK2p9sQqDLsC54yhWRl9CmlOwmhNL5FJbA4P41dohhFYW6Z
         dQeUx6kxPYhaSxMosQHs78Ofbug91ev1dLAm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x9XZjdK+GoE1mq8etKM4GO7I6PYftFYYwI933vQGPrg=;
        b=hZtkoutFLB0GL0j+g5fXK0yXVlTbP+pD/37PcdWosngpIDG4+qBb0y8qa14FTp7sIN
         J12E/fIza77TrCF9xvi9IhTxJKTJctdxtGG+DZKCP2JP7lAWrQ2yNEtsjV3Ntz2gH067
         ET96uM9uXM8VS4mx1GLnrjKFnT9For48GE7VerZM7QVDX60zUsgiPRr75DuMX7yUb4c8
         evCuEAsVA5frIAkcjIFF79TQSKTJGOE2p29hHSjGyzcu37YvsIl+ueuGOYwpwuNbh4en
         Vgp+mblnqlcM5Ei27U2I1biVpAVCW846fUITbP+Mu5Dwz0SPdDugvMDmAPo5wAYje3sx
         TzjA==
X-Gm-Message-State: AOAM530/VmBGFt/RQxEz4X5zIBLSTDY1X0yHE8hdB21B6cQ+0SPk6nSG
        1b4YqZlRAongoKDt4hlKH9AIqg==
X-Google-Smtp-Source: ABdhPJwCRhTAQIZIINOCzPzE9pS6fDFL0U1Y/aa6OdOEA56IDLEaqGgcS+25lMkrtBvhBXqH+Xyabg==
X-Received: by 2002:a17:90a:5901:: with SMTP id k1mr9465703pji.7.1607633851215;
        Thu, 10 Dec 2020 12:57:31 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id x143sm8006786pgx.66.2020.12.10.12.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 12:57:30 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     vbadigan@codeaurora.org, Stephen Boyd <swboyd@chromium.org>,
        Taniya Das <tdas@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH] mmc: sdhci-msm: Warn about overclocking SD/MMC
Date:   Thu, 10 Dec 2020 12:57:25 -0800
Message-Id: <20201210125709.1.Iec3430c7d3c2a29262695edef7b82a14aaa567e5@changeid>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

As talked about in commit 5e4b7e82d497 ("clk: qcom: gcc-sdm845: Use
floor ops for sdcc clks"), most clocks handled by the Qualcomm clock
drivers are rounded _up_ by default instead of down.  We should make
sure SD/MMC clocks are always rounded down in the clock drivers.
Let's add a warning in the Qualcomm SDHCI driver to help catch the
problem.

This would have saved a bunch of time [1].

[1] http://lore.kernel.org/r/20201210102234.1.I096779f219625148900fc984dd0084ed1ba87c7f@changeid

Suggested-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/mmc/host/sdhci-msm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 3451eb325513..dd41f6a4dbfb 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -353,6 +353,7 @@ static void msm_set_clock_rate_for_bus_mode(struct sdhci_host *host,
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
 	struct mmc_ios curr_ios = host->mmc->ios;
 	struct clk *core_clk = msm_host->bulk_clks[0].clk;
+	unsigned int achieved_rate;
 	int rc;
 
 	clock = msm_get_clock_rate_for_bus_mode(host, clock);
@@ -363,6 +364,17 @@ static void msm_set_clock_rate_for_bus_mode(struct sdhci_host *host,
 		       curr_ios.timing);
 		return;
 	}
+
+	/*
+	 * Qualcomm clock drivers by default round clock _up_ if they can't
+	 * make the requested rate.  This is not good for SD.  Yell if we
+	 * encounter it.
+	 */
+	achieved_rate = clk_get_rate(core_clk);
+	if (achieved_rate > clock)
+		pr_warn("%s: Card appears overclocked; req %u Hz, actual %d Hz\n",
+			mmc_hostname(host->mmc), clock, achieved_rate);
+
 	msm_host->clk_rate = clock;
 	pr_debug("%s: Setting clock at rate %lu at timing %d\n",
 		 mmc_hostname(host->mmc), clk_get_rate(core_clk),
-- 
2.29.2.576.ga3fc446d84-goog

