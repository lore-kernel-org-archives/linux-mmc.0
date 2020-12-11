Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCA2C4361B
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Dec 2020 19:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45F4C23E1B
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Dec 2020 19:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391373AbgLKRPx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 11 Dec 2020 12:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393817AbgLKRPS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Dec 2020 12:15:18 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4B4C0613D6
        for <linux-mmc@vger.kernel.org>; Fri, 11 Dec 2020 09:14:38 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id hk16so2679065pjb.4
        for <linux-mmc@vger.kernel.org>; Fri, 11 Dec 2020 09:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uR0YjgXtKu52Ys9ozO8PBjvLYurXhASyqCjNQPfwTb4=;
        b=Brgm7LZVxVwcvbkIFXrexDB2orSaCca8av4L297rkICYUdeanX03+8l9Mrm3UGRRhF
         agAFyXef7Ta5qY/u1+sGco5pZDn8MXcQIZjtQxRMkv5HjHuK/cwTb3AdSyEhACPPNTDB
         07nT1YBEgOekA4MVZx8E8Y+FigG1drsDsRXZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uR0YjgXtKu52Ys9ozO8PBjvLYurXhASyqCjNQPfwTb4=;
        b=WeQGlb8pn6hgDZev9lh/Hw3nYk4Y7Fy70wJNvmqyHg+2z9pk1xcjVAT0GCdoPlZjuj
         IueG2cepUCCWUY9JANYFdF8UBEglrBdU19WyfXkshNYg1I5LqIiQk0LmV2VOWds5v/WO
         6RN8VtSRRi7Ie1bqstfHyEtDSmVwEGWOKKPNwhNhQfxkggIUEgC36XN4mgoTSFwEnapc
         CNO3lI4pFmeulTAfVPbS/z0OxlakFh1DamjFPfbA6DmxAmEIXVR3/2/faeFOlg0NdpJ1
         gmB3ZalEa6l63tSnEcONvmB5d7XmKYqYXhjJxa11cz841OqnJpEX3DGGOPlc3IrU+1a6
         1IaQ==
X-Gm-Message-State: AOAM533aajM6L0V0H2dVKZR24+OL0eQIyQ+zBD16sBjLqV1VP7SatYju
        kGDg0q/ijpjkXmylbGAlP7MiJw==
X-Google-Smtp-Source: ABdhPJyLmeMdzeZUCXeg52OqxkzlZcrmD5D5c2OFcExkilP+LqBoMxGKs3kJmHS0cxy79jbY6XVycA==
X-Received: by 2002:a17:90b:1087:: with SMTP id gj7mr9882865pjb.41.1607706877348;
        Fri, 11 Dec 2020 09:14:37 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id w70sm11149737pfd.65.2020.12.11.09.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 09:14:36 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Taniya Das <tdas@codeaurora.org>, vbadigan@codeaurora.org,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH v4 1/2] mmc: sdhci-msm: Warn about overclocking SD/MMC
Date:   Fri, 11 Dec 2020 09:12:32 -0800
Message-Id: <20201211091150.v4.1.Iec3430c7d3c2a29262695edef7b82a14aaa567e5@changeid>
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

NOTE: this doesn't actually fix any problems, it just makes it obvious
to devs that there is a problem and that should be an indication to
fix the clock driver.

[1] http://lore.kernel.org/r/20201210102234.1.I096779f219625148900fc984dd0084ed1ba87c7f@changeid

Suggested-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes in v4:
- Emphasize in the commit message that this itself doesn't fix anything.

Changes in v3:
- Proper printf format code.

Changes in v2:
- Store rate in unsigned long, not unsigned int.
- Reuse the clk_get_rate() in the later print.

 drivers/mmc/host/sdhci-msm.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 3451eb325513..50beb407dbe9 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -353,6 +353,7 @@ static void msm_set_clock_rate_for_bus_mode(struct sdhci_host *host,
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
 	struct mmc_ios curr_ios = host->mmc->ios;
 	struct clk *core_clk = msm_host->bulk_clks[0].clk;
+	unsigned long achieved_rate;
 	int rc;
 
 	clock = msm_get_clock_rate_for_bus_mode(host, clock);
@@ -363,10 +364,20 @@ static void msm_set_clock_rate_for_bus_mode(struct sdhci_host *host,
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
+		pr_warn("%s: Card appears overclocked; req %u Hz, actual %lu Hz\n",
+			mmc_hostname(host->mmc), clock, achieved_rate);
+
 	msm_host->clk_rate = clock;
 	pr_debug("%s: Setting clock at rate %lu at timing %d\n",
-		 mmc_hostname(host->mmc), clk_get_rate(core_clk),
-		 curr_ios.timing);
+		 mmc_hostname(host->mmc), achieved_rate, curr_ios.timing);
 }
 
 /* Platform specific tuning */
-- 
2.29.2.576.ga3fc446d84-goog

