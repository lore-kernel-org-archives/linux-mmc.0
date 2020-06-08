Return-Path: <SRS0=G9E5=7V=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8913CC433DF
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Jun 2020 16:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6849D20810
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Jun 2020 16:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxMZviQz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbgFHQWo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Jun 2020 12:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730383AbgFHQWn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Jun 2020 12:22:43 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6F5C08C5C2;
        Mon,  8 Jun 2020 09:22:42 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t7so8988746pgt.3;
        Mon, 08 Jun 2020 09:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xb9iduIo0ZsY8UkuJNW0EYDly2gzKS1dDnF5Tlucm3E=;
        b=ZxMZviQzRAeJ5DYVXko9AgnUzdM+2XqibnUTpLy53K/ePADf3nmLYW8DBnT5/aKoIL
         awbhhoGIqdDybOaGZ7VBexdf371ynrzzMrAq6zwTY3CXtFMFR8OBdoQSwtjBo9TzwdIc
         TVxxa6xjPf+NciarOzBz7a354AQp9mdHivGVD3N/9+oBGCiSqER9KZA67fFU5vrX8vMQ
         aD8umA50I5wjNKq1ULpY4j/kXYULB450Zx06+gjAe1ySU5kWjpDFX48Vged7P4Ps7qnt
         LeTOuy+pUf0e23rx8MlIYOdyAuHrTi0leShThPh5oJJdRxxkwoP4z1wtV8trIWBfq0bT
         zW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xb9iduIo0ZsY8UkuJNW0EYDly2gzKS1dDnF5Tlucm3E=;
        b=bKSPV9qn0TIxQeHBHJXo6HxZoMzsCCi8i8cOqqTe9WkRAnabZqaGTP2LT8lVukpvji
         sSiDhseWm6Jyse1IaPKc9/flOU52WwJYdbH/M2wdYa/2FZUA50UfW7C/h5daPXxnJ/HB
         H2VQ4pz6fZtOrtmK07co4mKD6ZOZ6PGDzG4zO+gVB5Y/HH0k3isaTdSlaJ6ZQ8gBa9NP
         ggu9Ty6Qr/mv8iYI/oTNPN/x5xlLfD91sQhqohlw5m5w3FICbNAYbg30JQd219zxBGLE
         pmCcc/C9gBdXvOii0BAfv3JoaBCfEVLkq1279tgUW0mSuB+rq6GtlxiHKLZJuQbfUTKu
         l7oA==
X-Gm-Message-State: AOAM5338QVyPXQEnUc6XIileuyRfKuEnjvUQnmORqMTRnXVPaRAGxHOO
        xAdLczn+2ZKDMInrEKRzljM=
X-Google-Smtp-Source: ABdhPJxYAdGwPeXtwY/l/RnJjV2BHHPTERXRM6uP6tdjLlvz+7+36VZTNJg5ogRbBq84QCGe0sAkZA==
X-Received: by 2002:a63:5024:: with SMTP id e36mr20019756pgb.438.1591633361854;
        Mon, 08 Jun 2020 09:22:41 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id c9sm7015334pfr.72.2020.06.08.09.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 09:22:41 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Douglas Anderson <dianders@chromium.org>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] mmc: sdhci-of-arasan: Add missed checks for devm_clk_register()
Date:   Tue,  9 Jun 2020 00:22:26 +0800
Message-Id: <20200608162226.3259186-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

These functions do not check the return value of devm_clk_register():
  - sdhci_arasan_register_sdcardclk()
  - sdhci_arasan_register_sampleclk()

Therefore, add the missed checks to fix them.

Fixes: c390f2110adf1 ("mmc: sdhci-of-arasan: Add ability to export card clock")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index db9b544465cd..fb26e743e1fd 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -1299,6 +1299,8 @@ sdhci_arasan_register_sdcardclk(struct sdhci_arasan_data *sdhci_arasan,
 	clk_data->sdcardclk_hw.init = &sdcardclk_init;
 	clk_data->sdcardclk =
 		devm_clk_register(dev, &clk_data->sdcardclk_hw);
+	if (IS_ERR(clk_data->sdcardclk))
+		return PTR_ERR(clk_data->sdcardclk);
 	clk_data->sdcardclk_hw.init = NULL;
 
 	ret = of_clk_add_provider(np, of_clk_src_simple_get,
@@ -1349,6 +1351,8 @@ sdhci_arasan_register_sampleclk(struct sdhci_arasan_data *sdhci_arasan,
 	clk_data->sampleclk_hw.init = &sampleclk_init;
 	clk_data->sampleclk =
 		devm_clk_register(dev, &clk_data->sampleclk_hw);
+	if (IS_ERR(clk_data->sampleclk))
+		return PTR_ERR(clk_data->sampleclk);
 	clk_data->sampleclk_hw.init = NULL;
 
 	ret = of_clk_add_provider(np, of_clk_src_simple_get,
-- 
2.26.2

