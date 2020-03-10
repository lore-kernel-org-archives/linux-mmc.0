Return-Path: <SRS0=AZQG=43=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321DDC10F27
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Mar 2020 15:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C8020578
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Mar 2020 15:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="evewDF+w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgCJPd6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Mar 2020 11:33:58 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39522 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgCJPd6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Mar 2020 11:33:58 -0400
Received: by mail-lj1-f196.google.com with SMTP id f10so14651762ljn.6
        for <linux-mmc@vger.kernel.org>; Tue, 10 Mar 2020 08:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zXfY+hm6nAyuD/AmdMy4F6zgsNBRxXYSqgTSrNob95Q=;
        b=evewDF+wTbM0lLqZStPAgQrySHKOjDHSrTd0D3LYXi3Hs1GFNSR2WKOt5NSBLo8RIp
         LxOIXvlUl3s7CuyOoTRhBAfyHxGwEtKkv0VIU1R7vqrvkTlLg9qrbqES+G6AwX0c89Gz
         A0dmrhmJ/vNNCaOjDh2a1J++41kzdyq0wzhbk/qe+/NGoCdog6ZJ9BhLi5F2vygH/2r8
         muK7CKqK/LHc8xNMcwbBlDDoC69aDJYHbJ9JJ0e5MO/szgUP5RsFkn/IrdTv2ZueelUS
         9vukUF7mTkIb2upmvxx/cqXFl6PlKA5UnMs25tKaAvlBRbydEx3XD0EfYAayl45jYRkO
         Qx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zXfY+hm6nAyuD/AmdMy4F6zgsNBRxXYSqgTSrNob95Q=;
        b=YNv0K4FUMxk7oA8xziYVmuIeCWS+MCKG3w0RYODWlWlu1F007NxzgpEjBDcpcdUMpm
         noMmoOahCijNzAgJsN1cBghBE/X07O1SKD28ho6CsiyZ+ucPwngJSJev63cV8PhDw6EW
         t6nZl5fN8U7CMUxqT8dBxc3cXLXqwSAYWg85IyXxRwCcnHZo3HhNfKMMjpcN2ofRA/WT
         qZq9PwZe3pcg1AhxBuyYQ5asSOGPC1LahkSSk2hm7v18PR8BL5/bgf8cTiWbVr9+mQPk
         tYf9j8s94BOBuL9VqHhocyvF1QR94wLMZrJF/hUQ1+pBJ5HQO4G89mtv8AACLr8povBx
         /J8w==
X-Gm-Message-State: ANhLgQ3usvwLNVlD8sek9NzspgDq5acaVBcNBYKpKhNUnUoqZcK5cXZZ
        2pC7Y2fge6cDFc/DS7BiCBBPlAlmQ3k=
X-Google-Smtp-Source: ADFU+vu0tIjfpP50RQbzS8Z+nzh45tErRu3mPFdaEIEBUL9uWfO0Z5/yv52Cb1ks+dOCE2AuCLaiKA==
X-Received: by 2002:a2e:3608:: with SMTP id d8mr12867272lja.52.1583854434100;
        Tue, 10 Mar 2020 08:33:54 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id c22sm17283776lfi.41.2020.03.10.08.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 08:33:53 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, mirq-linux@rere.qmqm.pl,
        Bitan Biswas <bbiswas@nvidia.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Jon Hunter <jonathanh@nvidia.com>, stable@vger.kernel.org
Subject: [PATCH 4/4] mmc: sdhci-tegra: Fix busy detection by enabling MMC_CAP_NEED_RSP_BUSY
Date:   Tue, 10 Mar 2020 16:33:40 +0100
Message-Id: <20200310153340.5593-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200310153340.5593-1-ulf.hansson@linaro.org>
References: <20200310153340.5593-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

It has turned out that the sdhci-tegra controller requires the R1B response,
for commands that has this response associated with them. So, converting
from an R1B to an R1 response for a CMD6 for example, leads to problems
with the HW busy detection support.

Fix this by informing the mmc core about the requirement, via setting the
host cap, MMC_CAP_NEED_RSP_BUSY.

Reported-by: Bitan Biswas <bbiswas@nvidia.com>
Reported-by: Peter Geis <pgwipeout@gmail.com>
Suggested-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci-tegra.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 403ac44a7378..a25c3a4d3f6c 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1552,6 +1552,9 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 	if (tegra_host->soc_data->nvquirks & NVQUIRK_ENABLE_DDR50)
 		host->mmc->caps |= MMC_CAP_1_8V_DDR;
 
+	/* R1B responses is required to properly manage HW busy detection. */
+	host->mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
+
 	tegra_sdhci_parse_dt(host);
 
 	tegra_host->power_gpio = devm_gpiod_get_optional(&pdev->dev, "power",
-- 
2.20.1

