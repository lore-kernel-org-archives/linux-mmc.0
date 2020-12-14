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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2830C2D0E4
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Dec 2020 17:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D352022AAE
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Dec 2020 17:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408527AbgLNRY6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 14 Dec 2020 12:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408521AbgLNRYh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Dec 2020 12:24:37 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD60C0617A6
        for <linux-mmc@vger.kernel.org>; Mon, 14 Dec 2020 09:23:18 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id e2so1820861plt.12
        for <linux-mmc@vger.kernel.org>; Mon, 14 Dec 2020 09:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ixXiJOTpChsS+4hsOynBoznKWWFukOcSg8gnLionDSc=;
        b=JR/A58L++gYOFPkthluSdjweS9CJRgdMUVOXmjprfA1QPNlbEHthNfByO0JoyKPdM/
         clkf8QWTb84hc9tw2QCU5bNTf2w5sbO5wSvwK/jU1GwJ8CC2eZo0NvMv6lJXg5c4+nRm
         vP6i3psTjbxQ2cZE2jn/VeQv44A8aaFeFxJRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ixXiJOTpChsS+4hsOynBoznKWWFukOcSg8gnLionDSc=;
        b=qnzU/QbNHc6qQczQSh8UDr9Y3grZmVg/ZPmlav3381NcXBNH0lAt+GU9k01CZbYH+V
         bJX2qpludR1q4c4i0Z/GWYCjlaS9zfOW39sKyDCeT4nY96PMX+hon5xoRrqeveTIqjUD
         EdW/rUd4OZc6KW3JQKVROYaYbTF8r0beP2/0xI7Nyiy21NV5btLvls9BsjIfUrYIrUkG
         Rbvo1V9lHb+vlzPMqdPSyFt955WO38MMsOgdI2UnOE4k+LnhUiLC9qmUQ8w79euDr2aO
         N4UUcTPPIph/w2px+3qHO+aiaFBKBCdFoHVZiygLqMPh3Vt7FLloQwH1Y5cE7CBtv3iA
         Gn4Q==
X-Gm-Message-State: AOAM531d5yfHlfK0T8BXRYTeKB8mGPNYiiZMbbxvrkLFqfxKVl0xOu6t
        2+4Je0GT386QTxvnyHzvTay5eg==
X-Google-Smtp-Source: ABdhPJxnhLBxYwe6+7mjOz3eHTxWqA0+Qq10RmkZ3BR4aip0H78wl4m2aTZmzdXZNTGzKIjQ+UlDjQ==
X-Received: by 2002:a17:90a:c910:: with SMTP id v16mr26359722pjt.198.1607966597919;
        Mon, 14 Dec 2020 09:23:17 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id 7sm16013498pfh.142.2020.12.14.09.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 09:23:17 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Taniya Das <tdas@codeaurora.org>, vbadigan@codeaurora.org,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH v5 1/2] mmc: sdhci-msm: Warn about overclocking SD/MMC
Date:   Mon, 14 Dec 2020 09:21:14 -0800
Message-Id: <20201214092048.v5.1.Iec3430c7d3c2a29262695edef7b82a14aaa567e5@changeid>
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

(no changes since v4)

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

