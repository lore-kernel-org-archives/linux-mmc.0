Return-Path: <SRS0=lwnd=CM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E103FC2BC11
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Sep 2020 23:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B23062078E
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Sep 2020 23:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VhBq0Pd1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbgICXZd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 3 Sep 2020 19:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728775AbgICXZL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Sep 2020 19:25:11 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48270C061244
        for <linux-mmc@vger.kernel.org>; Thu,  3 Sep 2020 16:25:11 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 7so3324157pgm.11
        for <linux-mmc@vger.kernel.org>; Thu, 03 Sep 2020 16:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ak7sgXD1yUS+b4yneXUgmseigL5T/tHURONnrfZ0LI4=;
        b=VhBq0Pd1fQUl41cTBulPJPpdxGflwL0G7Gqg1UwnWwh7hC3EHSfa7oPF3xPReYY4jn
         BAWM7qrieI6Kba9y15jYXktkL7ZlLYJjFqbAHH+2+qgP7TtD6dXZkTSM/dM7KV4y/BQ2
         YfsUkkK/A9E3N0HUpkt7fYZBAsf2ixttwmFIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ak7sgXD1yUS+b4yneXUgmseigL5T/tHURONnrfZ0LI4=;
        b=Z3YP8utKkbjQSJ5mo0I/bKIa2n/3xnLfOxn+BG9O4Et2787hNJDGLYiE7wXPhxQWJH
         fVLBcnGELs80PXdWZv/edGRmfs+CLksaPuXgD04UCC2B55sAcg9DnlAWWzDd6qK7l3XL
         TSBsSYyLkAp2LsrrzAmW8gcmcQZC7hsuwMSrPiWyotErkWINEcAugZlhbZr1NR9ZBAK1
         Jk+iSTTR/KMBdnXJEvFg5PELFrQaojta0c55iCv2XMNwH+/oGxlJnNUoTu5deArfV8z1
         CCkAdh72iHn0wWre0KqTY76SWLeGCW0U0Xr3MV1nmutdEqt0WJikZb4ywaYwHUV4m6/e
         NZEw==
X-Gm-Message-State: AOAM530xdWNwKi9EQp0X8sC6MWWH+UBAJfkMdB0Cu7MhEmPXJHoOwK60
        v86BYETVtwjcdn1aVstPg7WliA==
X-Google-Smtp-Source: ABdhPJzWCp1ofM9pNblsz3oLmRdRBFRUQauHQjSC92yoCjre8k5Y3NiZEW1Bbb485EaunCczoEjv5Q==
X-Received: by 2002:a62:ea01:: with SMTP id t1mr6001343pfh.125.1599175510807;
        Thu, 03 Sep 2020 16:25:10 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id q7sm3614459pgg.10.2020.09.03.16.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 16:25:10 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     swboyd@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH 6/6] mmc: Set PROBE_PREFER_ASYNCHRONOUS for drivers that are newer than 5.4
Date:   Thu,  3 Sep 2020 16:24:41 -0700
Message-Id: <20200903162412.6.Ib121debfb18e5f923a3cd38fe9c36aa086c650c5@changeid>
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
the drivers that appeared to have been added after kernel 5.4.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/mmc/host/meson-mx-sdhc-mmc.c | 1 +
 drivers/mmc/host/owl-mmc.c           | 1 +
 drivers/mmc/host/sdhci-esdhc-mcf.c   | 1 +
 drivers/mmc/host/sdhci-milbeaut.c    | 1 +
 drivers/mmc/host/sdhci-of-sparx5.c   | 1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/mmc/host/meson-mx-sdhc-mmc.c b/drivers/mmc/host/meson-mx-sdhc-mmc.c
index 53e3f6a4245a..7cd9c0ec2fcf 100644
--- a/drivers/mmc/host/meson-mx-sdhc-mmc.c
+++ b/drivers/mmc/host/meson-mx-sdhc-mmc.c
@@ -903,6 +903,7 @@ static struct platform_driver meson_mx_sdhc_driver = {
 	.remove  = meson_mx_sdhc_remove,
 	.driver  = {
 		.name = "meson-mx-sdhc",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(meson_mx_sdhc_of_match),
 	},
 };
diff --git a/drivers/mmc/host/owl-mmc.c b/drivers/mmc/host/owl-mmc.c
index df43f42855e2..ccf214a89eda 100644
--- a/drivers/mmc/host/owl-mmc.c
+++ b/drivers/mmc/host/owl-mmc.c
@@ -689,6 +689,7 @@ MODULE_DEVICE_TABLE(of, owl_mmc_of_match);
 static struct platform_driver owl_mmc_driver = {
 	.driver = {
 		.name	= "owl_mmc",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = owl_mmc_of_match,
 	},
 	.probe		= owl_mmc_probe,
diff --git a/drivers/mmc/host/sdhci-esdhc-mcf.c b/drivers/mmc/host/sdhci-esdhc-mcf.c
index 71bf086a9812..ca7a1690b2a8 100644
--- a/drivers/mmc/host/sdhci-esdhc-mcf.c
+++ b/drivers/mmc/host/sdhci-esdhc-mcf.c
@@ -509,6 +509,7 @@ static int sdhci_esdhc_mcf_remove(struct platform_device *pdev)
 static struct platform_driver sdhci_esdhc_mcf_driver = {
 	.driver	= {
 		.name = "sdhci-esdhc-mcf",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = sdhci_esdhc_mcf_probe,
 	.remove = sdhci_esdhc_mcf_remove,
diff --git a/drivers/mmc/host/sdhci-milbeaut.c b/drivers/mmc/host/sdhci-milbeaut.c
index 4e7cc0680f94..148b37ac6564 100644
--- a/drivers/mmc/host/sdhci-milbeaut.c
+++ b/drivers/mmc/host/sdhci-milbeaut.c
@@ -333,6 +333,7 @@ static int sdhci_milbeaut_remove(struct platform_device *pdev)
 static struct platform_driver sdhci_milbeaut_driver = {
 	.driver = {
 		.name = "sdhci-milbeaut",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(mlb_dt_ids),
 	},
 	.probe	= sdhci_milbeaut_probe,
diff --git a/drivers/mmc/host/sdhci-of-sparx5.c b/drivers/mmc/host/sdhci-of-sparx5.c
index 747f108a0ace..28e4ee69e100 100644
--- a/drivers/mmc/host/sdhci-of-sparx5.c
+++ b/drivers/mmc/host/sdhci-of-sparx5.c
@@ -255,6 +255,7 @@ MODULE_DEVICE_TABLE(of, sdhci_sparx5_of_match);
 static struct platform_driver sdhci_sparx5_driver = {
 	.driver = {
 		.name = "sdhci-sparx5",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = sdhci_sparx5_of_match,
 		.pm = &sdhci_pltfm_pmops,
 	},
-- 
2.28.0.526.ge36021eeef-goog

